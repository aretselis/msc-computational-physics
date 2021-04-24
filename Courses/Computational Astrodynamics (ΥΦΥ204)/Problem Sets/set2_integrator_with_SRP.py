import numpy as np
import matplotlib.pyplot as plt


def orbital_elements_to_cartesian(a, e, i, Omega, omega, M, mu):
    # Computes cartesian position and velocity vector given some orbital elements
    # Input:
    # a [m]
    # e []
    # i [deg]
    # Omega [deg]
    # omega [deg]
    # M [deg]
    # mu [m^3/(kg*s^2)] (GM)
    # Output:
    # r_vector, y_vector

    # Compute E using Newton-Raphson
    # Define initial value for E_0
    if M > -np.pi and M < 0:
        E_0 = M - e
    elif M > np.pi:
        E_0 = M + e
    else:
        E_0 = 0.1
    # Convert M to radians
    M = np.radians(M)
    # Define f and f dot
    f = lambda E: M - E + np.sin(E)
    fdot = lambda E: -1 + np.cos(E)
    # Stopping criteria
    N = 15  # Number of significant digits to be computed
    max_repetitions = 1000000
    es = 0.5 * pow(10, (2 - N))  # Scarborough Criterion
    ea = 100
    E_prev = E_0
    repetitions = 0
    # Main Newton-Raphson loop
    while ea > es:
        repetitions = repetitions + 1
        E_next = E_prev - (f(E_prev) / fdot(E_prev))
        ea = np.fabs((E_next - E_prev) * 100 / E_next)
        E_prev = E_next
        if repetitions > max_repetitions:
            # print('Max repetitions reached without achieving desired accuracy for E!')
            break
    E = E_next
    # Compute x, xdot, y, ydot on the orbital plane
    x = a * (np.cos(E) - e)
    y = a * np.sqrt(1 - pow(e, 2)) * np.sin(E)
    r = np.sqrt(pow(x, 2) + pow(y, 2))
    n = np.sqrt(mu / pow(a, 3))  # Mean motion
    x_dot = -(n * pow(a, 2) / r) * np.sin(E)
    y_dot = (n * pow(a, 2) / r) * np.sqrt(1 - pow(e, 2)) * np.cos(E)
    # Rotation Matrices definition
    Omega = np.radians(Omega)
    omega = np.radians(omega)
    i = np.radians(i)
    P1 = np.array([[np.cos(omega), -np.sin(omega), 0],
                   [np.sin(omega), np.cos(omega), 0],
                   [0, 0, 1]])
    P2 = np.array([[1, 0, 0],
                   [0, np.cos(i), np.sin(i)],
                   [0, np.sin(i), np.cos(i)]])
    P3 = np.array([[np.cos(Omega), -np.sin(Omega), 0],
                   [np.sin(Omega), np.cos(Omega), 0],
                   [0, 0, 1]])
    # Compute cartesian coordinates
    x_y_vector = np.array([x, y, 0])
    x_y_dot_vector = np.array([x_dot, y_dot, 0])
    r_vector = np.matmul(np.matmul(np.matmul(P3, P2), P1), x_y_vector)
    v_vector = np.matmul(np.matmul(np.matmul(P3, P2), P1), x_y_dot_vector)
    return r_vector, v_vector


def cartesian_to_orbital_elements(r_vector, v_vector, mu):
    # Computes cartesian position and velocity vector given some orbital elements
    # Input:
    # r_vector, y_vector
    # mu [m^3/(kg*s^2)] (GM)
    # Output:
    # a [m] (Semi-major axis)
    # e [] (Eccentricity)

    # Compute magnitude and angular momentum
    r = np.sqrt(pow(r_vector[0], 2) + pow(r_vector[1], 2) + pow(r_vector[2], 2))
    v = np.sqrt(pow(v_vector[0], 2) + pow(v_vector[1], 2) + pow(v_vector[2], 2))
    h_vector = np.cross(r_vector, v_vector)
    h = np.sqrt(pow(h_vector[0], 2) + pow(h_vector[1], 2) + pow(h_vector[2], 2))
    # Compute a, e and i
    a = mu / ((2 * mu / r) - pow(v, 2))
    e_vector = (np.cross(v_vector, h_vector)/mu) - (r_vector/r)
    e = np.sqrt(pow(e_vector[0], 2) + pow(e_vector[1], 2) + pow(e_vector[2], 2))
    return a, e


def runge_kutta_4(x_0, y_0, z_0, vx_0, vy_0, vz_0, mu, t_start, tmax, h, x_sun, y_sun, z_sun, A, c_p, m_sc, case):
    # 4th order Runge Kutta orbit propagator
    # Input:
    # x_0, y_0, z_0, namely the coordinates of the position vector [meters]
    # vx_0, vy_0, vz_0, namely the coordinates of the velocity vector [m/s]
    # mu, mu constant
    # t_start, initial time [seconds]
    # t_end, propagation end time [seconds]
    # h, integration step size [seconds]
    # Output is 7 vectors containing position, velocity and time information at each integration step

    # Log initial values
    tn = [t_start]
    xn = [x_0]
    yn = [y_0]
    zn = [z_0]
    vxn = [vx_0]
    vyn = [vy_0]
    vzn = [vz_0]
    counter = 0
    ground_check = 1
    R_earth = 6371000
    # Main RK4 loop
    while tn[counter] < tmax:
        # Calculate sun position
        time = tn[counter]
        x_sun, y_sun = sun_position_calculator(x_sun, y_sun, time)
        # Calculate k1 values
        k1_x = fx(vx_0)
        k1_y = fy(vy_0)
        k1_z = fz(vz_0)
        k1_vx = fv_x(x_0, y_0, z_0, mu, x_sun, y_sun, z_sun, A, c_p, m_sc, time, case)
        k1_vy = fv_y(x_0, y_0, z_0, mu, x_sun, y_sun, z_sun, A, c_p, m_sc, time, case)
        k1_vz = fv_z(x_0, y_0, z_0, mu, x_sun, y_sun, z_sun, A, c_p, m_sc, time, case)
        # Calculate midpoint values
        mid_x = x_0 + k1_x * h/2
        mid_y = y_0 + k1_y * h/2
        mid_z = z_0 + k1_z * h/2
        mid_vx = vx_0 + k1_vx * h/2
        mid_vy = vy_0 + k1_vy * h/2
        mid_vz = vz_0 + k1_vz * h/2
        # Calculate k2 values
        k2_x = fx(mid_vx)
        k2_y = fy(mid_vy)
        k2_z = fz(mid_vz)
        k2_vx = fv_x(mid_x, mid_y, mid_z, mu, x_sun, y_sun, z_sun, A, c_p, m_sc, time, case)
        k2_vy = fv_y(mid_x, mid_y, mid_z, mu, x_sun, y_sun, z_sun, A, c_p, m_sc, time, case)
        k2_vz = fv_z(mid_x, mid_y, mid_z, mu, x_sun, y_sun, z_sun, A, c_p, m_sc, time, case)
        # Calculate next midpoint values
        mid_x = x_0 + k2_x * h / 2
        mid_y = y_0 + k2_y * h / 2
        mid_z = z_0 + k2_z * h / 2
        mid_vx = vx_0 + k2_vx * h / 2
        mid_vy = vy_0 + k2_vy * h / 2
        mid_vz = vz_0 + k2_vz * h / 2
        # Calculate k3 values
        k3_x = fx(mid_vx)
        k3_y = fy(mid_vy)
        k3_z = fz(mid_vz)
        k3_vx = fv_x(mid_x, mid_y, mid_z, mu, x_sun, y_sun, z_sun, A, c_p, m_sc, time, case)
        k3_vy = fv_y(mid_x, mid_y, mid_z, mu, x_sun, y_sun, z_sun, A, c_p, m_sc, time, case)
        k3_vz = fv_z(mid_x, mid_y, mid_z, mu, x_sun, y_sun, z_sun, A, c_p, m_sc, time, case)
        # Calculate next midpoint values
        mid_x = x_0 + k3_x * h
        mid_y = y_0 + k3_y * h
        mid_z = z_0 + k3_z * h
        mid_vx = vx_0 + k3_vx * h
        mid_vy = vy_0 + k3_vy * h
        mid_vz = vz_0 + k3_vz * h
        # Calculate k4 values
        k4_x = fx(mid_vx)
        k4_y = fy(mid_vy)
        k4_z = fz(mid_vz)
        k4_vx = fv_x(mid_x, mid_y, mid_z, mu, x_sun, y_sun, z_sun, A, c_p, m_sc, time, case)
        k4_vy = fv_y(mid_x, mid_y, mid_z, mu, x_sun, y_sun, z_sun, A, c_p, m_sc, time, case)
        k4_vz = fv_z(mid_x, mid_y, mid_z, mu, x_sun, y_sun, z_sun, A, c_p, m_sc, time, case)
        # Compute r, v values and append to list
        xn.append(xn[counter] + (h / 6) * (k1_x + 2 * k2_x + 2 * k3_x + k4_x))
        yn.append(yn[counter] + (h / 6) * (k1_y + 2 * k2_y + 2 * k3_y + k4_y))
        zn.append(zn[counter] + (h / 6) * (k1_z + 2 * k2_z + 2 * k3_z + k4_z))
        vxn.append(vxn[counter] + (h / 6) * (k1_vx + 2 * k2_vx + 2 * k3_vx + k4_vx))
        vyn.append(vyn[counter] + (h / 6) * (k1_vy + 2 * k2_vy + 2 * k3_vy + k4_vy))
        vzn.append(vzn[counter] + (h / 6) * (k1_vz + 2 * k2_vz + 2 * k3_vz + k4_vz))
        r_check = np.sqrt(pow(x_0, 2) + pow(y_0, 2) + pow(z_0, 2))
        if ground_check == 1 and r_check < R_earth:
            print('Warning: Spacecraft altitude touched the surface of the earth for time %d seconds.' % tn[counter])
            print('Continuing propagation')
            ground_check = 0
        # Prepare for the next iteration and reset values
        counter += 1
        tn.append(tn[counter - 1] + h)
        x_0 = xn[counter]
        y_0 = yn[counter]
        z_0 = zn[counter]
        vx_0 = vxn[counter]
        vy_0 = vyn[counter]
        vz_0 = vzn[counter]
    return xn, yn, zn, vxn, vyn, vzn, tn


def fx(v_x):
    # Assuming x'(t)=v_x
    return v_x


def fy(v_y):
    # Assuming y'(t)=v_y
    return v_y


def fz(v_z):
    # Assuming z'(t)=v_z
    return v_z


def fv_x(x, y, z, mu, x_sun, y_sun, z_sun, A, c_p, m_sc, current_time, shadow_enabled):
    # Assuming v_x'(t)=-mu*x/(sqrt(x^2+y^2+z^2))^3
    c = 3*pow(10, 8)
    flux = flux_calculator(current_time)
    if shadow_enabled == 1:
        shadow = shadow_checker(x, y, z, x_sun, y_sun, z_sun)
    else:
        shadow = 1
    return -mu*x/pow(np.sqrt(pow(x, 2) + pow(y, 2) + pow(z, 2)), 3) \
           + shadow*flux*A*c_p*(x-x_sun)/(c*m_sc*np.sqrt(pow(x-x_sun, 2) + pow(y-y_sun,2) + pow(z-z_sun, 2)))


def fv_y(x, y, z, mu, x_sun, y_sun, z_sun, A, c_p, m_sc, current_time, shadow_enabled):
    # Assuming v_y'(t)=-mu*y/(sqrt(x^2+y^2+z^2))^3
    c = 3*pow(10, 8)
    flux = flux_calculator(current_time)
    if shadow_enabled == 1:
        shadow = shadow_checker(x, y, z, x_sun, y_sun, z_sun)
    else:
        shadow = 1
    return -mu*y/pow(np.sqrt(pow(x, 2) + pow(y, 2) + pow(z, 2)), 3) \
           + shadow*flux*A*c_p*(y-y_sun)/(c*m_sc*np.sqrt(pow(x-x_sun, 2) + pow(y-y_sun,2) + pow(z-z_sun, 2)))


def fv_z(x, y, z, mu, x_sun, y_sun, z_sun, A, c_p, m_sc, current_time, shadow_enabled):
    # Assuming v_z'(t)=-mu*z/(sqrt(x^2+y^2+z^2))^3
    c = 3*pow(10, 8)
    flux = flux_calculator(current_time)
    if shadow_enabled == 1:
        shadow = shadow_checker(x, y, z, x_sun, y_sun, z_sun)
    else:
        shadow = 1
    return -mu*z/pow(np.sqrt(pow(x, 2) + pow(y, 2) + pow(z, 2)), 3)


def flux_calculator(time):
    # Calculates the amount of flux received by the satellite, assuming it is relatively close to the earth
    # The calculator assumes that the sun is initially (t=0) alligned with the positive OX axis of the ICRF frame
    # Input is time since t=0 [seconds]
    # Output is flux [W/m^2
    # Convert to the desired units
    n = 1
    time = time/(60*60*24)
    phase_angle = time*n
    phase_angle = np.radians(phase_angle)
    # Make phase_angle in [0, 2*pi]
    while phase_angle >= 2*np.pi:
        phase_angle -= 2*np.pi
    flux = 1358/(1+0.033*phase_angle)
    return 1358


def sun_position_calculator(x_initial, y_initial, propagation_time):
    # Rotates the sun around the earth in the ICRF frame
    # Input is the initial position vector of the sun [meters] and propagation time [seconds]
    # Output is the position vector of the sun [meters] after propagation
    n_dot = 1  # [deg/day]
    propagation_time = propagation_time / (60 * 60 * 24)
    theta = n_dot*propagation_time
    theta = np.radians(theta)
    r = np.sqrt(pow(x_initial, 2) + pow(y_initial, 2))
    x_final = r*np.cos(theta)
    y_final = r*np.sin(theta)
    return x_final, y_final


def shadow_checker(x_sc, y_sc, z_sc, x_sun, y_sun, z_sun):
    # Computes if a spacecraft is inside Earth's shadow
    # Input:
    # Spacecraft position vector (x_sc, y_sc, z_sc) [meters]
    # Sun position vector (x_sun, y_sun, z_sun) [meters]
    # Output:
    # 0, if the spacecraft is in Earth's shadow
    # 1, if the spacecraft is in sunlight
    r_earth = 6371000
    # Compute vector magnitudes
    r_spacecraft = np.sqrt(pow(x_sc, 2) + pow(y_sc, 2) + pow(z_sc, 2))
    r_sun = np.sqrt(pow(x_sun, 2) + pow(y_sun, 2) + pow(z_sun, 2))
    # Compute theta values
    theta = np.arccos((x_sc*x_sun+y_sc*y_sun+z_sc*z_sun)/(r_spacecraft*r_sun))
    theta_1 = np.arccos(r_earth/r_spacecraft)
    theta_2 = np.arccos(r_earth/r_sun)
    # Decide if we are inside or outside Earth's shadow
    if theta_1+theta_2 <= theta:
        result = 0
    else:
        result = 1
    return result


# Constants definition
G = 6.6743*pow(10, -11)
M_earth = 5.977*pow(10, 24)
mu_earth = G*M_earth
R_earth = 6371000  # [meters]

# Orbit definition
H = 400000  # Altitude, [meters]
a = R_earth + H  # Semi-major axis, [meters]
i = 0  # Inclination, [deg]
e = 0  # Eccentricity, []
Omega = 0  # Longitude of the Ascending Note [deg]
omega = 0  # Argument of pericenter [deg]
M = 0  # Mean anomaly, [deg]
T = 2 * np.pi * np.sqrt(pow(a, 3)/mu_earth)  # Orbital period, [seconds]

# Compute initial position and velocity vector from orbital elements
r_vector, v_vector = orbital_elements_to_cartesian(a, e, i, Omega, omega, M, mu_earth)
x = r_vector[0]
y = r_vector[1]
z = r_vector[2]
vx = v_vector[0]
vy = v_vector[1]
vz = v_vector[2]

# Compute sun initial position

x_sun_initial = 149597870700.0
y_sun_initial = 0.0
z_sun_initial = 0.0

# Spacecraft properties

S = 8000
C_p = 1.5
M_spacecraft = 400

# Shadow? (0 is OFF, 1 is ON)
shadow_case = 0

# Propagate orbit (all times in seconds)
start_time = 0
end_time = 10*T
time_step = 10
xn, yn, zn, vxn, vyn, vzn, tn = \
    runge_kutta_4(x, y, z, vx, vy, vz, mu_earth, start_time, end_time, time_step,
                  x_sun_initial, y_sun_initial, z_sun_initial, S, C_p, M_spacecraft, shadow_case)

# Propagate case and take shadow into account
shadow_case = 1
xn_s, yn_s, zn_s, vxn_s, vyn_s, vzn_s, tn_s = \
    runge_kutta_4(x, y, z, vx, vy, vz, mu_earth, start_time, end_time, time_step,
                  x_sun_initial, y_sun_initial, z_sun_initial, S, C_p, M_spacecraft, shadow_case)

a_values = np.zeros(np.size(xn))
e_values = np.zeros(np.size(xn))
a_values_s = np.zeros(np.size(xn_s))
e_values_s = np.zeros(np.size(xn_s))
for counter in range(0, np.size(xn)):
    r_vector = np.array([xn[counter], yn[counter], zn[counter]])
    v_vector = np.array([vxn[counter], vyn[counter], vzn[counter]])
    a_values[counter], e_values[counter] = cartesian_to_orbital_elements(r_vector, v_vector, mu_earth)
    r_vector_s = np.array([xn_s[counter], yn_s[counter], zn_s[counter]])
    v_vector_s = np.array([vxn_s[counter], vyn_s[counter], vzn_s[counter]])
    a_values_s[counter], e_values_s[counter] = cartesian_to_orbital_elements(r_vector_s, v_vector_s, mu_earth)

# Plot for one period
start_index = 1
end_index = int(T/time_step)
plt.figure()
plt.plot(tn[start_index:end_index], a_values[start_index:end_index])
plt.plot(tn_s[start_index:end_index], a_values_s[start_index:end_index])
plt.grid()
plt.ylabel('Semimajor axis, a, [meters]')
plt.xlabel('Time, t, [seconds]')
plt.title('Semimajor axis vs time for one orbit')
plt.legend(['Without shadowing', 'With shadowing'])

plt.figure()
plt.plot(tn[1:int(T)], e_values[1:int(T)])
plt.plot(tn_s[1:int(T)], e_values_s[1:int(T)])
plt.grid()
plt.ylabel('Eccentricity, e, []')
plt.xlabel('Time, t, [seconds]')
plt.title('Eccentricity vs time for one orbit')
plt.legend(['Without shadowing', 'With shadowing'])

# Plot the entire orbit
plt.figure()
plt.plot(tn[1:np.size(xn)], a_values[1:np.size(xn)])
plt.plot(tn_s[1:np.size(xn_s)], a_values_s[1:np.size(xn_s)])
plt.grid()
plt.ylabel('Semimajor axis, a, [meters]')
plt.xlabel('Time, t, [seconds]')
plt.title('Semimajor axis vs time for 6000 orbits')
plt.legend(['Without shadowing', 'With shadowing'])

plt.figure()
plt.plot(tn[1:np.size(xn)], e_values[1:np.size(xn)])
plt.plot(tn_s[1:np.size(xn_s)], e_values_s[1:np.size(xn_s)])
plt.grid()
plt.ylabel('Eccentricity, e, []')
plt.xlabel('Time, t, [seconds]')
plt.title('Eccentricity vs time for 6000 orbits')
plt.legend(['Without shadowing', 'With shadowing'])
plt.legend(['Without shadowing', 'With shadowing'])
plt.show()
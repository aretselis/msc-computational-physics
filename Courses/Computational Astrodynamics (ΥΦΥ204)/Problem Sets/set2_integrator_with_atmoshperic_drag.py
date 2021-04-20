import numpy as np
import matplotlib.pyplot as plt
from mpl_toolkits.axes_grid1.inset_locator import zoomed_inset_axes
from mpl_toolkits.axes_grid1.inset_locator import mark_inset


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


def runge_kutta_4(x_0, y_0, z_0, vx_0, vy_0, vz_0, mu, C_t, S, M_sc, t_start, t_end, h, relative):
    # 4th order Runge Kutta orbit propagator
    # Input:
    # x_0, y_0, z_0, namely the coordinates of the position vector [meters]
    # vx_0, vy_0, vz_0, namely the coordinates of the velocity vector [m/s]
    # mu, mu constant
    # t_start, initial time [seconds]
    # t_end, propagation end time [seconds]
    # h, integration step size [seconds]
    # relative, 0 or 1, if 0 the integrator will not compute relative velocity to atmosphere, if 1 it will
    # Output is 7 vectors containing position, velocity and time information at each integration step

    min_propagation_altitude = 100000
    R_earth = 6371000
    # Log initial values
    tn = [t_start]
    xn = [x_0]
    yn = [y_0]
    zn = [z_0]
    vxn = [vx_0]
    vyn = [vy_0]
    vzn = [vz_0]
    counter = 0
    # Main RK4 loop
    while tn[counter] < t_end:
        # Calculate k1 values
        k1_x = fx(vx_0)
        k1_y = fy(vy_0)
        k1_z = fz(vz_0)
        if relative == 0:
            vx_rel, vy_rel, vz_rel = vx_0, vy_0, vz_0
        else:
            vx_rel, vy_rel, vz_rel = relative_velocity(x_0, y_0, z_0, vx_0, vy_0, vz_0)
        k1_vx = fv_x(x_0, y_0, z_0, mu, vx_rel, vy_rel, vz_rel, C_t, S, M_sc)
        k1_vy = fv_y(x_0, y_0, z_0, mu, vx_rel, vy_rel, vz_rel, C_t, S, M_sc)
        k1_vz = fv_z(x_0, y_0, z_0, mu, vx_rel, vy_rel, vz_rel, C_t, S, M_sc)
        # Calculate midpoint values
        mid_x = x_0 + k1_x * h / 2
        mid_y = y_0 + k1_y * h / 2
        mid_z = z_0 + k1_z * h / 2
        mid_vx = vx_0 + k1_vx * h / 2
        mid_vy = vy_0 + k1_vy * h / 2
        mid_vz = vz_0 + k1_vz * h / 2
        if relative == 0:
            vx_rel, vy_rel, vz_rel = mid_vx, mid_vy, mid_vz
        else:
            vx_rel, vy_rel, vz_rel = relative_velocity(mid_x, mid_y, mid_z, mid_vx, mid_vy, mid_vz)
        # Calculate k2 values
        k2_x = fx(mid_vx)
        k2_y = fy(mid_vy)
        k2_z = fz(mid_vz)
        k2_vx = fv_x(mid_x, mid_y, mid_z, mu, vx_rel, vy_rel, vz_rel, C_t, S, M_sc)
        k2_vy = fv_y(mid_x, mid_y, mid_z, mu, vx_rel, vy_rel, vz_rel, C_t, S, M_sc)
        k2_vz = fv_z(mid_x, mid_y, mid_z, mu, vx_rel, vy_rel, vz_rel, C_t, S, M_sc)
        # Calculate next midpoint values
        mid_x = x_0 + k2_x * h / 2
        mid_y = y_0 + k2_y * h / 2
        mid_z = z_0 + k2_z * h / 2
        mid_vx = vx_0 + k2_vx * h / 2
        mid_vy = vy_0 + k2_vy * h / 2
        mid_vz = vz_0 + k2_vz * h / 2
        if relative == 0:
            vx_rel, vy_rel, vz_rel = mid_vx, mid_vy, mid_vz
        else:
            vx_rel, vy_rel, vz_rel = relative_velocity(mid_x, mid_y, mid_z, mid_vx, mid_vy, mid_vz)
        # Calculate k3 values
        k3_x = fx(mid_vx)
        k3_y = fy(mid_vy)
        k3_z = fz(mid_vz)
        k3_vx = fv_x(mid_x, mid_y, mid_z, mu, vx_rel, vy_rel, vz_rel, C_t, S, M_sc)
        k3_vy = fv_y(mid_x, mid_y, mid_z, mu, vx_rel, vy_rel, vz_rel, C_t, S, M_sc)
        k3_vz = fv_z(mid_x, mid_y, mid_z, mu, vx_rel, vy_rel, vz_rel, C_t, S, M_sc)
        # Calculate next midpoint values
        mid_x = x_0 + k3_x * h
        mid_y = y_0 + k3_y * h
        mid_z = z_0 + k3_z * h
        mid_vx = vx_0 + k3_vx * h
        mid_vy = vy_0 + k3_vy * h
        mid_vz = vz_0 + k3_vz * h
        if relative == 0:
            vx_rel, vy_rel, vz_rel = mid_vx, mid_vy, mid_vz
        else:
            vx_rel, vy_rel, vz_rel = relative_velocity(mid_x, mid_y, mid_z, mid_vx, mid_vy, mid_vz)
        # Calculate k4 values
        k4_x = fx(mid_vx)
        k4_y = fy(mid_vy)
        k4_z = fz(mid_vz)
        k4_vx = fv_x(mid_x, mid_y, mid_z, mu, vx_rel, vy_rel, vz_rel, C_t, S, M_sc)
        k4_vy = fv_y(mid_x, mid_y, mid_z, mu, vx_rel, vy_rel, vz_rel, C_t, S, M_sc)
        k4_vz = fv_z(mid_x, mid_y, mid_z, mu, vx_rel, vy_rel, vz_rel, C_t, S, M_sc)
        # Compute r, v values and append to list
        xn.append(xn[counter] + (h / 6) * (k1_x + 2 * k2_x + 2 * k3_x + k4_x))
        yn.append(yn[counter] + (h / 6) * (k1_y + 2 * k2_y + 2 * k3_y + k4_y))
        zn.append(zn[counter] + (h / 6) * (k1_z + 2 * k2_z + 2 * k3_z + k4_z))
        vxn.append(vxn[counter] + (h / 6) * (k1_vx + 2 * k2_vx + 2 * k3_vx + k4_vx))
        vyn.append(vyn[counter] + (h / 6) * (k1_vy + 2 * k2_vy + 2 * k3_vy + k4_vy))
        vzn.append(vzn[counter] + (h / 6) * (k1_vz + 2 * k2_vz + 2 * k3_vz + k4_vz))
        # Prepare for the next iteration and reset values
        counter += 1
        tn.append(tn[counter - 1] + h)
        x_0 = xn[counter]
        y_0 = yn[counter]
        z_0 = zn[counter]
        vx_0 = vxn[counter]
        vy_0 = vyn[counter]
        vz_0 = vzn[counter]
        r_check = np.sqrt(pow(x_0, 2) + pow(y_0, 2) + pow(z_0, 2))
        if r_check < R_earth + min_propagation_altitude:
            print('Minimum altitude reached, leading to rapid decay of the orbit. Exiting propagation...')
            break
    return xn, yn, zn, vxn, vyn, vzn, tn


def gauss_integrator(a_0, mu, c_t, S, m_s,  t_start, t_end, h):
    min_propagation_altitude = 120000
    R_earth = 6371000
    tn = [t_start]
    an = [a_0]
    counter = 0
    while tn[counter] < t_end:
        k1_a = fa(a_0, mu, c_t, S, m_s)
        mid_a = a_0 + k1_a * h / 2
        k2_a = fa(mid_a, mu, c_t, S, m_s)
        mid_a = a_0 + k2_a * h / 2
        k3_a = fa(mid_a, mu, c_t, S, m_s)
        mid_a = a_0 + k3_a * h
        k4_a = fa(mid_a, mu, c_t, S, m_s)
        an.append(an[counter] + (h / 6) * (k1_a + 2 * k2_a + 2 * k3_a + k4_a))
        counter += 1
        tn.append(tn[counter - 1] + h)
        a_0 = an[counter]
        if a_0 < R_earth + min_propagation_altitude:
            print('Minimum altitude reached, leading to rapid decay of the orbit. Exiting propagation...')
            break
    return an, tn


def fa(a, mu, c_t, S, m_s):
    rho = atmospheric_density(a)
    return -rho*np.sqrt(mu*a)*c_t*S/m_s


def fx(v_x):
    # Assuming x'(t)=v_x
    return v_x


def fy(v_y):
    # Assuming y'(t)=v_y
    return v_y


def fz(v_z):
    # Assuming z'(t)=v_z
    return v_z


def fv_x(x, y, z, mu, v_x, v_y, v_z, Ct, S, M_sc):
    # Assuming v_x'(t)=-mu*x/(sqrt(x^2+y^2+z^2))^3
    r_vector_magnitude = np.sqrt(pow(x, 2) + pow(y, 2) + pow(z, 2))
    v_vector_magnitude = np.sqrt(pow(v_x, 2) + pow(v_y, 2) + pow(v_z, 2))
    rho = atmospheric_density(r_vector_magnitude)
    return -mu * x / pow(r_vector_magnitude, 3) - (rho*v_vector_magnitude*Ct*S*v_x/(2*M_sc))


def fv_y(x, y, z, mu, v_x, v_y, v_z, Ct, S, M_sc):
    # Assuming v_y'(t)=-mu*y/(sqrt(x^2+y^2+z^2))^3
    r_vector_magnitude = np.sqrt(pow(x, 2) + pow(y, 2) + pow(z, 2))
    v_vector_magnitude = np.sqrt(pow(v_x, 2) + pow(v_y, 2) + pow(v_z, 2))
    rho = atmospheric_density(r_vector_magnitude)
    return -mu * y / pow(r_vector_magnitude, 3) - (rho*v_vector_magnitude*Ct*S*v_y/(2*M_sc))


def fv_z(x, y, z, mu, v_x, v_y, v_z, Ct, S, M_sc):
    # Assuming v_z'(t)=-mu*z/(sqrt(x^2+y^2+z^2))^3
    r_vector_magnitude = np.sqrt(pow(x, 2) + pow(y, 2) + pow(z, 2))
    v_vector_magnitude = np.sqrt(pow(v_x, 2) + pow(v_y, 2) + pow(v_z, 2))
    rho = atmospheric_density(r_vector_magnitude)
    return - mu * z / pow(r_vector_magnitude, 3) - (rho*v_vector_magnitude*Ct*S*v_z/(2*M_sc))


def atmospheric_density(r_magnitude):
    # Computes atmospheric density at a specific height above the Earth
    # Input is radius from the center of the Earth [m]
    # Output is rho [kg/m^3]
    R_earth = 6371
    height = r_magnitude*pow(10, -3) - R_earth
    if height >= 15:
        rho = pow(0.1 * height, -7.5)
    else:
        rho = 0.1
    return rho


def relative_velocity(x, y, z, vx, vy, vz):
    # Computes spacecraft's velocity relative to the atmosphere
    r = np.array([x, y, z])
    v = np.array([vx, vy, vz])
    w_z = np.array([0, 0, 7.2921150*pow(10, -5)])
    v_rel = v - np.cross(w_z, r)
    return v_rel[0], v_rel[1], v_rel[2]


# Constants definition
G = 6.6743 * pow(10, -11)
M_earth = 5.977 * pow(10, 24)
mu_earth = G * M_earth
R_earth = 6371000  # [meters]

# Orbit definition
H = 400000  # Altitude, [meters]
a = R_earth + H  # Semi-major axis, [meters]
i = 0  # Inclination, [deg]
e = 0  # Eccentricity, []
Omega = 0  # Longitude of the Ascending Note [deg]
omega = 90  # Argument of pericenter [deg]
M = 0  # Mean anomaly, [deg]
T = 2 * np.pi * np.sqrt(pow(a, 3) / mu_earth)  # Orbital period, [seconds]

# Atmospheric drag properties
C_t = 2.2
S = 8000
M_spacecraft = 400

# Compute initial position and velocity vector from orbital elements
r_vector, v_vector = orbital_elements_to_cartesian(a, e, i, Omega, omega, M, mu_earth)
x = r_vector[0]
y = r_vector[1]
z = r_vector[2]
vx = v_vector[0]
vy = v_vector[1]
vz = v_vector[2]

# Propagate orbit (all times in seconds)
start_time = 0
end_time = 10*T
time_step = 1
# Relative velocity case
xn_rel, yn_rel, zn_rel, vxn_rel, vyn_rel, vzn_rel, tn_rel = \
    runge_kutta_4(x, y, z, vx, vy, vz, mu_earth, C_t, S, M_spacecraft, start_time, end_time, time_step, 1)
# Non-relative velocity case
xn, yn, zn, vxn, vyn, vzn, tn = \
    runge_kutta_4(x, y, z, vx, vy, vz, mu_earth, C_t, S, M_spacecraft, start_time, end_time, time_step, 0)


# Compute r magnitude
r_rel = np.zeros(np.size(xn_rel))
h_rel = np.zeros(np.size(xn_rel))
r = np.zeros(np.size(xn))
h = np.zeros(np.size(xn))
for i in range(0, np.size(xn)):
    r[i] = np.sqrt(pow(xn[i], 2) + pow(yn[i], 2) + pow(zn[i], 2))
    h[i] = r[i] - R_earth
for i in range(0, np.size(xn_rel)):
    r_rel[i] = np.sqrt(pow(xn_rel[i], 2) + pow(yn_rel[i], 2) + pow(zn_rel[i], 2))
    h_rel[i] = r_rel[i] - R_earth

# Convert to xn, yn to km an
r = np.divide(r, 1000)
h = np.divide(h, 1000)
r_rel = np.divide(r_rel, 1000)
h_rel = np.divide(h_rel, 1000)
xn_rel = np.divide(xn_rel, 1000)
yn_rel = np.divide(yn_rel, 1000)

# Test with Gauss equation
start_time = 0
end_time = 10*T
time_step = 1
a_vector, t_vector = gauss_integrator(a, mu_earth, C_t, S, M_spacecraft, start_time, end_time, time_step)
a_vector = np.subtract(a_vector, R_earth)
a_vector = np.divide(a_vector, 1000)

# Plot radius vs time
plt.figure()
plt.plot(tn, h,  label='Equation of Motion, non-relative')
plt.plot(tn_rel, h_rel,  label='Equation of Motion, relative)')
plt.plot(t_vector, a_vector, label='Gauss Equation')
plt.xlabel('Time, t, [seconds]')
plt.ylabel('Altitude above Earth, h, [km]')
plt.title('Orbital Decay Diagram for a satellite similar to the ISS\nBased on equation of motion or Gauss equation')
plt.grid()
plt.legend()

# Plot orbit on XY-plane
# Plot the earth
radius = R_earth/1000
theta = np.linspace(0, 2*np.pi, 1000)
x_earth = radius*np.cos(theta)
y_earth = radius*np.sin(theta)
# Plot the orbit
fig, ax = plt.subplots()
ax.plot(x_earth, y_earth, label='Earth Radius')
ax.plot(xn_rel, yn_rel, label='Orbit')
ax.grid()
ax.set_xlabel('x-coordinate [km]')
ax.set_ylabel('y-coordinate [km]')
ax.set_title('Orbit view on XY-plane')
ax.axis('scaled')
# Create zoom-in window
zoom1 = zoomed_inset_axes(ax, zoom = 5, loc=10)
zoom1.plot(x_earth, y_earth)
zoom1.plot(xn_rel, yn_rel)
x1, x2, y1, y2 = 5500, 6800, 1200, 2200
zoom1.set_xlim(x1, x2)
zoom1.set_ylim(y1, y2)
plt.xticks(visible=False)
plt.yticks(visible=False)
mark_inset(ax, zoom1, loc1=1, loc2=4, fc="none", ec="0.5")
fig.legend()
plt.show()

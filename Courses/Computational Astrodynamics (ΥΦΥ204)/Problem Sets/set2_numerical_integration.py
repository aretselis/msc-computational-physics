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
    return (r_vector, v_vector)


def runge_kutta_4(x_0, y_0, z_0, vx_0, vy_0, vz_0, mu, tmin, tmax, h):
    # 4th order Runge Kutta implementation
    # Input is initial condition (t0,y0), interval to compute [t_min,t_max] and step/distance h
    # Output is 2 vectors containing t and y values (ready to be plotted)
    tn = [tmin]
    xn = [x_0]
    yn = [y_0]
    zn = [z_0]
    vxn = [vx_0]
    vyn = [vy_0]
    vzn = [vz_0]
    counter = 0
    while tn[counter] < tmax:
        # Calculate k1 values
        k1_x = fx(vx_0)
        k1_y = fy(vy_0)
        k1_z = fz(vz_0)
        k1_vx = fv_x(x_0, y_0, z_0, mu)
        k1_vy = fv_y(x_0, y_0, z_0, mu)
        k1_vz = fv_z(x_0, y_0, z_0, mu)
        # Calculate midpoint values
        mid_x = x_0 + k1_x * h/2
        mid_y = y_0 + k1_y * h/2
        mid_z = z_0 + k1_z * h/2
        mid_vx = vx_0 + k1_vx * h/2
        mid_vy = vy_0 + k1_vy * h/2
        mid_vz = vz_0 + k1_vz * h/2
        # Calculate k2 values
        k2_x = h * fx(mid_vx)
        k2_y = h * fy(mid_vy)
        k2_z = h * fz(mid_vz)
        k2_vx = h * fv_x(mid_x, mid_y, mid_z, mu)
        k2_vy = h * fv_y(mid_x, mid_y, mid_z, mu)
        k2_vz = h * fv_z(mid_x, mid_y, mid_z, mu)
        # Calculate next midpoint values
        mid_x = x_0 + k2_x * h / 2
        mid_y = y_0 + k2_y * h / 2
        mid_z = z_0 + k2_z * h / 2
        mid_vx = vx_0 + k2_vx * h / 2
        mid_vy = vy_0 + k2_vy * h / 2
        mid_vz = vz_0 + k2_vz * h / 2
        # Calculate k3 values
        k3_x = h * fx(mid_vx)
        k3_y = h * fy(mid_vy)
        k3_z = h * fz(mid_vz)
        k3_vx = h * fv_x(mid_x, mid_y, mid_z, mu)
        k3_vy = h * fv_y(mid_x, mid_y, mid_z, mu)
        k3_vz = h * fv_z(mid_x, mid_y, mid_z, mu)
        # Calculate next midpoint values
        mid_x = x_0 + k3_x * h / 2
        mid_y = y_0 + k3_y * h / 2
        mid_z = z_0 + k3_z * h / 2
        mid_vx = vx_0 + k3_vx * h / 2
        mid_vy = vy_0 + k3_vy * h / 2
        mid_vz = vz_0 + k3_vz * h / 2
        # Calculate k4 values
        k4_x = h * fx(mid_vx)
        k4_y = h * fy(mid_vy)
        k4_z = h * fz(mid_vz)
        k4_vx = h * fv_x(mid_x, mid_y, mid_z, mu)
        k4_vy = h * fv_y(mid_x, mid_y, mid_z, mu)
        k4_vz = h * fv_z(mid_x, mid_y, mid_z, mu)
        # Compute r, v values and append to list
        xn.append(xn[counter] + (h / 6) * (k1_x + 2 * k2_x + 2 * k3_x + k4_x))
        yn.append(yn[counter] + (h / 6) * (k1_y + 2 * k2_y + 2 * k3_y + k4_y))
        zn.append(zn[counter] + (h / 6) * (k1_z + 2 * k2_z + 2 * k3_z + k4_z))
        vxn.append(vxn[counter] + (h / 6) * (k1_vx + 2 * k2_vx + 2 * k3_vx + k4_vx))
        vyn.append(vyn[counter] + (h / 6) * (k1_vy + 2 * k2_vy + 2 * k3_vy + k4_vy))
        vzn.append(vzn[counter] + (h / 6) * (k1_vz + 2 * k2_vz + 2 * k3_vz + k4_vz))
        # Compute next t and reset values
        counter += 1
        tn.append(tn[counter - 1] + h)
        x_0 = xn[counter]
        y_0 = yn[counter]
        z_0 = zn[counter]
        vx_0 = vxn[counter]
        vy_0 = vyn[counter]
        vz_0 = vzn[counter]
    return xn, yn, zn, vxn, vyn, vzn


def fx(v_x):
    # Assuming x'(t)=v_x
    return v_x


def fy(v_y):
    # Assuming y'(t)=v_y
    return v_y


def fz(v_z):
    # Assuming z'(t)=v_z
    return v_z


def fv_x(x, y, z, mu):
    # Assuming v_x'(t)=-mu*x/(sqrt(x^2+y^2+z^2))^3
    return -mu*x/pow(np.sqrt(pow(x, 2) + pow(y, 2) + pow(z, 2)), 3)


def fv_y(x, y, z, mu):
    # Assuming v_y'(t)=-mu*y/(sqrt(x^2+y^2+z^2))^3
    return -mu*y/pow(np.sqrt(pow(x, 2) + pow(y, 2) + pow(z, 2)), 3)


def fv_z(x, y, z, mu):
    # Assuming v_z'(t)=-mu*z/(sqrt(x^2+y^2+z^2))^3
    return -mu*z/pow(np.sqrt(pow(x, 2) + pow(y, 2) + pow(z, 2)), 3)


# Constants definition
G = 6.6743*pow(10, -11)
M_earth = 5.977*pow(10, 24)
mu_earth = G*M_earth
R_earth = 6371000  # [meters]

# Orbit definition
H = 400000  # [meters]
a = R_earth + H
i = 0
e = 0
Omega = 0
omega = 0
M = 0

# Initial conditions t=0
r_vector, v_vector = orbital_elements_to_cartesian(a, e, i, Omega, omega, M, mu_earth)
x = r_vector[0]
y = r_vector[1]
z = r_vector[2]
vx = v_vector[0]
vy = v_vector[1]
vz = v_vector[2]
xn, yn, zn, vxn, vyn, vzn = runge_kutta_4(x, y, z, vx, vy, vz, mu_earth, 0, 3600, 0.1)

r = np.zeros(np.size(xn))
x = np.zeros(np.size(zn))
y = np.zeros(np.size(zn))
z = np.zeros(np.size(zn))
for i in range(0, np.size(xn)):
    r[i] = np.sqrt(pow(xn[i], 2) + pow(yn[i], 2) + pow(zn[i], 2))
    x[i] = np.sqrt(pow(xn[i], 2))
    y[i] = np.sqrt(pow(yn[i], 2))
    z[i] = np.sqrt(pow(zn[i], 2))

plt.plot(x)
plt.plot(y)
plt.plot(z)
plt.plot(r)
plt.grid()
plt.show()

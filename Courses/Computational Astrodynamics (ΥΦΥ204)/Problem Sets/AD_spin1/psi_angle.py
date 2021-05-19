import numpy as np
import matplotlib.pyplot as plt


def runge_kutta_4(theta_0, theta_dot_0, a, epsilon, ecc, n, tau, initial_anomaly, t_start, t_max, h):
    # 4th order Runge-Kutta method for the spin-orbit coupling problem
    # Input:
    # Initial conditions: theta_0 [rad], theta_dot_0 [rad]
    # a, semi-major axis []
    # epsilon, asphericity []
    # ecc, eccentricity []
    # n, Orbit mean motion [rad]
    # tau, time of pericenter [time units]
    # initial_anomaly, [rad]
    # t_start, initial time [time units]
    # t_max, RK4 end time [time units]
    # h, integration step size [time units]

    # Log initial values
    t_vector = [t_start]
    theta_vector = [theta_0]
    thetadot_vector = [theta_dot_0]
    psi_vector = [initial_anomaly-theta_0]
    counter = 0
    anomaly_counter = 0
    anomaly_vector = [initial_anomaly]
    # Main RK4 loop
    while t_vector[counter] < t_max:
        # Calculate k1 values
        k1_theta = f_theta(theta_dot_0)
        k1_thetadot, anomaly = f_theta_dot(theta_0, t_vector[counter], n, tau, ecc, a, epsilon)
        # Calculate midpoint values
        mid_theta = theta_0 + k1_theta * h/2
        mid_thetadot = theta_dot_0 + k1_thetadot * h/2
        # Calculate k2 values
        k2_theta = f_theta(mid_thetadot)
        k2_thetadot, anomaly = f_theta_dot(mid_theta, t_vector[counter]+h/2, n, tau, ecc, a, epsilon)
        # Calculate next midpoint values
        mid_theta = theta_0 + k2_theta * h / 2
        mid_thetadot = theta_dot_0 + k2_thetadot * h / 2
        # Calculate k3 values
        k3_theta = f_theta(mid_thetadot)
        k3_thetadot, anomaly = f_theta_dot(mid_theta, t_vector[counter]+h/2, n, tau, ecc, a, epsilon)
        # Calculate endpoint values
        mid_theta = theta_0 + k3_theta * h
        mid_thetadot = theta_dot_0 + k3_thetadot * h
        # Calculate k4 values
        k4_theta = f_theta(mid_thetadot)
        k4_thetadot, anomaly = f_theta_dot(mid_theta, t_vector[counter]+h, n, tau, ecc, a, epsilon)
        # Compute theta and theta_dot values and append to vector
        theta_vector.append(theta_vector[counter] + (h / 6) * (k1_theta + 2 * k2_theta + 2 * k3_theta + k4_theta))
        thetadot_vector.append(thetadot_vector[counter] + (h / 6) * (k1_thetadot + 2 * k2_thetadot + 2 * k3_thetadot + k4_thetadot))
        # Compute endpoint anomaly and condition for cases above 2pi
        anomaly_vector.append(anomaly+2*np.pi*anomaly_counter)
        if anomaly_vector[counter+1]-anomaly_vector[counter] < 0:
            anomaly_counter += 1
            anomaly_vector[counter + 1] += 2*np.pi
        psi_vector.append(anomaly_vector[counter+1]-theta_vector[counter+1])
        # Prepare for next iteration
        counter += 1
        t_vector.append(t_vector[counter - 1] + h)
        theta_0 = theta_vector[counter]
        theta_dot_0 = thetadot_vector[counter]
    return t_vector, psi_vector


def f_theta(theta_dot):
    # Assuming theta'(t) = theta_dot
    return theta_dot


def f_theta_dot(theta, time, n, tau, e, a, epsilon):
    # Assuming theta''(t) = -epsilon*(1/r^3)sin(2theta-2f)
    E = eccentric_anomaly_calculator(time, n, tau, e)
    ni = 2*np.arctan(np.sqrt((1+e)/(1-e))*np.tan(E/2))
    if ni < 0:
        ni += 2*np.pi
    r = a*(1-e*np.cos(E))
    return -(epsilon/pow(r, 3))*np.sin(2*theta-2*ni), ni


def eccentric_anomaly_calculator(time, n, tau, e):
    # Compute E using Newton-Raphson
    # Define initial value for E_0
    M = n * (time - tau)
    if M <np.pi:
        E_0 = M - e
    else:
        E_0 = M + e
    # Define f and f dot
    f = lambda E: M - E + e*np.sin(E)
    fdot = lambda E: -1 + e*np.cos(E)
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
        if E_next == 0:
            return E_next
        ea = np.fabs((E_next - E_prev) * 100 / E_next)
        E_prev = E_next
        if repetitions > max_repetitions:
            print('Max repetitions reached without achieving desired accuracy for E!')
            break
    E = E_next
    return E


def plot_results(x, y, e, theta_0, theta_dot_0):
    plt.figure()
    plt.plot(x, y)
    plt.title(r"$\psi(t)$ for e=%.1f" % e + "\n" +
              r"with initial conditions $\theta_{0}=$%.2f and $\dot{\theta}_{0}$=%.2f" % (theta_0, theta_dot_0))
    plt.grid()
    plt.show()


# System properties
a = 1
mu = 1
tau = 0
f_0 = 0
T = np.sqrt(4*pow(np.pi, 2)*pow(a, 3)/mu)
n = 2*np.pi/T
epsilon = 0.05

# Integration properties
start_time = 0
end_time = 200
time_step = 0.1

# Case 1
e = 0
theta_0 = 0.1
theta_dot_0 = 1.0

# Solve and plot result
time, psi_values = runge_kutta_4(theta_0, theta_dot_0, a, epsilon, e, n, tau, f_0, start_time, end_time, time_step)
plot_results(time, psi_values, e, theta_0, theta_dot_0)

# Case 2
e = 0
theta_0 = 1.57
theta_dot_0 = 1.0

# Solve and plot result
time, psi_values = runge_kutta_4(theta_0, theta_dot_0, a, epsilon, e, n, tau, f_0, start_time, end_time, time_step)
plot_results(time, psi_values, e, theta_0, theta_dot_0)

# Case 3
e = 0.3
theta_0 = 0.1
theta_dot_0 = 1.0

# Solve and plot result
time, psi_values = runge_kutta_4(theta_0, theta_dot_0, a, epsilon, e, n, tau, f_0, start_time, end_time, time_step)
plot_results(time, psi_values, e, theta_0, theta_dot_0)

# Case 4
e = 0.3
theta_0 = 1.57
theta_dot_0 = 1.0

# Solve and plot result
time, psi_values = runge_kutta_4(theta_0, theta_dot_0, a, epsilon, e, n, tau, f_0, start_time, end_time, time_step)
plot_results(time, psi_values, e, theta_0, theta_dot_0)

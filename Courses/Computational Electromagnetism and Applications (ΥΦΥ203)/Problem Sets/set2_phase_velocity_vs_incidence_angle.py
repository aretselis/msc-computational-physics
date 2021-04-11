import numpy as np
import matplotlib.pyplot as plt


def percent_stability_criterion(dx, dy, percent):
    # Computes a percent of the stability limit for the explicit 2D Formulation
    # Input: dx, dy, percent
    # Output: dt
    if dx == dy:
        dt = percent * dx / np.sqrt(2)
    else:
        dt = percent * 1 / (np.sqrt((1 / pow(dx, 2)) + (1 / pow(dy, 2))))
    return dt


def k_hat_newton(theta, dx, dy, dt, lambd):
    # Computes k_hat using the Newton-Raphson method
    # Input: theta [deg], dx, dy, dt, l
    # Output: k_hat
    theta = np.deg2rad(theta)
    # Define f and f dot
    f = lambda khat: ((1 / pow(dx, 2)) * pow(np.sin(khat * np.cos(theta) * dx / 2), 2)) + (
                (1 / pow(dy, 2)) * pow(np.sin(khat * np.sin(theta) * dy / 2), 2)) - (
                                 (1 / pow(dt, 2)) * pow(np.sin(np.pi * dt / lambd), 2))
    fdot = lambda khat: (np.cos(theta) / (2 * dx)) * np.sin(khat * np.cos(theta) * dx) + (
                np.sin(theta) / (2 * dy)) * np.sin(khat * np.sin(theta) * dy)
    # Stopping criteria
    n = 10  # Number of significant digits to be computed
    max_repetitions = 1000
    es = 0.5 * pow(10, (2 - n))  # Scarborough Criterion
    ea = 100
    k_prev = 2 * np.pi / lambd
    repetitions = 0
    # Main Newton-Raphson loop
    while ea > es:
        repetitions = repetitions + 1
        k_next = k_prev - (f(k_prev) / fdot(k_prev))
        ea = np.fabs((k_next - k_prev) * 100 / k_next)
        k_prev = k_next
        if repetitions > max_repetitions:
            print('Max repetitions reached without achieving desired accuracy for E!')
            break
    k_hat = k_next
    return k_hat


def phase_velocity_vs_theta_diagram(dx, dy, dt, lambd, min_theta, max_theta):
    # Creates a numerical phase velocity diagram vs theta for theta interval [min_theta, max_theta]
    # Input: dx, dy, dt, lambd, min_theta, max_theta
    # Output: None (can plot figure using plt.show())
    step_size = 1
    total_size = int(((max_theta - min_theta) / step_size) + 1)
    vpc_values = np.zeros(total_size)
    # Compute k and v_p/c values
    for i in range(0, total_size):
        theta = i * step_size
        k = k_hat_newton(theta, dx, dy, dt, lambd)
        vpc_values[i] = 2 * np.pi / (lambd * k)
    # Plot output
    plt.plot(vpc_values, label="$\Delta x = %.2f \lambda$\n$\Delta y = %.2f \lambda$" % (dx, dy))
    plt.title("Numerical phase velocity vs θ (for Δt = 90% of stability limit)")
    plt.ylabel(r"$v_{p}/c$")
    plt.xlabel(r"$\theta$ [degrees]")
    plt.legend()
    return None


theta_start = 0
theta_end = 90

# Case A: Delta_x = Delta_y = lambda/10, Delta_t = 0.9 C.L.
lmbd = 1
Delta_x = lmbd / 10
Delta_y = lmbd / 10
Delta_t = percent_stability_criterion(Delta_x, Delta_y, 0.9)
phase_velocity_vs_theta_diagram(Delta_x, Delta_y, Delta_t, lmbd, theta_start, theta_end)

# Case B: Delta_x = lambda/10, Delta_y = lambda/20, Delta_t = 0.9 C.L.
lmbd = 1
Delta_x = lmbd / 10
Delta_y = lmbd / 20
Delta_t = percent_stability_criterion(Delta_x, Delta_y, 0.9)
phase_velocity_vs_theta_diagram(Delta_x, Delta_y, Delta_t, lmbd, theta_start, theta_end)

# Show resulting plot
plt.grid()
plt.show()

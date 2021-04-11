import numpy as np
import matplotlib.pyplot as plt


def percent_stability_criterion(dx, dy, percent):
    # Computes a percent of the stability limit for the explicit 2D Formulation
    # Input: dx, dy, percent
    # Output: dt
    if dx == dy:
        dt = percent * dx/np.sqrt(2)
    else:
        dt = percent * 1/(np.sqrt((1/pow(dx, 2))+(1/pow(dy, 2))))
    return dt


def k_hat_newton(theta, dx, dy, dt, l):
    theta = np.deg2rad(theta)
    # Define f and f dot
    f = lambda khat: ((1/pow(dx, 2))*pow(np.sin(khat*np.cos(theta)*dx/2), 2)) + ((1/pow(dy, 2))*pow(np.sin(khat*np.sin(theta)*dy/2), 2)) - ((1/pow(dt, 2))*pow(np.sin(np.pi*dt/l),2))
    fdot = lambda khat: (np.cos(theta)/(2*dx))*np.sin(khat*np.cos(theta)*dx) + (np.sin(theta)/(2*dy))*np.sin(khat*np.sin(theta)*dy)
    # Stopping criteria
    N = 5  # Number of significant digits to be computed
    max_repetitions = 1000
    es = 0.5 * pow(10, (2 - N))  # Scarborough Criterion
    ea = 100
    k_prev = 2*np.pi/l
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
    k = k_next
    return k


# Case A: Delta_x = Delta_y = lambda/10
lmbd = 1
Delta_x = Delta_y = lmbd/10
Delta_t = percent_stability_criterion(Delta_x, Delta_y, 0.9)

vpc_values = np.zeros(90)

for i in range(0, 90):
    k = k_hat_newton(i, Delta_x, Delta_y, Delta_t, lmbd)
    vpc_values[i] = 2*np.pi/(lmbd*k)

plt.plot(vpc_values)
plt.grid()
plt.show()
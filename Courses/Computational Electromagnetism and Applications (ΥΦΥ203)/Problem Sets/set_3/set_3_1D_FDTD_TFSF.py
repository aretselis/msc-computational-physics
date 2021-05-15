import numpy as np
from scipy.optimize import minimize
import matplotlib.pyplot as plt
import matplotlib.animation as animation


def source(omega, t):
    tw = pow(10, -10)
    t0 = tw * 10
    if t <= t0:
        return np.sin(omega * t) * np.exp(-pow(t - t0, 2) / pow(tw, 2))
    else:
        return np.sin(omega * t)


# def advance_time(Hy, Ex, dt, c):


# Constants
c = 3 * pow(10, 8)
mu_0 = 4 * np.pi * pow(10, -7)
epsilon_0 = 1 / (pow(c, 2) * mu_0)

# Grid
size = 200
dx = 0.01
grid_start = 0
grid_end = size - 1

# Source definition
frequency = pow(10, 9)
T = 1 / frequency
lambda_source = c / frequency
omega = 2 * np.pi * frequency
source_location = 50

# Time
N_periods = 5
S = 0.99
dt = S * dx / c
t_max = round(N_periods * T / dt)

# Add and initialize electric and magnetic field
Hy = np.zeros(size)
Ez = np.zeros(size)
Ez_recording = np.zeros((t_max, size))
Hy_recording = np.zeros((t_max, size))
epsilon_r = np.ones(size)

# Advance time

for j in range(0, t_max):

    # Update magnetic field
    for i in range(0, size - 1):
        Hy[i] = Hy[i] - (dt / mu_0) * ((Ez[i + 1] - Ez[i]) / dx)

    for i in range(1, size):
        Ez[i] = Ez[i] - (dt / epsilon_0) * ((Hy[i] - Hy[i - 1]) / dx)

    # Hardwire a source
    Ez[source_location] = source(omega, j*dt)

    # Mur absorving boundary conditions
    if j > 2:
        Ez[grid_end] = Ez_secondtolast_prev + ((c * dt - dx) / (c * dt + dx)) * (Ez[grid_end - 1] - Ez_end_prev)
        Ez[grid_start] = Ez_1_prev + ((c * dt - dx) / (c * dt + dx)) * (Ez[1] - Ez_0_prev)

    Ez_0_prev = Ez[0]
    Ez_1_prev = Ez[1]
    Ez_end_prev = Ez[grid_end]
    Ez_secondtolast_prev = Ez[grid_end - 1]

    # Record Ez & Hy
    Ez_recording[j][:] = Ez
    Hy_recording[j][:] = Hy

fig, ax = plt.subplots()
xdata, ydata = [], []
ln, = plt.plot([], [])


def init():
    ax.set_xlim(0, 200)
    ax.set_ylim(-4 * pow(10,-3), 4 * pow(10,-3))
    return ln,


def update(frame):
    xdata = np.arange(0, size, 1)
    ydata = Hy_recording[frame][:]
    ln.set_data(xdata, ydata)
    return ln,


ani = animation.FuncAnimation(fig, update, frames=t_max,
                              init_func=init)
plt.show()

import numpy as np
from scipy.optimize import minimize
import matplotlib.pyplot as plt
import matplotlib.animation as animation


def source(omega, t):
    tw = pow(10, -10)
    t0 = tw * 10
    if t <= t0:
        return 2*np.sin(omega * t) * np.exp(-pow(t - t0, 2) / pow(tw, 2))
    else:
        return 2*np.sin(omega * t)


# def advance_time(Hy, Ex, dt, c):


# Constants
c = 3 * pow(10, 8)
mu_0 = 4 * np.pi * pow(10, -7)
epsilon_0 = 1 / (pow(c, 2) * mu_0)

# Source definition
frequency = pow(10, 9)
T = 1 / frequency
lambda_source = c / frequency
omega = 2 * np.pi * frequency
source_location = 90

# Grid
size = 500
dx = lambda_source/25
grid_start = 0
grid_end = size - 1
TFSF_location = 75

# Time
N_periods = 30
S = 0.99
dt = S * dx / c
t_max = round(N_periods * T / dt)

# Material definition, ranging from [position, infinity)

material_location = 250
sigma_mat = 0.01
epsilon_r = 2
mu_r = 1
eaf = dt * sigma_mat/(2*epsilon_0*epsilon_r)
c_r = c/np.sqrt(epsilon_r*mu_r)

# Add and initialize electric and magnetic field
Hy = np.zeros(size)
Ez = np.zeros(size)
Ez_inc = np.zeros(size)
Hy_inc = np.zeros(size)
Ez_recording = np.zeros((t_max, size))
Hy_recording = np.zeros((t_max, size))

# Advance time
H_const_free_space = dt / (mu_0 * dx)
E_const_free_space = dt / (epsilon_0 * dx)


for j in range(0, t_max):

    # Record inc fields
    for i in range(0, size - 1):
        Hy_inc[i] = Hy_inc[i] - H_const_free_space * (Ez_inc[i+1] - Ez_inc[i])
    for i in range(1, size):
        Ez_inc[i] = Ez_inc[i] - E_const_free_space * (Hy_inc[i] - Hy_inc[i - 1])

    # Update magnetic field
    for i in range(0, size - 1):
        if i < material_location:
            Hy[i] = Hy[i] - H_const_free_space * (Ez[i + 1] - Ez[i])
        else:
            Hy[i] = Hy[i] - (dt / (mu_0 * mu_r * dx)) * (Ez[i + 1] - Ez[i])

    # Update electric field
    for i in range(1, size):
        if i < material_location:
            Ez[i] = Ez[i] - E_const_free_space * (Hy[i] - Hy[i - 1])
        else:
            Ez[i] = ((1-eaf)/(1+eaf))*Ez[i] - (dt / (epsilon_0*epsilon_r * dx*(1+eaf))) * (Hy[i] - Hy[i - 1])

    # Hardwire a source
    Ez[source_location] = Ez[source_location] + source(omega, j * dt)
    Ez_inc[source_location] = Ez_inc[source_location] + source(omega, j * dt)
    Hy[TFSF_location] = Hy[TFSF_location] + H_const_free_space * Ez_inc[TFSF_location + 1]
    Ez[TFSF_location + 1] = Ez[TFSF_location + 1] + E_const_free_space * Hy_inc[TFSF_location]

    # Mur absorving boundary conditions
    if j > 2:
        Ez[grid_end] = Ez_secondtolast_prev + ((c_r * dt - dx) / (c_r * dt + dx)) * (Ez[grid_end - 1] - Ez_end_prev)
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
    ax.set_xlim(0, size)
    #ax.set_ylim(-4 * pow(10,-3), 4 * pow(10,-3))
    ax.set_ylim(-2, 2)
    ax.grid()
    ax.axvline(TFSF_location, color='red')
    ax.set_title("TFSF Implementation with material on the right")
    ax.text((TFSF_location-50), 1.8, 'SF')
    ax.text((TFSF_location + 50), 1.8, 'TF')
    ax.text((material_location + 50), 1.8, 'Material')
    ax.axvspan(material_location, size, facecolor='green', alpha=0.3)
    return ln,


def update(frame):
    xdata = np.arange(0, size, 1)
    ydata = Ez_recording[frame][:]
    ln.set_data(xdata, ydata)
    return ln,


ani = animation.FuncAnimation(fig, update, frames=t_max,
                              init_func=init, interval=1)
plt.show()

plt.figure()
x_data = np.zeros(5)
y_data = np.zeros(5)
for i in range(1,6):
    y_data[i-1] = pow((1-np.sqrt(i))/(np.sqrt(i)+1),2)
    x_data[i-1] = i
plt.plot(x_data, y_data, '.')
plt.show()
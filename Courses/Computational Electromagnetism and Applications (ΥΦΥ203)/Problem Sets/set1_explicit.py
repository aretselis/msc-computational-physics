import numpy as np
import matplotlib.pyplot as plt
# Make jupyter export images as .pdf files for higher quality
from IPython.display import set_matplotlib_formats

set_matplotlib_formats('png', 'pdf')


def initial_conditions(array):
    # Defines initial conditions for the problem
    # Input is a 2D array
    # Output is the 2D array with the applied initial/boundary conditions
    lower_limit = 2
    upper_limit = 11
    for i in range(lower_limit - 1, upper_limit):
        array[0][i] = 1
        array[1][i + 1] = 1
    return (array)


def solve_1D_FDTD_stencil(u, dx, dt):
    # Solves the 1D FDTD Stencil
    # Input is the grid in form of a 2D array w/ initial+boundary conditions
    # Output is the grid
    for n in range(1, size - 1):
        for i in range(0, size - 1):
            u[n + 1][i] = pow(c * dt, 2) * ((u[n][i + 1] - 2 * u[n][i] + u[n][i - 1]) / pow(dx, 2)) + 2 * u[n][i] - \
                          u[n - 1][i]
    return (u)


def plot_frame(array, id1, id2, id3, id4, case):
    # Extract frames from an array and plots them
    # Note that with this convention we have if we request frame number i the index of the frame is i+2
    plt.ylabel(r'$u_{i}$')
    plt.xlabel('Grid coordinate i')
    frame1 = array[id1 + 2, :]
    frame2 = array[id2 + 2, :]
    frame3 = array[id3 + 2, :]
    frame4 = array[id4 + 2, :]
    fig1 = plt.plot(frame1, label=r'$u_{{i}}^{{{}}}$'.format(id1))
    plt.plot(frame2, label=r'$u_{{i}}^{{{}}}$'.format(id2))
    plt.plot(frame3, label=r'$u_{{i}}^{{{}}}$'.format(id3))
    plt.plot(frame4, label=r'$u_{{i}}^{{{}}}$'.format(id4))
    plt.grid()
    plt.legend()
    plt.title('Combined frames for $\Delta t={}\Delta x/c$\n'.format(case))
    fig, axs = plt.subplots(2, 2)
    axs[0, 0].plot(frame1, label=r'$u_{{i}}^{{{}}}$'.format(id1))
    axs[0, 0].grid()
    axs[0, 0].legend()
    axs[0, 1].plot(frame2, 'tab:orange', label=r'$u_{{i}}^{{{}}}$'.format(id2))
    axs[0, 1].grid()
    axs[0, 1].legend()
    axs[1, 0].plot(frame3, 'tab:green', label=r'$u_{{i}}^{{{}}}$'.format(id3))
    axs[1, 0].grid()
    axs[1, 0].legend()
    axs[1, 1].plot(frame4, 'tab:red', label=r'$u_{{i}}^{{{}}}$'.format(id4))
    axs[1, 1].grid()
    axs[1, 1].legend()
    for ax in axs.flat:
        ax.set(xlabel=r'Grid coordinate i', ylabel=r'$u_{i}$')
    for ax in axs.flat:
        ax.label_outer()


size = 120
c = 1

# Case 1
dx = 0.1
a = 0.9
dt = a * dx / c
u = np.zeros((size, size))
u = initial_conditions(u)
u = solve_1D_FDTD_stencil(u, dx, dt)

# Extract and plot frames for case 1
plot_frame(u, 25, 50, 75, 100, a)
plt.suptitle('Case 1: $\Delta t={}\Delta x/c$\n '.format(a))
plt.show()

# Case 2
dx = 0.1
a = 1
dt = a * dx / c
u = np.zeros((size, size))
u = initial_conditions(u)
u = solve_1D_FDTD_stencil(u, dx, dt)

# Extract and plot frames for case 2
plot_frame(u, 25, 50, 75, 100, a)
plt.suptitle('Case 2: $\Delta t={}\Delta x/c$\n '.format(a))
plt.show()

# Case 3
dx = 0.1
a = 1.1
dt = a * dx / c
u = np.zeros((size, size))
u = initial_conditions(u)
u = solve_1D_FDTD_stencil(u, dx, dt)

# Extract and plot frames for case 3
plot_frame(u, 25, 50, 75, 100, a)
plt.suptitle('Case 3: $\Delta t={}\Delta x/c$\n '.format(a))
plt.show()

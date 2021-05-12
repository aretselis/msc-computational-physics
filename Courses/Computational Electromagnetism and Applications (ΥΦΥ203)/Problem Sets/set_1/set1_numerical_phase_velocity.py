import numpy as np
import matplotlib.pyplot as plt
# Make jupyter export images as .pdf files for higher quality
from IPython.display import set_matplotlib_formats

set_matplotlib_formats('png', 'pdf')

# x_values correspond to Δx/lambda_0
x_values = np.linspace(0.00001, 0.3, 10000)
# y_values correspond to v_ph/c

# Case a: cΔt=Δx/2
y_values = 2 * np.pi / (np.arccos(4 * (np.cos(np.pi * x_values) - 1) + 1)) * x_values
plt.semilogx(x_values, y_values, label=r'$c\Delta t=\frac{\Delta x}{2}$')
plt.ylim(0, 1.2)

# Case b: cΔt=Δx/4
y_values = 2 * np.pi / (np.arccos(16 * (np.cos(np.pi * x_values / 2) - 1) + 1)) * x_values
plt.semilogx(x_values, y_values, label=r'$c\Delta t=\frac{\Delta x}{4}$')
plt.legend()
plt.ylim(0.75, 1.05)
plt.xlabel(r'$\frac{\Delta x}{\lambda_{o}}$')
plt.ylabel(r'$\frac{v_{p}}{c}$')
plt.grid()
plt.show()

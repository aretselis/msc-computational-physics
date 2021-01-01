import numpy as np
import matplotlib.pyplot as plt

# Newton-Raphson method

# Function Definition
f = lambda x: pow(x, 2) - 1 + np.log(x + 1)
fdot = lambda x: 2 * x + (1 / (x + 1))

# Initial search condition and max iterations definition
x0 = 1
xr = x0
iterations = 0
max_iterations = 200

# Main Loop
while iterations < max_iterations:
    xr_old = xr
    xr = xr_old - (f(xr_old) / fdot(xr_old))
    iterations += 1
    if abs(xr - xr_old) < pow(10, -4):
        break

# Print and Plot Results
print('Newton-Raphson Method:')
if iterations < max_iterations:
    print('Root found (after %d iterations)! x_root = %.5f' % (iterations, xr))
else:
    print('Max iterations reached without solution!')

x_plot = np.linspace(0, 1, 100)
y_plot = f(x_plot)

plt.figure()
plt.plot(x_plot, y_plot, label=r'$f(x)$')
plt.title(r'Plot of $f(x)=x^{2}-1+ln(x+1)$')
plt.xlabel('x')
plt.ylabel('y')
plt.grid()
plt.legend()
plt.show()

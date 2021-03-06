import math as m
import matplotlib.pyplot as plt


def runge_kutta_4(x0, y0, xmax, h):
    xn = [x0]
    yn = [y0]
    i = 0
    while xn[i] < xmax:
        # Calculate k values
        k1 = h * f(xn[i], yn[i])
        k2 = h * f(xn[i] + (h / 2), yn[i] + (k1 / 2))
        k3 = h * f(xn[i] + (h / 2), yn[i] + (k2 / 2))
        k4 = h * f(xn[i] + h, yn[i] + k3)
        # Compute y value and append to list
        yn.append(yn[i] + (1 / 6) * (k1 + 2 * k2 + 2 * k3 + k4))
        i += 1
        # Compute next x
        xn.append(xn[i - 1] + h)
    return xn, yn


def f(x, y):
    # Assuming y'(x)=f(x,y)
    # This example uses y'(x)=y(x)*cos(x+y(x))
    return y * m.cos(x + y)


# Test the implementation:
# Define initial conditions, search interval and step size
x_0 = 0
y_0 = 1
interval = [0, 10]
step = 0.001
# Extract and plot the solution
xplot, yplot = runge_kutta_4(x_0, y_0, interval[1], step)
plt.plot(xplot, yplot)
plt.title('Numerical Solution for y\'(x)=y(x)cos(x+y(x)) in [0, 10]'
          '\nBased on 4th Order Runge Kutta')
plt.xlabel('x')
plt.ylabel('y')
plt.grid()
plt.show()

import numpy as np
import matplotlib.pyplot as plt
# Make jupyter export images as .pdf files for higher quality
from IPython.display import set_matplotlib_formats
set_matplotlib_formats('png', 'pdf')
# Silent run for NaNs
import warnings
warnings.filterwarnings('ignore')

def r1(x, y, mu):
    return np.sqrt(pow(x+mu, 2) + pow(y, 2))

def r2(x, y, mu):
    return np.sqrt(pow(x-1+mu, 2) + pow(y,2))

def f(x, y, m, Cj):
    rho_1 = r1(x, y, m)
    rho_2 = r2(x, y, m)
    return (1-mu)/rho_1 + mu/rho_2 + 0.5*(pow(x, 2)+pow(y, 2)) + Cj

m_didimos = 5.32*pow(10, 11)
m_dimorphos = 4.94*pow(10, 9)
R_didimos = 325
R_dimorphos = 80
r = 1180
mu = m_dimorphos/(m_didimos+m_dimorphos)
Cj = -1.585

x = np.linspace(-1.5,1.5,1000)
y = np.linspace(-1.5,1.5,1000)

X,Y = np.meshgrid(x, y)
Z = f(X,Y,mu,Cj)

# Print ZVC for the binary and desired Cj (h)

dimorphos_object = plt.Circle((1.0-mu,0.0), R_dimorphos/r, color='r')
didimos_object = plt.Circle((-mu,0.0), R_didimos/r, color='blue')

fig, ax = plt.subplots()
plt.contour(X,Y,Z, colors='black', levels=0)
ax.add_patch(dimorphos_object)
ax.add_patch(didimos_object)
ax.legend(['Dimorphos','Didymos'])
ax.axis('equal')
ax.set_xlim(-2, 2)
ax.set_ylim(-2, 2)
ax.set_xlabel("x, [normalized units]")
ax.set_ylabel("y, [normalized units]")
ax.set_title('Zero velocity curves for h = '+str(Cj))
plt.grid()
fig.savefig("zvc_both.pdf", format='pdf')

# Zoom in to dimorphos

dimorphos_object = plt.Circle((1.0-mu,0.0), R_dimorphos/r, color='r')

fig2, ax2 = plt.subplots()
plt.contour(X,Y,Z, colors='black', levels=0)
ax2.add_patch(dimorphos_object)
ax2.legend(['Dimorphos'])
ax2.axis('equal')
ax2.set_xlim(1-2*R_dimorphos/r, 1+2*R_dimorphos/r)
ax2.set_ylim(-2*R_dimorphos/r, 2*R_dimorphos/r)
ax2.set_xlabel("x, [normalized units]")
ax2.set_ylabel("y, [normalized units]")
ax2.set_title('Zero velocity curves for h = '+str(Cj))
plt.grid()
fig2.savefig("zvc_dimorphos.pdf", format='pdf')

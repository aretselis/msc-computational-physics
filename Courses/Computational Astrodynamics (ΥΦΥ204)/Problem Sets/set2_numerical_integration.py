import numpy as np

# Constants definition

G = 6.6743*pow(10, -11)
M_earth = 5.977*pow(10, 24)
mu_earth = G*M_earth
R_earth = 6371000  # [meters]

# Orbit definition
H = 400000  # [meters]
a = R_earth + H
i = 0
e = 0
Omega = 0
omega = 0
M = 0

# Initial conditions t=0

a = R_earth + H
v = np.sqrt(mu_earth/a)


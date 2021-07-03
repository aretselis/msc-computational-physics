import matplotlib.pyplot as plt

m_didimos = 5.32 * pow(10, 11)
m_dimorphos = 4.94 * pow(10, 9)
mu = m_dimorphos / (m_didimos + m_dimorphos)
R_didimos = 325
R_dimorphos = 80
r = 1180
dimorphos_object = plt.Circle((1.0-mu,0.0), R_dimorphos/r, color='r')
didimos_object = plt.Circle((-mu,0.0), R_didimos/r, color='blue')
a = pow(mu / 3, 1 / 3)

Lx = []

# Compute L1, L2, L3

Lx.append(1 - mu - a + pow(a, 2) / 3 + pow(a, 3) / 9 + 23 * pow(a, 4) / 81)  # L1
Lx.append(1 - mu + a + pow(a, 2) / 3 - pow(a, 3) / 9 - 23 * pow(a, 4) / 81)  # L2
Lx.append(-1 - mu + 7*mu/(12*(1-mu)) - 7*pow(mu/(1-mu), 2)/12 + 13223*pow(mu/(1-mu), 3)/20736)  # L3

Ly = [0.0, 0.0, 0.0]

# Compute L4,L5

Lx.append(1 / 2 - mu)
Lx.append(1 / 2 - mu)
Ly.append(pow(3, 1 / 2) / 2)
Ly.append(-pow(3, 1 / 2) / 2)

# Print locations

for i in range(len(Lx)):
    print("L"+str(i+1)+" location: x = " + str(Lx[i]) +"  y = " + str(Ly[i]))

# Get h values

h = []
h.append(-(3+pow(3, 4/3)*pow(mu, 2/3)-10*mu/3)/2)  # L1
h.append(-(3+pow(3, 4/3)*pow(mu, 2/3)-14*mu/3)/2)  # L2
h.append(-(3+mu)/2)  # L3
h.append(-(3-mu)/2)  # L4
h.append(-(3-mu)/2)  # L5

# Print energy values

for i in range(len(Lx)):
    print("h at point L"+str(i+1)+": " + str(h[i]))

# Plot for normalized units

fig, ax = plt.subplots()
ax.scatter(Lx, Ly)
ax.add_patch(didimos_object)
ax.add_patch(dimorphos_object)
ax.axis('equal')
ax.legend(['Didymos', 'Dimorphos'])
n = ["L1", "L2", "L3", "L4", "L5"]
for i, txt in enumerate(n):
    ax.annotate(txt, (Lx[i], Ly[i]+0.03))
ax.set_xlabel("x, [normalized units]")
ax.set_ylabel("y, [normalized units]")
ax.set_title("Lagrange points for Didymos-Dimorphos")
ax.grid()
fig.savefig("Lagrange_points_loc.pdf", format='pdf')

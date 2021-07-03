import matplotlib.pyplot as plt

m_didimos = 5.32 * pow(10, 11)
m_dimorphos = 4.94 * pow(10, 9)
mu = m_dimorphos / (m_didimos + m_dimorphos)
a = pow(mu / 3, 1 / 3)

Lx = []

# Compute L1, L2, L3

Lx.append(1 - mu - a + pow(a, 2) / 3 + pow(a, 3) / 9 + 23 * pow(a, 4) / 81)  # L1
Lx.append(1 - mu + a + pow(a, 2) / 3 - pow(a, 3) / 9 - 23 * pow(a, 4) / 81)  # L2
Lx.append(-1 - mu + 7*mu/(12*(1-mu)) - 7*pow(mu/(1-mu), 2)/12 + 13223*pow(mu/(1-mu), 3)/20736)

Ly = [0.0, 0.0, 0.0]

# Compute L4,L5

Lx.append(1 / 2 - mu)
Lx.append(1 / 2 - mu)
Ly.append(pow(3, 1 / 2) / 2)
Ly.append(-pow(3, 1 / 2) / 2)

# # Get h values
#
# C4 = C5 = 3 - mu
# print(C4, C5)

for i in range(len(Lx)):
    print("L"+str(i+1)+" location: x= " + str(Lx[i]) +"  y= " + str(Ly[i]))
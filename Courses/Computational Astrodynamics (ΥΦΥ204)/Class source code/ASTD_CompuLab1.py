import numpy as np

R_earth = 6371000 # meters
G = 6.67*pow(10, -11)
M = 5.977 * pow(10, 24)
mu = G*M

# Exercise 1

height = 322000
T = 2*np.pi*np.sqrt(pow(R_earth+height, 3)/mu)
T = T/60  # Convert to minutes
print('Period = %.2f minutes' % T)

# Exercise 2

R1 = R_earth + height
R2 = R_earth + 35786000  # Target Geostatic

v_c1 = np.sqrt(mu/R1)
v_c2 = np.sqrt(mu/R2)

a = (R1+R2)/2
e = (R2-R1)/(R2+R1)
v_p = np.sqrt((mu/a)*((1+e)/(1-e)))
v_a = np.sqrt((mu/a)*((1-e)/(1+e)))

Delta_v_1 = v_p - v_c1
Delta_v_2 = v_c2 - v_a

print('Delta_v_1 = %.2f m/s' % Delta_v_1)
print('Delta_v_2 = %.2f m/s' % Delta_v_2)

# Exercise 3

TOF = np.pi*np.sqrt(pow(a, 3)/mu)

print('Time of Flight = %.2f seconds' % TOF)

# Exercise 4

planet_rotation = 360*TOF/86164
print(planet_rotation)
lon_greece = 23.7275
desired_longitude = 23.7275 - (90+(90-planet_rotation))
print('Start longitude = %.4f degrees' % desired_longitude)

theta = np.pi*(1-((1/(2*np.sqrt(2)))*np.sqrt(1+pow((R1/R2), 3))))
print(np.degrees(theta))
print(planet_rotation + np.degrees(theta))

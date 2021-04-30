import numpy as np

def energy(speed, r, mu):
    return (pow(speed, 2)/2)-(mu/r)

def semimajor_axis(rp, ra):
    return (rp+ra)/2

def eccentricity(rp, ra):
    return (ra-rp)/(ra+rp)


# 1
sigma = 5.67*pow(10, -8)
T = 5780
R = 6.955*pow(10, 8)
distance_earth_sun = 149597871000

power = sigma*pow(T, 4)*4*np.pi*pow(R, 2)
#print(power)
power = power/(4*np.pi*pow(R,2))
#print(power)

#2
sigma = 5.67*pow(10, -8)
a = 0.33
R_earth = 6371000
J_s = 1368

T = pow(a*J_s/(sigma*2), 1/4)
#print(T)

T=255
J_r = sigma*pow(T, 4)
#print(J_r)
dist = R_earth + 900000
F = pow(R_earth/dist, 2)

ir_flux = J_r*(4*np.pi*pow(R_earth, 2))/(4*np.pi*pow(dist, 2))
#print(ir_flux)

#3
sigma = 5.67*pow(10, -8)
e_ir = 0.6
area = 6*(2*2)
T = 300

power = e_ir*sigma*area*pow(T, 4)
#print(power)

# 4
sigma = 5.67*pow(10, -8)
a = 0.3

F = pow(R_earth/(R_earth+10000000), 2)
#print(F)
#print(F*a*1368)

# 5
sigma = 5.67*pow(10, -8)
a = 0.96
e = 0.75

T = pow((a*1368)/(e*sigma*2), 1/4)
#print(T)

# 6
sigma = 5.67034*pow(10, -8)
r_sc = 1
a = 0.4
e = 0.2
p_dis = 150
flux = 1368
albedo = 0.3
r_earth = 6371000

ir_flux = pow(255, 4)*sigma*pow(r_earth,2)/(pow(r_earth+1000000,2))
#print(ir_flux)

F = 1#pow(r_earth/(r_earth+1000000), 2)
albedo_flux = albedo*flux*F
#print(albedo_flux)

A_a = np.pi*pow(r_sc, 2)
A_e = 4*np.pi*pow(r_sc, 2)
Q_abs = a*flux*A_a + a*albedo_flux*A_a + e*ir_flux*A_a
#print(Q_abs)
T = pow((Q_abs+p_dis)/(e*sigma*A_e), 1/4)
print(T)

A_a = np.pi*pow(r_sc, 2)
A_e = 4*np.pi*pow(r_sc, 2)
Q_abs = e*ir_flux*A_a
#print(Q_abs)
T = pow((Q_abs)/(e*sigma*A_e), 1/4)
print(T)

# 7
sigma = 5.67*pow(10, -8)
distance_earth_sun = 149597871000
area = 10

power = 1400*4*np.pi*pow(distance_earth_sun, 2)
#print(power)

flux = power/(4*np.pi*pow(4.4*distance_earth_sun, 2))
#print(flux)

a = 0.8
e = 0.7

Q_abs = a*area*flux
P_elec = 108

T = pow((Q_abs-P_elec)/(e*sigma*2*area), 1/4)
#print(T)

# 8
sigma = 5.67*pow(10, -8)
distance_earth_sun = 149597871000
area = 10

power = 1367*4*np.pi*pow(distance_earth_sun, 2)
print(power)

flux = power/(4*np.pi*pow(0.3*distance_earth_sun, 2))
print(flux)

a = 0.15
e_front = 0.9
e_back = 0.8

T_a = pow(a*flux*2/(sigma*e_front*np.pi+sigma*e_back*np.pi), 1/4)
print(T_a)

T = pow(pow(T_a, 4)*e_back/2, 1/4)
print(T)
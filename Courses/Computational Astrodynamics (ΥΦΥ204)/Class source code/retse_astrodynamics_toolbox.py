import numpy as np

def energy(speed, r, mu):
    return (pow(speed, 2)/2)-(mu/r)

def semimajor_axis(rp, ra):
    return (rp+ra)/2

def eccentricity(rp, ra):
    return (ra-rp)/(ra+rp)



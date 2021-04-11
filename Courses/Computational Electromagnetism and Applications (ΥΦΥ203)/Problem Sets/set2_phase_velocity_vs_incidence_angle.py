import numpy as np


def percent_stability_criterion(dx, dy, percent):
    # Computes a percent of the stability limit for the explicit 2D Formulation
    # Input: dx, dy, percent
    # Output: dt
    if dx == dy:
        dt = percent * dx/np.sqrt(2)
    else:
        dt = percent * 1/(np.sqrt((1/pow(dx, 2))+(1/pow(dy, 2))))
    return dt


# Case A: Delta_x = Delta_y = lambda/10

lmbd = 1
Delta_x = Delta_y = lmbd/10

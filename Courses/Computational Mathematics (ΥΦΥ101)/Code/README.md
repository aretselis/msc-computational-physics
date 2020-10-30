# Source code

Supplementary code written by me to accompany the notes of the class

## 1 - scarborough_exponential.c

**Language:** C

Ask the user for a value x (to compute e^x) and minimum number of significant digits n to be computed (Scarborough formula). Show computational process to user and return final value of e^x alongside approximation error ea. 

## 1 - taylor_and_irregular_points.m

**Language:** Mathematica

Brief mathematica notebook explaining the convergence of taylor series and the impact of irregular singular points to the convergence.

## 2-bisection_root_finder.class

**Language:** c

A C program which uses the bisection method in order to find the root of a function. It uses the scarborough criterion as a stopping condition. As a default, the program uses the function:

```math
f(x)=\frac{gm}{x}(1-e^{\frac{-xt}{m}})-v
```

With initial conditions t=10, g=9.8, v=40 and m=68.1. This function is based on the following **problem statement**:

Use the graphical approach to determine the drag coefficient c needed for a parachutist of mass m=68.1 kg to have a velocity of 40 m/s after free-falling for time t=10s. (_Note:_ The acceleration due to gravity is 9.8 m/s^2.)

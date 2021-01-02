clear; clc; close all;

n = 100000;
radius = 1;
max = radius;
min = -radius;
length = radius;

% The code below is completely vectorized, meaning it does not use any
% actual loop structures, in order to fully utilize MATLAB to achieve
% faster speeds

coordinates = min + (max-min).*rand(3,n);
r = sqrt(coordinates(1,:).^2+coordinates(2,:).^2+coordinates(3,:).^2);
r_inside = r <= radius;
n_inside_sphere = sum(r_inside);

pi_approx = 6*n_inside_sphere/n;
pi_approx
% Programming Tools (ΥΦΥ103)
% Solution for MonteCarlo exam
% Implemented by Anastasios-Faidon Retselis
clear; clc; close all;

n = 100000000;
radius = 1;
max = radius;
min = -radius;

% The code below is completely vectorized, meaning it does not use any
% actual loop structures, in order to fully utilize MATLAB to achieve
% faster speeds

vector_coordinates = min + (max-min).*rand(3,n);
r = sqrt(vector_coordinates(1,:).^2+vector_coordinates(2,:).^2+...
    vector_coordinates(3,:).^2);
r_inside = r <= radius;
n_inside_sphere = sum(r_inside);

pi_approx = 6*n_inside_sphere/n;
pi_error = 6*std(r_inside)/sqrt(length(r));
pi_lower = pi_approx - pi_error;
pi_upper = pi_approx + pi_error;

fprintf('π_approx = %.5f\n', pi_approx);
fprintf('error = %.5f\n', pi_error);
fprintf('Actual π will be inside [%.5f, %.5f]\n', pi_lower, pi_upper);
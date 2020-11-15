% Data Analysis and Processing using MATLAB (ΥΦΥ104)
% Solution for exercise Chapter3_2
% Implemented by Anastasis Retselis
clear;clc;

% User input
M = input('Enter number of samples M: ');
n = input('Enter size of each sample n: ');
tau = input('Enter tau parameter: ');

% Results and diagram
mean_sim = exponential_simulation(tau, n, M);
fprintf('Average of every sample mean is %.4f. \n',mean(mean_sim));
% Data Analysis and Processing using MATLAB (ΥΦΥ104)
% Solution for exercise Chapter3_1
% Implemented by Anastasis Retselis 
clear;clc;

% User input
M = input('Enter number of samples M: ');
n = input('Enter size of each sample n: ');
lambda = input('Enter lambda parameter: ');

% Results and histogram
mean_sim = poisson_simulation(M,n,lambda);
fprintf('Average of every sample mean is %.4f. \n',mean(mean_sim));

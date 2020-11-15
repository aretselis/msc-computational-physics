% Data Analysis and Processing using MATLAB (ΥΦΥ104)
% Solution for exercise Chapter3_2
% Implemented by Anastasis Retselis
clear;clc;

% User input
M = input('Enter number of samples M: ');
n = input('Enter size of each sample n: ');
tau = input('Enter tau parameter: ');

% Results and diagram
sim = exprnd(tau, n, M);
mean_sim = mean(sim);
figure;
histogram(mean_sim);
title({['Histogram of mean values for ' num2str(M) ' samples with si'...
    'ze ' num2str(n)] [' for an exponential distribution with'...
    ' \tau=' num2str(tau)]});
xlabel('Sample mean')
ylabel('Counts');
fprintf('Average of every sample mean is %.4f. \n',mean(mean_sim));
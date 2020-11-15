% Data Analysis and Processing using MATLAB (ΥΦΥ104)
% Solution for exercise Chapter3_1
% Implemented by Anastasis Retselis 
clear;clc;

% User input
M = input('Enter number of samples M: ');
n = input('Enter size of each sample n: ');
lambda = input('Enter lambda parameter: ');

% Results and histogram
sim = poissrnd(lambda, n, M);
mean_sim = mean(sim);
figure;
histogram(mean_sim);
title({['Histogram of mean values for ' num2str(M) ' samples with si'...
    'ze ' num2str(n)] [' for a Poisson distribution with'...
    ' \lambda=' num2str(lambda)]});
xlabel('Sample mean')
ylabel('Counts');
fprintf('Average of every sample mean is %.4f. \n',mean(mean_sim));

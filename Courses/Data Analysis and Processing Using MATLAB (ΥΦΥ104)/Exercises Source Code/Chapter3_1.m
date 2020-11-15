% Data Analysis and Processing using MATLAB (ΥΦΥ104)
% Solution for exercise Chapter3_1
% Implemented by Anastasis Retselis 
clear;clc;

% User input
runs = input('Enter number of runs: ');

% Results and histogram
for i=1:runs
    M=randi([1,10000]);
    n=randi([1,1000]);
    lambda=randi([1,100]);
    mean_sim = poisson_simulation(M,n,lambda);
    fprintf(['For M=%d samples with size n=%d and lambda=%d, the', ...
' average of every sample mean is %.4f. \n'],M,n,lambda,mean(mean_sim));
end
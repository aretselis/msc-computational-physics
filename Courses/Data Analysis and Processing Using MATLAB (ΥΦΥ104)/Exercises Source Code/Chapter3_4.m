% Data Analysis and Processing using MATLAB (ΥΦΥ104)
% Solution for exercise Chapter3_4
% Implemented by Anastasis Retselis
clear;clc;

data = [41 46 47 47 48 50 50 50 50 50 50 50 ...
    48 50 50 50 50 50 50 50 52 52 53 55 ...
    50 50 50 50 52 52 53 53 53 53 53 57 ...
    52 52 53 53 53 53 53 53 54 54 55 68];

%% Calculate 95% confidence interval and check 5kV deviation assumption
sd=5;

[~,p,ci,~] = vartest(data,sd^2,1-0.95);
fprintf('The 95%% confidence interval for the variance is [%.4f,%.4f]\n', ci(1), ci(2));
fprintf('The 95%% confidence inteval for the standard deviation is [%.4f,%.4f]\n', sqrt(ci(1)), sqrt(ci(2)));
fprintf('p-value for standard deviation σ=%d is %1.4f', sd, p);
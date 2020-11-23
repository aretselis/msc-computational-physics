% Data Analysis and Processing using MATLAB (ΥΦΥ104)
% Solution for exercise Chapter3_4
% Implemented by Anastasis Retselis
clear;clc;

data = [41 46 47 47 48 50 50 50 50 50 50 50 ...
    48 50 50 50 50 50 50 50 52 52 53 55 ...
    50 50 50 50 52 52 53 53 53 53 53 57 ...
    52 52 53 53 53 53 53 53 54 54 55 68];

% Calculate 95% confidence interval

[~,~,ci,~] = ttest(data);
fprintf('The 95%% confidence interval is [%.4f,%.4f]', ci(1), ci(2));

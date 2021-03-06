% Data Analysis and Processing using MATLAB (ΥΦΥ104)
% Solution for exercise Chapter3_4
% Implemented by Anastasis Retselis
clear;clc;

data = [41 46 47 47 48 50 50 50 50 50 50 50 ...
    48 50 50 50 50 50 50 50 52 52 53 55 ...
    50 50 50 50 52 52 53 53 53 53 53 57 ...
    52 52 53 53 53 53 53 53 54 54 55 68];

% histfit(data);

% Calculate 95% confidence interval for variance and check 5kV deviation assumption

sd=5;
[h,p_var,ci_var,~] = vartest(data,sd^2,0.05);
fprintf('The 95%% confidence interval for the variance is [%.4f,%.4f]\n', ci_var(1), ci_var(2));
fprintf('The 95%% confidence inteval for the standard deviation is [%.4f,%.4f]\n', sqrt(ci_var(1)), sqrt(ci_var(2)));
fprintf('p-value for standard deviation σ=%d is %1.4f\n', sd, p_var);
if h==0
    fprintf('Hypothesis for standard deviation true\n\n');
elseif h==1
    fprintf('Hypothesis for standard deviation false\n\n');
end

% Calculate 95% confidence interval for cut-off voltage and estimate 52 kV

cutoff_voltage=52;
[h,p_cv,ci_cv,~] = ttest(data, cutoff_voltage, 0.05);
fprintf('The 95%% confidence interval for the cut-off voltage is [%.4f,%.4f]\n', ci_cv(1), ci_cv(2));
fprintf('p-value for cut-off voltage V=%d is %1.4f\n', cutoff_voltage, p_cv);
if h == 0
    fprintf('Hypothesis for cut-off voltage true\n\n');
elseif h==1
    fprintf('Hypothesis for cut-off voltage false\n\n');
end

% Goodness-of-fit test

[h, p_fit] = chi2gof(data);
fprintf('p-value for goodness-of-fit for normal distribution is %1.5f\n', p_fit);
if h == 0
    fprintf('Hypothesis for goodness-of-fit for normal distribution true\n\n');
elseif h==1
    fprintf('Hypothesis for goodness-of-fit for normal distribution false\n\n');
end
% Data Analysis and Processing using MATLAB (ΥΦΥ104)
% Solution for exercise Chapter3_5
% Implemented by Anastasis Retselis
clear;clc;

data = importdata('eruption.dat');

% Column 1: Waiting time (minutes) 1989
% Column 2: Eruption duration (minutes) 1989
% Column 3: Waiting time (minutes) 2006

% Check confidence interval for standard deviation
sd_waiting = 10; 
sd_eruption = 1;

%% Column 1: Waiting time (minutes) 1989

fprintf('Stats for Waiting time in 1989:\n');
[h, p_wait, ci_wait] = vartest(data(:,1),sd_waiting^2,0.05);
fprintf('Confidence interval for standard deviation (σ) is [%.4f,%.4f]\n', sqrt(ci_wait(1)), sqrt(ci_wait(2)));
fprintf('p-value for hypothesis σ = %d is %.4f\n', sd_waiting, p_wait);
if h == 0
    fprintf('Hypothesis for σ true\n\n');
elseif h==1
    fprintf('Hypothesis for σ false\n\n');
end
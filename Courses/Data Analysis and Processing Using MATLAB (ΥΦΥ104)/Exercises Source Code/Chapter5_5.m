% Data Analysis and Processing using MATLAB (ΥΦΥ104)
% Solution for exercise Chapter5_5
% Implemented by Anastasis Retselis
clear;clc;close all;

lightairdata = importdata('lightair.dat');
n = length(lightairdata);
air_density = lightairdata(:,1);
light_speed = lightairdata(:,2);

% Calculate parametric confidence intervals based on 5.4

mean_x = mean(air_density);
mean_y = mean(light_speed);
S_xy = sum((air_density-mean_x).*(light_speed-mean_y));
S_xx = sum((air_density-mean_x).^2);
b1 = S_xy/S_xx;
b0 = mean_y-b1*mean_x;
fprintf('Repeating results from 5.4) y = b1*x + b0 for dataset...\n');
fprintf('y = %.4f*x + %.4f\n\n', b1, b0);
a = 0.05;
t_critical = tinv(1-a/2,n-2);
s_e = sqrt(sum((light_speed-b0-b1.*air_density).^2)/n-2);
s_b1 = s_e/sqrt(S_xx);
ci_upper_b1 = b1 + (t_critical*s_b1);
ci_lower_b1 = b1 - (t_critical*s_b1);
fprintf('Parametric %.0f%% Confidence interval for b1 = [%.4f, %.4f]\n',...
    (1-a)*100,ci_lower_b1,ci_upper_b1);
s_b0 = s_e*sqrt((1/n)+(mean_x^2/S_xx));
ci_upper_b0 = b0 + (t_critical*s_b0);
ci_lower_b0 = b0 - (t_critical*s_b0);
fprintf('Parametric %.0f%% Confidence interval for b0 = [%.4f, %.4f]\n',...
    (1-a)*100,ci_lower_b0,ci_upper_b0);


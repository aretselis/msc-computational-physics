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

% Perform simulation M times, calculating b0 and b1

M = 1000;
b_values = zeros(M,2);
for i=1:M
    index = unidrnd(n,n,1);
    sim_x = air_density(index);
    sim_y = light_speed(index);
    mean_sim_x = mean(air_density);
    mean_sim_y = mean(light_speed);
    S_xy_sim = sum((sim_x-mean_sim_x).*(sim_y-mean_sim_y));
    S_xx_sim = sum((sim_x-mean_sim_x).^2);
    b1_sim = S_xy_sim/S_xx_sim;
    b0_sim = mean_sim_y-b1_sim*mean_sim_x;
    b_values(i,1) = b0_sim;
    b_values(i,2) = b1_sim;
end

% Sort b_values based on b0 or b1 and extract results

b0_sorted = sortrows(b_values, 1);
b1_sorted = sortrows(b_values, 2);

lower_limit = M*a/2;
upper_limit = M*(1-a/2);

b0_lower_ci_sim = b0_sorted(lower_limit,1);
b0_upper_ci_sim = b0_sorted(upper_limit,1);
b1_lower_ci_sim = b1_sorted(lower_limit,2);
b1_upper_ci_sim = b1_sorted(upper_limit,2);

fprintf('\nRunning simulation M = %d times...\n', M);
fprintf('Bootstrap %.0f%% Confidence interval for b1 = [%.4f, %.4f]\n',...
    (1-a)*100, b1_lower_ci_sim, b1_upper_ci_sim);
fprintf('Bootstrap %.0f%% Confidence interval for b0 = [%.4f, %.4f]\n',...
    (1-a)*100, b0_lower_ci_sim, b0_upper_ci_sim);
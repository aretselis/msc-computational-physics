% Data Analysis and Processing using MATLAB (ΥΦΥ104)
% Solution for exercise Chapter5_4
% Implemented by Anastasis Retselis
clear;clc;close all;

lightairdata = importdata('lightair.dat');
n = length(lightairdata);
air_density = lightairdata(:,1);
light_speed = lightairdata(:,2);

lightair_corr_mat = corrcoef(lightairdata);
lightair_corrcoef = lightair_corr_mat(2);
figure;
plot(air_density,light_speed,'.');
title(sprintf('Light Speed as a function of air density (r = %.4f)',...
    lightair_corrcoef));
xlabel('Air Density, ρ, [kg/m^3]')
ylabel('Light Speed, c_{air}, [m/s]')
grid on;

% Least squares fitting method

mean_x = mean(air_density);
mean_y = mean(light_speed);
S_xy = sum((air_density-mean_x).*(light_speed-mean_y));
S_xx = sum((air_density-mean_x).^2);
b1 = S_xy/S_xx;
b0 = mean_y-b1*mean_x;

fprintf('Using least square method y = b1*x + b0 for dataset...\n');
fprintf('y = %.4f*x + %.4f\n\n', b1, b0);

% Calculate 95% confidence interval for b1 and b0

a = 0.05;
t_critical = tinv(1-a/2,n-2);
s_e = sqrt(sum((light_speed-b0-b1.*air_density).^2)/n-2);
s_b1 = s_e/sqrt(S_xx);
ci_upper_b1 = b1 + (t_critical*s_b1);
ci_lower_b1 = b1 - (t_critical*s_b1);
fprintf('%.0f%% Confidence interval for b1 = [%.4f, %.4f]\n',...
    (1-a)*100,ci_lower_b1,ci_upper_b1);
s_b0 = s_e*sqrt((1/n)+(mean_x^2/S_xx));
ci_upper_b0 = b0 + (t_critical*s_b0);
ci_lower_b0 = b0 - (t_critical*s_b0);
fprintf('%.0f%% Confidence interval for b0 = [%.4f, %.4f]\n',...
    (1-a)*100,ci_lower_b0,ci_upper_b0);

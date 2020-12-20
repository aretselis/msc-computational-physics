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
ylabel('Light Speed, c_{air}, [-299000 km/s]')
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
fprintf('%.0f%% Confidence interval for b0 = [%.4f, %.4f]\n\n',...
    (1-a)*100,ci_lower_b0,ci_upper_b0);

x_interval = air_density;
y_lsq = b1*x_interval + b0;
S_ymean = s_e*sqrt((1/n)+((air_density-mean_x).^2/S_xx));
y_upper_mean = b1*x_interval + b0 + t_critical*S_ymean;
y_lower_mean = b1*x_interval + b0 - t_critical*S_ymean;
s_measurement = s_e*sqrt(1+(1/n)+((air_density-mean_x).^2/S_xx));
y_upper_measurement = b1*x_interval + b0 + t_critical*s_measurement;
y_lower_measurement = b1*x_interval + b0 - t_critical*s_measurement;

figure;
hold on;
plot(air_density,light_speed,'.');
title(sprintf('Light Speed as a function of air density (r = %.4f)',...
    lightair_corrcoef));
plot(x_interval,y_lsq,'-r');
plot(x_interval,y_upper_mean,'LineStyle','--','Color','#EDB120');
plot(x_interval,y_upper_measurement,'LineStyle','--','Color','#77AC30');
plot(x_interval,y_lower_mean,'LineStyle','--','Color','#EDB120');
plot(x_interval,y_lower_measurement,'LineStyle','--','Color','#77AC30');
legend('Data Measurements',sprintf('y = %.4fx + %.4f', b1, b0),...
    'Confidence Interval (mean value)',...
    'Confidence Interval (measurement)');
xlabel('Air Density, ρ, [kg/m^3]')
ylabel('Light Speed, c_{air}, [-299000 km/s]')
grid on;

% Calculate for density=1.29

x_value = 1.29;
y_value = b1*x_value + b0;
fprintf('For x=%.2f , y=%.4f\n', x_value, y_value);
S_ymean_value = s_e*sqrt((1/n)+((x_value-mean_x).^2/S_xx));
ci_upper_mean_value = b1*x_value + b0 + t_critical*S_ymean_value;
ci_lower_mean_value = b1*x_value + b0 - t_critical*S_ymean_value;
s_measurement_value = s_e*sqrt(1+(1/n)+((x_value-mean_x).^2/S_xx));
ci_upper_measurement = b1*x_value + b0 + t_critical*s_measurement_value;
ci_lower_measurement = b1*x_value + b0 - t_critical*s_measurement_value;
fprintf('%.0f%% CI for mean value is [%.4f, %.4f]\n',...
    (1-a)*100,ci_lower_mean_value,ci_upper_mean_value);
fprintf('%.0f%% CI for next measurement is [%.4f, %.4f]\n\n',...
    (1-a)*100,ci_lower_measurement,ci_upper_measurement);

% Compare actual formula 

c = 299792.458;
d0 = 1.29;
b0_actual = c - 299000; 
b1_actual = -0.00029*c/1.29;
y_value_actual = b1_actual*x_value + b0_actual;
fprintf('Based on the actual formula, the equation is:\n');
fprintf('y = %.4f*x + %.4f\n', b1_actual, b0_actual);
if b0_actual>ci_lower_b0 && b0_actual<ci_upper_b0
    fprintf('b0 = %.4f inside %.0f%% CI specified in b [%.4f, %.4f]\n',...
    b0_actual,(1-a)*100, ci_lower_b0, ci_upper_b0);
else 
    fprintf('b0 = %.4f outside %.0f%% CI specified in b [%.4f, %.4f]\n',...
    b0_actual,(1-a)*100, ci_lower_b0, ci_upper_b0);
end
if b1_actual>ci_lower_b1 && b1_actual<ci_upper_b1
    fprintf('b1 = %.4f inside %.0f%% CI specified in b [%.4f, %.4f]\n',...
    b1_actual,(1-a)*100, ci_lower_b1, ci_upper_b1);
else 
    fprintf('b1 = %.4f outside %.0f%% CI specified in b [%.4f, %.4f]\n',...
    b1_actual,(1-a)*100, ci_lower_b1, ci_upper_b1);
end
fprintf('\nFor x = %.2f , y_actual = %.4f\n', x_value, y_value_actual);
if y_value_actual>ci_lower_mean_value && y_value_actual<ci_upper_mean_value
    fprintf('c_actual = %.4f inside %.0f%% CI specified [%.4f, %.4f]\n',...
    y_value_actual,(1-a)*100, ci_lower_mean_value, ci_upper_mean_value);
else 
    fprintf('c_actual = %.4f outside %.0f%% CI specified [%.4f, %.4f]\n',...
    y_value_actual,(1-a)*100, ci_lower_mean_value, ci_upper_mean_value);
end


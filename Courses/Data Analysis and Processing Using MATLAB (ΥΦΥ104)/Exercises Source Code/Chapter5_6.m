% Data Analysis and Processing using MATLAB (ΥΦΥ104)
% Solution for exercise Chapter5_6
% Implemented by Anastasis Retselis
clear;clc;close all;

tyre_data = [2 98.2
        3 91.7
        8 81.3
        16 64.0
        32 36.4
        48 32.6
        64 17.1
        80 11.33];
    
x_values = tyre_data(:,1);
y_values = tyre_data(:,2);
n = length(tyre_data);

%% Linear fit (Least squares fitting)

mean_x = mean(x_values);
mean_y = mean(y_values);
S_xy = sum((x_values-mean_x).*(y_values-mean_y));
S_xx = sum((x_values-mean_x).^2);
S_yy = sum((y_values-mean_y).^2);
b1 = S_xy/S_xx;
b0 = mean_y-b1*mean_x;
y_linear_lsq = b1*x_values + b0;

% Plot data and least square fit line
subplot(2,2,1);
hold on;
grid on;
plot(x_values,y_values,'.')
plot(x_values,y_linear_lsq)
title('Linear fit of data')
xlabel('Distance, [x], 10^3 km')
ylabel('% usable')

% Compute and plot diagnostic plot
e_i = y_values - y_linear_lsq;
s_e = sqrt(sum((y_values-b0-b1.*x_values).^2)/n-2);
e_i_star = e_i/s_e;
r = S_xy/sqrt(S_xx*S_yy);
r2 = r*r;
subplot(2,2,2);
hold on;
grid on;
yline(2,'-r')
yline(-2,'-r')
plot(y_linear_lsq,e_i_star,'.');
title('Diagnostic plot')
xlabel('y')
ylabel('e_i*')

%% Exponential fit

e_y_values = log(y_values);

% Linear fit (Least squares fitting)

e_mean_x = mean(x_values);
e_mean_y = mean(e_y_values);
e_S_xy = sum((x_values-e_mean_x).*(e_y_values-e_mean_y));
e_S_xx = sum((x_values-e_mean_x).^2);
e_S_yy = sum((e_y_values-e_mean_y).^2);
e_b1 = e_S_xy/e_S_xx;
e_b0 = e_mean_y-e_b1*e_mean_x;
y_exp_lsq = e_b1*x_values + e_b0;

% Plot data and least square fit line
subplot(2,2,3);
hold on;
grid on;
plot(x_values,e_y_values,'.')
plot(x_values,y_exp_lsq)
title('Exponential fit of data')
xlabel('Distance, [x], 10^3 km')
ylabel('ln(% usable)')

% Compute and plot diagnostic plot
exp_e_i = e_y_values - y_exp_lsq;
exp_s_e = sqrt(sum((e_y_values-e_b0-y_exp_lsq).^2)/n-2);
exp_e_i_star = exp_e_i/exp_s_e;
exp_r = e_S_xy/sqrt(e_S_xx*e_S_yy);
exp_r2 = r*r;
subplot(2,2,4);
hold on;
grid on;
yline(2,'-r')
yline(-2,'-r')
plot(y_exp_lsq,exp_e_i_star,'.');
title('Diagnostic plot')
xlabel('y')
ylabel('e_i*')

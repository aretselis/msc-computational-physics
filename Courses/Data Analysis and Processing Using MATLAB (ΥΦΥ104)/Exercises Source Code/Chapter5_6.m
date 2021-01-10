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

% Check all intrinsically linear functions with lsq method

%% Linear fit (Least squares fitting)

mean_x = mean(x_values);
mean_y = mean(y_values);
S_xy = sum((x_values-mean_x).*(y_values-mean_y));
S_xx = sum((x_values-mean_x).^2);
S_yy = sum((y_values-mean_y).^2);
r = S_xy/sqrt(S_xx*S_yy);
b1 = S_xy/S_xx;
b0 = mean_y-b1*mean_x;
y_linear_lsq = b1*x_values + b0;

% Plot data and least square fit line
subplot(2,2,1);
hold on;
grid on;
plot(x_values,y_values,'.')
plot(x_values,y_linear_lsq)
title(['Linear fit of data, r = ', num2str(r)])
xlabel('Distance, x, [10^3 km]')
ylabel('% usable')
legend('Data Points', sprintf('y = %.4f %.4f x', b0, b1));

% Compute and plot diagnostic plot
e_i = y_values - y_linear_lsq;
s_e = sqrt(sum((y_values-b0-b1.*x_values).^2)/n-2);
e_i_star = e_i/s_e;
subplot(2,2,2);
hold on;
grid on;
yline(2,'-r')
yline(-2,'-r')
plot(y_linear_lsq,e_i_star,'.');
title('Diagnostic plot')
xlabel('% usable')
ylabel('e_i*')

%% Exponential fit

e_y_values = log(y_values);

% Linear fit (Least squares fitting)

e_mean_x = mean(x_values);
e_mean_y = mean(e_y_values);
e_S_xy = sum((x_values-e_mean_x).*(e_y_values-e_mean_y));
e_S_xx = sum((x_values-e_mean_x).^2);
e_S_yy = sum((e_y_values-e_mean_y).^2);
exp_r = e_S_xy/sqrt(e_S_xx*e_S_yy);
e_b1 = e_S_xy/e_S_xx;
e_b0 = e_mean_y-e_b1*e_mean_x;
y_exp_lsq = e_b1*x_values + e_b0;

% Plot data and least square fit line
subplot(2,2,3);
hold on;
grid on;
plot(x_values,e_y_values,'.')
plot(x_values,y_exp_lsq)
title(['Exponential fit of data, r = ', num2str(exp_r)])
xlabel('Distance, x, [10^3 km]')
ylabel('ln(% usable)')
legend('Data Points', sprintf('y'' = %.4f %.4f x', e_b0, e_b1));

% Compute and plot diagnostic plot
exp_e_i = e_y_values - y_exp_lsq;
exp_s_e = sqrt(((n-1)/(n-2))*(e_S_yy-e_b1^2*e_S_xx));
exp_e_i_star = exp_e_i/exp_s_e;
subplot(2,2,4);
hold on;
grid on;
yline(2,'-r')
yline(-2,'-r')
plot(y_exp_lsq,exp_e_i_star,'.');
title('Diagnostic plot')
xlabel('ln(% usable)')
ylabel('e_i*')

%% Power fit

pow_y_values = log10(y_values);
pow_x_values = log10(x_values);

% Linear fit (Least squares fitting)

pow_mean_x = mean(pow_x_values);
pow_mean_y = mean(pow_y_values);
pow_S_xy = sum((pow_x_values-pow_mean_x).*(pow_y_values-pow_mean_y));
pow_S_xx = sum((pow_x_values-pow_mean_x).^2);
pow_S_yy = sum((pow_y_values-pow_mean_y).^2);
pow_r = pow_S_xy/sqrt(pow_S_xx*pow_S_yy);
pow_b1 = pow_S_xy/pow_S_xx;
pow_b0 = pow_mean_y-pow_b1*pow_mean_x;
y_pow_lsq = pow_b1*pow_x_values + pow_b0;

% Plot data and least square fit line
figure();
subplot(3,2,1);
hold on;
grid on;
plot(pow_x_values,pow_y_values,'.')
plot(pow_x_values,y_pow_lsq)
title(['Power fit of data, r = ', num2str(pow_r)])
xlabel('Distance, log(x), [log(10^3 km)]')
ylabel('log(% usable)')
legend('Data Points', sprintf('y'' = %.4f %.4f x''', pow_b0, pow_b1));

% Compute and plot diagnostic plot
pow_e_i = pow_y_values - y_pow_lsq;
pow_s_e = sqrt(((n-1)/(n-2))*(pow_S_yy-pow_b1^2*pow_S_xx));
pow_e_i_star = pow_e_i/pow_s_e;
subplot(3,2,2);
hold on;
grid on;
yline(2,'-r')
yline(-2,'-r')
plot(y_pow_lsq,pow_e_i_star,'.');
title('Diagnostic plot')
xlabel('log(% usable)')
ylabel('e_i*')

%% y=a+blog(x) fit

log_y_values = y_values;
log_x_values = log10(x_values);

% Linear fit (Least squares fitting)

log_mean_x = mean(log_x_values);
log_mean_y = mean(log_y_values);
log_S_xy = sum((log_x_values-log_mean_x).*(log_y_values-log_mean_y));
log_S_xx = sum((log_x_values-log_mean_x).^2);
log_S_yy = sum((log_y_values-log_mean_y).^2);
log_r = log_S_xy/sqrt(log_S_xx*log_S_yy);
log_b1 = log_S_xy/log_S_xx;
log_b0 = log_mean_y-log_b1*log_mean_x;
y_log_lsq = log_b1*log_x_values + log_b0;

% Plot data and least square fit line
subplot(3,2,3);
hold on;
grid on;
plot(log_x_values,log_y_values,'.')
plot(log_x_values,y_log_lsq)
title(['y=a+blog(x) fit of data, r = ', num2str(log_r)])
xlabel('Distance, log(x), [log(10^3 km)]')
ylabel('% usable')
legend('Data Points', sprintf('y = %.4f %.4f x''', log_b0, log_b1));

% Compute and plot diagnostic plot
log_e_i = log_y_values - y_log_lsq;
log_s_e = sqrt(((n-1)/(n-2))*(log_S_yy-log_b1^2*log_S_xx));
log_e_i_star = log_e_i/log_s_e;
subplot(3,2,4);
hold on;
grid on;
yline(2,'-r')
yline(-2,'-r')
plot(y_log_lsq,log_e_i_star,'.');
title('Diagnostic plot')
xlabel('% usable')
ylabel('e_i*')

%% Inverse fit

inv_y_values = y_values;
inv_x_values = 1./x_values;

% Linear fit (Least squares fitting)

inv_mean_x = mean(inv_x_values);
inv_mean_y = mean(inv_y_values);
inv_S_xy = sum((inv_x_values-inv_mean_x).*(inv_y_values-inv_mean_y));
inv_S_xx = sum((inv_x_values-inv_mean_x).^2);
inv_S_yy = sum((inv_y_values-inv_mean_y).^2);
inv_r = inv_S_xy/sqrt(inv_S_xx*inv_S_yy);
inv_b1 = inv_S_xy/inv_S_xx;
inv_b0 = inv_mean_y-inv_b1*inv_mean_x;
y_inv_lsq = inv_b1*inv_x_values + inv_b0;

% Plot data and least square fit line
subplot(3,2,5);
hold on;
grid on;
plot(inv_x_values,inv_y_values,'.')
plot(inv_x_values,y_inv_lsq)
title(['Inverse fit of data, r = ', num2str(inv_r)])
xlabel('Distance, 1/x, [1/(10^3 km)]')
ylabel('% usable')
legend('Data Points', sprintf('y = %.4f+%.4f x''', inv_b0, inv_b1));

% Compute and plot diagnostic plot
inv_e_i = inv_y_values - y_inv_lsq;
inv_s_e = sqrt(((n-1)/(n-2))*(inv_S_yy-inv_b1^2*inv_S_xx));
inv_e_i_star = inv_e_i/inv_s_e;
subplot(3,2,6);
hold on;
grid on;
yline(2,'-r')
yline(-2,'-r')
plot(y_inv_lsq,inv_e_i_star,'.');
title('Diagnostic plot')
xlabel('% usable')
ylabel('e_i*')

%% Extract results and make prediction

fprintf(['Based on the diagnostic plots and r-values, we can conclude',...
    ' that the best fit is the exponential function.\n\n']);

fprintf('In linear form:');
fprintf('\nln(y) = ln(a) + bx\n');
fprintf('ln(y) = %.4f + %.4fx', e_b0, e_b1);
fprintf('\n\nIn exponential form:\n');
fprintf('y = a e^(bx)\n');
fprintf('y = %.2f e^(%.4fx)\n', exp(e_b0), e_b1);

prediction = 25;
result = exp(e_b0)*exp(e_b1.*prediction);
point = [prediction, result];
fprintf('For x = 25000 km, the tyres would be %.2f %% usable.\n', result)

x_plot = 0:0.1:100;
y_plot = exp(e_b0)*exp(e_b1.*x_plot);
figure;
hold on;
grid on;
plot(x_values,y_values,'.');
plot(x_plot,y_plot);
plot([point(1), point(1)], [0, point(2)], '--m')  
plot([0, point(1)], [point(2), point(2)], '--m') 
title(['Exponential fit of data, r = ', num2str(exp_r)]);
legend('Data Points', sprintf('y = %.2f e^{%.4fx}', exp(e_b0), e_b1));
xlabel('Distance, x, [10^3 km]')
ylabel('% usable')
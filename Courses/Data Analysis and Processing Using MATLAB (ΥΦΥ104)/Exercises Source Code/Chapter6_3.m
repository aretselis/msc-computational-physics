% Data Analysis and Processing using MATLAB (ΥΦΥ104)
% Solution for exercise Chapter6_3
% Implemented by Anastasis Retselis
clear;clc;close all;

N = 100;
x_t = zeros(N,1);
x_0 = 0.2;

x_t(1) = x_0;
for i=2:N
    x_t(i) = 4*x_t(i-1)*(1-x_t(i-1));
end

% Time series plot
figure;
plot(x_t,'.-');
title('Logistic map')
ylabel('x_{t}');
xlabel('Step');
grid on;

% Time series plot
figure;
plot(x_t(1:N-1),x_t(2:N),'.');
title('Logistic map')
ylabel('x_{t}');
xlabel('x_{t-1}');
grid on;

% Compute autocorrelation and plot
rho_data = autocorrelation(x_t,20);
figure;
plot(rho_data(:,1),'r.');
hold on;
for i=1:length(rho_data)
    plot([i i], [0, rho_data(i)], 'r-'); 
end
title('Autocorrelation Function')
ylabel('Autocorrelation, r_{τ}');
xlabel('Lag, τ');
yline(0);
yline(-2/sqrt(N),'b');
yline(2/sqrt(N),'b');
grid on;

function rho_t = autocorrelation(y_data, lags)
    % Computes the autocorrelation of a time series 
    % INPUT: y_data, number of lags (lags)
    % OUTPUT: values of autocorrelation rho_t as a vector
    rho_t = zeros(lags,1);
    mean_y = mean(y_data);
    max_val = max(size(y_data));

    for i=1:lags
        temp_r = zeros(max_val-i,1);
        temp_r_num = zeros(max_val-i,1);
        for j=i+1:max_val
            temp_r(j) = (y_data(j)-mean_y)*(y_data(j-i)-mean_y);
            temp_r_num(j) = (y_data(j)-mean_y)^2;
        end
        rho_t(i) = sum(temp_r)/sum(temp_r_num);
    end
end
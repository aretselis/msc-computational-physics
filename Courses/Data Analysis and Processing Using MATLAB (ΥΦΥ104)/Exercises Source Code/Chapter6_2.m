% Data Analysis and Processing using MATLAB (ΥΦΥ104)
% Solution for exercise Chapter6_2
% Implemented by Anastasis Retselis
clear;clc;close all;

% Import data
data = importdata('crutem3nh.dat');
years = data(:,1);
T_index = data(:,2);
N = length(T_index);

% Time series plot
figure;
plot(years, T_index,'.-');
title('Temperature index for anomalous readings')
ylabel('Temperature index value, y(t)');
xlabel('Year, t');
grid on;

% Compute autocorrelation and plot
rho_data = autocorrelation(T_index,20);
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

%% First degree polynomial

x_data_reg = [ones(N,1) years];
[b_coefs,b_ints,~,~,~] = regress(T_index, x_data_reg);
first_results = T_index - (x_data_reg * b_coefs);

% Time series plot
subplot(2,1,1);
plot(years, first_results,'.-');
title('Temperature index for anomalous readings (after 1st degree trend removal)')
ylabel('Temperature index value, y(t)');
xlabel('Year, t');
grid on;

% Compute autocorrelation and plot
rho_data = autocorrelation(first_results,20);
subplot(2,1,2);
plot(rho_data(:,1),'r.');
hold on;
for i=1:length(rho_data)
    plot([i i], [0, rho_data(i)], 'r-'); 
end
title('Autocorrelation Function (after 1st degree trend removal)')
ylabel('Autocorrelation, r_{τ}');
xlabel('Lag, τ');
yline(0);
yline(-2/sqrt(N),'b');
yline(2/sqrt(N),'b');
grid on;

%% Second degree polynomial

x_data_reg = [ones(N,1) years years.^2];
[b_coefs,b_ints,~,~,~] = regress(T_index, x_data_reg);
second_results = T_index - (x_data_reg * b_coefs);

% Time series plot
figure;
subplot(2,1,1);
plot(years, second_results,'.-');
title('Temperature index for anomalous readings (after 2nd degree trend removal)')
ylabel('Temperature index value, y(t)');
xlabel('Year, t');
grid on;

% Compute autocorrelation and plot
rho_data = autocorrelation(second_results,20);
subplot(2,1,2);
plot(rho_data(:,1),'r.');
hold on;
for i=1:length(rho_data)
    plot([i i], [0, rho_data(i)], 'r-'); 
end
title('Autocorrelation Function (after 2nd degree trend removal)')
ylabel('Autocorrelation, r_{τ}');
xlabel('Lag, τ');
yline(0);
yline(-2/sqrt(N),'b');
yline(2/sqrt(N),'b');
grid on;

%% Third degree polynomial

x_data_reg = [ones(N,1) years years.^2 years.^3];
[b_coefs,b_ints,~,~,~] = regress(T_index, x_data_reg);
third_results = T_index - (x_data_reg * b_coefs);

% Time series plot
figure;
subplot(2,1,1);
plot(years, third_results,'.-');
title('Temperature index for anomalous readings (after 3rd degree trend removal)')
ylabel('Temperature index value, y(t)');
xlabel('Year, t');
grid on;

% Compute autocorrelation and plot
rho_data = autocorrelation(third_results,20);
subplot(2,1,2);
plot(rho_data(:,1),'r.');
hold on;
for i=1:length(rho_data)
    plot([i i], [0, rho_data(i)], 'r-'); 
end
title('Autocorrelation Function (after 3rd degree trend removal)')
ylabel('Autocorrelation, r_{τ}');
xlabel('Lag, τ');
yline(0);
yline(-2/sqrt(N),'b');
yline(2/sqrt(N),'b');
grid on;

%% First differences method
first_differences = zeros(N-1,1);

for i=2:N
    first_differences(i-1) = T_index(i) - T_index(i-1);
end

% Time series plot
figure;
subplot(2,1,1);
plot(years(2:N), first_differences,'.-');
title('Temperature index for anomalous readings (using first differences method)')
ylabel('Temperature index value, y(t)');
xlabel('Year, t');
grid on;

% Compute autocorrelation and plot
rho_data = autocorrelation(first_differences,20);
subplot(2,1,2);
plot(rho_data(:,1),'r.');
hold on;
for i=1:length(rho_data)
    plot([i i], [0, rho_data(i)], 'r-'); 
end
title('Autocorrelation Function (using first differences method)')
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
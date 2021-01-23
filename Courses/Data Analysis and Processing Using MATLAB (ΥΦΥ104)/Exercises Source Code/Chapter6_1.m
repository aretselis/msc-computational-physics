% Data Analysis and Processing using MATLAB (ΥΦΥ104)
% Solution for exercise Chapter6_1
% Implemented by Anastasis Retselis
clear;clc;close all;

% Import data
data = importdata('sunspots.dat');
years = data(:,1);
sunspots = data(:,2);
N = length(sunspots);

% Time series plot
figure;
plot(years, sunspots,'.-');
title('Sunspot time series')
ylabel('Number of sunspots, y(t)');
xlabel('Year, t');
grid on;

% Compute autocorrelation and plot
rho_data = autocorrelation(sunspots,20);
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

% Based on time series plot, assume a period of 11 years.
% Compute periodic component of time series and remove it 
period = 11;

temp_s = zeros(period,1);
for i=1:period
    temp_s(i) = mean(sunspots(i:period:N));
end
s_t = repmat(temp_s,N/period,1);

sunspots_mp = sunspots - s_t;

% Time series plot without periodic component
figure;
plot(years, sunspots_mp,'.-');
title('Sunspot time series minus periodic component')
ylabel('Number of sunspots, y(t)');
xlabel('Year, t');
grid on;

% Compute autocorrelation and plot
rho_data_mp = autocorrelation(sunspots_mp,20);
figure;
plot(rho_data_mp(:,1),'r.');
hold on;
for i=1:length(rho_data_mp)
    plot([i i], [0, rho_data_mp(i)], 'r-'); 
end
title('Autocorrelation Function (minus periodic component)')
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
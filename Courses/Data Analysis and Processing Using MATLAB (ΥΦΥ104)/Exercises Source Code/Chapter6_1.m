% Data Analysis and Processing using MATLAB (ΥΦΥ104)
% Solution for exercise Chapter6_1
% Implemented by Anastasis Retselis
clear;clc;close all;

data = importdata('sunspots.dat');
years = data(:,1);
sunspots = data(:,2);

figure;
plot(years, sunspots,'.-');
title('Sunspot time series')
ylabel('Number of sunspots, y(t)');
xlabel('Year, t');
grid on;

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
grid on;

function rho_t = autocorrelation(y_data, lags)
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
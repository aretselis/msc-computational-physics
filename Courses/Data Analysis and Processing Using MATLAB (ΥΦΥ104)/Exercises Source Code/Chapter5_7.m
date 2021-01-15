% Data Analysis and Processing using MATLAB (ΥΦΥ104)
% Solution for exercise Chapter5_7
% Implemented by Anastasis Retselis
clear;clc;close all;

data = [1 0.76 110
2 0.86 105
3 0.97 100
4 1.11 95
5 1.45 85
6 1.67 80
7 1.92 75
8 2.23 70
9 2.59 65
10 3.02 60
11 3.54 55
12 4.16 50
13 4.91 45
14 5.83 40
15 6.94 35
16 8.31 30
17 10.00 25
18 12.09 20
19 14.68 15
20 17.96 10
21 22.05 5
22 27.28 0
23 33.89 -5
24 42.45 -10
25 53.39 -15
26 67.74 -20
27 86.39 -25
28 111.30 -30
29 144.00 -35
30 188.40 -40
31 247.50 -45
32 329.20 -50];

resistance_data = log(data(:,2));
temperature_data = 1./(data(:,3) + 273.15);
n = length(resistance_data);
size = size(resistance_data);

plot(resistance_data,temperature_data,'.');

% First degree
k = 1;
first_degree_X = [ones(size) resistance_data];
[b,bint,r,rint,stats] = regress(temperature_data, first_degree_X);
y_regression_first = first_degree_X * b;
diagnostic_plot(temperature_data, y_regression_first,...
   resistance_data, n, k);

% Second degree
k = 2;
second_degree_X = [ones(size) resistance_data resistance_data.^2];
[b,bint,r,rint,stats] = regress(temperature_data, second_degree_X);
y_regression_second = second_degree_X * b;
diagnostic_plot(temperature_data, y_regression_second,...
   resistance_data, n, k);

% Third degree
k = 3;
third_degree_X = [ones(size) resistance_data resistance_data.^2 ...
    resistance_data.^3];
[b,bint,r,rint,stats] = regress(temperature_data, third_degree_X);
y_regression_third = third_degree_X * b;
diagnostic_plot(temperature_data,y_regression_third,...
   resistance_data, n, k);

% Fourth degree (just for demo purposes)
k = 4;
fourth_degree_X = [ones(size) resistance_data resistance_data.^2 ...
    resistance_data.^3 resistance_data.^4];
[b,bint,r,rint,stats] = regress(temperature_data, fourth_degree_X);
y_regression_fourth = fourth_degree_X * b;
diagnostic_plot(temperature_data,y_regression_fourth,...
   resistance_data, n, k);


function diagnostic_plot(y_values, y_hat, x_values, n, k)
    % Compute and plot diagnostic plot
    % Also add plot of fitting for clarity
    e_i = y_values - y_hat;
    s_e = sqrt(sum((y_values-y_hat).^2)/(n-k+1));
    e_i_star = e_i/s_e;
    % Diagnostic Plot
    subplot(4,2,2*k)
    hold on;
    grid on;
    yline(2,'-r')
    yline(-2,'-r')
    plot(y_hat,e_i_star,'.');
    title('Diagnostic plot')
    xlabel('1/T')
    ylabel('e_i*')
    % Fitting plot
    subplot(4,2,2*k-1);
    hold on;
    grid on;
    plot(x_values,y_values,'.')
    plot(x_values,y_hat)
    title(['Polynomial fit of degree = ', num2str(k)])
    xlabel('ln(R)')
    ylabel('1/T')
    legend('Data Points', sprintf('degree=%d', k));
end
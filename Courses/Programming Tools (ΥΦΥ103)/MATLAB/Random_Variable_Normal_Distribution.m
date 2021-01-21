% Programming Tools (ΥΦΥ103)
% Solution for RandomVariables exam
% Implemented by Anastasios-Faidon Retselis
clear; clc; close all;

m = 1000;

experiment_data = rand(m,1) - 0.5; % Create data in form of vector

figure;
plot(experiment_data,'.');
title(sprintf('Experiment results for m = %d runs', m));
yline(0);
ylabel('Experiment Value');
xlabel('Experiment number');
grid on;

figure;
histogram(experiment_data);
title(sprintf('Histogram of experiment data for m = %d runs', m));
ylabel('Counts');
xlabel('Experiment Value');

% Mean Calculation
mean_formula = sum(experiment_data)/m; % Mean based on formula
mean_builtin = mean(experiment_data); % Mean based on built-in function

% Standard Deviation Calculation
sigma_x_formula = sqrt(sum((experiment_data-mean_formula).^2)/(m-1)); % std based on formula
sigma_x_builtin = std(experiment_data); % std based on built-in function

% Mean value based on experiment
experiment_data_mean = rand(m) - 0.5;
mean_experiment = sum(experiment_data_mean)/m;
figure;
plot(mean_experiment,'.r');
grid on;

% Mean and standard deviation of this variable
mean_data_mean = mean(experiment_data_mean);
std_data_mean = std(experiment_data_mean);

figure;
hold on;
plot(experiment_data,'.');
plot(mean_experiment,'.');
yline(0);
ylabel('Experiment Value');
xlabel('Experiment number');
grid on;
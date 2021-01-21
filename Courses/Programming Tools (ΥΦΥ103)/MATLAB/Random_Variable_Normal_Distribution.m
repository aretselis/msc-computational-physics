% Programming Tools (ΥΦΥ103)
% Solution for RandomVariables exam
% Implemented by Anastasios-Faidon Retselis
clear; clc; close all;

m = 1000;
mean_input = 0;
variance_input = 1;
sigma_input = sqrt(variance_input);

experiment_data = normrnd(mean_input,sigma_input,[m,1]); % Create data in form of vector

figure;
plot(experiment_data,'.');
title(sprintf('Uniform random numbers with mean = %d\n and variance = %d for m = %d runs',...
    mean_input, variance_input, m));
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

% Print results
fprintf('Random numbers in [-0.5, 0.5] for m = %d runs...\n', m);
fprintf('Mean = %.4f\n', mean_builtin);
fprintf('sigma_x = %.4f\n\n', sigma_x_builtin);

% Mean value based on experiment
experiment_data_mean = normrnd(mean_input,sigma_input,m);
mean_experiment = sum(experiment_data_mean)/m;
figure;
plot(mean_experiment,'.r');
title(sprintf('Mean of uniform random numbers with mean = %d\n and variance = %d for m = %d runs',...
    mean_input, variance_input, m));
ylabel('Experiment Value');
xlabel('Experiment number');
grid on;

% Mean and standard deviation of this variable
mean_data_mean = mean(mean_experiment);
std_data_mean = std(mean_experiment,0,2);

% Print results
fprintf('Mean of random numbers in [-0.5, 0.5] for m = %d runs...\n', m);
fprintf('Mean = %.4f\n', mean_data_mean);
fprintf('sigma_X = %.4f\n', std_data_mean);

figure;
hold on;
plot(experiment_data,'.');
plot(mean_experiment,'.');
yline(0);
title(sprintf('Experimental results for m = %d runs', m));
legend('Uniform random numbers', 'Mean of uniform random numbers');
ylabel('Experiment Value');
xlabel('Experiment number');
grid on;
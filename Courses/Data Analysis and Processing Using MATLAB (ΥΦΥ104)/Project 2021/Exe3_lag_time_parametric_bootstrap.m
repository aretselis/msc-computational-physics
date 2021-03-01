% Data Analysis and Processing using MATLAB (ΥΦΥ104)
% Solution for project exercise 3
% Implemented by Anastasios-Faidon Retselis (AEM: 4394)

clear;clc;close all;

% Read data
cases_distribution = 'Gamma';
deaths_distribution = 'Gamma';
% Assumes that files are in the same directory
filename_cases = 'Covid19Confirmed.xlsx';
filename_deaths = 'Covid19Deaths.xlsx';
cases_data = readtable(filename_cases);
deaths_data = readtable(filename_deaths);
headers = cases_data(1,:);
dates = headers{:,4:end};
country_names = cases_data{:,1};

% Define countries from exercise 3 plus croatia (exercise 1)
countries = [9, 34, 45, 48, 49, 53, 55, 78, 104, 125, 126, 135];
results = zeros(length(countries),4);
fprintf('Lag Time (days)\t\t\tCountry\n');
for i=1:length(countries)
    results(i,1) = countries(i);
    country_cases = cases_data{countries(i),4:end};
    country_deaths = deaths_data{countries(i),4:end};
    % Condition the data (remove zeros, etc.)
    [country_cases,country_deaths] = read_condition_data(country_cases, country_deaths);
    % Compute wave1 and peak date
    results(i,2) = peak_date('cases', cases_distribution ,country_cases, dates);
    results(i,3) = peak_date('deaths', deaths_distribution ,country_deaths, dates);
    results(i,4) = results(i,3) - results(i,2);
    fprintf('\t\t%d\t\t\t\t%s\n', results(i,4), string(country_names(results(i,1))));
end

lag_data = results(:,4);

% Calculate parametric confidence interval

mean_lag = mean(lag_data);
s_n = std(lag_data)/sqrt(length(lag_data));
alpha = 0.05;
par_ci_upper = mean_lag + tinv(1-alpha/2,length(lag_data)-1)*s_n;
par_ci_lower = mean_lag - tinv(1-alpha/2,length(lag_data)-1)*s_n;

% Calculate bootstrap confidence inteval

% Run simulation for M times
M = 1000;
n = length(lag_data);
sim_results = zeros(M,2);
for i=1:M
   index = unidrnd(n,n,1);
   sim_lag = lag_data(index);
   sim_results(i,1) = mean(sim_lag);
end

% Sort data and extract confidence interval
mean_sorted = sortrows(sim_results, 1);
lower_limit = M*alpha/2;
upper_limit = M*(1-alpha/2);
boot_ci_upper = mean_sorted(upper_limit,1);
boot_ci_lower = mean_sorted(lower_limit,1);

% Print results
fprintf('\nFor lag time (days) between peak cases and peak deaths:\n\n');
fprintf('Parametric 95%% Confidence Interval = [%f,%f]\n',...
    par_ci_lower, par_ci_upper);
if(14>par_ci_lower && 14<par_ci_upper)
    fprintf('14 days inside 95%% parametic confidence interval\n\n');
else
    fprintf('14 days outside 95%% parametic confidence interval\n\n');
end
fprintf('Bootstrap 95%% Confidence Interval = [%f,%f]\n',...
    boot_ci_lower, boot_ci_upper);
if(14>boot_ci_lower && 14<boot_ci_upper)
    fprintf('14 days inside 95%% bootstrap confidence interval\n');
else
    fprintf('14 days outside 95%% bootstrap confidence interval\n');
end

% ANSWER:
% For the given countries, it appears that 14 days is inside both the 95%
% parametric confidence interval and the 95% bootstrap confidence interval.
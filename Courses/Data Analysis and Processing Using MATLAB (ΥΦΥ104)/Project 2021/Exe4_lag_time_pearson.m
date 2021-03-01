% Data Analysis and Processing using MATLAB (ΥΦΥ104)
% Solution for project exercise 4
% Implemented by Anastasios-Faidon Retselis (AEM: 4394)

clear;clc;close all;

% Read data
% Assumes that files are in the same directory
filename_cases = 'Covid19Confirmed.xlsx';
filename_deaths = 'Covid19Deaths.xlsx';
cases_data = readtable(filename_cases);
deaths_data = readtable(filename_deaths);
headers = cases_data(1,:);
dates = headers{:,4:end};
country_names = cases_data{:,1};

% Define countries and search interval
countries = [9, 34, 48, 49, 53, 126];
lag_interval = [-20, 30];
lower_lag = lag_interval(1);
upper_lag = lag_interval(2);
results = zeros(length(countries),3);

fprintf('Find the lag time τ for which Pearson correlation coefficient is maximized:\n');
fprintf('Search interval τ in [%d,%d] (days)\n\n', lower_lag, upper_lag);
fprintf('τ (days)\t\tρ\t\tCountry\n');

% Main search loop
for i=1:length(countries)
   % Read country specific data 
   country_cases = cases_data{countries(i),4:end};
   country_deaths = deaths_data{countries(i),4:end};
   % Condition the data (remove zeros, etc.)
   [country_cases,country_deaths] = read_condition_data(country_cases, country_deaths); 
   % Compute first wave start/end and dates
   [wave1_cases_start,wave1_cases_end,~,~] = wave_detect_silent(dates, country_cases, 0.1);
   wave1_dates = (1:wave1_cases_end-wave1_cases_start+1);
   % Initialize search variables
   rho_actual = 0;
   t_actual = 0;
   counter = 0;
   x_t = country_cases(wave1_cases_start:wave1_cases_end);
   % Find lag value in [lower_lag, upper_lag] for which ρ is max
   for j=lower_lag:upper_lag
       t = lower_lag + counter;
       y_t = country_deaths(wave1_cases_start+t:wave1_cases_end+t);
       R = corrcoef(x_t, y_t);
       if(abs(R(2))>abs(rho_actual))
           t_actual = t;
           rho_actual = R(2);
       end
       counter = counter + 1;
   end
   % Save and print results
   y_t = country_deaths(wave1_cases_start+t_actual:wave1_cases_end+t_actual);
   results(i,1) = countries(i);
   results(i,2) = t_actual;
   results(i,3) = rho_actual;
   fprintf('%d\t\t\t%f\t%s\n',...
       results(i,2), results(i,3),string(country_names(results(i,1))));
   % Print a plot
   visualize_max_pearson(x_t,y_t, wave1_dates, results(i,2), results(i,3),...
       string(country_names(results(i,1))));
end

% ANSWER:
% For 5 out of 6 countries, the lag time which maximizes the pearson
% correlation coefficient is inside the 95% confidence interval which was
% calculated in exercise 3, indicating both methods are in-line for those 
% cases.
% Data Analysis and Processing using MATLAB (ΥΦΥ104)
% Solution for project exercise 2
% Implemented by Anastasios-Faidon Retselis (AEM: 4394)

clear;clc;close all;

% Read data
exe1_cases_distribution = 'Gamma';
exe1_deaths_distribution = 'Gamma';
% Assumes that files are in the same directory
filename_cases = 'Covid19Confirmed.xlsx';
filename_deaths = 'Covid19Deaths.xlsx';
cases_data = readtable(filename_cases);
deaths_data = readtable(filename_deaths);
headers = cases_data(1,:);
dates = headers{:,4:end};
country_names = cases_data{:,1};

% Define countries (>10)
countries = [9, 45, 48, 49, 53, 55, 78, 104, 125, 126, 135];
ranking = zeros(length(countries),3);

for i=1:length(countries)
   % Read data for given country
   fprintf('For %s:\n', string(country_names(countries(i))));
   ranking(i,1) = countries(i);
   country_cases = cases_data{countries(i),4:end};
   country_deaths = deaths_data{countries(i),4:end};
   % Condition the data (remove zeros, etc.)
   [country_cases, country_deaths] = read_condition_data(country_cases, country_deaths);
   % Search for cases:
   % Detect wave begin and end, based on percent (%) of max cases
   fprintf('Cases:\n');
   [wave1_start,wave1_end,~,~] = wave_detect(dates, country_cases, 0.1);
   % Select data points corresponding to the first wave
   wave1_cases = country_cases(wave1_start:wave1_end);
   wave1_dates = (1:wave1_end-wave1_start+1)';
   pd = fitdist(wave1_dates,exe1_cases_distribution,'Frequency',...
        wave1_cases);
   dist_data = pdf(pd,wave1_dates)*sum(wave1_cases);
   [~,p] = chi2gof(wave1_dates,'CDF',pd);
   err = immse(wave1_cases',dist_data);
   ranking(i,2) = err;
   fprintf('p-value = %.15f, Mean square error = %f \n',...
        p, err);
   % Search for deaths:
   fprintf('Deaths:\n');
   [wave1_start,wave1_end,~,~] = wave_detect(dates, country_deaths, 0.1);
   % Select data points corresponding to the first wave
   wave1_deaths = country_deaths(wave1_start:wave1_end);
   wave1_dates = (1:wave1_end-wave1_start+1)';
   pd = fitdist(wave1_dates,exe1_deaths_distribution,'Frequency',...
        wave1_deaths);
   dist_data = pdf(pd,wave1_dates)*sum(wave1_deaths);
   [~,p] = chi2gof(wave1_dates,'CDF',pd);
   err = immse(wave1_deaths',dist_data);
   ranking(i,3) = err;
   fprintf('p-value = %.15f, Mean square error = %f \n\n',...
        p, err);
end

% Rank countries based on lowest mse value (cases)
case_results = sortrows(ranking, 2, 'ascend');
fprintf('Countries ranking based on cases:\n');
fprintf('Mean square error\tCountry\n');
for i=1:length(countries)
     fprintf('%f\t\t\t', case_results(i,2));
     fprintf('%s\n', string(country_names(case_results(i,1))));
end

% Rank countries based on lowest mse value (deaths)
case_results = sortrows(ranking, 3, 'ascend');
fprintf('\nCountries ranking based on deaths:\n');
fprintf('Mean square error\tCountry\n');
for i=1:length(countries)
     fprintf('%f\t\t\t', case_results(i,3));
     fprintf('%s\n', string(country_names(case_results(i,1))));
end

% ANSWER:
% For cases: We can see that the Gamma distribution chosen for the cases
% fits a small number of countries farely well, but for most countries 
% (especiallylarger countries it does not appear to be a good fit.
%
% For deaths: It appears that the Gamma distribution performs better than
% cases for deaths, since it returns a small mean square error for 6
% countries. For the remaining 4 countries, it does not appear to be the
% best distribution to interpret the data.
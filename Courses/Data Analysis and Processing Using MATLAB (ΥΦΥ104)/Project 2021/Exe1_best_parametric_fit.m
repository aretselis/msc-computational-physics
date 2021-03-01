% Data Analysis and Processing using MATLAB (ΥΦΥ104)
% Solution for project exercise 1
% Implemented by Anastasios-Faidon Retselis (AEM: 4394)

clear;clc;close all;

% Read data
aem = 4394;
country = mod(aem, 156) + 1;
% Country 27 is Chile, which is not European
% Closest European is Croatia
country = 34;
% Assumes that files are in the same directory
filename_cases = 'Covid19Confirmed.xlsx';
filename_deaths = 'Covid19Deaths.xlsx';
cases_data = readtable(filename_cases);
deaths_data = readtable(filename_deaths);
headers = cases_data(1,:);
dates = headers{:,4:end};
country_cases = cases_data{country,4:end};
country_deaths = deaths_data{country,4:end};

% Condition the data (remove zeros, etc.)
[country_cases, country_deaths] = read_condition_data(country_cases, country_deaths);

% Check distributions for cases
distributions = {'Gamma', 'Logistic', 'Loglogistic',...
    'Rayleigh', 'Weibull'};
fprintf('\nNow checking distribution for COVID cases:\n');
% Detect wave begin and end, based on percent (%) of max cases
[wave1_start,wave1_end,~,~] = wave_detect(dates, country_cases, 0.1);
wave1_cases = country_cases(wave1_start:wave1_end);
wave1_dates = (1:wave1_end-wave1_start+1)';
figure;
% Fit distributions and plot results
for i=1:5
    pd = fitdist(wave1_dates,string(distributions(i)),'Frequency',...
        wave1_cases);
    dist_data = pdf(pd,wave1_dates)*sum(wave1_cases);
    subplot(3,2,i);
    bar(wave1_dates,wave1_cases);
    hold on;
    plot(wave1_dates,dist_data,'Red','LineWidth',1);
    xlabel('# Day in wave');
    ylabel('Daily Cases');
    title(distributions(i));
    grid on;
    [h,p] = chi2gof(wave1_dates,'CDF',pd);
    err = immse(wave1_cases',dist_data);
    fprintf('For %s: p-value = %.15f, Mean square error = %f \n',...
        string(distributions(i)), p, err);
end

% Check distributions for deaths
figure;
fprintf('\nNow checking distribution for COVID deaths:\n');
[wave1_start,wave1_end,~,~] = wave_detect(dates, country_deaths, 0.1);
wave1_deaths = country_deaths(wave1_start:wave1_end);
wave1_dates = (1:wave1_end-wave1_start+1)';
% Fit distributions and plot results
for i=1:5
    pd = fitdist(wave1_dates,string(distributions(i)),'Frequency',...
        wave1_deaths);
    dist_data = pdf(pd,wave1_dates)*sum(wave1_deaths);
    subplot(3,2,i);
    bar(wave1_dates,wave1_deaths);
    hold on;
    plot(wave1_dates,dist_data,'Red','LineWidth',1);
    xlabel('# Day in wave');
    ylabel('Daily Deaths');
    title(distributions(i));
    grid on;
    [h,p] = chi2gof(wave1_dates,'CDF',pd);
    err = immse(wave1_deaths',dist_data);
    fprintf('For %s: p-value = %.15f, Mean square error = %f \n',...
        string(distributions(i)), p, err);
end

% ANSWER:
% For cases: Out of the five chosen distributions, we cannot draw a
% conclusion based on p-values alone since they are too low. By calculating
% the Mean square error, we can conclude that for Croatia, the Gamma
% distribution best fits the number of cases during the first wave.
%
% For deaths: We can see that the mean square errors for all distributions
% are low and pretty similar. However, we can see that the Gamma
% distribution here has a high p-value (0.317) and therefore we can
% conclude that the Gamma distribution also fits Croatia's COVID-19 deaths.

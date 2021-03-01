function result = peak_date(type, distribution, data, dates)
%peak_date Calculates peak date based on probability distribution
%   INPUT: type (cases or deaths), chosen distribution, data and dates
%   OUTPUT: result (peak date)
%   Requires wave_detect.m

if(isequal(type,'cases'))
    % Looking peak for cases
    country_cases = data;
    % Find wave limits
    [wave1_start,wave1_end,~,~] = wave_detect_silent(dates, country_cases, 0.1);
    % Select data points corresponding to the first wave
    wave1_cases = country_cases(wave1_start:wave1_end);
    wave1_interval = (1:wave1_end-wave1_start+1)';
    wave1_dates = dates(wave1_start:wave1_end);
    pd = fitdist(wave1_interval,distribution,'Frequency',...
         wave1_cases);
    dist_data = pdf(pd,wave1_interval)*sum(wave1_cases);
    [~,peak_date] = max(dist_data);
    result = wave1_dates(peak_date);
    %result_string = datestr(result+datenum('30-Dec-1899'));
    %fprintf('Peak date is %s', result_string);
elseif(isequal(type,'deaths'))
    % Looking peak for cases
    country_deaths = data;
    % Find wave limits
    [wave1_start,wave1_end,~,~] = wave_detect_silent(dates, country_deaths, 0.1);
    % Select data points corresponding to the first wave
    wave1_cases = country_deaths(wave1_start:wave1_end);
    wave1_interval = (1:wave1_end-wave1_start+1)';
    wave1_dates = dates(wave1_start:wave1_end);
    pd = fitdist(wave1_interval,distribution,'Frequency',...
         wave1_cases);
    dist_data = pdf(pd,wave1_interval)*sum(wave1_cases);
    [~,peak_date] = max(dist_data);
    result = wave1_dates(peak_date);
    %result_string = datestr(result+datenum('30-Dec-1899'));
    %fprintf('Peak date is %s', result_string);
end


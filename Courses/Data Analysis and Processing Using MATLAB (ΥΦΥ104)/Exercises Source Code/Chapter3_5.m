% Data Analysis and Processing using MATLAB (ΥΦΥ104)
% Solution for exercise Chapter3_5
% Implemented by Anastasis Retselis
clear;clc;

data = importdata('eruption.dat');

% Column 1: Waiting time (minutes) 1989
% Column 2: Eruption duration (minutes) 1989
% Column 3: Waiting time (minutes) 2006

% Check confidence interval for standard deviation
sd_waiting = 10; 
sd_eruption = 1;
mv_waiting = 75;
mv_eruption = 2.5;

%% Column 1: Waiting time (minutes) 1989

fprintf('<strong>Stats for Waiting time in 1989:\n</strong>');
fprintf('========================================\n');
[h, p_waiting, ci_waiting] = vartest(data(:,1),sd_waiting^2,0.05);
fprintf('Confidence interval for standard deviation (σ) is [%.4f,%.4f]\n', sqrt(ci_waiting(1)), sqrt(ci_waiting(2)));
fprintf('p-value for hypothesis σ = %d is %.5f\n', sd_waiting, p_waiting);
if h == 0
    fprintf('Hypothesis for σ true\n');
elseif h==1
    fprintf('Hypothesis for σ false\n');
end
fprintf('========================================\n');
[h, p_waiting, ci_waiting] = ttest(data(:,1),mv_waiting,0.05);
fprintf('Confidence interval for mean value of waiting time is [%.4f,%.4f]\n', ci_waiting(1), ci_waiting(2));
fprintf('p-value for hypothesis mv = %d is %.5f\n', mv_waiting, p_waiting);
if h == 0
    fprintf('Hypothesis for mv true\n');
elseif h==1
    fprintf('Hypothesis for mv false\n');
end
fprintf('========================================\n');
[h, p_fit] = chi2gof(data(:,1));
fprintf('p-value for goodness-of-fit for normal distribution is %.5f\n', p_fit);
if h == 0
    fprintf('Hypothesis for goodness-of-fit for normal distribution true\n\n');
elseif h==1
    fprintf('Hypothesis for goodness-of-fit for normal distribution false\n\n');
end

%% Column 2: Eruption time (minutes) 1989

fprintf('<strong>Stats for Eruption time in 1989:\n</strong>');
fprintf('========================================\n');
[h, p_eruption, ci_eruption] = vartest(data(:,2),sd_eruption^2,0.05);
fprintf('Confidence interval for standard deviation (σ) is [%.4f,%.4f]\n', sqrt(ci_eruption(1)), sqrt(ci_eruption(2)));
fprintf('p-value for hypothesis σ = %d is %.5f\n', sd_eruption, p_eruption);
if h == 0
    fprintf('Hypothesis for σ true\n');
elseif h==1
    fprintf('Hypothesis for σ false\n');
end
fprintf('========================================\n');
[h, p_eruption, ci_eruption] = ttest(data(:,2),mv_eruption,0.05);
fprintf('Confidence interval for mean value of eruption time is [%.4f,%.4f]\n', ci_eruption(1), ci_eruption(2));
fprintf('p-value for hypothesis mv = %.2f is %.5f\n', mv_eruption,p_eruption);
if h == 0
    fprintf('Hypothesis for mv true\n');
elseif h==1
    fprintf('Hypothesis for mv false\n');
end
fprintf('========================================\n');
[h, p_fit] = chi2gof(data(:,2));
fprintf('p-value for goodness-of-fit for normal distribution is %.5f\n', p_fit);
if h == 0
    fprintf('Hypothesis for goodness-of-fit for normal distribution true\n\n');
elseif h==1
    fprintf('Hypothesis for goodness-of-fit for normal distribution false\n\n');
end

%% Column 3: Waiting time (minutes) 2006

fprintf('<strong>Stats for Waiting time in 2006:\n</strong>');
fprintf('========================================\n');
[h, p_waiting, ci_waiting] = vartest(data(:,3),sd_waiting^2,0.05);
fprintf('Confidence interval for standard deviation (σ) is [%.4f,%.4f]\n', sqrt(ci_waiting(1)), sqrt(ci_waiting(2)));
fprintf('p-value for hypothesis σ = %d is %.5f\n', sd_waiting, p_waiting);
if h == 0
    fprintf('Hypothesis for σ true\n');
elseif h==1
    fprintf('Hypothesis for σ false\n');
end
fprintf('========================================\n');
[h, p_waiting, ci_waiting] = ttest(data(:,3),mv_waiting,0.05);
fprintf('Confidence interval for mean value of waiting time is [%.4f,%.4f]\n', ci_waiting(1), ci_waiting(2));
fprintf('p-value for hypothesis mv = %d is %.5f\n', mv_waiting, p_waiting);
if h == 0
    fprintf('Hypothesis for mv true\n');
elseif h==1
    fprintf('Hypothesis for mv false\n');
end
fprintf('========================================\n');
[h, p_fit] = chi2gof(data(:,3));
fprintf('p-value for goodness-of-fit for normal distribution is %.5f\n', p_fit);
if h == 0
    fprintf('Hypothesis for goodness-of-fit for normal distribution true\n\n');
elseif h==1
    fprintf('Hypothesis for goodness-of-fit for normal distribution false\n\n');
end
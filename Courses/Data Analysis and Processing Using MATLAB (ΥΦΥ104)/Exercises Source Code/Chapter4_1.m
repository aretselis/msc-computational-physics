% Data Analysis and Processing using MATLAB (ΥΦΥ104)
% Solution for exercise Chapter4_1
% Implemented by Anastasis Retselis
clear;clc;

% e=sqrt(h2/h1), where
% h1=initial height
% h2=height after first contact with ground

%% A) 5 given repetitions

h1 = 100;
h2 = [60 54 58 60 56];

e = sqrt(h2/h1);
sigma_e = std(e);


%% B) Simulate 1000 times the experiment in A)

M = 1000;
n = 5;
mv_h2 = 58;
sigma_h2 = 2;

% Calculate reference values for comparison of results

expected_mv_h2 = 58;
expected_sigma_h2 = 2;
expected_mv_e = sqrt(expected_mv_h2/h1);
expected_sigma_e = sqrt((expected_sigma_h2)^2 * 1/(4*expected_mv_h2*h1));

% Create simulation

simulation = normrnd(mv_h2, sigma_h2, n, M);
sim_mean_h2 = mean(simulation);
sim_sigma_h2 = std(simulation);
e = sqrt(simulation/h1);
sim_mean_e = mean(e);
sim_sigma_e = std(e);

% Plot results

figure;
histogram(sim_mean_h2);
xl = xline(expected_mv_h2,'-r',{'Expected'},'LineWidth',1);
xl.LabelVerticalAlignment = 'middle';
xl.LabelHorizontalAlignment = 'center';
title("Mean value for h_2 for M = " + M + " experiments");
xlabel('Mean value, \mu_{h_2}, [cm]');
ylabel('Counts');
grid on;

figure;
histogram(sim_sigma_h2);
xl = xline(expected_sigma_h2,'-r',{'Expected'},'LineWidth',1);
xl.LabelVerticalAlignment = 'middle';
xl.LabelHorizontalAlignment = 'center';
title("Standard deviation for h_2 for M = " + M + " experiments");
xlabel('Standard deviation, \sigma_{h_2}, [cm]');
ylabel('Counts');
grid on;

figure;
histogram(sim_mean_e);
xl = xline(expected_mv_e,'-r',{'Expected'},'LineWidth',1);
xl.LabelVerticalAlignment = 'middle';
xl.LabelHorizontalAlignment = 'center';
title("Mean value for e for M = " + M + " experiments");
xlabel('Mean value, \mu_{e}, [ ]');
ylabel('Counts');
grid on;

figure;
histogram(sim_sigma_e);
xl = xline(expected_sigma_e,'-r',{'Expected'},'LineWidth',1);
xl.LabelVerticalAlignment = 'middle';
xl.LabelHorizontalAlignment = 'center';
title("Standard deviation for e for M = " + M + " experiments");
xlabel('Standard deviation, \sigma_{e}, [ ]');
ylabel('Counts');
grid on;

%% C) Alternating initial height h1 with 1 h2 measurement each time


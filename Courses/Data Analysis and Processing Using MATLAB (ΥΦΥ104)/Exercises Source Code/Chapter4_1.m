% Data Analysis and Processing using MATLAB (ΥΦΥ104)
% Solution for exercise Chapter4_1
% Implemented by Anastasis Retselis
clear;clc;close all;

% Coefficient of restitution e
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
hold on;
xline(expected_mv_h2,'-r','LineWidth',1);
histogram(sim_mean_h2);
legend("Expected\newline\mu_{h_2} = " + num2str(expected_mv_h2));
title("Mean value \mu for h_2 for M = " + M + " experiments");
xlabel('Mean value, \mu_{h_2}, [cm]');
ylabel('Counts');
grid on;

figure;
hold on;
xline(expected_sigma_h2,'-r','LineWidth',1);
histogram(sim_sigma_h2);
legend("Expected \sigma_{h_2}= " + num2str(expected_sigma_h2));
title("Standard deviation \sigma for h_2 for M = " + M + " experiments");
xlabel('Standard deviation, \sigma_{h_2}, [cm]');
ylabel('Counts');
grid on;

figure;
hold on;
xline(expected_mv_e,'-r','LineWidth',1);
histogram(sim_mean_e);
legend("Expected\newline\mu_e = " + num2str(expected_mv_e,"%1.4f"));
title("Mean value \mu for e for M = " + M + " experiments");
xlabel('Mean value, \mu_{e}, [ ]');
ylabel('Counts');
grid on;

figure;
hold on;
xline(expected_sigma_e,'-r','LineWidth',1);
histogram(sim_sigma_e);
legend("Expected \sigma_e= " + num2str(expected_sigma_e,"%1.4f"));
title("Standard deviation \sigma for e for M = " + M + " experiments");
xlabel('Standard deviation, \sigma_{e}, [ ]');
ylabel('Counts');
grid on;

%% C) Alternating initial height h1 with 1 h2 measurement each time

h1_c = [80 100 90 120 95];
h2_c = [48 60 50 75 56];
e_c = sqrt(h2_c ./h1_c);
sigma_h1_c = std(h1_c);
sigma_h2_c = std(h2_c);
sigma_e_c = std(e_c);


% Data Analysis and Processing using MATLAB (ΥΦΥ104)
% Solution for exercise Chapter4_3
% Implemented by Anastasis Retselis
clear;clc;close all;

%% A,B) Dissipated power uncertainty and simulation

% Initialize values and calculate uncertainty

mean_V = 77.78;     % V
sigma_V = 0.71;     % V
mean_I = 1.12;      % A
sigma_I = 0.071;    % A
mean_f = 0.283;          % rad
sigma_f = 0.017;    % rad

sigma_P = sqrt((mean_I*cos(mean_f)*sigma_V)^2 + (mean_V*cos(mean_f)*...
    sigma_I)^2 + (-mean_V*mean_I*sin(mean_f)*sigma_f)^2); 
mean_P = mean_V*mean_I*cos(mean_f);
fprintf('Based on initial values we have P =%.4f and σ_P = %.4f\n',...
    mean_P, sigma_P);

% Create and run simulation

M = 1000;
sim_mean_V = normrnd(mean_V, sigma_V, 1, M);
sim_mean_I = normrnd(mean_I, sigma_I, 1, M);
sim_mean_f = normrnd(mean_f, sigma_f, 1, M);
sim_P = sim_mean_V.*sim_mean_I.*cos(sim_mean_f);
sim_sigma_P = std(sim_P);
sim_mean_P = mean(sim_P);
fprintf('For M=%d runs, the power is P = %.4f with σ_P = %.4f\n', M,...
 sim_mean_P, sim_sigma_P);

% Plot results

figure;
hold on;
x1 = xline(mean_P,'-r','LineWidth',1);
histogram(sim_P);
legend("Expected \mu_{P} = " + num2str(mean_P,"%1.4f"));
title("Mean value \mu for P for M = " + M + " experiments");
xlabel('Mean dissipated power, \mu_{P}, [Watt]');
ylabel('Counts');
grid on;


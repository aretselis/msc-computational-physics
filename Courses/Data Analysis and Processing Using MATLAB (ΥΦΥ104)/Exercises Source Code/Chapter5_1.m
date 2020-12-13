% Data Analysis and Processing using MATLAB (ΥΦΥ104)
% Solution for exercise Chapter5_1
% Implemented by Anastasis Retselis
clear;clc;close all;

M = 1000;
n = 20;
rho_1 = 0;
rho_2 = 0.5;
a = 0.05; 
mv = [0 0]';
sigma_1 = [1^2 rho_1;rho_1 1^2];
sigma_2 = [1^2 rho_2;rho_2 1^2];
results_rho_1 = zeros(M,1);
results_rho_2 = zeros(M,1);

%% A) Confidence interval using Fisher transformation 

for i=1:M
    simulation_1 = mvnrnd(mv,sigma_2,n);
    simulation_2 = mvnrnd(mv,sigma_2,n);
    sim_rho_1 = corrcoef(simulation_1);
    sim_rho_2 = corrcoef(simulation_2);
    results_rho_1(i) = sim_rho_1(2);
    results_rho_2(i) = sim_rho_2(2);
end

temp_z_1 = 0.5*log((1+results_rho_1)./(1-results_rho_1));
temp_z_2 = 0.5*log((1+results_rho_2)./(1-results_rho_2));
z_critical = norminv(1-a/2);
z_sigma = sqrt(1/(n-3));
z_1_lower = temp_z_1 - z_critical * z_sigma;
z_1_upper = temp_z_1 + z_critical * z_sigma;
z_2_lower = temp_z_2 - z_critical * z_sigma;
z_2_upper = temp_z_2 + z_critical * z_sigma;

figure;
hold on;
histogram(z_1_lower);
histogram(z_1_upper);
legend("Lower limit","Upper limit");
title("Confidence Inteval limits for M = "+ M +" experiments and ρ = "...
    + rho_1);
xlabel('Value');
ylabel('Counts');
grid on;

figure;
hold on;
histogram(z_2_lower);
histogram(z_2_upper);
legend("Lower limit","Upper limit");
title("Confidence Inteval limits for M = "+ M +" experiments and ρ = "...
    + rho_2);
xlabel('Value');
ylabel('Counts');
grid on;

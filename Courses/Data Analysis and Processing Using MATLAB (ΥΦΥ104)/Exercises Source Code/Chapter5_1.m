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
    simulation_1 = mvnrnd(mv,sigma_1,n);
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

inside_1 = length(find(results_rho_1>z_1_lower &...
    results_rho_1<z_1_upper));
inside_2 = length(find(results_rho_2>z_2_lower &...
    results_rho_2<z_2_upper));
ratio_1 = 100*inside_1/M;
ratio_2 = 100*inside_2/M;
fprintf('CI for ρ = %d includes actual value at %.2f%%\n', rho_1,...
    ratio_1);
fprintf('CI for ρ = %.1f includes actual value at %.2f%%\n', rho_2,...
    ratio_2);
figure;
hold on;
histogram(z_1_lower);
histogram(z_1_upper);
legend('Lower limit','Upper limit');
title("Confidence Inteval limits for M = "+ M +" experiments and ρ = "...
    + rho_1);
xlabel('Value');
ylabel('Counts');
grid on;

figure;
hold on;
histogram(z_2_lower);
histogram(z_2_upper);
legend('Lower limit','Upper limit');
title("Confidence Inteval limits for M = "+ M +" experiments and ρ = "...
    + rho_2);
xlabel('Value');
ylabel('Counts');
grid on;

%% B) Statistics using T-student

t_1 = results_rho_1.*sqrt((n-2)./(1-(results_rho_1.^2)));
t_2 = results_rho_2.*sqrt((n-2)./(1-(results_rho_2.^2)));
t_critical = tinv(1-a/2,n-2);
test_t_1 = length(find(abs(t_1)<t_critical));
test_t_2 = length(find(abs(t_2)<t_critical));
p_1 = 1-test_t_1/M;
p_2 = 1-test_t_2/M;
fprintf(['For ρ = %d experiment, the null correlation hypothesis ',...
    ' has p_value = %.4f\n'], rho_1, p_1);
fprintf(['For ρ = %.1f experiment, the null correlation hypothesis ',...
    ' has p_value= %.4f\n'],rho_2,p_2);
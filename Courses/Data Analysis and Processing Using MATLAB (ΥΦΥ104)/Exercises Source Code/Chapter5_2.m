% Data Analysis and Processing using MATLAB (ΥΦΥ104)
% Solution for exercise Chapter5_2
% Implemented by Anastasis Retselis
clear;clc;close all;

f = waitbar(0, 'Starting');
rho_1 = 0;
rho_2 = 0.5;
M = 1000;
L = 1000;
a = 0.05;
n = 20;
mv = [0 0];
sigma_1 = [1^2 rho_1;rho_1 1^2];
sigma_2 = [1^2 rho_2;rho_2 1^2];
results_1 = zeros(L,M);
results_2 = zeros(L,M);
results_3 = zeros(L,M);
results_4 = zeros(L,M);

for i = 1:M
    simulation_1 = mvnrnd(mv,sigma_1,n);
    simulation_2 = mvnrnd(mv,sigma_2,n).^2;
    sim_rho_1 = corrcoef(simulation_1);
    results_1(1,i) = sim_rho_1(2);
    sim_rho_2 = corrcoef(simulation_2);
    results_2(1,i) = sim_rho_2(2);    
    for j = 1:L
        random_sim_1 = [simulation_1(:,1) simulation_1(randperm(n),2)];
        sim_rho_1 = corrcoef(random_sim_1);
        results_1(j,i) = sim_rho_1(2);
        random_sim_2 = [simulation_2(:,1) simulation_2(randperm(n),2)];
        sim_rho_2 = corrcoef(random_sim_2);
        results_2(j+1,i) = sim_rho_2(2);
    end
    waitbar(i/M, f, sprintf('Progress: %d %%', floor(i/M*100)));
end
close(f)

% t-student statistic hypothesis H0 rho=0

t_1 = results_1.*sqrt((n-2)./(1-(results_1.^2)));
t_2 = results_2.*sqrt((n-2)./(1-(results_2.^2)));
sorted_t_1 = sort(t_1(2:L,:));
sorted_t_2 = sort(t_2(2:L,:));
lower_global = round(a*L/2);
lower_limit_1 = sorted_t_1(lower_global,:);
lower_limit_2 = sorted_t_2(lower_global,:);
upper_global = round((1-a/2)*L);
upper_limit_1 = sorted_t_1(upper_global,:);
upper_limit_2 = sorted_t_2(upper_global,:);
test_t_1 = length(find(t_1(1,:)-lower_limit_1<0|t_1(1,:)-upper_limit_1>0));
test_t_2 = length(find(t_2(1,:)-lower_limit_2<0|t_2(1,:)-upper_limit_2>0));
p_1 = test_t_1/M;
p_2 = test_t_2/M;

fprintf(['For (X,Y) with M = %d, L = %d and n = %d the hypothesis',...
    ' p_value is %.4f.\n'], M, L, n, p_1);
fprintf(['For (X^2,Y^2) with M = %d, L = %d and n = %d the hypothesis',...
    ' p_value is %.4f.\n'], M, L, n, p_2);
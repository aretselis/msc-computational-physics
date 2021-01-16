% Data Analysis and Processing using MATLAB (ΥΦΥ104)
% Solution for exercise Chapter5_8
% Implemented by Anastasis Retselis
clear;clc;close all;

physical = importdata('physical.txt','	',1);
data = physical.data;
headers = physical.colheaders;
n = length(data);
mass_data = data(:,1);
data(:,1) = [];
k = length(data(1,:));

%% Model including all variables as linear

x_data_reg = [ones(n,1) data];
[b_coefs,b_ints,~,~,~] = regress(mass_data, x_data_reg);
y_regression = x_data_reg * b_coefs;
s_e2_all = sum((mass_data-y_regression).^2)/(n-(k+1));
R2_all = 1 - (sum((mass_data-y_regression).^2)/...
    sum((mass_data-mean(mass_data)).^2));
adjR2_all = 1-(sum((mass_data-y_regression).^2)/...
    sum((mass_data-mean(mass_data)).^2)*(n-1)/(n-(k+1)));

fprintf('Linear regression based on all variables:\n\n');
fprintf('Variable\t\tb_coeff\t\t95%% Confidence Interval\n');
fprintf('%8s\t\t%.3f\t\t[%.3f, %.3f]\n','Constant',b_coefs(1),...
    b_ints(1), b_ints(2));
for i=2:length(headers)
    fprintf('%8s\t\t', headers{i});
    fprintf('%.3f\t\t', b_coefs(i));
    fprintf('[%.3f, %.3f]\n', b_ints(i+1), b_ints(i+2));
end

fprintf('\nVariance of e_i: σ_ε^2 = %.4f', s_e2_all);
fprintf('\nR^2\t   = %.4f', R2_all);
fprintf('\nadjR^2 = %.4f', adjR2_all);

%% Stepwise model

fprintf('\n\nNow using a stepwise method...\n\n');
[b_temp,se,~,value_check,stats] = stepwisefit(data,mass_data);
b_step = [stats.intercept ;b_temp];
a = 0.05;
k_step = sum(value_check);
t_critical = tinv(1-a/2,n-(k_step+1));
ci_step = [se se];
ci_step(:,1) = b_temp(:,1) - t_critical*se;
ci_step(:,2) = b_temp(:,1) + t_critical*se;

logic_test = [1 value_check]';
coefs_step = (b_step .*logic_test); 
y_regression_step = x_data_reg * coefs_step;  
s_e2_step = sum((mass_data-y_regression_step).^2)/(n-(k_step+1));
R2_step = 1 - (sum((mass_data-y_regression_step).^2)/...
    sum((mass_data-mean(mass_data)).^2));
adjR2_step = 1-(sum((mass_data-y_regression_step).^2)/...
    sum((mass_data-mean(mass_data)).^2)*(n-1)/(n-(k_step+1)));


fprintf('Stepwise model from MATLAB:\n\n');
fprintf('Variable\t\tb_coeff\t\t95%% Confidence Interval\n');
fprintf('%8s\t  %.3f\t\t\n','Constant',b_step(1));
for i=2:length(headers)
    if value_check(i-1)==1
        fprintf('%8s\t\t', headers{i});
        fprintf('%.4f\t\t', b_step(i));
        fprintf('[%.4f, %.4f]\n', ci_step(i-1,1), ci_step(i-1,2));
    end
end
fprintf('\nVariance of e_i: σ_ε^2 = %.4f', s_e2_step);
fprintf('\nR^2\t   = %.4f', R2_step);
fprintf('\nadjR^2 = %.4f\n', adjR2_step);
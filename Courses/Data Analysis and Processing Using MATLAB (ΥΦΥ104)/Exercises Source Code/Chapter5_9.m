% Data Analysis and Processing using MATLAB (ΥΦΥ104)
% Solution for exercise Chapter5_9
% Implemented by Anastasis Retselis
clear;clc;close all;

hospital = importdata('hospital.txt','	',1);
data = hospital.data;
headers = hospital.colheaders;
n = length(data);
man_hours = data(:,1);
data(:,1) = [];
k = length(data(1,:));

%% Model including all variables as linear

x_data_reg = [ones(n,1) data];
[b_coefs,b_ints,~,~,~] = regress(man_hours, x_data_reg);
y_regression = x_data_reg * b_coefs;
s_e2_all = sum((man_hours-y_regression).^2)/(n-(k+1));
R2_all = 1 - (sum((man_hours-y_regression).^2)/...
    sum((man_hours-mean(man_hours)).^2));
adjR2_all = 1-(sum((man_hours-y_regression).^2)/...
    sum((man_hours-mean(man_hours)).^2)*(n-1)/(n-(k+1)));

fprintf('Linear regression based on all variables:\n\n');
fprintf('Variable\t\tb_coeff\t\t95%% Confidence Interval\n');
fprintf('%8s\t  %.3f\t\t[%.4f, %.4f]\n','Constant',b_coefs(1),...
    b_ints(1,1), b_ints(1,2));
for i=2:length(headers)
    fprintf('%8s\t\t', headers{i});
    fprintf('%.3f\t\t', b_coefs(i));
    fprintf('[%.4f, %.4f]\n', b_ints(i,1), b_ints(i,2));
end

fprintf('\nVariance of e_i: σ_ε^2 = %.4f', s_e2_all);
fprintf('\nR^2\t   = %.4f', R2_all);
fprintf('\nadjR^2 = %.4f', adjR2_all);

%% Stepwise model

fprintf('\n\nNow using a stepwise method...\n\n');
[b_temp,se,~,value_check,stats] = stepwisefit(data,man_hours);
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
s_e2_step = sum((man_hours-y_regression_step).^2)/(n-(k_step+1));
R2_step = 1 - (sum((man_hours-y_regression_step).^2)/...
    sum((man_hours-mean(man_hours)).^2));
adjR2_step = 1-(sum((man_hours-y_regression_step).^2)/...
    sum((man_hours-mean(man_hours)).^2)*(n-1)/(n-(k_step+1)));


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

%% Multicollinearity check 

fprintf('\nNow checking for multicollinearity...\n\n');

for i=2:length(headers)
    fprintf('Regression model for variable %s\n', headers{i});
    mc_check_data = data;
    mx_xj = mc_check_data(:,i-1);
    mc_check_data(:,i-1) = [];
    mc_check_data = [ones(n,1) mc_check_data];
    [R2, adjR2] = multicollinearity_check(mx_xj, mc_check_data);
    fprintf('R^2 = %.4f\n', R2);
    fprintf('adjR^2 = %.4f\n\n', adjR2);
end

function [R2_mc, adjR2_mc] = multicollinearity_check(xj_data, x_rest_data)
    % Conduct a multicollinearity check based on linear regression
    % Input: xj variable to be researched, and remaining variables
    n_mc = length(xj_data);
    k_mc = size(x_rest_data, 2)-1;
    b_coef_mc = regress(xj_data, x_rest_data);
    xj_regression_mc = x_rest_data * b_coef_mc;
    R2_mc = 1 - (sum((xj_data-xj_regression_mc).^2)/...
    sum((xj_data-mean(xj_data)).^2));
    adjR2_mc = 1-(sum((xj_data-xj_regression_mc).^2)/...
    sum((xj_data-mean(xj_data)).^2)*(n_mc-1)/(n_mc-(k_mc+1)));
end
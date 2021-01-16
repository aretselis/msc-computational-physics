% Data Analysis and Processing using MATLAB (ΥΦΥ104)
% Solution for exercise Chapter5_8
% Implemented by Anastasis Retselis
clear;clc;close all;

physical = importdata('physical.txt','	',1);
data = physical.data;
headers = physical.colheaders;
n = length(data);

mass = 1;
fore = 2;
bicep = 3;
chest = 4;
neck = 5;
shoulder =6;
waist = 7;
height = 8;
calf = 9;
thigh = 10;
head = 11;

mass_data = data(:,1);
data(:,1) = [];
k = length(data(1,:));

%% Model including all variables as linearz

x_data_reg = [ones(n,1) data];
[b_coefs,b_ints,~,~,~] = regress(mass_data, x_data_reg);
y_regression = x_data_reg * b_coefs;
e_i = mass_data-y_regression;
s_e2_all = sum((mass_data-y_regression).^2)/(n-k+1);
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

% stepwisefit(data,mass_data);

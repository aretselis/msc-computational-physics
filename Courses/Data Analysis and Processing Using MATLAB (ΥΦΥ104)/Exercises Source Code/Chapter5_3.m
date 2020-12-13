% Data Analysis and Processing using MATLAB (ΥΦΥ104)
% Solution for exercise Chapter5_3
% Implemented by Anastasis Retselis
clear;clc;close all;

data_temp = importdata('tempThes59_97.dat');
data_rain = importdata('rainThes59_97.dat');
[years,months]=size(data_temp);
% In both files, rows are years and columns are months

L = 1000;
a = 0.05;
lower_limit = round((a/2)*L);
upper_limit = round((1-a/2)*L);
t_critical = tinv(1-a/2,years-2);
rand_comparison = zeros(L:1);
par_rho = zeros(L:1);

for i=1:months
    par_comparison = [data_temp(:,i) data_rain(:,i)];
    cor_matrix = corrcoef(par_comparison);
    rho = cor_matrix(2);
    for j=1:L
        rand_comparison = [par_comparison(:,1)...
            par_comparison(randperm(years),2)];
        cor_matrix = corrcoef(rand_comparison);
        par_rho(j) = cor_matrix(2);
    end
    t_par = rho*sqrt((years-2)/(1-rho^2));
    t_ran = par_rho.*sqrt((years-2)./(1-par_rho.^2));
    sort_t_ran = sort(t_ran);
    t_lower_limit = sort_t_ran(lower_limit);
    t_upper_limit = sort_t_ran(upper_limit);
    fprintf('Now examining Month %d:\n', i);
    % Parametric Check Results
    if abs(t_par)> t_critical
        fprintf(['Parametric check (H0 rejected) ( |t_par|= %.3f >',...
            ' t_critical = %.3f )\n'], abs(t_par), t_critical);
    else
        fprintf(['Parametric check (H0 accepted) ( |t_par|= %.3f <',...
            ' t_critical = %.3f )\n'], abs(t_par), t_critical);
    end
    % Randomization Check Resuults
    if t_par < t_lower_limit || t_par > t_upper_limit
        fprintf(['Randomization check (H0 rejected) ( t_par= %.3f out ',...
            'of [%.3f, %.3f])\n'], t_par, t_lower_limit, t_upper_limit);
    else
        fprintf(['Randomization check (H0 accepted) ( t_par= %.3f out ',...
            'of [%.3f, %.3f])\n'], t_par, t_lower_limit, t_upper_limit);
    end
    fprintf('==================================================\n');  
end
fprintf('\nChecks completed.\n');
    
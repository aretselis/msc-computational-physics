% Data Analysis and Processing using MATLAB (ΥΦΥ104)
% Solution for exercise Chapter3_3
% Implemented by Anastasis Retselis
clear;clc;

tau = 15;
M = 1000;

% Case a

n = 5;
sim = exprnd(tau, n, M);
mean_sim = mean(sim);
[~,~,ci,~] = ttest(mean_sim);

results = (mean_sim > ci(1) & mean_sim < ci(2));
ratio = sum(results)/length(results);

fprintf(['For M=%d samples with size n=%d the confidence interval is '...
    '[%.4f,%.4f] and the ratio of actual average lifetime being inside'...
    ' the confidence interval is %.4f\n'], M, n, ci(1), ci(2), ratio);

% Case b 

n = 100;
sim = exprnd(tau, n, M);
mean_sim = mean(sim);
[~,~,ci,~] = ttest(mean_sim);

results = (mean_sim > ci(1) & mean_sim < ci(2));
ratio = sum(results)/length(results);

fprintf(['For M=%d samples with size n=%d the confidence interval is '...
    '[%.4f,%.4f] and the ratio of actual average lifetime being inside'...
    ' the confidence interval is %.4f\n'], M, n, ci(1), ci(2), ratio);
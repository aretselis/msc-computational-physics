function [mean_sim] = exponential_simulation(tau,n,M)
% Data Analysis and Processing using MATLAB (ΥΦΥ104)
% Solution for exercise Chapter3_2
% Implemented by Anastasis Retselis
sim = exprnd(tau, n, M);
mean_sim = mean(sim);
figure;
histogram(mean_sim);
title({['Histogram of mean values for ' num2str(M) ' samples with si'...
    'ze ' num2str(n)] [' for an exponential distribution with'...
    ' \tau=' num2str(tau)]});
xlabel('Sample mean')
ylabel('Counts');
end


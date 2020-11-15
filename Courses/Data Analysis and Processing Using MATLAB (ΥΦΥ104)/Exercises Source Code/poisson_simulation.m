function mean_sim = poisson_simulation(M,n,lambda)

sim = poissrnd(lambda, n, M);
mean_sim = mean(sim);
figure;
histogram(mean_sim);
title({['Histogram of mean values for ' num2str(M) ' samples with si'...
    'ze ' num2str(n)] [' for a Poisson distribution with'...
    ' \lambda=' num2str(lambda)]});
xlabel('Sample mean')
ylabel('Counts');
end


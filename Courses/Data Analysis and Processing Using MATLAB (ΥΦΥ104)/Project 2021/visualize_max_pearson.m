function visualize_max_pearson(x_data,y_data, dates, lag, rho, country)
%visualize_max_pearson Plots x_t and y_t for a given country as overlap
%   INPUT: x_data, y_data, dates, lag, rho, country
%   OUTPUT: None (creates a figure)
figure;
bar(dates, x_data);
hold on;
grid on;
bar(dates, y_data);
title(sprintf('Plot for %s with τ = %d days\n which maximizes Pearson correlation coefficient ρ = %f',...
    country, lag, rho));
legend('x(t) (Cases)','y(t+τ) (Deaths with lag)');
xlabel('t (days)');
ylabel('Number of incidents');
end


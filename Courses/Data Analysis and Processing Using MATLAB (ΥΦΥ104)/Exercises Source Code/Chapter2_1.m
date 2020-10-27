clear;
clc;

disp('Coin Flipping Simulator');
n = input('Enter number of tosses to be performed: ');  
%Preallocate vectors
flips = zeros(n,1);
tails = zeros(n,1);
ratio = zeros(n,1);

%Discrete Method (Heads=0, Tails=1)
for i=1:n
    results = randi([0,1], [i,1]);
    tails(i)= sum(results);
    ratio(i)= tails(i)/i;
end
% Plot results and reset array for next run
figure
scatter((1:n),ratio,'.')
title({'Coin flips from discrete method (0=Heads, 1=Tails)',''})
xlabel('Number of flips, n')
ylabel('Number of Heads/Total Flips')
grid on
results = zeros(n,1); % Reset results array

% Continuous Distribution in [0,1] (Heads<0.5, Tails>0.5)
for i=1:n
    results = round(rand(i,1));
    tails(i)= sum(results);
    ratio(i)= tails(i)/i;
end
% Plot results
figure
scatter(1:n,ratio,'.','r')
title({'Coin flips from continuous distribution in [0,1]','(Heads if <0.5, Tails if >0.5)',''})
xlabel('Number of flips, n')
ylabel('Number of Heads/Total Flips')
grid on


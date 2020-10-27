clear;
clc;

disp('Coin Flipping Simulator');
n = input('Enter number of tosses to be performed: ');  
results = zeros(n,4); % Preallocate results array 

%Discrete Method (Heads=0, Tails=1)
for i = 1:n
    flips = randi([0:1], [i,1]);
    results(i,1) = i; % Log current number of flips 
    results(i,2) = sum(flips(:,1)==0); % Count heads ( ==0)
    results(i,3) = sum(flips(:,1)==1); % Count tails ( ==1)
    results(i,4) = results(i,3)/i; % Count tails percentage
end
% Plot results and reset array for next run
figure
scatter(results(:,1),results(:,4),'.')
title({'Coin flips from discrete method (0=Heads, 1=Tails)',''})
xlabel('Number of flips, n')
ylabel('Number of Heads/Total Flips')
grid on
results = zeros(n,4); % Reset results array

% Continuous Distribution in [0,1] (Heads<0.5, Tails>0.5)
for i = 1:n
    flips = rand(i,1);
    flips = round(flips);
    results(i,1) = i; % Log current number of flips 
    results(i,2) = sum(flips(:,1)==0); % Count heads ( ==0)
    results(i,3) = sum(flips(:,1)==1); % Count tails ( ==1)
    results(i,4) = results(i,3)/i; % Count tails percentage
end
% Plot results
figure
scatter(results(:,1),results(:,4),'.','r')
title({'Coin flips from continuous distribution in [0,1]','(Heads if <0.5, Tails if >0.5)',''})
xlabel('Number of flips, n')
ylabel('Number of Heads/Total Flips')
grid on


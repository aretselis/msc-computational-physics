clear;
clc;

disp('Coin Flipping Simulator');
n = input('Enter number of tosses to be performed: ');  

%Discrete Method (Heads=0, Tails=1)
flips = randi([0,1],1,n);
tails = cumsum(flips);
ratio = tails./(1:n);

% Plot results
figure;
semilogx((1:n),ratio,'.');
title({'Coin flips from discrete method (0=Heads, 1=Tails)',''});
xlabel('Number of flips, n');
ylabel('Ratio Tails/Total Flips');
grid on;

% Continuous Distribution in [0,1] (Heads<0.5, Tails>0.5)
flips=round(rand(1,n));
tails = cumsum(flips);
ratio = tails./(1:n);

% Plot results
figure;
semilogx(1:n,ratio,'.','color','r');
title({'Coin flips from continuous distribution in [0,1]'...
'(Heads if <0.5, Tails if >0.5)',''});
xlabel('Number of flips, n');
ylabel('Ratio Tails/Total Flips');
grid on;

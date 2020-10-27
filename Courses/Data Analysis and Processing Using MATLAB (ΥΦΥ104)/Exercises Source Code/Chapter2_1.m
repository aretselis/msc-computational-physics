clear;
clc;

disp('Coin Flipping Simulator');
n = input('Enter number of tosses to be performed: ');  
%Preallocate vectors
tails = zeros(n,1);

%Discrete Method (Heads=0, Tails=1)
flips = randi([0,1],n,1); % Add an extra flip to previous
for i=1:n
%      flips = randi([0,1], [i,1]); % Flip on all iterations until i
%      tails(i)= sum(flips); % Flip on all iterations until i
    
    % Use previous flips
    if i==1
        tails(1)= flips(1);
    else
        tails(i) = tails(i-1) + flips(i);
    end
end
ratio = tails./(1:n)';
% Plot results and reset array for next run
figure;
scatter((1:n),ratio,'.');
title({'Coin flips from discrete method (0=Heads, 1=Tails)',''});
xlabel('Number of flips, n');
ylabel('Number of Heads/Total Flips');
grid on;

% Continuous Distribution in [0,1] (Heads<0.5, Tails>0.5)

flips=round(rand(1,n)); % Use previous flips
for i=1:n
%     flips = round(rand(i,1)); % Flip on all iterations until i
%     tails(i)= sum(flips); % Flip on all iterations until i
    
    % Use previous flips
    if i==1
        tails(1)= flips(1);
    else
        tails(i) = tails(i-1) + flips(i);
    end
end
ratio = tails./(1:n)';
% Plot results
figure;
scatter(1:n,ratio,'.','r');
title({'Coin flips from continuous distribution in [0,1]'...
'(Heads if <0.5, Tails if >0.5)',''});
xlabel('Number of flips, n');
ylabel('Number of Heads/Total Flips');
grid on;

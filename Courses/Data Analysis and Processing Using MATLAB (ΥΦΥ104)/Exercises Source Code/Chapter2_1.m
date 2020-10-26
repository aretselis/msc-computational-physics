clear;
clc;

disp('Coin Flip Simulator');
n = input('Enter number of tosses to be performed: ')  
    
results = zeros(n,4); % Preallocate an array 
for i = 1:n
    toss = randi([0:1], [i,1]);
    results(i,1) = i;
    results(i,2) = sum(toss(:,1)==0); % Count heads ( ==0)
    results(i,3) = sum(toss(:,1)==1); % Count tails ( ==1)
    results(i,4) = results(i,3)/i;
end

scatter(results(:,1),results(:,4))
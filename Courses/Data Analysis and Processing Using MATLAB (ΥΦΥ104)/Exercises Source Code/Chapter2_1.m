clear;
clc;

while 1==1
    disp('Coin Flip Simulator');
    number_toss = input('Enter number of tosses to be performed: ')  
    
    results = randi([0:1], [number_toss,1]);
    heads = sum(results(:,1)==0);
    tails = sum(results(:,1)==1);
    sum = heads + tails;
    fprintf('Number of heads = %d\nNumber of tails = %d\n', heads, tails);
    fprintf('Total = %d\n', sum);    
    clear;
end
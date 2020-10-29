clear;
clc;

disp('Deal 23rd box simulator');
money = input('Enter your winnings: ');
n = input('Enter number of simulations to be performed: ');
results=zeros(n,1);

extra_box = randi([1,5],n,1);

for i=1:n
    if extra_box(i)==1
        results(i)= 0;
    elseif extra_box(i)==2
        results(i)= money/2;
    elseif extra_box(i)==3
        results(i)= money;
    elseif extra_box(i)==4
        results(i)= money + 1500;
    elseif extra_box(i)==5
        results(i)= 2*money;
    end
end

visualize=cumsum(results)./(1:n)';
cashout = sum(results)/n;

plot(1:n,visualize);
title('Προσομοιωτής 23ου κουτιού');
xlabel('Αριθμός προσομοίωσης, n');
ylabel('Μέσο κέρδος, Ευρώ');
grid on;

fprintf('With winning box being %d euros, after %d simulations, you would win an average of %.2f euros\n', money, n, cashout);
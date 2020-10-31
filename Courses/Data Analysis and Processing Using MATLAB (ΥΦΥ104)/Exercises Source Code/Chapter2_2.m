clear;
clc;

n = 1000;
lambda = 1;
syms x;

temp=rand(1,n);
results=-(1/lambda)*log(1-temp);
hold on;
histogram(results,'Normalization','pdf');
fplot(lambda*exp(-lambda*x),[0,5]);
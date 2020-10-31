clear;
clc;

n = 1000;
lambda = 1;
syms x;

% Using rand

temp=rand(1,n);
results=-(1/lambda)*log(1-temp);
figure;
hold on;
histogram(results,70,'Normalization','pdf');
fplot(lambda*exp(-lambda*x),[0,5]);

% MATLAB built-in implementation

% figure;
% hold on;
% results=exprnd(1,n);
% histogram(results,'Normalization','pdf');
% fplot(lambda*exp(-lambda*x),[0,5]);
clear;
clc;

n=1000000;
mu1=1;
Sigma=2;

x = mvnrnd(mu1,Sigma,n);
y = mvnrnd(mu1,Sigma,n);
var(x)+var(y)
var(x+y)

% Correct Var[x+y]

% actual = var(x)+var(y)+2*cov(x,y);
% actual(2)









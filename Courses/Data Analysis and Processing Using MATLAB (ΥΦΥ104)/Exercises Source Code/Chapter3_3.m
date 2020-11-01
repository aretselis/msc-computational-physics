clear;
clc;

n=10000000;
mu1=[2 0];
mu2=[4 0];
Sigma=[1 0];


x = mvnrnd(mu1,Sigma,n);
y = mvnrnd(mu2,Sigma,n);
var(x)+var(y)
var(x+y)



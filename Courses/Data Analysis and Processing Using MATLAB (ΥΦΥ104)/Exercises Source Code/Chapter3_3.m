clear;
clc;

n=1000000;
mu1=[0 1];
mu2=[0 1];
mu3=mu1+mu2;
Sigma=[1 0];


x = mvnrnd(mu1,Sigma,n);
y = mvnrnd(mu2,Sigma,n);
z = mvnrnd(mu3,Sigma,n);
var(x)+var(y)
var(z)




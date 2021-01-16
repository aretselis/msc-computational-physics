% Data Analysis and Processing using MATLAB (ΥΦΥ104)
% Solution for exercise Chapter5_8
% Implemented by Anastasis Retselis
clear;clc;close all;

physical = importdata('physical.txt','	',1);
data = physical.data;
n = length(data);

mass = 1;
fore = 2;
bicep = 3;
chest = 4;
neck = 5;
shoulder =6;
waist = 7;
height = 8;
calf = 9;
thigh = 10;
head = 11;

mass_data = data(:,1);
data(:,1) = [];

x_data_reg = [ones(n,1) data];
[b_coefs,b_ints,~,~,~] = regress(mass_data, x_data_reg);
stepwisefit(data,mass_data);

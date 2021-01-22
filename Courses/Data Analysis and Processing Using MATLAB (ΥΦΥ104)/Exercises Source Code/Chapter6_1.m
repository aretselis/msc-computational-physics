% Data Analysis and Processing using MATLAB (ΥΦΥ104)
% Solution for exercise Chapter5_9
% Implemented by Anastasis Retselis
clear;clc;close all;

data = importdata('sunspots.dat');
years = data(:,1);
sunspots = data(:,2);

plot(years, sunspots,'.-');


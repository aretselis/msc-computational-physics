% Data Analysis and Processing using MATLAB (ΥΦΥ104)
% Solution for exercise Chapter5_4
% Implemented by Anastasis Retselis
clear;clc;close all;

lightairdata = importdata('lightair.dat');
measurements_count = length(lightairdata);
density = lightairdata(:,1);
light_speed = lightairdata(:,2);

lightair_corr_mat = corrcoef(lightairdata);
lightair_corrcoef = lightair_corr_mat(2);
figure;
plot(density,light_speed,'.');
title(sprintf('Light Speed as a function of air density (r = %.4f)',...
    lightair_corrcoef));
xlabel('Air Density, ρ, [kg/m^3]')
ylabel('Light Speed, c_{air}, [m/s]')
grid on;


% Data Analysis and Processing using MATLAB (ΥΦΥ104)
% Solution for exercise Chapter4_2
% Implemented by Anastasis Retselis
clear;clc;close all;

%% A) Area uncertainty for width and length

sigma_measurement = 5;
length = 500;
width = 300;
sigma_area = sqrt(width^2*sigma_measurement^2+length^2*...
    sigma_measurement^2);
fprintf(['The uncertainty of the area for Width = %d m',...
    ', Length = %d m and σ_measure = %d m is σ_A = %.4f m^2\n'],...
    width, length, sigma_measurement, sigma_area);

% sigma_area^2/sigma_measurement^2 = width^2 + length ^2 
% This is the equation of a circle. Only consider width>0 and length>0

t = 0:0.0001:pi/2;
radius = sqrt(sigma_area^2/sigma_measurement^2);
x = radius * cos(t);
y = radius * sin(t);
plot(x,y);
title(['Equation $$\frac{\sigma{_{A}}^{2}}{\sigma{_{measure}}^{2}}'...
    '=w^2+l^2\; for\: w>0\: ,\: l>0$$'],'interpreter','latex');
xlabel('Width, w, [m]','interpreter','latex');
ylabel('Length, l, [m]','interpreter','latex');
axis equal;
axis([0 700 0 700]);
grid on;

%% B) Uncertainty plot as a function of width and length

size = 1000;
step = 10;
width_b = 1:step:size;
length_b = (1:step:size)';
sigma_area_b = sqrt(width_b.^2*sigma_measurement^2+length_b.^2*...
    sigma_measurement^2);
figure;
surf(width_b,length_b,sigma_area_b');
xlabel('Width, w, [m]','interpreter','latex');
ylabel('Length, l, [m]','interpreter','latex');
zlabel('Area Uncertainty, $$\sigma_{A}$$, $$[m^2]$$','interpreter','latex');

% Data Analysis and Processing using MATLAB (ΥΦΥ104)
% Solution for exercise Chapter4_3
% Implemented by Anastasis Retselis
clear;clc;close all;

%% A,B) Dissipated power uncertainty and simulation

% Initialize values and calculate uncertainty

mean_V = 77.78;     % V
sigma_V = 0.71;     % V
mean_I = 1.12;      % A
sigma_I = 0.071;    % A
mean_f = 0.283;          % rad
sigma_f = 0.017;    % rad

sigma_p = sqrt((mean_I*cos(mean_f)*sigma_V)^2 + (mean_V*cos(mean_f)*...
    sigma_I)^2 + (-mean_V*mean_I*sin(mean_f))^2); 

% Create and run simulation

M = 100;
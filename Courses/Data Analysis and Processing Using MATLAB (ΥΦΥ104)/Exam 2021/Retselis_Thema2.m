% Thema 2
% Anastasios-Faidon Retselis

clear;clc;close all;

filename = 'DataEx2No1.dat';
data = importdata(filename);
data = sortrows(data,1);
x = data(:,1);
y = data(:,2);
size = size(y);
n = length(y);
figure;
plot(x,y,'.');
xlabel('x');
ylabel('y');
hold on;

% Model 1
% Simple Linear

k = 1;
linear_x = [ones(size) x];
[lin_b_1,~,~,~,~] = regress(y, linear_x);

y_regression_linear = linear_x * lin_b_1;
R2_m1 = 1 - (sum((y-y_regression_linear).^2)/sum((y-mean(y)).^2));
adjR2_m1 = 1-(sum((y-y_regression_linear).^2)/...
        sum((y-mean(y)).^2)*(n-1)/(n-(k+1)));
plot(x,y_regression_linear,'-.');
fprintf('For simple linear model, adjR^2 = %.4f\n', adjR2_m1);

% Model 2
% Split in half

k = 2;
size_m2 = size;
size_m2(1) = size(1)/2;
x1 = x(1:(n/2));
x2 = x(((n/2)+1):end);
y1 = y(1:(n/2));
y2 = y(((n/2)+1):end);
linear_x1 = [ones(size_m2) x1];
linear_x2 = [ones(size_m2) x2];

[h1lin_b,~,~,~,~] = regress(y1, linear_x1);
[h2lin_b,~,~,~,~] = regress(y2, linear_x2);
y1_regression_linear = linear_x1 * h1lin_b;
y2_regression_linear = linear_x2 * h2lin_b;

y_sum = [y1_regression_linear; y2_regression_linear];

R2_m2 = 1 - (sum((y-y_sum).^2)/sum((y-mean(y)).^2));
adjR2_m2 = 1-(sum((y-y_sum).^2)/...
        sum((y-mean(y)).^2)*(n-1)/(n-(k+1)));
plot(x1,y1_regression_linear,'--');
plot(x2,y2_regression_linear,'--');
fprintf('For two segment linear model (split in half), adjR^2 = %.4f\n', adjR2_m2);

% Model 3
% Split in 10s

k = 4;
size_m3 = size;
size_m3(1) = size(1)/4;
x1 = x(1:size_m3(1));
x2 = x(size_m3(1)+1:2*size_m3(1));
x3 = x(2*size_m3(1)+1:3*size_m3(1));
x4 = x(3*size_m3(1)+1:end);
y1 = y(1:size_m3(1));
y2 = y(size_m3(1)+1:2*size_m3(1));
y3 = y(2*size_m3(1)+1:3*size_m3(1));
y4 = y(3*size_m3(1)+1:end);

linear_x1 = [ones(size_m3) x1];
linear_x2 = [ones(size_m3) x2];
linear_x3 = [ones(size_m3) x3];
linear_x4 = [ones(size_m3) x4];

[h1lin_b,~,~,~,~] = regress(y1, linear_x1);
[h2lin_b,~,~,~,~] = regress(y2, linear_x2);
[h3lin_b,~,~,~,~] = regress(y3, linear_x3);
[h4lin_b,~,~,~,~] = regress(y4, linear_x4);

y1_linear = linear_x1 * h1lin_b;
y2_linear = linear_x2 * h2lin_b;
y3_linear = linear_x3 * h3lin_b;
y4_linear = linear_x4 * h4lin_b;


y_sum_m3 = [y1_linear; y2_linear; y3_linear; y3_linear];

R2_m3 = 1 - (sum((y-y_sum_m3).^2)/sum((y-mean(y)).^2));
adjR2_m3 = 1-(sum((y-y_sum_m3).^2)/...
        sum((y-mean(y)).^2)*(n-1)/(n-(k+1)));
fprintf('For four segment linear model (split in tens), adjR^2 = %.4f\n', adjR2_m3);

plot(x1,y1_linear);
plot(x2,y2_linear);
plot(x3,y3_linear);
plot(x4,y4_linear);
legend('Raw Data Points',...
    'Linear Model',...
    'Split in half (1st segment)',...
    'Split in half (2nd segment)',...
    'Split in tens (1st segment)',...
    'Split in tens (2nd segment)',...
    'Split in tens (3rd segment)',...
    'Split in tens (4th segment)');

% 1. Me basi tis times tou adjR^2 poy ypologisame, to montelo 2 (se dio tmimata)
% prosarmozetai kalytera
%
% 2. Gia to 1o modelo, ena tmima k=1, dof=n-(k+1)=40-2=38
%    Gia to 2o modelo, dio tmimata k=2, dof=n-(k+1)=40-3=37
%    Gia to 3o modelo, tessera tmimata k=4, dof=n-(k+1)=40-5=35

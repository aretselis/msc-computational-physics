clear;clc;close all;

filename = 'results.csv';
data = importdata(filename);
step = 12/199;
x_vector = 0:step:12;
t_step = step/(2*sqrt(2/(pi*pi)));
t_vector = 0:t_step:5*pi;

figure;
subplot(3,2,1);
plot(x_vector,data(1,:),'.')
xlabel('x');
ylabel('u(x,0)');
grid on;
subplot(3,2,2);
plot(x_vector,data(48,:),'.')
xlabel('x');
ylabel('u(x,π)');
grid on;
subplot(3,2,3);
plot(x_vector,data(95,:),'.')
xlabel('x');
ylabel('u(x,2π)');
grid on;
subplot(3,2,4);
plot(x_vector,data(142,:),'.')
xlabel('x');
ylabel('u(x,3π)');
grid on;
subplot(3,2,5);
plot(x_vector,data(189,:),'.')
xlabel('x');
ylabel('u(x,4π)');
grid on;
subplot(3,2,6);
plot(x_vector,data(end,:),'.')
xlabel('x');
ylabel('u(x,5π)');
grid on;

figure;
surf(x_vector,t_vector,data);
xlabel('x');
ylabel('t');
zlabel('u(x,t)');

threads = [1 2 4 8];
time = [42.239 29.231 18.851 17.753];
speedup = time(1)./time;
figure;
plot(threads,speedup,'o-');
ylabel('Speedup');
xlabel('Threads');
title('N=20000 grid points');
grid on;

time_2 = [8.145 4.384 3.012 2.635];
speedup2 = time_2(1)./time_2;
a = speedup2./[1 2 4 8];
a = a*100;

figure;
plot(threads,time_2,'ro');
xlabel('Threads');
ylabel('Execution Time (sec)');
grid on;

figure;
plot(threads,a,'ro');
xlabel('Threads');
ylabel('Parallel efficiency (%)');
grid on;

time_3 = [0.956 0.556 0.434 0.415];
speedup3 = time_3(1)./time_3;
figure;
plot(threads,speedup3,'ro-');
ylabel('Speedup');
xlabel('Threads');
title('n=100000001 points');
grid on;

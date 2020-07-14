clc;
clear all;
close all;
run('ur5_trajectory2.m');
omega_P_1 = 19.4841;
omega_D_1 = 36.5366;
omega_P_2 = 6.6640;
omega_D_2 = 22.5504;
omega_P_3 = 10.2280;
omega_D_3 = 56.6301;


K_0 =   [379.6302         0         0         0         0         0;
         0   44.4089         0         0         0         0;
         0         0  104.6120         0         0         0;
         0         0         0   76.9813         0         0;
         0         0         0         0   76.9813         0;
         0         0         0         0         0   76.9813];
     
K_1 = [  73.0732         0         0         0         0         0;
         0   45.1008         0         0         0         0;
         0         0  113.2602         0         0         0;
         0         0         0   77.8688         0         0;
         0         0         0         0   77.8688         0;
         0         0         0         0         0   77.8688];

q_max =  2*pi*ones(1,6);        % [rad]
q_min = -2*pi*ones(1,6);        % [rad]
v_max = 3.4*ones(1,6);          % [rad/sec]
a_max = [15 15 15 25 25 25];    % [rad/sec/sec]
a_max = [27 27 27 27 27 27];    % [rad/sec/sec]
torque_max = [150 150 150 28 28 28];
run('control2')
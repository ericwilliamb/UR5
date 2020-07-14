clc;
clear all;
close all;

run('IRB_trajectory2.m')

Q_A = [0.0951    0.1937    0.0007         0];
q_max =  2*pi*ones(1,4);        % [rad]
q_min = -2*pi*ones(1,4);        % [rad]
v_max = 3.4*ones(1,4);          % [rad/sec]
v(1,3) = 20;
a_max = [50 50 50 50];    % [rad/sec/sec]
torque_max = [300 150 150 28];

 
 K_1 = [5.0000         0         0         0
          0   10.0000         0         0;
          0         0   40.0000         0;
          0         0         0   77.8688];
 K_0 = [  5         0         0         0;
          0   10         0         0;
          0         0  40.0000         0;
          0         0         0   76.9813];


run('control2_irb')


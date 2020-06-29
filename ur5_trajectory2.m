clc
clear
close all
addpath('functions')
%% Robot construction.
deg = pi/180;
a2=425/1000;%dimensoes (m)
a3=392/1000;
d1=89.2/1000;
d2=0;
d3=0;
d4=109.3/1000;
d5=94.75/1000;
d6=82.5/1000;

Elo(1) = Link([0 d1 0 pi/2]);%theta, d, a, alpha, 0/1(opcional: rev/prism)
Elo(2) = Link([0 d2 a2 0]);
Elo(3) = Link([0 d3 a3 0]);
Elo(4) = Link([0 d4 0 pi/2]);
Elo(5) = Link([0 d5 0 -pi/2]);
Elo(6) = Link([0 d6 0 0]);
Robo = SerialLink(Elo);%constrói robo
Robo.name = 'UR5';

%% Getting KeyPoints
start_position=[0.817; -0.1918; 0.101];
pick_position = [0.1918; 0.5046; 0.09998];
pick2_position = [0.1918; 0.5046; 0];
default_rotation = [1 0 0 ; 0 0 -1; 0  1 0];
T_start = getTransformationMatrix(start_position, default_rotation);
T_pick = getTransformationMatrix(pick_position, default_rotation);
T_pick2 = getTransformationMatrix(pick2_position, default_rotation);
Q_start= Robo.ikine(T_start, 'verbose');
Q_pick = Robo.ikine(T_pick, 'verbose');
Q_pick2 = Robo.ikine(T_pick2, 'verbose');

%% Interpolating
theta0_space = [Q_start(1) Q_pick(1) Q_pick2(1) Q_start(1)];
dt = 1;
time_space = [ 0*dt 1*dt 2*dt 3*dt]; 
time_space_new = 0:0.005:3*dt;
pos_theta0 = interp1(time_space, theta0_space, time_space_new); 

%% Plotting
[vel_theta0, acel_theta0] = calcVelocityAcceleration(time_space_new, pos_theta0);
plot(time_space,theta0_space,'o',time_space_new,pos_theta0,':.');
subplot(3,1,1)
plot(time_space_new, pos_theta0)
xlabel('t')
ylabel('Positions')
legend('X','Y')
subplot(3,1,2)
plot(time_space_new(1:600), vel_theta0)
xlabel('t')
ylabel('Velocities')
legend('X','Y')
subplot(3,1,3)
plot(time_space_new(1:599), acel_theta0)
xlabel('t')
ylabel('Acceleration')
legend('X','Y')




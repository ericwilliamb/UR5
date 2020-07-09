%clc
%clear
%close all
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
%Theta0
waypoints = [Q_start; Q_pick; Q_pick2; Q_pick2; Q_start];

theta_space = zeros(6,5);
for i=1:6
    for j = 1:5
       theta_space(i,j) = [waypoints(j,i)]; 
    end
end

dt = 4;

[x1_s, th1_s] = computePosition(theta_space(1,:), dt);
signal1 = [x1_s' th1_s'];
[x2_s, th2_s] = computePosition(theta_space(2,:), dt);
signal2 = [x2_s' th2_s'];
[x3_s, th3_s] = computePosition(theta_space(3,:), dt);
signal3 = [x3_s' th3_s'];
[x4_s, th4_s] = computePosition(theta_space(4,:), dt);
signal4 = [x4_s' th4_s'];
[x5_s, th5_s] = computePosition(theta_space(5,:), dt);
signal5 = [x5_s' th5_s'];
[x6_s, th6_s] = computePosition(theta_space(6,:), dt);
signal6 = [x6_s' th6_s'];




[x_v, y_v, x_a, y_a] = calcVelocityAcceleration(x1_s, th1_s);


%% Plotting

subplot(3,1,1)
plot(x1_s, th1_s)
xlabel('t')
ylabel('Positions')
subplot(3,1,2)
plot(x_v, y_v)
xlabel('t')
ylabel('Velocities')
subplot(3,1,3)
plot(x_a, y_a)
xlabel('t')
ylabel('Acceleration')




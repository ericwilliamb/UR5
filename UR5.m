close all
clear all
clc
%% construção

a2=425;%dimensoes (mm)
a3=392;
d1=89.2;
d2=0;
d3=0;
d4=109.3;
d5=94.75;
d6=82.5;


Elo(1) = Link([0 d1 0 pi/2]);%theta, d, a, alpha, 0/1(opcional: rev/prism)
Elo(2) = Link([0 d2 a2 0]);
Elo(3) = Link([0 d3 a3 0]);
Elo(4) = Link([0 d4 0 pi/2]);
Elo(5) = Link([0 d5 0 -pi/2]);
Elo(6) = Link([0 d6 0 0]);
Robo = SerialLink(Elo);%constrói robo
Robo.name = 'UR5';

%% matriz A(x-1 a x)
syms x;
syms theta;
syms theta1;
syms theta2; 
syms theta3; 
syms theta4; 
syms theta5; 
syms theta6;

%parâmetros:
%   a alpha   d theta
DH=[0   pi/2    d1   theta1;
    a2    0   d2   theta2;
    a3   0     d3   theta3;
    0   pi/2     d4   theta4;
    0   -pi/2   d5   theta5;
    0    0    d6   theta6];

GD=size(DH);
GDL=GD(1,1);


for x=1:GDL
    
    a=DH(x,1);%extrai parametros
    alpha=DH(x,2);
    d=DH(x,3);
    %theta=DH(x,4);

Atemp = [cos(DH(x,4))   -sin(DH(x,4))*cos(alpha)   sin(DH(x,4))*sin(alpha)    a*cos(DH(x,4));
         sin(DH(x,4))    cos(DH(x,4))*cos(alpha)   -cos(DH(x,4))*sin(alpha)   a*sin(DH(x,4));
          0             sin(alpha)              cos(alpha)               d;
          0                 0                       0                    1];

 A(:,:,x)=Atemp;%forma as matrizes A01, A12, A23...An-1 n
      
end

%% Calculo da matriz de transformação:
 T(:,:,1)= A(:,:,1);
 
 for x=2:1:GDL
 
     Ttemp = A(:,:,x);
     
     T(:,:,x)= T(:,:,(x-1))*Ttemp;
     T(:,:,x)= simplify(T(:,:,x));
 
 end


%% plots

Q0 = [0 0 0 0 0 0];%%posicao inicial na esteira
%Robo.plot(Q0);
Q1 = [0 pi/4 -pi/2 pi/4 0 0];%recua
%Robo.plot(Q1);
Q2 = [(pi/2) pi/4 -pi/2 pi/4 0 0];%gira ccw
%Robo.plot(Q2);
Q3 = [0 pi/4 -pi/2 pi/4 0 0];%gira cw
%Robo.plot(Q3);
Q0 = [0 0 0 0 0 0];%%esteira novamente
%Robo.plot(Q0);
Q1 = [0 pi/4 -pi/2 pi/4 0 0];%recua
%Robo.plot(Q1);
Q4 = [-(pi/2) pi/4 -pi/2 pi/4 0 0];%gira cw
%Robo.plot(Q4);
Q1 = [0 pi/4 -pi/2 pi/4 0 0];%retorna
%Robo.plot(Q1);

%% cinematica

%Qfinal = Robo.ikine(T);


%% animação

TRAJ = jtraj(Q0, Q1, (0:.03:1));%posicao inicial, final, vetor de tempo (pode ser substituido por int=passos)
Robo.plot(TRAJ);%mostra animação da trajetoria

TRAJ1= jtraj(Q1, Q2, (0:.03:1));
Robo.plot(TRAJ1);

TRAJ2 = jtraj(Q2, Q3, (0:.03:1));
Robo.plot(TRAJ2);

TRAJ3 = jtraj(Q3, Q0, (0:.03:1));
Robo.plot(TRAJ3);

TRAJ4 = jtraj(Q0, Q1, (0:.03:1));
Robo.plot(TRAJ4);

TRAJ5 = jtraj(Q1, Q4, (0:.03:1));
Robo.plot(TRAJ5);

TRAJ6 = jtraj(Q4, Q1, (0:.03:1));
Robo.plot(TRAJ6);

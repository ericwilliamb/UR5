close all
clear all
clc
%% constru��o

a2=425;%dimensoes
a3=392;
d1=89.2;
d4=109.3;
d5=94.75;
d6=82.5;


Elo(1) = Link([0 d1 0 0]);%theta, d, a, alpha, 0/1(opcional: rev/prism)
Elo(2) = Link([0 0 0 pi/2]);
Elo(3) = Link([0 -80 a2 0]);
Elo(4) = Link([0 d4 a3 0]);
Elo(5) = Link([0 -d5 0 pi/2]);
Elo(6) = Link([0 d6 0 -pi/2]);
Robo = SerialLink(Elo);%constr�i robo
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

%par�metros:
%   a alpha   d theta
DH=[0   0     d1   theta1;
    0   pi/2   0   theta2;
    a2   0     0   theta3;
    a3   0     d4   theta4;
    0   pi/2   d5   theta5;
    0   -pi/2  d6   theta6];

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

%% Calculo da matriz de transforma��o:
 T(:,:,1)= A(:,:,1);
 
 for x=2:1:GDL
 
     Ttemp = A(:,:,x);
     
     T(:,:,x)= T(:,:,(x-1))*Ttemp;
     T(:,:,x)= simplify(T(:,:,x));
 
 end


%% plots

Q0 = [0 0 0 0 pi/2 0];
%Robo.plot(Q0);
Q1 = [0 0 pi/4 -pi/2 (pi/2+pi/4) 0];
%Robo.plot(Q1);

%% cinematica

%Qfinal = Robo.ikine(T);


%% anima��o

TRAJ = jtraj(Q0, Q1, (0:.03:1));%posicao inicial, final, vetor de tempo (pode ser substituido por int=passos)
Robo.plot(TRAJ);%mostra anima��o da trajetoria

TRAJ2 = jtraj(Q1, Q0, (0:.03:1));
Robo.plot(TRAJ2);

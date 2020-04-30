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
    a2    0    d2   theta2;
    a3   0     d3   theta3;
    0   pi/2   d4   theta4;
    0   -pi/2  d5   theta5;
    0    0     d6   theta6];

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

 %extrai coordenadas da matriz de transformação 0-6(final):
 X=T(1,4,6);
 Y=T(2,4,6);
 Z=T(3,4,6);
 
 %% jacobiano
 
 J=[diff(X, theta1)    diff(X, theta2)    diff(X, theta3)    diff(X, theta3)    diff(X, theta5)    diff(X, theta6)
     diff(Y, theta1)    diff(Y, theta2)    diff(Y, theta3)    diff(Y, theta3)    diff(Y, theta5)    diff(Y, theta6)
     diff(Z, theta1)    diff(Z, theta2)    diff(Z, theta3)    diff(Z, theta3)    diff(Z, theta5)    diff(Z, theta6)];
 
 %% iteracoes:
 
 %posição desejada??:
 XYZo=[500
        0
        0];
    
    
 %faltando orientação desejada??
 
 
 %angulos iniciais?
 theta1=0;
 theta2=0;
 theta3=0;
 theta4=0;
 theta5=0;
 theta6=0;
 
 for k=1:20
     %matriz posição atual
     XYZi=[eval(X)
         eval(Y)
         eval(Z)];
     
     Ji=eval(J);
     
     %pseudo inversa:
     Jinv=Ji'*inv(Ji*Ji');
     
     ERRO=XYZo-XYZi
     
     %nova posição soma (pseudo inversa)x ERRO
     Posicao=[theta1;
              theta2;
              theta3;
              theta4;
              theta5;
              theta6]+ Jinv*ERRO; 
          
     %atualiza cada ângulo
     theta1=Posicao(1,1);
     theta2=Posicao(2,1);
     theta3=Posicao(3,1);
     theta4=Posicao(4,1);
     theta5=Posicao(5,1);
     theta6=Posicao(6,1);
     
 end
 
 
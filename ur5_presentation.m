%% Plot erros position robo UR5

t=out.erroPos.time;
position=out.erroPos.data;
N=length(t);

figure(1)
title('Position error of robot UR5')

subplot(6,1,1)
plot(t(1:N),position(1:N,1))
ylabel('joint n.1')
xlabel('time')
title('Position error of robot UR5')

subplot(6,1,2)
plot(t(1:N),position(1:N,2))
ylabel('joint n.2')
xlabel('time')

subplot(6,1,3)
plot(t(1:N),position(1:N,3))
ylabel('joint n.3')
xlabel('time')

subplot(6,1,4)
plot(t(1:N),position(1:N,4))
ylabel('joint n.4')
xlabel('time')

subplot(6,1,5)
plot(t(1:N),position(1:N,5))
ylabel('joint n.5')
xlabel('time')

subplot(6,1,6)
plot(t(1:N),position(1:N,6))
ylabel('joint n.6')
xlabel('time')


figure(2)
title('Torques of robot UR5')
torques = out.torques.Data;
t = out.torques.Time;
subplot(6,1,1)
Start=15;
plot(t(Start:N),torques(Start:N,1))
ylabel('joint n.1')
xlabel('time')
title('Torque of Robot UR5')

subplot(6,1,2)
plot(t(Start:N),torques(Start:N,2))
ylabel('joint n.2')
xlabel('time')

subplot(6,1,3)
plot(t(Start:N),torques(Start:N,3))
ylabel('joint n.3')
xlabel('time')

subplot(6,1,4)
plot(t(Start:N),torques(Start:N,4))
ylabel('joint n.4')
xlabel('time')

subplot(6,1,5)
plot(t(Start:N),torques(Start:N,5))
ylabel('joint n.5')
xlabel('time')

subplot(6,1,6)
plot(t(Start:N),torques(Start:N,6))
ylabel('joint n.6')
xlabel('time')


figure(3)
title('Trajectory UR5')
for i=1:30:length(th1_s)
    Tm = Robo.fkine([th1_s(i), th2_s(i), th3_s(i), th4_s(i), th5_s(i), th6_s(i)]);
    x = Tm.t(1);
    y = Tm.t(2);
    z = Tm.t(3);
    plot3(x,y,z,'b.');
    drawnow;
    hold on;
   % Robo.plot([th1_s(i), th2_s(i), th3_s(i), th4_s(i), th5_s(i), th6_s(i)])
end


for i=1:50:5419
    T1 = Robo.fkine([out.posicaoReal.Data(i,1) out.posicaoReal.Data(i,2) out.posicaoReal.Data(i,3) out.posicaoReal.Data(i,4) out.posicaoReal.Data(i,5) out.posicaoReal.Data(i,6)]);
    x = T1.t(1);
    y = T1.t(2);
    z = T1.t(3);
    plot3(x,y,z,'r.');
    drawnow;
    hold on;
    %Robo.plot([th1_s(i), th2_s(i), th3_s(i), th4_s(i), th5_s(i), th6_s(i)])
end
L(1) = plot(nan, nan, 'b-');
L(2) = plot(nan, nan, 'r-');
legend(L, {'Desired Trajectory', 'Real Trajectory'})
hold off


figure(4)
title('Trajectory UR5(With Robot)')
for i=1:70:length(th1_s)
    Tm = Robo.fkine([th1_s(i), th2_s(i), th3_s(i), th4_s(i), th5_s(i), th6_s(i)]);
    x = Tm.t(1);
    y = Tm.t(2);
    z = Tm.t(3);
    plot3(x,y,z,'b.');
    drawnow;
    hold on;
    Robo.plot([th1_s(i), th2_s(i), th3_s(i), th4_s(i), th5_s(i), th6_s(i)])
end


for i=1:100:size(out.posicaoReal.Time,1)
    T1 = Robo.fkine([out.posicaoReal.Data(i,1) out.posicaoReal.Data(i,2) out.posicaoReal.Data(i,3) out.posicaoReal.Data(i,4) out.posicaoReal.Data(i,5) out.posicaoReal.Data(i,6)]);
    x = T1.t(1);
    y = T1.t(2);
    z = T1.t(3);
    plot3(x,y,z,'r.');
    drawnow;
    hold on;
    Robo.plot([out.posicaoReal.Data(i,1) out.posicaoReal.Data(i,2) out.posicaoReal.Data(i,3) out.posicaoReal.Data(i,4) out.posicaoReal.Data(i,5) out.posicaoReal.Data(i,6)])
end
hold off


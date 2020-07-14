%% Plot erros position robo IRB
t=out.erroPos.time;
position=out.erroPos.data;
N=length(t);

figure(1)
title('Position error of robot IRB')
subplot(4,1,1)
plot(t(1:N),position(1:N,1))
ylabel('joint n.1')
xlabel('time')
title('Position error of robot IRB')

subplot(4,1,2)
plot(t(1:N),position(1:N,2))
ylabel('joint n.2')
xlabel('time')

subplot(4,1,3)
plot(t(1:N),position(1:N,3))
ylabel('joint n.3')
xlabel('time')

subplot(4,1,4)
plot(t(1:N),position(1:N,4))
ylabel('joint n.4')
xlabel('time')



figure(2)
title('Torques of robot IRB')
torques = out.torques.Data;
t = out.torques.Time;
subplot(4,1,1)
Start=15;
plot(t(Start:N),torques(Start:N,1))
ylabel('joint n.1')
xlabel('time')
title('Torque of Robot IRB')

subplot(4,1,2)
plot(t(Start:N),torques(Start:N,2))
ylabel('joint n.2')
xlabel('time')

subplot(4,1,3)
plot(t(Start:N),torques(Start:N,3))
ylabel('joint n.3')
xlabel('time')

subplot(4,1,4)
plot(t(Start:N),torques(Start:N,4))
ylabel('joint n.4')
xlabel('time')

figure(3)
title('Trajectory IRB')
for i=1:30:length(th1_s)
    Tm = Robo.fkine([th1_s(i), th2_s(i), th3_s(i), th4_s(i)]);
    x = Tm.t(1);
    y = Tm.t(2);
    z = Tm.t(3);
    plot3(x,y,z,'b.');
    drawnow;
    hold on;
   % Robo.plot([th1_s(i), th2_s(i), th3_s(i), th4_s(i), th5_s(i), th6_s(i)])
end


for i=1:50:size(out.posicaoReal.Time,1)
    T1 = Robo.fkine([out.posicaoReal.Data(i,1) out.posicaoReal.Data(i,2) out.posicaoReal.Data(i,3) out.posicaoReal.Data(i,4)]);
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
title('Trajectory IRB(With Robot)')
for i=1:70:length(th1_s)
    Tm = Robo.fkine([th1_s(i), th2_s(i), th3_s(i), th4_s(i)]);
    x = Tm.t(1);
    y = Tm.t(2);
    z = Tm.t(3);
    plot3(x,y,z,'b.');
    drawnow;
    hold on;
    Robo.plot([th1_s(i), th2_s(i), th3_s(i), th4_s(i)])
end


for i=1:100:size(out.posicaoReal.Time,1)
    T1 = Robo.fkine([out.posicaoReal.Data(i,1) out.posicaoReal.Data(i,2) out.posicaoReal.Data(i,3) out.posicaoReal.Data(i,4)]);
    x = T1.t(1);
    y = T1.t(2);
    z = T1.t(3);
    plot3(x,y,z,'r.');
    drawnow;
    hold on;
    Robo.plot([out.posicaoReal.Data(i,1) out.posicaoReal.Data(i,2) out.posicaoReal.Data(i,3) out.posicaoReal.Data(i,4)])
end
hold off


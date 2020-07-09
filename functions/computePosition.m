function [x_3, y_3] = computePosition(y_1, dt)
   dt = 4;
   %x_1 and y_1 contain only waypoints.
   x_1 = [0*dt 3*dt 4*dt 5*dt 8*dt];
   f0 = fit(x_1', y_1', 'poly4');
   
   %x_2 and y_2 are a continuous signal
   x_2 = 0*dt:0.5:8*dt;
   y_2 = f0(x_2)';
   
   %x_3 and y_3 will receive leading and ending zeros to make sure velocity
   %at the start and end are zero.
   x_3 = 0*dt:0.5:8*dt+2*dt;
   y_3 =[zeros(1,size(0:0.5:dt,2)-1) y_2 zeros(1,size(0:0.5:dt,2)-1)];
end
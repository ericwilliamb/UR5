function [vel_theta0, acel_theta0] = calcVelocityAcceleration(x_s, y_s)
for i = 1:size(x_s,2)-1
    vel_theta0(i) = (y_s(i+1) - y_s(i))/ (x_s(i+1) - x_s(i));
end

for i = 1:size(x_s,2)-2
    acel_theta0(i) = (vel_theta0(i+1) - vel_theta0(i))/ (x_s(i+1) - x_s(i));
end
end
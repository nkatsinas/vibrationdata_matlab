load('d2y.mat'); %d2y is [Time Accelration] vector
m = 1.5; %mass of brain in kg; Skull= 3.5 kg see Analytical modelling of soccer heading
k = 156e3; %stiffness of the brain
c = 340; %damping coefficien of the brain

p = 300; %peak accel m/s2
f = 100; %frequency Hz
tend = 1/f; %full period
t=0:0.0001:tend;
d2y = @(t) p*(sin(pi*f*t).^2); %haversine formula

%solve d2z + (c/m)*dz + (k/m)*z = -d2y from: http://www.vibrationdata.com/tutorials_alt/base_sine.pdf

%introduce two new variables x = [ x1 x2] = [z dz]
%differentiate: dx = [dx1 dx2] = [dz d2z]
%dx = [x2 -d2y-(c/m)dz -(k/m)z] = [x2 -d2y-(c/m)x2 -(k/m)x1]

dx = @(t,x) [x(2); -d2y-(c/m)*x(2)-(k/m)*x(1)];      

[tout,xout] = ode45(dx,t,[0 0]);

z = xout(:,1);         % Parse position
dz = xout(:,2);         % Parse velocity

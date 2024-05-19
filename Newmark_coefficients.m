
% Newmark_coefficients.m  ver 1.1  by Tom Irvine

function[a0,a1,a2,a3,a4,a5,a6,a7]=Newmark_coefficients(dt)

alpha=0.25;
beta=0.5;

a0=1/(alpha*dt^2);
a1=beta/(alpha*dt);
a2=1/(alpha*dt); 
a3=(1/(2*alpha))-1;
a4=(beta/alpha)-1;
a5=(dt/2)*((beta/alpha)-2);
a6=dt*(1-beta);
a7=beta*dt;
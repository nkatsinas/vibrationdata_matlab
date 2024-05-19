
% line_joint_plates.m  ver 1.0 by Tom Irvine

function[clf12,clf21,cg1,cg2]=line_joint_plates(E,rho,mu,h1,h2,A1,A2,omega,Lc)

sigma=h2/h1;

tau=2/(  sigma^(-1.25)  +   sigma^(1.25)   );

[cb1]=plate_bending_phase_speed(E,rho,mu,h1,omega);
[cb2]=plate_bending_phase_speed(E,rho,mu,h2,omega);

cg1=2*cb1;
cg2=2*cb2;

%%%

clf12=cg1*Lc*tau/(omega*pi*A1);
clf21=cg2*Lc*tau/(omega*pi*A2);
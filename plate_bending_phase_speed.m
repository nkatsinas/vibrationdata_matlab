%
%   plate_bending_phase_speed.m  ver 1.0  by Tom Irvine 
%
function[cb]=plate_bending_phase_speed(em,md,mu,h,omega)

B=em*h^3/(12*(1-mu^2));
mp=md*h; 
cb=( (B/mp)^(1/4))*sqrt(omega);   
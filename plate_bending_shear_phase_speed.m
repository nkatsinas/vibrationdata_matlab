%
%   plate_bending_shear_phase_speed.m  ver 1.0  by Tom Irvine 
%
function[cb,cs,fshift]=plate_bending_shear_phase_speed(em,md,mu,h,omega)

B=em*h^3/(12*(1-mu^2));
mp=md*h; 
cb=( (B/mp)^(1/4))*sqrt(omega);

G=em/(2*(1+mu));

cs=sqrt(G*h/mp);

fshift=(cs^2/(2*pi))*sqrt(mp/B);
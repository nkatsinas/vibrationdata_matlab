%
%  shear_frequencies.m  ver 1.1  by Tom Irvine
%
%  Reference: pending  
%
function [f1,f2]=shear_frequencies(E,G,mp,tf,hc,v)

tpi=2*pi;

D1=E*tf*(tf+hc)^2/(2*(1-v^2));
D3=E*tf^3/(6*(1-v^2));

omega1=G*hc/sqrt(mp*D1);
omega2=G*hc/sqrt(mp*D3);

f1=omega1/tpi;
f2=omega2/tpi;
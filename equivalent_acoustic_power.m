%
%  equivalent_acoustic_power.m  ver 1.0  by Tom Irvine
%
function[P]=equivalent_acoustic_power(mph,c,rad_eff,pressure,md,thick,freq)
%

fsep=1/mph;

num=c^2*rad_eff*pressure^2;
den=4*pi*freq^2*fsep*md*thick;

P=num/den;


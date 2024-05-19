%
%   critical_frequency_cylinder.m  ver 1.0  Tom Irvine
%
function[fcr]=critical_frequency_cylinder(c,thick,mu,rho,em)
%
tpi=2*pi;
%
fcr=(c^2/(tpi*thick))*sqrt(12*(1-mu^2)*rho/em);
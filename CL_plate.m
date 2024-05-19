%
%   CL_plate.m  ver 1.0  by Tom Irvine
%
function[CL]=CL_plate(E,rho,mu)
%
den=rho*(1-mu^2);
%
CL=sqrt(E/den);
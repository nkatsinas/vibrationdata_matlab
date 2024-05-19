%
%    velocity_from_power_one.m  ver 1.0  by Tom Irvine
%
function[v,E]=velocity_from_power_one(lf,omega,m,power)
%
A=lf;
B=power/omega;
E=B/A;
v=sqrt(E/m);
 

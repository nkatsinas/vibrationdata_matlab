%
%  homogeneous_totals_mass.m  ver 1.0  by Tom Irvine
%

function[volume,total_mass,rho]=homogeneous_totals_mass(area,T,rho,NSM)

volume=area*T;
total_mass=rho*volume + NSM;
rho=total_mass/volume;

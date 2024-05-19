
%
%   panel_stress_strain_from_velox.m  ver 1.0  by Tom Irvine
%

function[stress,strain]=panel_stress_strain_from_velox(CL,v,em,scf,K)

strain=(K/CL)*v;
stress=em*strain*scf;
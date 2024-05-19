%
%   cylinder_properties_wave.m  ver 1.0  by Tom Irvine
%
%   Facesheets:
%
%       em=elastic modulus
%       mu=Poisson ratio
%        h=thickness
%      rho=mass density (mass/volume)
%
%   Output:
%
%        D=bending stiffness parameter
%      mpa=total mass per area
%    fring=ring frequency
%
function[D,K,mpa,fcr,fring,CL]=cylinder_properties_wave(em,mu,h,diam,rho,air_c)
%
D=em*h^3/(12*(1-mu^2));

K=em*h/(1-mu^2);

mpa=rho*h;

[fring,CL]=ring_frequency_I(em,rho,diam);

[fcr]=critical_frequency_cylinder(air_c,h,mu,rho,em);

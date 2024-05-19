%
%   velocity_from_diffuse_pressure.m  ver 1.0  by Tom Irvine
%
function[v]=velocity_from_diffuse_pressure(pressure,rho_s,rho_c,CL,c,thick,lf,rad_eff,freq)

omega=2*pi*freq;

anum=sqrt(12)*pi*c^2;
aden=2*rho_c*thick*CL*rho_s*omega^2;
 
bden= 1 + (rho_s*omega*lf)/(2*rho_c*rad_eff);
  
v2=(pressure^2)*(anum/aden)*(1 / bden);
 
v=sqrt(v2);

%
%   honeycomb_sandwich_properties.m  ver 1.0  by Tom Irvine
%
%   Facesheets:
%
%        E=elastic modulus
%       mu=Poisson ratio
%       tf=individual facesheet thickness
%     rhof=face sheet mass density (mass/volume)
%
%   Core:
%
%       G=shear modulus
%      hc=core thickness
%    rhoc=core mass density (mass/volume)
%
%   Output:
%
%       D=bending stiffness parameter
%       G=shear stiffness parameter
%     mpa=total mass per area
%     fcr=critical frequency 
%
function[D,S,S2,mpa]=honeycomb_sandwich_properties(E,G,mu,tf,hc,rhof,rhoc)
%
D=E*tf*(hc+tf)^2/( 2*(1-mu^2));
S=G*hc*(1+(tf/hc))^2;
S2=S^2;


mpa=(2*tf*rhof + hc*rhoc);











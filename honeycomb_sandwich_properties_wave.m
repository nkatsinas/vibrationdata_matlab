%
%   honeycomb_sandwich_properties_wave.m  ver 1.1  by Tom Irvine
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
%        D=bending stiffness parameter
%        S=shear stiffness parameter
%      mpa=total mass per area
%    fring=ring frequency
%
function[D,K,S,mpa,fring]=honeycomb_sandwich_properties_wave(E,G,mu,tf,hc,diam,rhof,rhoc)
%

%% D=E*tf*(hc+tf)^2/( 2*(1-mu^2));

%%  https://femci.gsfc.nasa.gov/hcplate/    Better formula

Ip=(2/3)*( (hc/2) + tf )^3 - (hc^3/12); 

D=E*Ip/(1-mu^2);

S=G*hc*(1+(tf/hc))^2;

K=2*E*tf/(1-mu^2);
mpa=(2*tf*rhof + hc*rhoc);

fprintf(' E=%8.4g tf=%8.4g  mu=%8.4g  \n',E,tf,mu);
fprintf(' rhof=%8.4g rhoc=%8.4g  \n',rhof,rhoc);
fprintf(' diam=%8.4g  mpa=%8.4g  \n',diam,mpa);

fring=(1/(pi*diam))*sqrt(K/mpa);
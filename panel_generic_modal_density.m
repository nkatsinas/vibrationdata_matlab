%
%  panel_generic_modal_density.m  ver 1.0 by Tom Irvine
%
function[modal_density_Hz,modal_density_rad,D,m_hat]=...
                         panel_generic_modal_density(em,mu,rho,thick,area)
%
tpi=2*pi;
m_hat=rho*thick;
D=em*thick^3/(12*(1-mu^2));
modal_density_rad=(area/(4*pi))*sqrt(m_hat/D);  
modal_density_Hz=modal_density_rad*tpi;
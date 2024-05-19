%
%  flow_pressure_psd.m  ver 1.0  by Tom Irvine
%
function[pressure_psd]=flow_pressure_psd(fc,deltastar,Uinf,Uc,F,prms,q,comp)

poq=prms/q;

constant = 4*(poq^2)*(F^1.433)*comp;
constant = constant*(q^2)*(deltastar/Uinf);

omega= 2*pi*fc*deltastar/Uc;

pressure_psd= constant/(1 + comp^2*(F^2.867)*(omega^2));
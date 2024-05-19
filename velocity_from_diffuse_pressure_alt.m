%
%   velocity_from_diffuse_pressure_alt.m  ver 1.0 by Tom Irvine
%
%   velocity & pressure both functions of freq (Hz);
%
function[v,total_lf]=...
             velocity_from_diffuse_pressure_alt(pressure,c,gas_md,M,...
                                                      lf,rad_eff,freq,mph,Ap)

%
tpi=2*pi;

modes_per_Hz=mph;

omega=tpi*freq;

Rrad=gas_md*c*Ap*rad_eff;
Rint=M*omega*lf;

[modes_per_radps]=modal_density_convert(modes_per_Hz);

A=2*pi^2*c*(modes_per_radps);
B=gas_md*M*omega^2;
RR=Rrad/(Rint+Rrad);

term=(A/B)*RR*pressure^2;

v=sqrt(term);

out1=sprintf(' %8.4g  %8.4g %8.4g  %8.4g  %8.4g  %8.4g ',freq,v,pressure,modes_per_radps,lf,RR);
disp(out1);

total_lf=lf+(Rrad/(M*omega));
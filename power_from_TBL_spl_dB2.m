
% power_from_TBL_spl_dB2.m  ver 1.1  by Tom Irvine

function[power,power_dB,power_psd_scale]=power_from_TBL_spl_dB2(freq,dB,mpa,Ap,L,diam,Uc,ax,az,D)

pressure_ref=20e-06;
power_ref=1.0e-12;

pressure=pressure_ref*10^(dB/20);

a=L;
b=pi*diam;


M=mpa;
A=Ap;

[power_psd_scale]=Corcos_FAIP(freq,Uc,ax,az,M,D,A,a,b);

power=(power_psd_scale*pressure^2);

if(power>power_ref)
    power_dB=10*log10(power/power_ref);
else
    power=power_ref;  
    power_dB=0;
end



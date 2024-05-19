
% power_from_TBL_spl_dB.m  ver 1.2  by Tom Irvine

%  Uc=convection velocity
%  ax=Corcos coefficient longitudinal
%  az=Corcos coefficent transverse
%  M =mass per area
%  D =bending stiffness
%  A =surface area
%  a =length
%  b =width
%
%  mpa  = mass per area
%  freq = input SPL frequency vector
%  dB   = input SPL vector
%  L    = cylindrical shell length
%  diam = cylindrical shell diameter

function[power,power_dB]=power_from_TBL_spl_dB(freq,dB,mpa,Ap,L,diam,Uc,ax,az,D)

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



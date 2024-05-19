%
%  convert_pressure_dB.m  ver 1.0  by Tom Irvine
%

function[pressure_dB]=convert_pressure_dB(pressure,iu)
%
ref=20e-06;
Pa_per_psi = 6894.;

if(iu==1) % convert psi to Pa
   pressure=pressure*Pa_per_psi;
end

pressure_dB=20*log10(pressure/ref);

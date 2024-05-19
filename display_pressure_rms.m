%
%   display_pressure_rms.m  ver 1.0  by Tom Irvine
%

function[]=display_pressure_rms(iu,prms)

Pa_per_psi=6894.;
ref=20e-06;

if(iu==1)
   out1=sprintf('  Pressure = %8.4g psi ',prms);
   prms=prms*Pa_per_psi;
else
   out1=sprintf('  Pressure = %8.4g Pa ',prms);

end
disp(out1);
 
dB=20*log10(prms/ref);

out2=sprintf('           = %8.4g dB ref 20 micro Pa ',dB);
disp(out2);


%
%   display_power.m  ver 1.0  by Tom Irvine
%

function[]=display_power(iu,P)

ref=1.0e-12;

if(iu==1)
   out1=sprintf('  Power = %8.4g in-lbf/sec ',P);
   out2=sprintf('        = %8.4g ft-lbf/sec ',P/12);
   
   P=(P/12)*1.3557;
   
else
   out1=sprintf('  Power = %8.4g W ',P);
end
disp(out1);
 
if(iu==1)
   disp(out2); 
end

dB=10*log10(P/ref);

out2=sprintf('        = %8.4g dB ref 1.0e-12 W ',dB);   
disp(out2);
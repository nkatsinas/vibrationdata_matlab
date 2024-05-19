%
%  convert_dB_pressure_alt.m  ver 1.0  by Tom Irvine
%

function[pressure]=convert_dB_pressure_alt(dB,iu)
%
ref=20e-06;
%

N=length(dB);


Pa_rms=zeros(N,1);

for i=1:N
    Pa_rms(i)=ref*10^(dB(i)/20);
end


psi_rms=Pa_rms*0.00014511;
    
       
if(iu==1)
    pressure=psi_rms; 
else
    pressure=Pa_rms; 
end

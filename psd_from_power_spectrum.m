%
%  psd_from_power_spectrum.m  ver 1.0  by Tom Irvine
%   
function[psd,rms]=psd_from_spectrum(nb,fc,a_power)

if(nb==1)
    bw=(2^(1/6)-2^(-1/6));
else
    bw=(2^(1/2)-2^(-1/2));        
end 

NL=length(fc);
psd=zeros(NL,1);

for i=1:NL
        
    fb=fc(i)*bw;
        
    psd(i)=(a_power(i))/fb;
    
end

ms=sum(a.^2);    
rms=sqrt(ms);

%   psd_spl_function_dB_ref.m  ver 1.1  by Tom Irvine
%
%   This script converts a pressue power spectral density (PSD) into a 
%   Sound Pressure Level (SPL)
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%   Input variables
%
%   ref is the zero dB reference.
%
%   ref = 20e-09  for Pa  
%       = 2.9e-09 for psi
%
%   fi is the frequency coordinate for the input PSD
%   ai is the corresponding PSD amplitude in Pa^2/Hz or psi^2/Hz
%
%   The output SPL would typically be in one-third octave band format
%
%   fl is the band lower frequency
%   fc is the band center frequency
%   fu is the band upper frequency
%
%   df is the input PSD frequency spacing which should be a constant
%
%   dB_ref is the expected overall SPL in dB based on the pressure PSD
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%   Output variables
%
%   SPL is the sound pressure level with two columns:
%       band center frequency (Hz) & sound pressure level (dB)
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function[SPL]=psd_spl_function_dB_ref(ref,fi,ai,fl,fc,fu,df,dB_ref)

% Find the overall pressure in each band

NL=length(fi);
imax=length(fl);

js=1;

asum=zeros(imax,1);
counts=zeros(imax,1);

for i=1:NL
    
   for j=js:imax
      
       if(fi(i)>=fl(j) && fi(i) <fu(j))
           
            asum(j)=asum(j)+ai(i)*df; 
          counts(j)=counts(j)+1;
           
          js=j; 
          break; 
       end 
   end
end   

k=1;

asum=sqrt(asum);

% convert the overall pressure in each band to dB format

for i=1:imax
   
    if(counts(i)>=1)        
        SPL(k,1)= fc(i);
        SPL(k,2)= 20*log10(asum(i)/ref);
        k=k+1;
    end
    
end


[oadB]=oaspl_function(SPL(:,2));

SPL(:,2)=SPL(:,2)+(dB_ref-oadB);

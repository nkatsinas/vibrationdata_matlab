%
%   gust_interpolate_PSD_spec.m  ver 1.1  August 13, 2013
%
function[fft_freq,spec]=...
                   gust_interpolate_PSD_spec(mmm,freq,amp,slope,df,grms)
%
out5 = sprintf('\n Interpolating specification ');
disp(out5);
m2=fix(mmm/2);
%
fft_freq = linspace(0,(m2-1)*df,m2);
fft_freq = fft_freq';
%
spec=zeros(mmm,1);
%
js=1;
LS=length(freq);
%
for i=1:m2
%       
      for j=js:(LS-1)
%            
         if( fft_freq(i) >= freq(j) && fft_freq(i) <= freq(j+1) )
%               
              fr = (fft_freq(i)/freq(j) );
              spec(i)=amp(j)*( fr^slope(j) );  
%
              js=j;
              break;
         end
%
      end
%            
end
%
%   gust_PSD_final_correction.m  ver 1.0  November 16, 2012
%
function[amp,freq,full]=...
     gust_PSD_final_correction(amp,freq,full,freq_spec,amp_spec,den,...
                                                  NW,mH,mr_choice,h_choice)
%
mmm = 2^fix(log(length(amp)/NW)/log(2));
%
n=length(freq);
m=length(freq_spec);
%
dB_error=0;
p=0;
jstart=1;
%
for i=1:n
%
    for j=jstart:m-1
%
      if(freq(i)>=freq_spec(j) && freq(i)<=freq_spec(j+1)) 
%
        slope=log(amp_spec(j+1)/amp_spec(j))/log(freq_spec(j+1)/freq_spec(j));
%
        level= amp_spec(j)*(freq(i)/freq_spec(j))^slope;
%
        dB_error=dB_error+10*log10(level/full(i));
        p=p+1;
        jstart=j;
        break;
%      
      end
%    
    end
%
end
%
dB_error=dB_error/p;
%
scale=10^(dB_error/20);
%
amp=amp*scale;
%
%
full=zeros(mH,1);
%
nov=0;
%
for ijk=1:(2*NW-1)
%
        amp_seg=zeros(mmm,1);
        amp_seg(1:mmm)=amp((1+ nov):(mmm+ nov));  
        nov=nov+fix(mmm/2);
%
        [mag_seg]=FFT_core(amp_seg,mmm,mH,mr_choice,h_choice);
%
        mag_seg=fix_size(mag_seg);
%
        full=full+mag_seg(1:mH);
end
%
full=full/den;
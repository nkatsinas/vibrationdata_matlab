%
%  convert_FFT_to_one_third_rms.m  ver 1.1  by Tom Irvine
%
function[band_rms,band_dB]=convert_FFT_to_one_third_rms(freq,fl,fu,full_rms,ref)
%
imax=length(freq);
%
jmax=length(fu);
%
band_rms=zeros(jmax,1);
band_dB=zeros(jmax,1);
%
%
istart=1;
%
for j=1:jmax
    for i=istart:imax
        if( freq(i)>= fl(j) && freq(i) <= fu(j))
            band_rms(j)=band_rms(j)+ (full_rms(i))^2;
        end
        if(freq(i)>fu(j))
            istart=i;
            break;
        end
    end
    band_rms(j)=sqrt(band_rms(j));
    
    if(band_rms(j)>ref)
        band_dB(j)=20*log10(band_rms(j)/ref);
    end
    
end




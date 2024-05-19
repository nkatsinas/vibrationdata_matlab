%
%  convert_FFT_to_one_third.m  ver 1.1  October 18, 2012
%
function[band_rms]=convert_FFT_to_one_third(freq,fl,fu,full)
%
imax=length(freq);
%
jmax=length(fu);
%
band_rms=zeros(jmax,1);
%
rms=full/sqrt(2);
%
istart=1;
%
for j=1:jmax
    for i=istart:imax
        if( freq(i)>= fl(j) && freq(i) <= fu(j))
            band_rms(j)=band_rms(j)+ (rms(i))^2;
        end
        if(freq(i)>fu(j))
            istart=i;
            break;
        end
    end
    band_rms(j)=sqrt(band_rms(j));
end
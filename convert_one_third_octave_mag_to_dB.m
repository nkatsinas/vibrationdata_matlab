%
%  convert_one_third_octave_mag_to_dB.m  ver 1.1  by Tom Irvine
%
function[splevel,oaspl]=convert_one_third_octave_mag_to_dB(band_rms,ref)
%
imax=length(band_rms);
%
splevel=zeros(imax,1);

%
for j=1:imax
        if(band_rms(j)>1.0e-20)
            splevel(j)=20*log10(band_rms(j)/ref);
        end
end 
%
[oaspl]=oaspl_function(splevel);
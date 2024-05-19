
%
%   one_third_octave_spl_to_pressure_psd.m  ver 1.0  by Tom Irvine
%

function[apsd_sam]=one_third_octave_spl_to_pressure_psd(fc,spla,reference)

num=length(fc);
apsd_sam=zeros(num,1);



%
%
delta=(2^(1/6)) - 1/(2^(1/6));
%
for i=1:num    
%	
    if( spla(i) >= 1.0e-50)
%		
        pressure_rms=reference*(10.^(spla(i)/20.) );
%
		df=fc(i)*delta;
%
        if( df > 0. )	
            apsd_sam(i)=(pressure_rms^2.)/df;
        end
    end
end
%
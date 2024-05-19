
% one_octave_spl_to_psd_function.m  ver 1.1  by Tom Irvine

function[power_spectral_density,rms]=one_octave_spl_to_psd_function(fc,spl,ref)

fc=fix_size(fc);

%   
num=length(fc);
psd=zeros(num,1);

[oadB]=oaspl_function(spl);

ref_rms=ref*10^(oadB/20);

%
%
delta=(2^(1/6)) - 1/(2^(1/6));
%
for i=1:num    
%	
    if( spl(i) >= 1.0e-50)
%		
        pressure_rms=ref*(10^(spl(i)/20) );
%
		df=fc(i)*delta;
%
        if( df > 0 )	
            psd(i)=(pressure_rms^2)/df;
        end
        
    end
end
%

[~,iter_rms] = calculate_PSD_slopes_no(fc,psd);

ratio=(ref_rms/iter_rms)^2;

psd=psd*ratio;

[~,rms] = calculate_PSD_slopes_no(fc,psd);

power_spectral_density=[fc psd];

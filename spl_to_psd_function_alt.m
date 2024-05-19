
%  spl_to_psd_function_alt.m  ver 1.1  by Tom Irvine

function[power_spectral_density,rms]=spl_to_psd_function_alt(fc,spl,ref,n_type)

fc=fix_size(fc);

%   
num=length(fc);
psd=zeros(num,1);

[oadB]=oaspl_function(spl);

ref_rms=ref*10^(oadB/20);

%
if(n_type==1)
   delta=(sqrt(2) - 1/sqrt(2));
end    
if(n_type==3)
    delta=(2^(1/6)) - 1/(2^(1/6));
end    
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


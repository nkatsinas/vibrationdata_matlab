%
%   env_generate_sample_psd_spl_alt.m  ver 1.8   by Tom Irvine
%
%   used by:  vibrationdata_envelope_psd.m
%             vibrationdata_envelope_fds.m
%             vibrationdata_envelope_fds_batch.m 
%
%
function[f_sam,apsd_sam,spla]=...
    env_generate_sample_psd_spl_alt(n_ref,nbreak,npb,f_ref,ik,slopec,initial,final,f1,f2,fc,reference)
%


f_sam=fc;     
[spla]=generate_amplitude(nbreak,initial,final);
        
        
num=length(fc);
apsd_sam=zeros(num,1);
%
%
delta=(2.^(1./6.)) - 1./(2.^(1./6.));
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





function[f_sam]=generate_frequency(nbreak,npb,n_ref,f_ref,f1,f2)

f_sam=zeros(nbreak,1);

noct=log(f2/f1)/log(2);
    
while(1)

    for i=1:nbreak
        while(1)
            f_sam(i)=f1*2^(noct*rand());
            if(f_sam(i)>f1 && f_sam(i)<f2)
                break;
            end
        end
    end    

    f_sam=sort(f_sam);
    f_sam(1)=f1;
    f_sam(nbreak)=f2;
    
    
    if(length(unique(f_sam))==nbreak)
        break;
    end

end


function[spla]=generate_amplitude(nbreak,initial,final)
%
    spla=zeros(nbreak,1);

    for i=1:nbreak
        spla(i)=80+80*rand();
    end
%	   
%%
    

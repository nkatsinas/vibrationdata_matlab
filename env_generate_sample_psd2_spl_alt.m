%
%   env_generate_sample_psd2_spl_alt.m  ver 1.7   by Tom Irvine
%
%   used by:  vibrationdata_envelope_psd.m
%             vibrationdata_envelope_fds.m
%             vibrationdata_envelope_fds_batch.m
%
function[f_sam,apsd_sam]=...
    env_generate_sample_psd2_spl_alt(n_ref,nbreak,npb,f_ref,xf,xapsd,slopec,initial,final,ik,f1,f2,fc,reference,xspla)
%

f_sam=fc;
       

%
    spla=xspla;

    if(rand()<0.5)

        for i=1:nbreak
           
            spla(i)=xspla(i)+(-0.001+0.002*rand());

        end

    else

        ijk=round(rand()*nbreak);

        if(ijk<1)
            ijk=1;
        end
        if(ijk>nbreak)
            ijk=nbreak;
        end

        spla(ijk)=xspla(ijk)+(-0.01+0.02*rand());
    end
    
    
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
    
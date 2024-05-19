%
%   env_generate_sample_psd_spl.m  ver 1.8   by Tom Irvine
%
%   used by:  vibrationdata_envelope_psd.m
%             vibrationdata_envelope_fds.m
%             vibrationdata_envelope_fds_batch.m 
%
%
function[f_sam,apsd_sam]=...
    env_generate_sample_psd_spl(n_ref,nbreak,npb,f_ref,ik,slopec,initial,final,f1,f2,fc)
%

one_half=1/2;

while(1)
%
    if(npb==14)
        f_sam=fc; 
    else
        [f_sam]=generate_frequency(nbreak,npb,n_ref,f_ref,f1,f2);       
    end
        
    [apsd_sam]=generate_amplitude(nbreak,initial,final);
    
    [apsd_sam]=opt_psd_amplitude_adjust(nbreak,npb,apsd_sam);
        

    
    [max_sss,min_fff]=freq_slope_check(f_sam,apsd_sam);
           
    if(f_sam(end)==f2 && max_sss<slopec)
        break;
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


function[apsd_sam]=generate_amplitude(nbreak,initial,final)
%
    apsd_sam=zeros(nbreak,1);

    for i=1:nbreak
        apsd_sam(i)=(0.01+1.99*rand());
    end
%	   
    amin=1.0e-12;
%
    for i=1:nbreak
%	 
        if(apsd_sam(i) < amin)
            apsd_sam(i)=amin;
        end  
	    if(apsd_sam(i) > (1/amin))
            apsd_sam(i)=(1/amin);
        end    
    end
%%
    if(initial==1 && apsd_sam(1) > apsd_sam(1))
        apsd_sam(1)=apsd_sam(1);
    end
    if(final==1 && apsd_sam(nbreak) > apsd_sam(nbreak-1))
        apsd_sam(nbreak)=apsd_sam(nbreak-1);
    end
    
    apsd_sam(1)=apsd_sam(2)*rand();
    

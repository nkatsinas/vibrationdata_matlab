%
%   env_generate_sample_psd_freq.m  ver 1.9   by Tom Irvine
%
%   used by:  vibrationdata_envelope_psd.m
%
%
function[f_sam,apsd_sam,max_sss,slopec]=...
    env_generate_sample_psd(n_ref,nbreak,npb,f_ref,ik,slopec,initial,final,f1,f2,FL,FU,nfc)
%

% slopec

while(1)
%
    f_sam(1)=f1;
    f_sam(nbreak)=f2;

    if(nfc==1 && nbreak>=3)
        for i=2:nbreak-1
            df=FU(i)-FL(i);
            f_sam(i)=df*rand()+FL(i);
        end
        f_sam=sort(f_sam);
    else    
        [f_sam]=generate_frequency(nbreak,n_ref,f_ref,f1,f2);
    end
    
    [apsd_sam]=generate_amplitude(nbreak,initial,final);
    
    [apsd_sam]=opt_psd_amplitude_adjust_freq(nbreak,npb,apsd_sam);
    
    [max_sss,min_fff]=freq_slope_check(f_sam,apsd_sam);
           
    one_half=1/2;
    two_thirds=2/3;
    one=1;
    
    if(f_sam(end)==f2 && max_sss<slopec && min_fff>two_thirds && nfc==2)    
        break;
    end
    if(f_sam(end)==f2 && min_fff>0.1 && nfc==1)   
        break;
    end    
    
end

%


function[f_sam]=generate_frequency(nbreak,n_ref,f_ref,f1,f2)



f_sam=zeros(nbreak,1);

while(1)    
        g=zeros(nbreak,1);
    
        for i=1:nbreak
%		  
            index = round( n_ref*rand());
            if(index >= n_ref)
                index=n_ref-1;
            end    
            if(index <= 1)
                index=2;
            end
        
            g(i)=index;
            f_sam(i)=f_ref(index);
            
        end    
%    
%
        f_sam(1)=f1;
        f_sam(nbreak)=f2;
        f_sam=sort(f_sam);
        
        if(length(g)==length(unique(g)))
            break;
        end  

end




function[apsd_sam]=generate_amplitude(nbreak,initial,final)
%
    apsd_sam=zeros(nbreak,1);

    for i=1:nbreak
        apsd_sam(i)=rand();
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
    
    
    

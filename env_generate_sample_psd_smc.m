%
%   env_generate_sample_psd_smc.m  ver 2.1   by Tom Irvine
%
%
function[f_sam,apsd_sam]=...
    env_generate_sample_psd_smc(n_ref,nbreak,f_ref,initial,final,f1,f2,FL,FU,nfc)

    while(1)

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

        f_sam=unique(f_sam);
        nbreak=length(f_sam);
    
        [apsd_sam]=generate_amplitude(nbreak,initial,final);
    
        L1=length(f_sam);
        L2=length(apsd_sam);      
        
        if(L1~=L2)
            L1
            L2
            warndlg('ref 0')
            return;
        end


        if(f_sam(end)==f2 && nfc==2)   
            break;
        else
            fprintf('  nfc=%d \n',min_fff);
        end    
    
    end

end
    
function[f_sam,nbreak]=generate_frequency(nbreak,n_ref,f_ref,f1,f2)

    f_sam=zeros(nbreak,1);
    
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
        
        g=unique(g);

        nbreak=length(g);

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

end    
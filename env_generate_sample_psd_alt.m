%
%   env_generate_sample_psd_alt.m  ver 2.0   by Tom Irvine
%
%   used by:  vibrationdata_envelope_psd.m
%             vibrationdata_envelope_fds.m
%             vibrationdata_envelope_fds_batch.m 
%
%
function[f_sam,apsd_sam,max_sss,slopec]=...
    env_generate_sample_psd_alt(n_ref,nbreak,npb,f_ref,~,slopec,initial,final,f1,f2,plateau)
%

% slopec

max_sss=0;

while(1)
%

   if(npb<=13)
        [f_sam]=generate_frequency(nbreak,npb,n_ref,f_ref,f1,f2);
        [apsd_sam]=generate_amplitude(nbreak,initial,final);
        [apsd_sam]=opt_psd_amplitude_adjust(nbreak,npb,apsd_sam);   
        [max_sss,min_fff]=freq_slope_check(f_sam,apsd_sam);
  
        if(f_sam(end)==f2 && max_sss<slopec && min_fff>plateau)
            break;
        end        
   else

        f_sam=f_ref;
        apsd_sam=zeros(nbreak,1);

        a=rand();

        if(a<=0.1)
            apsd_sam=ones(nbreak,1);
        end
        if(a>0.1 && a<=0.3)
            n=1*rand();
            apsd_sam(1)=1;
            for i=2:nbreak
                ratio=f_sam(i)/f_sam(i-1);
                apsd_sam(i)=apsd_sam(i-1)*ratio^n;
            end
        end
        if(a>0.3 && a<=0.5)
            n=1*rand();
            m=round(nbreak*rand());
            if(m<=1)
                m=2;
            end    
            apsd_sam(1)=1;
            for i=2:nbreak
                if(i<m)
                    ratio=f_sam(i)/f_sam(i-1);
                    apsd_sam(i)=apsd_sam(i-1)*ratio^n;
                else
                    apsd_sam(i)=apsd_sam(i-1); 
                end
            end
        end        
        if(a>0.5 && a<=0.99)
            n=1*rand();
            nn=-1*rand();
            mm(1)=round(nbreak*rand());
            if(mm(1)<=1)
                mm(1)=2;
            end   
            mm(2)=round(nbreak*rand());
            if(mm(2)<=1)
                mm(2)=2;
            end     
            mm=sort(mm);
            apsd_sam(1)=1;
            for i=2:mm(1)
                ratio=f_sam(i)/f_sam(i-1);
                apsd_sam(i)=apsd_sam(i-1)*ratio^n;
            end
            for i=(mm(1)+1):mm(2)
                apsd_sam(i)=apsd_sam(i-1); 
            end
            for i=(mm(2)+1):nbreak
                ratio=f_sam(i)/f_sam(i-1);
                apsd_sam(i)=apsd_sam(i-1)*ratio^nn;
            end           
        end          
        if(a>0.99)
            for i=1:nbreak
                apsd_sam(i)=1+3*rand();
            end
        end
        break;
   end    
 
end

%


function[f_sam]=generate_frequency(nbreak,~,n_ref,f_ref,f1,f2)


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
    
    
%
%   env_generate_sample_psd_sine.m  ver 1.9   by Tom Irvine
%
%
%
function[f_sam,apsd_sam,max_sss,slopec,sine_samp]=...
    env_generate_sample_psd_sine(n_ref,nbreak,npb,f_ref,slopec,initial,final,f1,f2,plateau,smax)
%

% slopec

nsine=length(smax);

sine_samp=zeros(nsine,1);

for i=1:nsine
   sine_samp(i)=smax(i)*(0.9+0.2*rand()); 
end

while(1)
%
    [f_sam]=generate_frequency(nbreak,npb,n_ref,f_ref,f1,f2);
    
    [apsd_sam]=generate_amplitude(nbreak,initial,final);
    
    [apsd_sam]=opt_psd_amplitude_adjust(nbreak,npb,apsd_sam);
    
    [max_sss,min_fff]=freq_slope_check(f_sam,apsd_sam);
    
    
    if(npb==5)
        
        slope1=log(apsd_sam(2)/apsd_sam(1))/log(f_sam(2)/f_sam(1));
        slope2=log(apsd_sam(4)/apsd_sam(3))/log(f_sam(4)/f_sam(3));
        
        if(slope1<1)
            apsd_sam(1)=apsd_sam(2)*f_sam(1)/f_sam(2);
        end
        if(slope2>-1)
            apsd_sam(4)=apsd_sam(3)*f_sam(3)/f_sam(4);            
        end

    end
           
    
    min_fff=1.0e+90;
    
    nq=length(f_sam);
    for i=1:nq-1
        if(apsd_sam(i+1)==apsd_sam(i))
             fq=log(f_sam(i+1)/f_sam(i))/log(2);
             if(fq<min_fff)
                 min_fff=fq;
             end
        end    
    end
    
    
    if(f_sam(end)==f2 && max_sss<slopec && min_fff>plateau)
        
        if(npb==5)
            if(f_sam(2)>=4*f_sam(1))
                break;
            end
        else
            break;
        end    
    end
    
end

%


function[f_sam]=generate_frequency(nbreak,nbp,n_ref,f_ref,f1,f2)



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
    
    
    

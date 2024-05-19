%
%   env_generate_sample_psd2_freq.m  ver 1.7   by Tom Irvine
%
%   used by:  vibrationdata_envelope_psd.m
%
function[f_sam,apsd_sam,max_sss,slopec]=...
    env_generate_sample_psd2(n_ref,nbreak,npb,f_ref,xf,xapsd,slopec,initial,final,ik,f1,f2,FL,FU,nfc)
%

one_half=1/2;
two_thirds=2/3;
one=1;

ijk=0;

while(1)
 
    [f_sam]=frequency2(xf,f1,f2);

    f_sam(1)=f1;
    f_sam(end)=f2;

    if(nfc==1 && nbreak>=3)
        for i=2:nbreak-1
            if(f_sam(i)<FL(i))
                f_sam(i)=FL(i);
            end
            if(f_sam(i)>FU(i))
                f_sam(i)=FU(i);
            end            
        end
        f_sam=sort(f_sam);
    end
    
    
    [apsd_sam]=amplitude2(nbreak,xapsd);

    [apsd_sam]=opt_psd_amplitude_adjust_freq(nbreak,npb,apsd_sam);   

    [max_sss,min_fff]=freq_slope_check(f_sam,apsd_sam);
    
    if(f_sam(nbreak)==f2 && max_sss<slopec && min_fff>two_thirds && nfc==2)
        break;
    end
    if(min_fff>0.05 && nfc==1)
        break;
    end
    
    ijk=ijk+1;
    if(ijk==200)
        disp('*');
        out1=sprintf(' max_sss=%8.4g  min_fff=%8.4g  ',max_sss,min_fff);
        disp(out1);
        f_sam=xf;
        apsd_sam=xapsd;
        return;
    end

    
end


function[f_sam]=frequency2(xf,f1,f2)
 

    nbreak=length(xf);

    f_sam=zeros(nbreak,1);

    while(1)
%  
        for i=1:nbreak
            f_sam(i)=xf(i)*(0.95+0.1*rand());
        end
        
%        f_sam=round(f_sam);
        
        if(length(f_sam)==length(unique(f_sam)))
            break;
        end
        
    end
%   
% sort the frequencies
%
    f_sam=sort(f_sam);  
          
    f_sam(1)=f1;
    f_sam(nbreak)=f2; 
        
    if(  length(unique(f_sam))<nbreak)
       f_sam=xf; 
    end    
    
   


function[apsd_sam]=amplitude2(nbreak,xapsd)
%
    apsd_sam=zeros(nbreak,1);

    for i=1:nbreak
            
        aaa=0.5*rand();
%
        if(rand()>0.75)
            aaa=-aaa;
        end
        
        bbb=10^(aaa/10);
%       
        apsd_sam(i)=xapsd(i)*bbb;
%
        if(apsd_sam(i)>2000.)
%           
            out1=sprintf(' Error: %ld  %8.4g  %8.4g \n',i,apsd_sam(i),xapsd(i));
            disp(out1);
%               
            return;
%
        end
    end
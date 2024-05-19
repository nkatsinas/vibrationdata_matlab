%
%   env_generate_sample_psd2_altz.m  ver 1.7   by Tom Irvine
%
%   used by:  vibrationdata_envelope_psd.m
%             vibrationdata_envelope_fds.m
%             vibrationdata_envelope_fds_batch.m
%
function[f_sam,apsd_sam,max_sss,slopec]=...
    env_generate_sample_psd2_altz(n_ref,nbreak,npb,f_ref,xf,xapsd,slopec,initial,final,ik,f1,f2,plateau,foct)
%


ijk=0;

while(1)
 
    if(npb==11)
        f_sam=foct;
    else    
        [f_sam]=frequency2(xf,f1,f2);
    end
        
    [apsd_sam]=amplitude2(nbreak,xapsd);

    [apsd_sam]=opt_psd_amplitude_adjust(nbreak,npb,apsd_sam);   

    [max_sss,min_fff]=freq_slope_check(f_sam,apsd_sam);
    
    if(npb==11)
        break;
    else
        if(f_sam(end)==f2 && max_sss<slopec && min_fff>plateau)
            break;
        end
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
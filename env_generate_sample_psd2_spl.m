%
%   env_generate_sample_psd2_spl.m  ver 1.7   by Tom Irvine
%
%   used by:  vibrationdata_envelope_psd.m
%             vibrationdata_envelope_fds.m
%             vibrationdata_envelope_fds_batch.m
%
function[f_sam,apsd_sam]=...
    env_generate_sample_psd2_spl(n_ref,nbreak,npb,f_ref,xf,xapsd,slopec,initial,final,ik,f1,f2,fc)
%

one_half=1/2;

ijk=0;

N=1;

while(1)
 
    if(npb==14)
        [f_sam]=fc;
    else
        [f_sam]=frequency2(xf,f1,f2);        
    end
        
    [apsd_sam]=amplitude2(nbreak,xapsd,N);

    [apsd_sam]=opt_psd_amplitude_adjust(nbreak,npb,apsd_sam);   


    [max_sss,min_fff]=freq_slope_check(f_sam,apsd_sam);
        
     if(f_sam(end)==f2 && max_sss<slopec)
            break;
     else
         N=N*0.9;
     end

        
    ijk=ijk+1;
    if(ijk==1000)
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
            while(1)
                f_sam(i)=xf(i)*(0.95+0.1*rand());
                if(f_sam(i)>=f1 && f_sam(i)<=f2)
                    break;
                end
            end    
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
    
    


function[apsd_sam]=amplitude2(nbreak,xapsd,N)
%
    apsd_sam=zeros(nbreak,1);

    if(rand()<0.5)

        for i=1:nbreak
            
            aaa=0.1*rand()*N;
%
            if(rand()>0.5)
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

    else

        ijk=round(rand()*nbreak);

        if(ijk<1)
            ijk=1;
        end
        if(ijk>nbreak)
            ijk=nbreak;
        end

        aaa=0.1*rand()*N;
%
        if(rand()>0.5)
            aaa=-aaa;
        end
        
        bbb=10^(aaa/10);
%       
        apsd_sam(ijk)=xapsd(ijk)*bbb;

    end
    
    if(apsd_sam(1)>=apsd_sam(2))
          apsd_sam(1)=apsd_sam(2)*rand();
    end      
    
    
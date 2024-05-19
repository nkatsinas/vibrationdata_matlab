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
 
    if(npb==16)
        f_sam=foct;
        apsd_sam=xapsd;

        
        q=0.95+0.05*rand();
        v=2*(1-q);
        
        if(rand()<0.66)
            if(rand()<0.5)
                for i=1:nbreak
                    if(rand()>0.9)
                        apsd_sam(i)=xapsd(i)*(q+v*rand());
                    end    
                end
            else
               nx=ceil(nbreak*rand());
               if(nx<=0)
                   nx=1;
               end
               if(nx>nbreak)
                   nx=nbreak;
               end
               apsd_sam(nx)=xapsd(nx)*(q+v*rand());              
            end
        else
            for i=1:nbreak
                apsd_sam(i)=xapsd(i)*(q+v*rand());
            end            
        end
    end
    if(npb>=11 && npb<=15 )
        f_sam=xf;
        apsd_sam=xapsd;
        
        if(rand()>0.5)
            [f_sam]=frequency3(xf,f1,f2,foct);
        end    
        if(rand()>0.2)
            [apsd_sam]=amplitude2(nbreak,xapsd);    
        end               
    end    
    

    if(npb<=10)
        f_sam=xf;
        apsd_sam=xapsd;
        
        if(rand()>0.3)
            [f_sam]=frequency2(xf,f1,f2);
        end    
        if(rand()>0.3)
            [apsd_sam]=amplitude2(nbreak,xapsd);    
        end
        [apsd_sam]=opt_psd_amplitude_adjust(nbreak,npb,apsd_sam);        
    end
        
    [max_sss,min_fff]=freq_slope_check(f_sam,apsd_sam);
    
    if(npb==16)
        break;
    else
        if(f_sam(end)==f2 && max_sss<slopec && min_fff>plateau  && min(diff(f_sam))>=5)
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
        uuu=input(' ');
        return;
    end

    
end

function[f_sam]=frequency3(xf,f1,f2,foct)

    nbreak=length(xf);
    Loct=length(foct);
    
    f_sam=xf;


    while(1)
%  
        if(rand()<0.5)
            for i=1:nbreak
                
                [~,j]=min(abs(f_sam(i)-foct));
            
                if(rand()<0.25)
                    j=j-1;
                end
                if(rand()>0.75)
                    j=j+1;
                end
            
                if(j>=2 && j<=Loct-1)
                    f_sam(i)=foct(j);
                end
            
            end
        else
            
            nn=1+round(nbreak*rand());
            if(nn<2)
                nn=2;
            end
            if(nn>nbreak-1)
                nn=nbreak-1;
            end
            
            [~,j]=min(abs(f_sam(nn)-foct));
            
            if(rand()<0.25)
                j=j-1;
            end
            if(rand()>0.75)
                j=j+1;
            end
            
            if(j>=2 && j<=Loct-1)
                f_sam(nn)=foct(j);
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
while(1)
    apsd_sam=zeros(nbreak,1);

    q=0.9+0.1*rand();
    
    tq=2*(1-q);
    
    if(rand()<0.7)
    
        for i=1:nbreak
%        
            apsd_sam(i)=xapsd(i)*(q+tq*rand());
%
            if(apsd_sam(i)>2000. || apsd_sam(i)==0)
%           
                out1=sprintf(' Error: %ld  %8.4g  %8.4g \n',i,apsd_sam(i),xapsd(i));
                disp(out1);
%               
                return;
%
            end
        end
    else
        i=ceil(rand()*nbreak);
        if(i<1)
            i=1;
        end
        if(i>nbreak)
            i=nbreak;
        end

        apsd_sam(i)=xapsd(i)*(q+tq*rand());
    end 
    
    if(min(apsd_sam)>0)
        break;
    end
end
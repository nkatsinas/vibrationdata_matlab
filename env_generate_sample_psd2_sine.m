%
%   env_generate_sample_psd2_sine.m  ver 1.7   by Tom Irvine
%
%
function[f_sam,apsd_sam,max_sss,slopec,sine_samp]=...
    env_generate_sample_psd2_sine(nbreak,npb,xf,xapsd,slopec,f1,f2,plateau,xsine)
%

num_sine=length(xsine);

sine_samp=xsine;

if(rand()>0.5)
    for i=1:num_sine
        if(rand()>0.5)
            sine_samp(i)=xsine(i)*(0.94+0.12*rand());
        else
            sine_samp(i)=xsine(i)*(0.99+0.02*rand());            
        end
    end
end
    
ijk=0;

while(1)
    
    apsd_sam=xapsd;
    f_sam=xf;
 
    if(rand()>0.3)
        [f_sam]=frequency2(xf,f1,f2);
    end
    
    if(rand()>0.3)
        [apsd_sam]=amplitude2(nbreak,xapsd);
        [apsd_sam]=opt_psd_amplitude_adjust(nbreak,npb,apsd_sam);   
    end
    
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
    
    [max_sss,min_fff]=freq_slope_check(f_sam,apsd_sam);
    
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
            if(rand()>0.5)
                f_sam(i)=xf(i)*(0.95+0.1*rand());
            else
                f_sam(i)=xf(i)*(0.99+0.02*rand());                
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
        if(rand()>0.5)
            apsd_sam(i)=xapsd(i)*bbb;
        else
            apsd_sam(i)=xapsd(i)*(0.99+0.02*rand());            
        end
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
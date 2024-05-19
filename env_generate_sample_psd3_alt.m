%
%   env_generate_sample_psd3_alt.m  ver 1.8   by Tom Irvine
%

function[f_sam,apsd_sam]=env_generate_sample_psd3_alt(xf,xapsd,slopec)
%
    f_sam=xf;

    qq=randi([1 2]);
       
    LF=length(f_sam);
    apsd_sam=xapsd;
    
    if(rand()<0.75)
            
        for i=2:LF

            if(qq==1)
                apsd_sam(i)=xapsd(i)*(0.9+0.2*rand());
            else
                apsd_sam(i)=xapsd(i)*(0.95+0.1*rand());                
            end
                
            sq=log10(apsd_sam(i)/apsd_sam(i-1))/log10(f_sam(i)/f_sam(i-1));
            if(abs(sq)>slopec)
                apsd_sam(i)=xapsd(i);
            end
        end
        
    else
        
        i=randi([2 LF]);
        apsd_sam(i)=xapsd(i)*(0.9+0.2*rand());  
        sq=log10(apsd_sam(i)/apsd_sam(i-1))/log10(f_sam(i)/f_sam(i-1));
        
        if(abs(sq)>slopec)
            apsd_sam(i)=xapsd(i);
        end        
    end

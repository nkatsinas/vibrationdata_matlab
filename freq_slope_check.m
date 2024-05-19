    
% freq_slope_check.m  ver 1.1  by Tom Irvine

function[max_sss,min_fff]=freq_slope_check(f_sam,apsd_sam)

    try
      
        nbreak=length(f_sam);
    
        
        sss=zeros(nbreak-1,1);
        fff=zeros(nbreak-1,1);
        
        for i=1:(nbreak-1)
            fr=f_sam(i+1)/f_sam(i);
            sss(i)=log(apsd_sam(i+1)/apsd_sam(i))/log(fr);
            fff(i)=log(fr)/log(2);
        end
        max_sss=max(abs(sss));
        min_fff=min(abs(fff));
     
    catch
        size(f_sam)
        size(apsd_sam)
    end    
    
    
% slope_check.m  ver 1.0  by Tom Irvine

function
      
    nbreak=length(f_sam)-1;

    sss=zeros(nbreak-1,1);
    for i=1:(nbreak-1)
        fr=f_sam(i+1)/f_sam(i);
        sss(i)=log(apsd_sam(i+1)/apsd_sam(i))/log(fr);
    end
    max_sss=max(abs(sss));
     

    
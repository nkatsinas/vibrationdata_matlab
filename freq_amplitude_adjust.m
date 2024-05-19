

% freq_amplitude_adjust.m  ver 1.0  by Tom Irvine


function[f_sam,apsd_sam]=freq_amplitude_adjust(nbreak,npb,f_sam,apsd_sam,f1,f2)

one_oct=1;
one_23=2/3;
one_half=1/2;
one_third=1/3;    
    
% out1=sprintf('nbreak=%d npb=%d',nbreak,npb);
% disp(out1);

%%%%%%%%
%
    if(nbreak==3 && npb==3)
        apsd_sam(3)=apsd_sam(2);
    end
%
    if(nbreak==4 && npb==5)
        apsd_sam(3)=apsd_sam(2);
 %       
        if(apsd_sam(1)>apsd_sam(2))
            apsd_sam(1)=rand()*apsd_sam(2);
        end        
        if(apsd_sam(4)>apsd_sam(3))
            apsd_sam(4)=rand()*apsd_sam(3);
        end
        
        noct=log(f_sam(3)/f_sam(2))/log(2);
        
        if(noct< one_23)
%            f_sam(3)=f_sam(2)*2^(one_23);
        end
        
%        
    end
    
    if(npb==7)
        noct=log(f_sam(3)/f_sam(2))/log(2);
        
        if(noct< one_half)
 %           f_sam(3)=f_sam(2)*2^(one_half);
        end
        
    end
    
    if(npb==7|| npb==8)
        aaa=apsd_sam(2);
        bbb=apsd_sam(3);
        ccc=(aaa+bbb)/2;
        apsd_sam(2)=ccc;
        apsd_sam(3)=ccc; 
%
        aaa=apsd_sam(4);
        bbb=apsd_sam(5);
        ccc=(aaa+bbb)/2;
        apsd_sam(4)=ccc;
        apsd_sam(5)=ccc;
        
        if(apsd_sam(1)>apsd_sam(2))
            apsd_sam(1)=apsd_sam(2)*rand();
        end
    end
    
    if(npb==8)
        if(apsd_sam(6)>apsd_sam(5))
            apsd_sam(6)=apsd_sam(5);
        end
    end  
    if(npb==9)
        apsd_sam(3)=apsd_sam(4);
        
        noct=log(f_sam(4)/f_sam(3))/log(2);
        
        if(noct< one_half)
%            f_sam(4)=f_sam(3)*2^(one_half);
            apsd_sam(1)=apsd_sam(2)*rand();
        end     
        
    end    
 
    f_sam(1)=f1;
    f_sam(nbreak)=f2; 
    f_sam=sort(f_sam);    
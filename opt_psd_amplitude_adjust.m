

% freq_amplitude_adjust.m  ver 1.3  by Tom Irvine


function[apsd_sam]=opt_psd_amplitude_adjust(nbreak,npb,apsd_sam)

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
       
%        
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
    
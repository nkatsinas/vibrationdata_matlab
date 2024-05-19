

%  blanket_alpha.m  ver 1.0  by Tom Irvine


function[fig_num,freq_alpha]=blanket_alpha(THMalpha,thickness,fc,nfc,fig_num,iac)


if(iac==1)  % reference data

    alpha_peak=0.333*thickness+0.0005;
    
    if(alpha_peak>1)
        alpha_peak=1;
    end
    
    term=-0.201*thickness+3.302;
    
    freq_peak=10^term;
    
    ffq=abs(fc-freq_peak);
    
    [~,ind] = min(ffq);
    
    freq_peak=fc(ind);
    
    alpha=zeros(nfc,1);
     
    for i=1:nfc
       
        if(i<ind)
            alpha(i)=alpha_peak*fc(i)/freq_peak;
        end
        if(i==ind)
            alpha(i)=alpha_peak;
        end
        if(i>ind)
            alpha(i)=alpha_peak*freq_peak/fc(i);
        end
        
    end
    
% fc    
    
else
    
    ff=THMalpha(:,1);
    aa=THMalpha(:,2);
    mn=length(aa);
 
    alpha=zeros(nfc,1); 
    
    for i=1:nfc
        
        if(fc(i)<=ff(1))
                aint=aa(1);
        end
        if(fc(i)>=ff(mn))
                aint=aa(mn);
        end          
 
        if(fc(i)>ff(1) && fc(i)<ff(mn))
            
            for j=1:(mn-1)
                
                if(fc(i)>=ff(j) && fc(i)<=ff(j+1))
            
                    noct=log(ff(j+1)/ff(j))/log(2);
                    c2=(log(fc(i)/ff(j))/log(2))/noct;
                    c1=1.-c2;
                    aint=c1*aa(j)+c2*aa(j+1);
                   
                    break;
                end    
                  
            end  
        
        end
        
        alpha(i)=aint;
    
    end   
end


freq_alpha=[ fc alpha  ];

ppp=[fc alpha];
y_label='alpha';
t_string='Blanket Absorption Coefficient';

fmin=fc(1);
fmax=fc(nfc);

x_label='Frequency (Hz)';

[fig_num,h2]=...
    plot_loglog_function_h2(fig_num,x_label,y_label,t_string,ppp,fmin,fmax);


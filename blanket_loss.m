
% blanket_loss.m  ver 1.0  by Tom Irvine

function[fig_num,freq_iloss]=blanket_loss(THMloss,fc,nfc,fig_num,iloss)


if(iloss==1)
    
    fl=[63	2;
        80	2;
        100	2;
        125	2;
        160	4;
        200	6;
        250	7.7;
        315	11.9;
        400	16.1;
        500	19.6;
        630	23.1;
        800	25.2;
        1000	27.3;
        1250	28;
        1600	28;
        2000	28;
        2500	28;
        3150	28; 
        4000	28;
        5000	28];
    
else
    
    fl=THMloss;
 
end

% interpolate

    ff=fl(:,1);
    aa=fl(:,2);
    mn=length(aa);
    
    
    for i=1:mn
        aa(i)=10^(aa(i)/10);
        aa(i)=1/aa(i);
    end
    
    insertion_loss=zeros(nfc,1); 
    insertion_loss_dB=zeros(nfc,1); 
    
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
        
        insertion_loss(i)=aint;
        insertion_loss_dB(i)=10*log10(1/aint);    
    end   

freq_iloss=[fc insertion_loss];
ppp=[fc insertion_loss_dB];

t_string='Blanket Insertion Loss';
x_label='Center Frequency (Hz)';
y_label='Loss (dB)';

fmin=min(fc);
fmax=max(fc);

[fig_num,h2]=...
    plot_loglin_function_h2(fig_num,x_label,y_label,t_string,ppp,fmin,fmax);
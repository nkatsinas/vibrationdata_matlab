%
%  transfer_core.m  ver 1.6  April 29, 2015
%
function[H]=...
    transfer_core_n(freq,fnv,dampv,QE,omn2,omega,omega2,iam,nf,num_columns,i,k,nrb,max_num)
%

    omegan=2*pi*fnv;

    if(max_num>num_columns)
        max_num=num_columns;
    end    


  H=zeros(nf,1); 
%  
    if(nf>4)
       progressbar;
    end
%
    for s=1:nf   % excitation frequency loop
%
        if(nf>4)
            progressbar(s/nf);
        end    
%
        for r=(1+nrb):max_num  % natural frequency loop
            if(fnv(r)<1.0e+30)
%
%                rho=freq(s)/fnv(r);
                
                den= (omn2(r)-omega2(s))  +  (1i)*2*dampv(r)*omegan(r)*omega(s);
                
%
                if(abs(den)<1.0e-60)
                    out1=sprintf(' dampv(r)=%8.4g omn2(r)=%8.4g omega(s)=%8.4g  den=%8.4g',dampv(r),omn2(r),omega(s),den);
                    disp(out1);
                    disp(' den error ');
                    return;
                end
              
%
                term=-(QE(i,r)*QE(k,r)/den);
              
%        
                if(iam==2)
                    term=term*(1i)*omega(s);                   
                end
                if(iam==3 || iam==4)
                    term=term*(-1)*omega2(s);                    
                end 
                H(s)=H(s)+term;                
%
            end
        end   
%
    end
    progressbar(1);
%
    if(iam==5)
        for s=1:nf   % excitation frequency loop
            H(s)=1/H(s);
        end    
    end
%
%  transfer_core.m  ver 1.8   by Tom Irvine
%
%  H is displacement unless iam=2 or 3   
%
%  iam=2 vel
%      3 accel


function[H]=...
    transfer_core(~,fnv,dampv,QE,omn2,omega,omega2,iam,nf,num_columns,i,k,nrb)
%

  omegan=2*pi*fnv;

  H=zeros(nf,1); 
%  
%    if(nf>4)
%       progressbar;
%    end
%
    for s=1:nf   % excitation frequency loop
%
%        if(nf>4)
%            progressbar(s/nf);
%        end    
%
        for r=(1+nrb):num_columns  % natural frequency loop
            if(fnv(r)<1.0e+30)
%
                den= (omn2(r)-omega2(s))  +  (1i)*2*dampv(r)*omegan(r)*omega(s);
%
                if(abs(den)<1.0e-20)
                    disp(' den error ');
                    return;
                end
              
%
                term=(QE(i,r)*QE(k,r)/den);
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
%    progressbar(1);
%
    if(iam==5)
        for s=1:nf   % excitation frequency loop
            H(s)=1/H(s);
        end    
    end
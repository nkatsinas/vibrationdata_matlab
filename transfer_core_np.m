%
%  transfer_core_np.m  ver 1.7  by Tom Irvine
%
% iam=1 disp
%     2 vel
%     3 accel

function[H]=...
    transfer_core_np(freq,fnv,dampv,QE,omn2,omega,omega2,iam,nf,num_columns,i,k,nrb)
%

    disp('ref 1')

  H=zeros(nf,1); 
%   
%%   progressbar;
%
    for s=1:nf   % excitation frequency loop
%
%%        progressbar(s/nf);
%
        for r=(1+nrb):num_columns  % natural frequency loop
            if(fnv(r)<1.0e+30)
%
                rho=freq(s)/fnv(r);
                den=1-rho^2+(1i)*2*dampv(r)*rho;
%
                if(abs(den)<1.0e-20)
                    disp(' den error ');
                    return;
                end         
%
                term=-(QE(i,r)*QE(k,r)/den)/omn2(r);
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
%%    progressbar(1);
%
    if(iam==5)
        for s=1:nf   % excitation frequency loop
            H(s)=1/H(s);
        end    
    end
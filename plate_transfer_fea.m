

%  plate_transfer_fea.m  ver 1.0  by Tom Irvine


function[Ha,Hv,Hd]=plate_transfer_fea(f,fn,QE,response_dof,num_columns,damp,omegan,omega,zz)


zzn=length(zz(:,1));

omn2=omegan.^2;
omega2=omega.^2;


nf=length(f);

i=response_dof;



Ha=zeros(nf,1);
Hv=zeros(nf,1);
Hd=zeros(nf,1);



szQ=size(QE);

progressbar;

for s=1:nf   % excitation frequency loop
%

    progressbar(s/nf);

    for r=1:num_columns  % natural frequency loop

        if(fn(r)<1.0e+30)
%
            den= (omn2(r)-omega2(s))  +  (1i)*2*damp(r)*omegan(r)*omega(s);
%
            if(abs(den)<1.0e-20)
                    disp(' den error ');
                    return;
            end
              
            for ijk=1:zzn
    
                k=zz(ijk,1); 
                
                try
                    termd=-(QE(i,r)*QE(k,r)/den);
%        
                    termv=termd*(1i)*omega(s);                   
                    terma=termd*(-1)*omega2(s);                    
                 
                    Ha(s)=Ha(s)+terma;     
                    Hv(s)=Hv(s)+termv;  
                    Hd(s)=Hd(s)+termd;                
                catch

                    
                    out1=sprintf(' i=%d k=%d r=%d  ',i,k,r);
                    disp(out1);
                    
                    out1=sprintf('Transfer error ');
                    warndlg(out1);
                    return;
                end
            end
%
         end
    end   
%
end

pause(0.3);
progressbar(1);

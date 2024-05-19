%
%  plate_circular_four_points_frf.m  ver 1.0  by Tom Irvine
%
function[H,Hv,HA,accel_trans,rv_trans,rd_trans]=...
                               plate_circular_four_frf(f,fn,damp,part,Z,iu)
%
    tpi=2*pi;
    n2=length(damp);
%
     H=zeros(n2,1);
    Hv=zeros(n2,1);
    HA=zeros(n2,1);   
%
    nmodes=1;
%
    nf=length(f);
%
    for k=1:nf
         H(k)=0;
        Hv(k)=0;
        HA(k)=0;       
 %       
        om=tpi*f(k);
 %
        ijk=0; 
        
        for i=1:nmodes
            for jk=1:nmodes          
 %                  
                clear num;
                clear den;
                clear pY;
                clear omn;
 %
                ijk=ijk+1;
                if(ijk>length(damp))
                    break;
                end                
 %  
                pY=part(ijk)*Z;
                omn=tpi*fn(ijk);
                num=-pY;
                den=(omn^2-om^2)+(1i)*2*damp(ijk)*om*omn;
                num_den=num/den;
                H(k)=H(k)+num_den;            
 %
                HA(k)=HA(k)-om^2*num_den;
 %      
            end
 %
            if(ijk>=length(damp))
                break;
            end
 %
        end
 %
        Hv(k)=(1i)*om*H(k);
 %
    end
%
    if(iu==1)
        conv=386;
    else
        conv=9.81;
    end   
%    conv
%
    H=conv*abs(H);
    Hv=conv*abs(Hv);
%    
    HA=HA+1;
    HA=abs(HA);    
%
    f=fix_size(f);
 
    HA=fix_size(HA);
 
    H=fix_size(H);    
    
    Hv=fix_size(Hv);

accel_trans=[f HA];
rv_trans=[f Hv];
rd_trans=[f H];
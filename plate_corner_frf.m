%
%  plate_corner_frf.m  ver 1.0  by Tom Irvine
%
function[H,Hv,HA,Hsxx,Hsyy,Htxy]=plate_corner_frf(nf,nmodes,f,fn,damp,part,Z,SXX,SYY,TXY)
%
    tpi=2*pi;
    n2=length(damp);
%
     H=zeros(n2,1);
    Hv=zeros(n2,1);
    HA=zeros(n2,1);
    Hsxx=zeros(n2,1);    
    Hsyy=zeros(n2,1);
    Htxy=zeros(n2,1);    
%
    for k=1:nf
         H(k)=0;
        Hv(k)=0;
        HA(k)=0;
 %
        Hsxx(k)=0;
        Hsyy(k)=0;    
        Htxy(k)=0;        
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
                Hsxx(k)=Hsxx(k)-(part(ijk)/den)*SXX;
                Hsyy(k)=Hsyy(k)-(part(ijk)/den)*SYY;
                Htxy(k)=Htxy(k)-(part(ijk)/den)*TXY;             
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
Hsxx=abs(Hsxx);
Hsyy=abs(Hsyy);
Htxy=abs(Htxy);

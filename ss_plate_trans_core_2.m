
%  ss_plate_trans_core_2.m  ver 1.0  by Tom Irvine


function[accel_trans,rv_trans,rd_trans,vM_trans,Tr_trans,HA,Hv,H,HM_stress_vM,Hsxx,Hsyy,Htxy]...
        =ss_plate_trans_core_2(nf,f,fn,damp,pax,pby,part,Amn,fbig,a,b,T,E,mu,iu)

    
    tpi=2*pi; 
%
    clear H;
    clear Hv;
    clear HA;
%
    n2=length(damp);
    nmodes=16;
%
     H=zeros(nf,1);
    Hv=zeros(nf,1);
    HA=zeros(nf,1);
    Hsxx=zeros(nf,1);    
    Hsyy=zeros(nf,1);
    Htxy=zeros(nf,1);    
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
                sss=sin(i*pax)*sin(jk*pby);
                ccc=cos(i*pax)*cos(jk*pby);               
 %               
                nmode=Amn*sss;  
                pY=part(ijk)*nmode;
                omn=tpi*fn(ijk);
                num=-pY;
                den=(omn^2-om^2)+(1i)*2*damp(ijk)*om*omn;
                num_den=num/den;
                H(k)=H(k)+num_den;
 %
                m=fbig(ijk,2);
                n=fbig(ijk,3);               
 %
                A=pi^2*m^2/a^2;
                B=pi^2*n^2/b^2;
 %
                Hsxx(k)=Hsxx(k)-Amn*part(ijk)*(A+mu*B)*sss/den;
                Hsyy(k)=Hsyy(k)-Amn*part(ijk)*(mu*A+B)*sss/den;
                Htxy(k)=Htxy(k)-Amn*part(ijk)*(pi^2*(m*n)/(a*b))*ccc/den;             
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

[accel_trans,rv_trans,rd_trans,vM_trans,Tr_trans,HA,Hv,H,HM_stress_vM,Hsxx,Hsyy,Htxy]=...
         vibrationdata_plate_transfer_3(nf,iu,E,mu,T,H,Hv,HA,Hsxx,Hsyy,Htxy,f);
     
     
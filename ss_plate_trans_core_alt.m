
%  ss_plate_trans_core_alt.m  ver 1.0  by Tom Irvine


function[accel_trans,rv_trans,rd_trans,vM_trans,HA,Hv,H,HM_stress_vM,Hsxx,Hsyy,Htxy]...
        =ss_plate_trans_core_alt(nf,f,fn,damp,pax,pby,part,Amn,fbig,a,b,T,E,mu,iu)
   
    tpi=2*pi; 
%
     H=zeros(nf,1);
    Hv=zeros(nf,1);
    HA=zeros(nf,1);
    Hsxx=zeros(nf,1);    
    Hsyy=zeros(nf,1);
    Htxy=zeros(nf,1);    
%    
    N=length(fbig(:,1));
        
    for k=1:length(f)

        om=tpi*f(k);

         H(k)=0;
        Hv(k)=0;
        HA(k)=0;
 %
        Hsxx(k)=0;
        Hsyy(k)=0;    
        Htxy(k)=0;        
 %
        for j=1:N

             i=fbig(j,2);
            jk=fbig(j,3);
      
 %
            sss=sin(i*pax)*sin(jk*pby);
            ccc=cos(i*pax)*cos(jk*pby);               
 %               
            nmode=Amn*sss;  
            pY=part(j)*nmode;
            omn=tpi*fn(j);
            num=-pY;
            den=(omn^2-om^2)+(1i)*2*damp(i,jk)*om*omn;
            num_den=num/den;
            H(k)=H(k)+num_den;
 %
            m=fbig(j,2);
            n=fbig(j,3);               
 %
            A=pi^2*m^2/a^2;
            B=pi^2*n^2/b^2;
 %
            Hsxx(k)=Hsxx(k)-Amn*part(j)*(A+mu*B)*sss/den;
            Hsyy(k)=Hsyy(k)-Amn*part(j)*(mu*A+B)*sss/den;
            Htxy(k)=Htxy(k)-Amn*part(j)*(pi^2*(m*n)/(a*b))*ccc/den;             
 %
            HA(k)=HA(k)-om^2*num_den;
            Hv(k)=(1i)*om*H(k);

        end
 %
    end

    Hsxx=abs(Hsxx);
    Hsyy=abs(Hsyy);
    Htxy=abs(Htxy);

    [accel_trans,rv_trans,rd_trans,vM_trans,HA,Hv,H,HM_stress_vM,Hsxx,Hsyy,Htxy]=...
         vibrationdata_plate_transfer_2(nf,iu,E,mu,T,H,Hv,HA,Hsxx,Hsyy,Htxy,f);
          
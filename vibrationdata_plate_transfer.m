%
%  vibrationdata_plate_transfer.m  ver 1.1  February 13, 2015
%
function[accel_trans,rv_trans,rd_trans,vM_trans,HA,Hv,H,HM_stress_vM]=...
         vibrationdata_plate_transfer(nf,iu,E,mu,T,H,Hv,HA,Hsxx,Hsyy,Htxy,f)
%
    z=T/2;
    term1=-(E*z/(1-mu^2));    
    term2=-(E*z/(1+mu));
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
    Hsxx=conv*abs(Hsxx);
    Hsyy=conv*abs(Hsyy);
    Htxy=conv*abs(Htxy);        

%   
    Hsxx=term1*Hsxx;
    Hsyy=term1*Hsyy;  
    Htxy=term2*Htxy;  
%
    clear HM_stress_vM;
%
    HM_stress_vM=zeros(nf,1);
    for k=1:nf
        HM_stress_vM(k)=sqrt( Hsxx(k)^2 + Hsyy(k)^2 - Hsxx(k)*Hsyy(k) + 3*Htxy(k)^2 );
    end  
%    
    HA=HA+1;
    HA=abs(HA);
    HA2=HA.*HA;
    Hv2=Hv.*Hv; 
    H2=H.*H;     
    HM_stress_vM2=HM_stress_vM.*HM_stress_vM;
%
    f=fix_size(f);
 
    HA=fix_size(HA);
    HA2=fix_size(HA2);
 
    H=fix_size(H);
    H2=fix_size(H2);    
    
    Hv=fix_size(Hv);
    Hv2=fix_size(Hv2);   
    
    HM_stress_vM=fix_size(HM_stress_vM);    
    HM_stress_vM2=fix_size(HM_stress_vM2);
    
szf=size(f);
szh=size(HA);

if(szf(1)~=szh(1))
    szf
    szh
end
    
accel_trans=[f HA];
rv_trans=[f Hv];
rd_trans=[f H];
vM_trans=[f HM_stress_vM];

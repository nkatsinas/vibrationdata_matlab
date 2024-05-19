
%  beam_bending_trans_core_dforce.m  ver 1.1  by Tom Irvine

function[acc_trans,v_trans,d_trans,moment_trans,shear_trans]=...
          beam_bending_trans_core_dforce(beta,C,sq_mass,x,iu,LBC,RBC,f,part,fn,damp,E,I,mass_per_length)

[ModeShape,ModeShape_dd,ModeShape_ddd]=beam_bending_modes_shapes_alt(LBC,RBC);
    
   nf=length(f);
   n=length(fn);
   
   YY=zeros(n,1);
   YYdd=zeros(n,1);
   YYddd=zeros(n,1);

%   
   for i=1:n
        arg=beta(i)*x;
%        
           YY(i)=ModeShape(arg,C(i),sq_mass);
         YYdd(i)=ModeShape_dd(arg,C(i),beta(i),sq_mass);
        YYddd(i)=ModeShape_ddd(arg,C(i),beta(i),sq_mass);  
   end
%
   H=zeros(nf,1);
   HA=zeros(nf,1);
   HV=zeros(nf,1);
   H_moment=zeros(nf,1);
   H_shear=zeros(nf,1);
%   

%  fprintf('\n  n=%d  nf=%d \n',n,nf);
  
   for k=1:nf 
        
        H(k)=0;
        HA(k)=0;
        H_moment(k)=0;
        H_shear(k)=0;
        
        om=2*pi*f(k);
        
        for i=1:n
%            
            pY=part(i)*YY(i);
            omn=2*pi*fn(i);
            num=pY;
            den=(omn^2-om^2)+(1i)*2*damp(i)*om*omn;
            den=den*mass_per_length;
            
            H(k)=H(k)+num/den;
%
            pY=part(i)*YYdd(i);
            num=-pY;
            H_moment(k)=H_moment(k)+num/den;
%
            pY=part(i)*YYddd(i);
            num=-pY;
            H_shear(k)=H_shear(k)+num/den;            
%
        end
        HA(k)=-om^2*H(k);
        HV(k)=(1i)*om*H(k);  
   end
%
    H=abs(H);
    
%    fprintf('\n max H =%8.4g \n',max(H));
    
    HA=abs(HA);
    HV=abs(HV);
    HM=abs(H_moment);
    HS=abs(H_shear);

    if(iu==1)
        HA=HA/386;
    else
        HA=HA/9.81; 
    end
%
    f=fix_size(f);
%
    n=length(f);
    for i=n:-1:1
%
       if(f(i)==0)
            f(i)=[];
            H(i)=[];
           HA(i)=[]; 
           HV(i)=[];
           HM(i)=[];
           HS(i)=[];
       end
%
    end
%
    acc_trans(:,1)=f;
     v_trans(:,1)=f; 
     d_trans(:,1)=f;
     moment_trans(:,1)=f;
      shear_trans(:,1)=f;
%     
    acc_trans(:,2)=HA;
     v_trans(:,2)=HV;    
     d_trans(:,2)=H;
     
     moment_trans(:,2)=HM*E*I;
      shear_trans(:,2)=HS*E*I;
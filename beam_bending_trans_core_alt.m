
%  beam_bending_trans_core_alt.m  ver 1.1  by Tom Irvine

function[acc_trans,rv_trans,rd_trans,moment_trans,shear_trans]=...
          beam_bending_trans_core_alt(beta,C,sq_mass,x,iu,LBC,RBC,f,part,fn,damp,E,I)

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
   H_relA=zeros(nf,1);
   H_relV=zeros(nf,1);
   H_moment=zeros(nf,1);
   H_shear=zeros(nf,1);
%   

%  fprintf('\n  n=%d  nf=%d \n',n,nf);
  
   for k=1:nf 
        
        H(k)=0;
        H_relA(k)=0;
        H_moment(k)=0;
        H_shear(k)=0;
        
        om=2*pi*f(k);
        
        for i=1:n
%            
            pY=part(i)*YY(i);
            omn=2*pi*fn(i);
            num=-pY;
            den=(omn^2-om^2)+(1i)*2*damp(i)*om*omn;
            
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
        H_relA(k)=-om^2*H(k);
        H_relV(k)=(1i)*om*H(k);  
   end
%
    H=abs(H);
    
%    fprintf('\n max H =%8.4g \n',max(H));
    
    HA=abs(H_relA+1);
    H_relV=abs(H_relV);
    HM=abs(H_moment);
    HS=abs(H_shear);


    if(iu==1)
        H=H*386;
        H_relV=H_relV*386;
        HM=HM*386;
        HS=HS*386;
    else
        H=H*9.81; 
        H_relV=H_relV*9.81;
        HM=HM*9.81;
        HS=HS*9.81;
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
       H_relA(i)=[]; 
       H_relV(i)=[];
           HM(i)=[];
           HS(i)=[];
       end
%
    end
%

    acc_trans(:,1)=f;
     rv_trans(:,1)=f; 
     rd_trans(:,1)=f;
     moment_trans(:,1)=f;
      shear_trans(:,1)=f;
%     
    acc_trans(:,2)=HA;
     rv_trans(:,2)=H_relV;    
     rd_trans(:,2)=H;
     
     moment_trans(:,2)=HM*E*I;
      shear_trans(:,2)=HS*E*I;
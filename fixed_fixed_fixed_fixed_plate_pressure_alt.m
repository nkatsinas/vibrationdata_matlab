%
%  fixed_fixed_fixed_fixed_plate_pressure_alt.m   ver 1.2  by Tom Irvine
%
function[disp_transfer,von_Mises_stress_transfer,f,HM_stress_xx,HM_stress_yy,HM_stress_xy]=...
    fixed_fixed_fixed_fixed_plate_pressure_alt(E,rho,mu,a,b,h,...
                        fn,fig_num,P,dPdx,d2Pdx2,W,dWdy,d2Wdy2,norm,PF,damp,x,y,MAXF,iu)
%
if(x>a)
   disp(' Warning: x reset to total length');
   x=a;
end
%
if(y>b)
   disp(' Warning: y reset to total length');
   y=b;
end
%
%
nf=20000;
%
clear f;
f(1)=1;
for k=2:nf
    f(k)=f(k-1)*2^(1/48);
    if(f(k)>MAXF)
        break;
    end    
end
nf=max(size(f));
%
clear omega;
clear HM;
clear HM_stress_xx;
clear HM_stress_yy;
clear HM_stress_xy;
clear HM_stress_vM;
%
omega=2*pi*f;
omegamn=2*pi*fn;
%%

%
HM=zeros(nf,1);
HM_stress_xx=zeros(nf,1);
HM_stress_yy=zeros(nf,1);
HM_stress_xy=zeros(nf,1);
HM_stress_vM=zeros(nf,1);
%
for k=1:nf
   
%            
    num=P(x)*W(y);
%            
    den=(omegamn^2-omega(k)^2) + (1i)*2*damp*omega(k)*omegamn;
%
    HM(k)=num/den;
%
    dxx=d2Pdx2(x)*W(y);
    dyy=     P(x)*d2Wdy2(y);
    dxy=  dPdx(x)*dWdy(y);
%
    HM_stress_xx(k)= (dxx + mu*dyy)/den;
    HM_stress_yy(k)= (mu*dxx + dyy)/den;
    HM_stress_xy(k)=  dxy/den;
%
end
%
PP=PF/(rho*h*norm);
%
HM=PP*HM;
HM_stress_xx=PP*HM_stress_xx;
HM_stress_yy=PP*HM_stress_yy;
HM_stress_xy=PP*HM_stress_xy;
%
zh=h/2;
AA=-E*zh/(1-mu^2);
BB=-E*zh/(1+mu);
%
HM_stress_xx=HM_stress_xx*AA;
HM_stress_yy=HM_stress_yy*AA;
HM_stress_xy=HM_stress_xy*BB;
%
for k=1:nf
    sxx=HM_stress_xx(k);   
    syy=HM_stress_yy(k);   
    sxy=HM_stress_xy(k);  
    HM_stress_vM(k)=sqrt( sxx^2 + syy^2 - sxx*syy + 3*sxy^2 );
end
%
HM=abs(HM);
HM_stress_xx=abs(HM_stress_xx);
HM_stress_yy=abs(HM_stress_yy);
HM_stress_xy=abs(HM_stress_xy);
HM_stress_vM=abs(HM_stress_vM);
%
%%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
[fig_num]=acoustic_plate_plots(fig_num,x,y,iu,f,HM,HM_stress_xx,HM_stress_yy,HM_stress_xy,HM_stress_vM);
%
%
f=fix_size(f);

xc=[f HM];
disp_transfer=xc;
clear C;
clear I;
[C,I]=max(xc);
xmax=xc(I(2),2);
fmax=xc(I(2),1);
%
if(iu==1)
    out1=sprintf('\n Displacement: max = %8.4g in/psi at %8.4g Hz  ',xmax,fmax);
else
    out1=sprintf('\n Displacement: max = %8.4g m/Pa at %8.4g Hz  ',xmax,fmax);    
end
disp(out1);
%
%
%%%%%%
%

xc=[f HM_stress_vM];
von_Mises_stress_transfer=xc;

clear C;
clear I;
[C,I]=max(xc);
xmax=xc(I(2),2);
fmax=xc(I(2),1);
%
disp(' ');
if(iu==1)
    out1=sprintf('von Mises stress: max = %8.4g (psi/psi) at %8.4g Hz  ',xmax,fmax);
else
    out1=sprintf('von Mises stress: max = %8.4g (Pa/Pa) at %8.4g Hz  ',xmax,fmax);    
end
disp(out1);
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
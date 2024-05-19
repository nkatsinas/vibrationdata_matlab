%
%  ss_ss_ss_ss_plate_uniform_LD.m  ver 1.1   by Tom Irvine
%
function[disp_transfer,von_Mises_stress_transfer,f,HM_stress_xx,HM_stress_yy,HM_stress_xy]=...
ss_ss_ss_ss_plate_uniform_LD(E,D,rho,h,a,b,mu,mass_per_area,damp,MAXF,fig_num,iu,x,y)
%
fig_num=2;

nmodes=6;
%
mass=mass_per_area*a*b;
%
sq_mass=sqrt(mass);
%
DD=sqrt(D/(rho*h));
%
i=1;
for m=1:nmodes
    for n=1:nmodes
        omegamn(m,n)=DD*( (m*pi/a)^2 + (n*pi/b)^2 );
        faux(i)=omegamn(m,n)/(2*pi);
        i=i+1;
    end
end
%
fmn=omegamn/(2*pi);
sort(faux);
%
Amn=2/sqrt(mass);
%
AAA=(2*sqrt(mass)/pi^2);
iv=1;
part=zeros(nmodes,nmodes);
for i=1:nmodes
    for j=1:nmodes
        part(i,j)=(cos(i*pi)-1)*(cos(j*pi)-1);
        part(i,j)=AAA*part(i,j)/(i*j);
        fbig(iv,1)=faux(iv);
        fbig(iv,2)=i;
        fbig(iv,3)=j;
        fbig(iv,4)=part(i,j);
        fbig(iv,5)=(part(i,j))^2;
        iv=iv+1;
    end
end
fbig=sortrows(fbig,1);
mt=iv-1;
%

% x=a/2;
% y=b/2;


disp(' ');
disp('    fn(Hz)   m   n        PF       EMM     EMM ratio   Eig at (x,y)');
%
fn=zeros(mt,1);
for i=1:mt  
    m=fbig(i,2);
    n=fbig(i,3);
    SS=sin(m*pi*x/a)*sin(n*pi*y/b);
    eig=Amn*SS;
    out1=sprintf(' %9.5g \t %d\t %d\t %8.4g\t %8.4g\t %8.4g\t %8.4g  ',fbig(i,1),fbig(i,2),fbig(i,3),fbig(i,4),fbig(i,5),fbig(i,5)/mass,eig);
    disp(out1);
    fn(i)=fbig(i,1);
end
disp(' ');
if(x>a)
   disp(' Warning: x reset to total length');
   x=a;
end
%
disp(' ');
if(y>b)
   disp(' Warning: y reset to total length');
   y=b;
end
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
%%
j=sqrt(-1); 
%
for k=1:nf
    HM(k)=0;
    HM_stress_xx(k)=0;    
    HM_stress_yy(k)=0;    
    HM_stress_xy(k)=0;  
    HM_stress_vM(k)=0;
%    
    for m=1:nmodes
        for n=1:nmodes
%
            CC=cos(m*pi*x/a)*cos(n*pi*y/b);
            SS=sin(m*pi*x/a)*sin(n*pi*y/b);
%            
            G=(cos(m*pi)-1)*(cos(n*pi)-1);
%            
            num=G*SS;
%            
            den=(omegamn(m,n)^2-omega(k)^2) + j*2*damp*omega(k)*omegamn(m,n);
            den=den*(m*n);
%
            HM(k)=HM(k)+num/den;
%
            dxx=-G*(m*pi/a)^2*SS;
            dyy=-G*(n*pi/b)^2*SS;
            dxy= G*(m*pi/a)*(n*pi/b)*CC;
%
            HM_stress_xx(k)=HM_stress_xx(k)+ (dxx + mu*dyy)/den;
            HM_stress_yy(k)=HM_stress_yy(k)+ (mu*dxx + dyy)/den;
            HM_stress_xy(k)=HM_stress_xy(k)+  dxy/den;
%
        end
    end
end
%
P=4/(rho*h*pi^2);
%
HM=P*HM;
HM_stress_xx=P*HM_stress_xx;
HM_stress_yy=P*HM_stress_yy;
HM_stress_xy=P*HM_stress_xy;
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
%
%%%
% [fig_num]=acoustic_plate_plots(fig_num,x,y,iu,f,HM,HM_stress_xx,HM_stress_yy,HM_stress_xy,HM_stress_vM);
%%%
%
f=f';
HM=HM';
xc=[f HM];
disp_transfer=xc;
clear C;
clear I;
[C,I]=max(xc);
xmax=xc(I(2),2);
fmax=xc(I(2),1);
%
if(iu==1)
    out1=sprintf('Displacement: max = %8.4g in/psi at %8.4g Hz  ',xmax,fmax);
else
    out1=sprintf('Displacement: max = %8.4g m/Pa at %8.4g Hz  ',xmax,fmax);    
end
%  disp(out1);
%
%
%%%%%%
%
HM_stress_vM=HM_stress_vM';
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
%  disp(out1);
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
clear xx;
clear yy;
clear zzr;
%
zmax=0;
zmin=0;
%
num=41; 
%
clear x;
clear y;
%
dx=a/(num-1);
dy=b/(num-1);
%
for i=1:num
   ii=i-1;
   x(i)=ii*dx;
   y(i)=ii*dy;
end
%
%  Calculate mode shapes and mass-normalized
%
clear norm;
%
zzr=zeros(num,num);
%
for i=1:num 
%          
        for j=1:num 
%
            zzr(i,j)=sin(pi*x(i)/a)*sin(pi*y(j)/b);            
%
        end
end

%
norm=sqrt(mass_per_area*a*b);
%
zzr=2*zzr/norm;
%
%
zmax=max(max(zzr));
zmin=min(min(zzr));
%
clear aaa;
clear abc;
abc=[x y];
aaa=max(abc);
xmin=0;
ymin=0;
xmax=aaa;
ymax=aaa;
figure(1); 
surf(x,y,zzr);
zmax=2*zmax;
axis([xmin,xmax,ymin,ymax,zmin,zmax]);
out1=sprintf('Mode 1  fn=%8.4g Hz',fn(1));
title(out1)
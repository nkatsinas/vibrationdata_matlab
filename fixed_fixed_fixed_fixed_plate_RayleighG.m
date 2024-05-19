%
%  fixed_fixed_fixed_fixed_plate_RayleighG.m  ver 1.1   by Tom Irvine
%
function[fn,zzr,fig_num,P,dPdx,d2Pdx2,W,dWdy,d2Wdy2,norm,PF]=...
fixed_fixed_fixed_fixed_plate_RayleighG(D,rho,h,a,b,mu,mass_per_area,fig_num,psave)
%
fmin=1.0e+90;
%
x=[0.4 0.67 1.0 1.5 2.5]';
y=[23.65 27.01 35.99 60.77 147.80]';
%
ratio=a/b;
%
LL=-0.426*ratio^3 +27.3*ratio^2 -16.9*ratio +26.1;
%
disp(' ');
%
if(ratio>=min(x) && ratio<=max(x))
    fn1=(LL/(2*pi))*sqrt(D/(rho*h))/a^2;
    out1=sprintf(' Blevins Expected:  fn ~ %8.4g Hz ',fn1);
    disp(out1);
else
    if(ratio>max(x))
        LL=max(y);
        fn1=(LL/(2*pi))*sqrt(D/(rho*h))/a^2; 
        out1=sprintf(' Blevins Expected:  fn > %8.4g Hz ',fn1);       
    end
    if(ratio<min(x))
        LL=min(y);
        fn1=(LL/(2*pi))*sqrt(D/(rho*h))/a^2; 
        out1=sprintf(' Blevins Expected:  fn < %8.4g Hz ',fn1); 
    end    
end
%
c1=2*mu;
c2=2*(1-mu);
%
clear x;
clear y;
%
disp(' ');
disp(' Calculating Rayleigh natural frequency.... '); 
%
% 
num=401; 
%
dx=a/(num-1);
dy=b/(num-1);
%
x=zeros(num,1);
y=zeros(num,1);
for i=1:num
   ii=i-1;
   x(i)=ii*dx;
   y(i)=ii*dy;
end 
%    
disp(' ');
knum=1; 
%
beta=4.73004;
%
beta_x=beta/a;
beta_y=beta/b;
%
%
sigma=( sinh(beta)+sin(beta)  )/( cosh(beta)-cos(beta)  );
%
     P=@(x)            ( cosh(beta_x*x)-cos(beta_x*x) )-sigma*( sinh(beta_x*x)-sin(beta_x*x) );
  dPdx=@(x)   (beta_x*(( sinh(beta_x*x)+sin(beta_x*x) )-sigma*( cosh(beta_x*x)-cos(beta_x*x) )));
d2Pdx2=@(x) (beta_x^2*(( cosh(beta_x*x)+cos(beta_x*x) )-sigma*( sinh(beta_x*x)+sin(beta_x*x) )));
%
     W=@(y)            ( cosh(beta_y*y)-cos(beta_y*y) )-sigma*( sinh(beta_y*y)-sin(beta_y*y) );
  dWdy=@(y)   (beta_y*(( sinh(beta_y*y)+sin(beta_y*y) )-sigma*( cosh(beta_y*y)-cos(beta_y*y) )));  
d2Wdy2=@(y) (beta_y^2*(( cosh(beta_y*y)+cos(beta_y*y) )-sigma*( sinh(beta_y*y)+sin(beta_y*y) )));
%
%
for k=1:knum
%
    V=0;
    T=0;
%
     Zsum=0.;  
    Z2sum=0.;     
%
    for i=1:num
%   
            PP=P(x(i));
%        
        for j=1:num
%  
            WW=W(y(j));    
%
            Z=PP*WW;
%
            Zsum=Zsum+Z*dx*dy;
            Z2sum=Z2sum+Z^2*dx*dy;
%    
            dZdx  =   dPdx(x(i))*WW; 
            d2Zdx2= d2Pdx2(x(i))*WW;     
%
            dZdy  = PP*dWdy(y(j)); 
            d2Zdy2= PP*d2Wdy2(y(j));  
%    
            d2Zdxdy=dPdx(x(i))*dWdy(y(j));
%
            V1=(d2Zdx2)^2;
            V2=(d2Zdy2)^2;
            V3=c1*(d2Zdx2)*(d2Zdy2);
            V4=c2*(d2Zdxdy)^2;
%            
            V=V+ V1+V2+V3+V4;
            T=T+Z^2;
        end
    end
    V=V*D/2;
    T=T*rho*h/2;
    omega=sqrt(V/T);
    fn=omega/(2*pi);
    if(fn<fmin)
        fmin=fn;
        fprintf('%d %8.4g Hz \n',k,fn);
    end
%
end
%
%% out1=sprintf('\n\n Zsum=%8.4g  Z2sum=%8.4g  \n',Zsum/(a*b),Z2sum/(a*b));
%% disp(out1);
%
clear xx;
clear yy;
clear zzr;
%
figure(fig_num); 
fig_num=fig_num+1;
%
num=41; 
%
clear x;
clear y;
%
dx=a/(num-1);
dy=b/(num-1);
%
x=zeros(num,1);
y=zeros(num,1);
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
    for j=1:num 
        zzr(i,j)=P(x(i))*W(y(j));             
    end
end
%
norm=sqrt(mass_per_area*a*b);
%
zzr=zzr/norm;
%
PF=0.690*norm;
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

h2=figure(1);
surf(x,y,zzr);
zmax=2*zmax;
axis([xmin,xmax,ymin,ymax,zmin,zmax]);
out1=sprintf(' fn=%8.4g Hz',fmin);
title(out1)
xlim([0 a]);
ylim([0 b]);


if(psave==1)
    disp(' ');
    disp(' Plot file exported to hard drive as: ');    
    disp(' ');
    pname='fixed_fixed_fixed_fixed_plate';
    set(gca,'Fontsize',12);
    print(h2,pname,'-dpng','-r300');    
    out1=sprintf(' %s.png',pname);
    disp(out1);    
end   
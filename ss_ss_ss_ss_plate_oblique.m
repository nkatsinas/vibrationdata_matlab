%
%  ss_ss_ss_ss_plate_oblique.m  ver 1.2  December 29, 2014
%
function[disp_transfer,von_Mises_stress_transfer,f]=...
ss_ss_ss_ss_plate(E,D,rho,h,a,b,mu,mass_per_area,damp,x,y,MINF,MAXF,fig_num,theta,c,iu)
%
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
sort(faux);
%
iv=1;
%
for i=1:nmodes
    for j=1:nmodes
        fbig(iv,1)=faux(iv);
        fbig(iv,2)=i;
        fbig(iv,3)=j;
        iv=iv+1;
    end
end
fbig=sortrows(fbig,1);
mt=iv-1;
%
disp(' ');
disp('    fn(Hz)      m     n');
%
fn=zeros(mt,1);
for i=1:mt  
    out1=sprintf(' %9.5g \t %d\t %d\t %8.4g\t %8.4g  ',fbig(i,1),fbig(i,2),fbig(i,3));
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
JA11=zeros(nf,1);
%
A_hat=2/(sqrt(rho*a*b*h));
%
for k=1:nf
    HM(k)=0;
    HM_stress_xx(k)=0;    
    HM_stress_yy(k)=0;    
    HM_stress_xy(k)=0;  
    HM_stress_vM(k)=0;
%
    theta_rad=theta*pi/180;
    lambda=c/f(k);
    lambda_t=lambda/sin(theta_rad);
    akt=2*pi/lambda_t;
%
    for m=1:nmodes
%
        lambda_m=2*a/m;
        ratio=lambda_m/lambda_t;        
%
%%        if(m==1)
%%            out1=sprintf(' %8.4g %8.4g %8.4g ',f(k),ratio,(ratio^2 -1));
%%            disp(out1);
%%        end
%
        for n=1:nmodes
%
            AA=(akt/(pi*m))^2-1;
%
            if(abs(AA-1)>=1.0e-06)
%
                arg=(pi*m/2)*(ratio+1);
%                
                NNQ=2*A_hat*a*b*(1-cos(n*pi))*sin(arg);
                DDQ=pi^2*m*n*(ratio^2 -1);
%                
                pf=NNQ/DDQ;
%                
            else
                pf=A_hat*a*b*(cos(n*pi)-1)/(2*pi*n);
            end
%            
            if(m==1 && n==1)
               JA11(k)=JA11(k)+pf/(A_hat*a*b);
            end
%
            CC=A_hat*cos(m*pi*x/a)*cos(n*pi*y/b);
            SS=A_hat*sin(m*pi*x/a)*sin(n*pi*y/b);
%            
            num=pf*SS;
%            
            den=(omegamn(m,n)^2-omega(k)^2) + j*2*damp*omega(k)*omegamn(m,n);
%
            HM(k)=HM(k)+num/den;
%
            G=pf;
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
%%
figure(fig_num);
fig_num=fig_num+1;
JA11=abs(JA11);
plot(f,JA11);
grid on;
out1=sprintf('Joint Acceptance Function m=1 n=1 \n Oblique Incidence theta=%g deg',theta);
title(out1);
ylabel('j');
xlabel('Frequency (Hz)');
ylim([0 0.5]);
xlim([0 MAXF]);
%%
P=1;
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
figure(fig_num);
fig_num=fig_num+1;
plot(f,HM);  
set(gca,'MinorGridLineStyle','none','GridLineStyle',':','XScale','log','YScale','log');


if(iu==1)
    out1=sprintf('Displacement Frequency Response Function at x=%g y=%g inch \n Oblique Incidence theta=%g deg',x,y,theta);
    ylabel('[Displacement/Pressure] (in/psi) ');
else
    out1=sprintf('Displacement Frequency Response Function at x=%g y=%g meters \n Oblique Incidence theta=%g deg',x,y,theta);
    ylabel('[Displacement/Pressure] (m/Pa) ');    
end


ymax= 10^ceil(log10(max(HM)));
%
ymin= 10^floor(log10(min(HM)));
%
L=10^6;
%
if(ymin<ymax/L)
    ymin=ymax/L;
end

xlim([MINF MAXF]);
ylim([ymin ymax]);


title(out1);
xlabel('Frequency (Hz)');
grid on;
disp(' ');
%
%%%
    figure(fig_num);
    fig_num=fig_num+1;
    plot(f,HM_stress_xx,f,HM_stress_yy);  
    legend ('stress xx','stress yy');  
    set(gca,'MinorGridLineStyle','none','GridLineStyle',':','XScale','log','YScale','log');
    if(iu==1)
        out1=sprintf('Stress Frequency Response Function at x=%g y=%g inch \n Oblique Incidence theta=%g deg',x,y);        
        ylabel('[Stress/Pressure] (psi/psi) ');
    else
        out1=sprintf('Stress Frequency Response Function at x=%g y=%g meters \n Oblique Incidence theta=%g deg',x,y);        
        ylabel('[Stress/Pressure] (Pa/Pa) ');        
    end
    title(out1);    
    xlabel('Frequency (Hz)');
    grid on;
    disp(' ');
%%%
    figure(fig_num);
    fig_num=fig_num+1;
    plot(f,HM_stress_xy);  
    legend ('stress xy');  
    set(gca,'MinorGridLineStyle','none','GridLineStyle',':','XScale','log','YScale','log');    
    if(iu==1)
        out1=sprintf('Stress Frequency Response Function at x=%g y=%g inch\n Oblique Incidence theta=%g deg',x,y,theta);        
        ylabel('[Stress/Pressure] (psi/psi) ');
    else
        out1=sprintf('Stress Frequency Response Function at x=%g y=%g meters\n Oblique Incidence theta=%g deg',x,y,theta);        
        ylabel('[Stress/Pressure] (Pa/Pa) ');        
    end
    title(out1);
    xlabel('Frequency (Hz)');
    grid on;
    xlim([MINF MAXF]);    
%%%
    figure(fig_num);
    fig_num=fig_num+1;
    plot(f,HM_stress_vM);  
    legend ('von Mises');  
    set(gca,'MinorGridLineStyle','none','GridLineStyle',':','XScale','log','YScale','log');
    if(iu==1)
        out1=sprintf('Stress Frequency Response Function at x=%g y=%g inch\n Oblique Incidence theta=%g deg',x,y,theta);        
        ylabel('[Stress/Pressure] (psi/psi) ');
    else
        out1=sprintf('Stress Frequency Response Function at x=%g y=%g meters\n Oblique Incidence theta=%g deg',x,y,theta);           
        ylabel('[Stress/Pressure] (Pa/Pa) ');        
    end
    title(out1);    
    xlabel('Frequency (Hz)');
    grid on;
    
    ymax= 10^ceil(log10(max(HM_stress_vM)));
%
    ymin= 10^floor(log10(min(HM_stress_vM)));
%
    L=10^6;
%
    if(ymin<ymax/L)
        ymin=ymax/L;
    end
    xlim([MINF MAXF]); 
    ylim([ymin ymax]);    
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
disp(out1);
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
disp(out1);
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
clear xx;
clear yy;
clear zzr;
%
figure(fig_num); 
fig_num=fig_num+1;
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
surf(x,y,zzr);
zmax=2*zmax;
axis([xmin,xmax,ymin,ymax,zmin,zmax]);
out1=sprintf('Mode 1  fn=%8.4g Hz',fn(1));
title(out1)
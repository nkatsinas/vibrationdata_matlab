disp(' ');
disp(' fixed_plate_uniform_pressure_frf.m  ver 1.1  September 21, 2012');
disp(' by Tom Irvine  Email: tom@vibrationdata.com ');
disp(' ');
disp(' This script calculates the response of a rectangular plate  ');
disp(' fixed on all sides to a uniform pressure.');
disp(' ');
%
close all;
%
clear root;
clear f;
clear H;
clear HA;
clear HA2;
clear beta;
clear fn;
clear fmn;
clear faux;
clear A;
clear M;
clear D;
clear x;
%
%
clear y;
clear z;
clear YY;
clear omegamn;
clear fbig;
clear part;
%
fig_num=1;
iu=1;
%
nmodes=5;
mt=nmodes^2;
%
[E,rho,mu]=materials(iu);
%
[a,b,h,rho,D,mass]=rectangular_plate_entry(E,rho,mu);
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
%
disp(' ');
disp('    fn(Hz)   m   n        PF    EMM ratio');
for i=1:mt  
    out1=sprintf(' %9.5g \t %d\t %d\t %8.4g\t %8.4g  ',fbig(i,1),fbig(i,2),fbig(i,3),fbig(i,4),fbig(i,5)/mass);
    disp(out1);
end
disp(' ');
%
%%
%    
disp(' ');    
out1=sprintf(' Enter uniform modal damping ratio ');
disp(out1);
damp=input(' ');
% 
disp(' ');
disp(' Select response point of interest ');
disp(' ');
disp(' Enter distance x ');
x=input(' ');
if(x>a)
   disp(' Warning: x reset to total length');
   x=a;
end
%
disp(' ');
disp(' Enter distance y ');
y=input(' ');
if(y>b)
   disp(' Warning: y reset to total length');
   y=b;
end
%
%%
%
disp(' ');
disp(' Enter maximum base excitation frequency Hz ');
MAXF=input(' ');
%
nf=20000;
%
clear f;
f=zeros(nf,1);
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
            den=(omegamn(m,n)^2-omega(k)^2) + (1i)*2*damp*omega(k)*omegamn(m,n);
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
figure(fig_num);
fig_num=fig_num+1;
plot(f,HM);  
set(gca,'MinorGridLineStyle','none','GridLineStyle',':','XScale','log','YScale','log');
out1=sprintf('Displacement Frequency Response Function at x=%7.4g y=%7.4g inch',x,y);
title(out1);
ylabel('[Displacement/Pressure] (in/psi) ');
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
    out1=sprintf('Stress Frequency Response Function at x=%7.4g y=%7.4g inch',x,y);
    title(out1);
    ylabel('[Stress/Pressure] (psi/psi) ');
    xlabel('Frequency (Hz)');
    grid on;
    disp(' ');
%%%
    figure(fig_num);
    fig_num=fig_num+1;
    plot(f,HM_stress_xy);  
    legend ('stress xy');  
    set(gca,'MinorGridLineStyle','none','GridLineStyle',':','XScale','log','YScale','log');
    out1=sprintf('Stress Frequency Response Function at x=%7.4g y=%7.4g inch',x,y);
    title(out1);
    ylabel('[Stress/Pressure] (psi/psi) ');
    xlabel('Frequency (Hz)');
    grid on;
%%%
    figure(fig_num);
    fig_num=fig_num+1;
    plot(f,HM_stress_vM);  
    legend ('von Mises');  
    set(gca,'MinorGridLineStyle','none','GridLineStyle',':','XScale','log','YScale','log');
    out1=sprintf('Stress Frequency Response Function at x=%7.4g y=%7.4g inch',x,y);
    title(out1);
    ylabel('[Stress/Pressure] (psi/psi) ');
    xlabel('Frequency (Hz)');
    grid on;
%%%
%
HM=HM';
xc=[f HM];
disp_transfer=xc;
HM2=HM.*HM;
clear C;
clear I;
[C,I]=max(xc);
xmax=xc(I(2),2);
fmax=xc(I(2),1);
%
out1=sprintf('Displacement: max = %8.4g in/psi at %8.4g Hz  ',xmax,fmax);
disp(out1);
%
ptrans=[f HM2];
%
%%%%%%
%
HM_stress_vM=HM_stress_vM';
xc=[f HM_stress_vM];
von_Mises_stress_transfer=xc;
HM_stress_vM2=HM_stress_vM.*HM_stress_vM;
clear C;
clear I;
[C,I]=max(xc);
xmax=xc(I(2),2);
fmax=xc(I(2),1);
%
disp(' ');
out1=sprintf('von Mises stress: max = %8.4g (psi/psi) at %8.4g Hz  ',xmax,fmax);
disp(out1);
%
vM_trans=[f HM_stress_vM2];
% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
disp(' ');
disp(' ');
disp(' The displacement output array name is:  disp_transfer ');
%
disp(' ');
disp(' The von Mises stress output array name is:  von_Mises_stress_transfer ');
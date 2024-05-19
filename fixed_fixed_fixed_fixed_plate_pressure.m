%
%  fixed_fixed_fixed_fixed_plate_pressure.m   ver 1.0  July 26, 2012
%
function[disp_transfer,von_Mises_stress_transfer]=...
    fixed_fixed_fixed_fixed_plate_pressure(E,rho,mu,a,b,h,D,...
                        fn,zzr,fig_num,P,dPdx,d2Pdx2,W,dWdy,d2Wdy2,norm,PF)
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
j=sqrt(-1); 
%
%
for k=1:nf
    HM(k)=0;
    HM_stress_xx(k)=0;    
    HM_stress_yy(k)=0;    
    HM_stress_xy(k)=0;  
    HM_stress_vM(k)=0;
%            
    num=P(x)*W(y);
%            
    den=(omegamn^2-omega(k)^2) + j*2*damp*omega(k)*omegamn;
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
f=f';
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

HM_stress_xx=fix_size(HM_stress_xx);
HM_stress_yy=fix_size(HM_stress_yy);
HM_stress_xy=fix_size(HM_stress_xy);
HM_stress_vM=fix_size(HM_stress_vM);

HM_stress_xx2=HM_stress_xx.*M_stress_xx;
HM_stress_yy2=HM_stress_yy.*HM_stress_yy;
HM_stress_xy2=HM_stress_xy.*HM_stress_xy;
HM_stress_vM2=HM_stress_vM.*HM_stress_vM;


HM_stress_xx=[f HM_stress_xx];
HM_stress_yy=[f HM_stress_yy];
HM_stress_xy=[f HM_stress_xy];
von_Mises_stress_transfer=[f HM_stress_vM];


HM_stress_xx_trans=[f HM_stress_xx2];
HM_stress_yy_trans=[f HM_stress_yy2];
HM_stress_xy_trans=[f HM_stress_xy2];
vM_trans=[f HM_stress_vM2];

%%%%%%%


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

% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
disp(' ');
disp(' ');
disp(' The displacement output array name is:  disp_transfer ');
%
disp(' ');
disp(' The von Mises stress output array name is:  von_Mises_stress_transfer ');
disp(' ');
disp(' fixed_fixed_beam_frf.m  ver 1.4  December 10, 2013');
disp(' by Tom Irvine  Email: tomirvine@aol.com ');
disp(' ');
disp(' Normal Modes & Frequency Response Function');
disp(' ');
disp(' where the force is uniform across the beam length. ');
disp(' ');
%
close all;
%
clear root;
clear f;
clear ccc;
clear H;
clear HA;
clear HM;
clear HM2;
clear beta;
clear YY;
clear beta;
clear xc;
clear transfer;
clear ptrans;
clear fn;
clear part;
clear emm;
%
fig_num=1;
%
disp(' Enter number of modes ');
n = input(' ');
%
iu=1;
%
[ccc,A,I,L]=geometry_entry(iu);
%
[E,rho,mu]=materials(iu);
%
rho=rho*A;   % mass per unit length
%
clear EI;
clear EI_term;
inertia=I;
EI=E*inertia;
EI_term = sqrt(EI/rho);
%
mass=rho*L;
%
sq_mass=sqrt(mass);
%
root=zeros(n,1);
beta=zeros(n,1);
omegan=zeros(n,1);
fn=zeros(n,1);
%
root(1)=4.73004;
root(2)=7.8532;
root(3)=10.9956;
root(4)=14.13717;
root(5)=17.27876;
%
for i=1:n
    if(i>=6)
        root(i)=(0.5 + i)*pi;
    end  
    beta(i)=root(i)/L;
    omegan(i)=(beta(i))^2*EI_term;
    fn(i)=omegan(i)/(2*pi);
end
%
C=zeros(n,1);
for i=1:n
    bL=root(i);
    C(i)=(sinh(bL)+sin(bL))/(cosh(bL)-cos(bL));
end
%
part=zeros(n,1);
for i=1:n
    arg=root(i);
    p2=(sinh(arg)-sin(arg))-C(i)*(cosh(arg)+cos(arg));
    arg=0;
    p1=(sinh(arg)-sin(arg))-C(i)*(cosh(arg)+cos(arg));
    part(i)=(p2-p1)/beta(i);
end
part=part/L;
emm=part.^2;
emm=emm*mass*386;
part=part*sq_mass;
%
clear x;
clear y;
clear yydd;
dx=L/200;
ax=0;
nu=201;
%
x=zeros(nu,1);
y=zeros(nu,1);
yydd=zeros(nu,1);
yyddd=zeros(nu,1);
%
for i=1:nu
    x(i)=(i-1)*dx;
    arg=beta(1)*x(i);
    y(i)=                (cosh(arg)-cos(arg))-C(1)*(sinh(arg)-sin(arg));
    yydd(i)=(beta(1))^2*((cosh(arg)+cos(arg))-C(1)*(sinh(arg)+sin(arg))); 
end
y=      y/sqrt(rho*L);
yydd=yydd/sqrt(rho*L);
%
figure(fig_num);
fig_num=fig_num+1;
plot(x,y);
title('Mode 1');
xlabel('x (inch) ');
grid on;
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
figure(fig_num);
fig_num=fig_num+1;
plot(x,yydd);
title('Second derivative of Mode 1');
xlabel('x (inch) ');
grid on;
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
disp(' ');
disp(' mode   fn(Hz)        PF     Effective Modal Mass (lbm)');
for i=1:n
    out1=sprintf('   %d %8.4g Hz\t %8.4g\t %8.4g ',i,fn(i),part(i),emm(i));
    disp(out1);
end
%
disp(' ');
disp(' Total Modal Mass ')
out1=sprintf('  %8.4g lbm ',sum(emm));
disp(out1);
%
[damp]=damping_entry(n);   
%
    nf=20000;
    f(1)=1;
    for k=2:nf
        f(k)=f(k-1)*2^(1/48);  % ignore warning
        if(f(k)>2000)
            break;
        end    
    end
   nf=k;
%
   disp(' ');
   x=input(' Enter the response location (inch) ');
%
[YY,YYd,YYdd,YYddd]=fixed_fixed_beam_modes(n,x,C,beta,sq_mass);
%
[HM_disp,HM_bending_moment,HM_shear]=...
                        beam_frf(n,nf,f,fn,damp,part,rho,EI,YY,YYdd,YYddd);
%
%%%
%
%
HM_bending_stress=abs(HM_bending_moment)*(ccc/I);
%% HM_average_shear_stress=abs(HM_shear_force)/A;
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
f=fix_size(f);
HM_disp=fix_size(HM_disp);
HM_bending_moment=fix_size(HM_bending_moment);
HM_bending_stress=fix_size(HM_bending_stress);
%% HM_shear_force=fix_size(HM_shear_force);
%% HM_average_shear_stress=fix_size(HM_average_shear_stress);
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
figure(fig_num);
fig_num=fig_num+1;
plot(f,HM_disp);  
set(gca,'MinorGridLineStyle','none','GridLineStyle',':','XScale','log','YScale','log');
out1=sprintf('Displacement Frequency Response Function at x=%8.4g inch',x);
title(out1);
ylabel('[Displacement/(Force/Length)] [in/(lbf/in)] ');
xlabel('Frequency (Hz)');
grid on;
disp(' ');
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
figure(fig_num);
fig_num=fig_num+1;
plot(f,HM_bending_moment);  
set(gca,'MinorGridLineStyle','none','GridLineStyle',':','XScale','log','YScale','log');
out1=sprintf('Bending Moment Frequency Response Function at x=%8.4g inch',x);
title(out1);
ylabel('[Bending Moment/(Force/Length)] [in-lbf/(lbf/in)] ');
xlabel('Frequency (Hz)');
grid on;
disp(' ');
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
figure(fig_num);
fig_num=fig_num+1;
plot(f,HM_bending_stress);  
set(gca,'MinorGridLineStyle','none','GridLineStyle',':','XScale','log','YScale','log');
out1=sprintf('Bending Stress Frequency Response Function at x=%8.4g inch',x);
title(out1);
ylabel('[Stress/(Force/Length)] [psi/(lbf/in)] ');
xlabel('Frequency (Hz)');
grid on;
disp(' ');
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
figure(fig_num);
fig_num=fig_num+1;
plot(f,HM_shear_force);  
set(gca,'MinorGridLineStyle','none','GridLineStyle',':','XScale','log','YScale','log');
out1=sprintf('Shear Force  Frequency Response Function at x=%8.4g inch',x);
title(out1);
ylabel('[Shear/(Force/Length)] [lbf/(lbf/in)] ');
xlabel('Frequency (Hz)');
grid on;
disp(' ');
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
out1=sprintf('\n Maximum values at %8.4g inch \n',x);
disp(out1);
%
xc=[f HM_disp];
disp_transfer=xc;
HM2_disp=HM_disp.*HM_disp;
clear C;
clear I;
[C,I]=max(xc);
xmax0=xc(I(2),2);
fmax0=xc(I(2),1);
%
ptrans=[f HM2_disp];
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
xc=[f HM_bending_moment];
bending_moment_transfer=xc;        
clear C;
clear I;
[C,I]=max(xc);
xmax1=xc(I(2),2);
fmax1=xc(I(2),1);
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
xc=[f HM_bending_stress];
bending_stress_transfer=xc;        
clear C;
clear I;
[C,I]=max(xc);
xmax2=xc(I(2),2);
fmax2=xc(I(2),1);
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
xc=[f HM_shear_force];
shear_force_transfer=xc;        
clear C;
clear I;
[C,I]=max(xc);
xmax3=xc(I(2),2);
fmax3=xc(I(2),1);
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
xc=[f HM_average_shear_stress];
average_shear_transfer=xc;        
clear C;
clear I;
[C,I]=max(xc);
xmax4=xc(I(2),2);
fmax4=xc(I(2),1);
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
out0=sprintf('        Displacement:  max = %8.4g [in/(lbf/in)] at %8.4g Hz ',xmax0,fmax0);
out1=sprintf('      Bending Moment:  max = %8.4g [in-lbf/(lbf/in)] at %8.4g Hz',xmax1,fmax1);
out2=sprintf('      Bending Stress:  max = %8.4g [psi/(lbf/in)] at %8.4g Hz',xmax2,fmax2);
out3=sprintf('         Shear Force:  max = %8.4g [lbf/(lbf/in)] at %8.4g Hz',xmax3,fmax3);
out4=sprintf('Average Shear Stress:  max = %8.4g [psi/(lbf/in)] at %8.4g Hz',xmax4,fmax4);
%
disp(out0);
disp(out1);
disp(out2);
disp(out3);
disp(out4);
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
disp(' ');
disp(' Output Arrays:');
disp(' ');
disp('         Displacement:  disp_transfer ');
disp('       Bending Moment:  bending_moment_transfer ');
disp('       Bending Stress:  bending_stress_transfer ');
disp('          Shear Force:  shear_force_transfer ');
disp(' Average Shear Stress:  average_shear_stress_transfer ');
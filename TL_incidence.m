%
disp(' ');
disp(' TL_incidence.m   ver 1.0  February 12, 2009');
disp(' ');
disp(' by Tom Irvine ');
disp(' ');
disp(' Plane Acoustic Wave, Transmission Loss through a Single Partition ');
disp(' Assume f < 0.5 fc ');
disp(' ');
disp(' Reference: Beranek & Ver ');
disp(' ');
% disp(' Note that field incidence approximates a diffuse incidence sound ');
% disp(' field with a limiting angle of about 78 deg ');
disp(' ');
%
clear R;
clear c;
clear cc5;
clear rho;
clear rhos;
clear f;
clear alpha_t;
clear k;
clear L;
clear TL;
clear theta;
%
% disp(' Is medium 3 the same as medium 1 ? ');
% disp(' 1=yes  2=no ');
% isame=input(' ');
isame=1;
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
iu=2;
if(isame==2)
    iu=3;
end
%
for(i=1:iu)
%
    disp(' ');
    out1=sprintf(' Select medium %d',i);
    disp(out1);
    disp(' 1=air  2=water  3=aluminum  4=graphite/epoxy  5=other ');
    imedium=input(' ');
%
%   Unit = (Pa s/m) or (N s/m^3)
%
    if(imedium==1) % air
        R(i)=415;
        if(i==2)
            c=343;
        end
    end
    if(imedium==2) % water
        R(i)=1.5e+06;
        if(i==2)
            c=1500;
        end       
    end
    if(imedium==3) % aluminum
        R(i)=14.0e+06; 
        if(i==2)
            c=5000;
        end     
    end
    if(imedium==4) % graphite/epoxy
        R(i)=10.5e+06;  % varies depending on composition
        if(i==2)
            c=6553;
        end
    end
    if(imedium==5)
%
        disp(' ');
        disp(' Select speed unit ');
        disp(' 1=m/sec  2=ft/sec  3=in/sec ');
        ispeed=input(' ');
        disp(' input speed ');
        cc5=input(' ');
%        
        if(ispeed==2)
            cc5=cc5*0.3048;
        end
        if(ispeed==3)
            cc5=cc5*0.0254;
        end
%        
        disp(' ');
        if(i==2)
            c=cc5;
        end
%
        disp(' ');
        disp(' Select density unit ');
        disp(' 1=kg/m^3  2=lbm/in^3 ');
        idu=input(' ');
        disp(' input density ')
        rho=input(' ');
        if(idu==2)
            rho=rho*27675;
        end
%
        R(i)=rho*cc5;
%
    end
%
end
%
disp(' ');
disp(' Select length unit ');
disp(' 1=meters  2=mm  3=inch ');
ilength=input(' ');
%
disp(' ');
if(ilength==1)
    disp(' Enter the thickness of medium 2  (meters) ');
    L=input(' ');
end
%
if(ilength==2)
    disp(' Enter the thickness of medium 2  (mm) ');
    L=input(' ');
    L=L/1000.;
end
%
if(ilength==3)
    disp(' Enter the thickness of medium 2  (inch) ');
    L=input(' ');
    L=L*0.0254;
end
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
if(isame==1)
    R(3)=R(1);
end
%
disp(' ');
disp(' Acoustic Impedance Values (Pa s/m) ')
for(i=1:3)
    out1=sprintf(' R(%d)= %8.4g ',i,R(i));
    disp(out1);
end
disp(' ');
out1=sprintf(' Speed in Medium 2 = %8.4g m/sec  ',c);
out2=sprintf('                   = %8.4g ft/sec ',c/0.3048);
out3=sprintf('                   = %8.4g in/sec ',c/0.0254);
disp(out1);
disp(out2);
disp(out3);
disp(' ');
%
j=1;
%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
fcr= 343^2/(1.8*c*L);
%
rhos=L*R(2)/c;
%
out1=sprintf(' Surface Mass Density = %8.4g kg/m^2 \n',rhos);
disp(out1);
%
out1=sprintf(' Critical frequency of medium 2 in air is %8.4g Hz \n',fcr);
disp(out1);
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
disp(' ');
disp(' Select analysis type: ');
disp('  1 = TL at normal incidence ');
disp('  2 = TL at oblique incidence ');
disp('  3 = TL at field incidence ');
disp('  4 = TL at random incidence ');
%
iat=input(' ');
%
theta=0;
%
if(iat==2)
    disp(' Input angle (degrees) ');
    theta=input(' ');
end
if(iat==1 || iat == 2)
    theta=theta*pi/180;
    cc=cos(theta);
    den=2*R(1);  
    for(i=1:10000)
        f(i)=i;
        num=rhos*(2*pi*f(i))*cc;
        TL(i)=20*log10(1+num/den);
    end
end
%
if(iat==3)
    theta_limit=78*pi/180;
end
if(iat==4)
    theta_limit=90*pi/180;
end
%
if(iat==3 || iat==4)
    delta=(1/6)*pi/180;
%    
    for(i=1:10000)
        f(i)=i;
        num=0;
        ddd=2*R(1);  
        for(j=0:540)
%
            theta=j*delta;
            if(theta>theta_limit)
                break;
            end
%
            cc=cos(theta);
            nnn=rhos*(2*pi*f(i))*cc;
            ttt=1/(1+nnn/ddd)^2;
%
            num = num + ttt*cos(theta)*sin(theta);
        end
        den=0.5*(sin(theta_limit))^2;
        tau(i)=(num*delta)/den;   
        TL(i)=abs(10*log10(tau(i)));   
    end
end
%
disp(' ');
plot(f,TL);
%
axis([10,10000,0,50]);
set(gca,'ytick',[0 5 10 15 20 25 30 35 40 45 50])
set(gca,'YTickLabel',{'0';'5';'10';'15';'20';'25';'30';'35';'40';'45';'50'})
set(gca,'MinorGridLineStyle','none','GridLineStyle',':','XScale','log','YScale','lin');
grid on;
xlabel('Frequency (Hz)');
ylabel('Transmission Loss (dB)');
title('Transmission Loss through Three Media, Plane Waves');
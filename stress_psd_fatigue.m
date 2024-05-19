disp(' ')
disp(' stress_psd_fatigue.m   ver 1.5   July 21, 2014')
disp(' by Tom Irvine   Email: tom@vibrationdata.com')
disp(' ')
disp(' This program calculates the cumulative fatigue damage for ');
disp(' an input stress PSD using a number of methods.  ');
disp(' ');
disp(' ');
disp(' Failure is assumed to occur if the damage >= 1 ');
disp('  ');
disp(' But some conservative references have a lower threshold with ');
disp(' safety margin. ');
disp('  ');
disp(' References: ');
disp(' 1. Wirsching, Paez, Ortiz, Random Vibrations, Theory & Practice');
disp(' 2. M. Mrsnik, J. Slavic and M Boltezar, Frequency-domain Methods');
disp('    for a Vibration-fatigue-life Estimation -Application to Real Data');
%
disp(' ');
disp(' The input stress PSD and the fatigue strength coefficient must ');
disp(' have consistent stress units. ');
%
disp(' ');
disp(' Select stress unit: ');
disp('   1=psi '); 
disp('   2=ksi '); 
disp('   3=Mpa');
%
iu=input(' ');
disp(' ');
%
if(iu==1)
    stress_unit='psi';
end
if(iu==2)
    stress_unit='ksi';
end
if(iu==3)
    stress_unit='MPa';   
end
%
close all;
clear gamma;
clear f;
clear a;
clear fi;
clear ai;
%
out1=sprintf(' The input PSD must have two columns:  freq(Hz) & stress(%s^2/Hz) \n',stress_unit);
disp(out1);
%
disp(' Select stress PSD file input method ');
disp('   1=external ASCII file ');
disp('   2=file preloaded into Matlab ');
disp('   3=Excel file ');
file_choice = input('');
%
if(file_choice==1)
        [filename, pathname] = uigetfile('*.*');
        filename = fullfile(pathname, filename);
        fid = fopen(filename,'r');
        THM = fscanf(fid,'%g %g',[2 inf]);
        THM=THM';
end
if(file_choice==2)
        FS = input(' Enter the matrix name:  ','s');
        THM=evalin('caller',FS);
end
if(file_choice==3)
        [filename, pathname] = uigetfile('*.*');
        xfile = fullfile(pathname, filename);
%        
        THM = xlsread(xfile);
%         
end
%
f=THM(:,1);
a=THM(:,2);
%
if(f(1)<0.0001)
    f(1)=0.0001;
end    
%
[s,rms]=calculate_PSD_slopes(f,a);
%
sigma_s=rms;
%
df=0.1;
[fi,ai]=interpolate_PSD(f,a,s,df);
%
disp(' ');
disp(' Select material ');
disp('   1=Aluminum 6061-T6');
disp('   2=Butt-welded Steel Joint');
disp('   3=Stainless Steel, PH13-8Mo(H1000)');
disp('   4=other')
imat=input(' ');
%
if(imat==1)
    m=9.25;
    Aksi=9.7724e+17;
    if(iu==1)
        A=((Aksi^(1/m))*1000)^m;
    end
    if(iu==2)
        A=Aksi;
    end
    if(iu==3)
        A=5.5757e+25;
    end    
end
%
if(imat==2)
    m=3.5;
    Aksi=1.255e+11;
    if(iu==1)
        A=((Aksi^(1/m))*1000)^m;
    end
    if(iu==2)
        A=Aksi;
    end
    if(iu==3)
        A=1.080e+14;
    end    
end
%
if(imat==3)
    m=6.54;
    Aksi=1.32E+18;
    if(iu==1)
        A=((Aksi^(1/m))*1000)^m;
    end
    if(iu==2)
        A=Aksi;
    end
    if(iu==3)
        A=4.0224e+23;
    end    
end
%
if(imat==4)
    disp(' ');
    m=input(' Enter the fatigue exponent m: ');
%
    disp(' ');
    out1=sprintf(' Enter the fatigue strength coefficient A (%s^%g):',stress_unit,m);
    disp(out1);
    A=input(' ');
%
end
%
disp(' ');
tau=input(' Enter the duration (sec):  ');
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
clear length;
n=length(fi);
%
m0=0;
m1=0;
m2=0;
m4=0;
M2m=0;
Mkp2=0;
m0p75=0;
m1p5=0;
%
ae=2/m;
be=ae+2;
%
for i=1:n
%    
    m0=m0+ai(i)*df;
    m1=m1+ai(i)*fi(i)*df;
    m2=m2+ai(i)*fi(i)^2*df;
    m4=m4+ai(i)*fi(i)^4*df;
    M2m=M2m+ai(i)*fi(i)^ae*df;
    Mkp2=Mkp2+ai(i)*fi(i)^be*df;
%    
    m0p75=m0p75+ai(i)*fi(i)^0.75*df;
    m1p5=m1p5+ai(i)*fi(i)^1.5*df;
%    
end
%
alpha_0p75=m0p75/sqrt(m0*m1p5);
alpha_1=m1/sqrt(m0*m2);
alpha_2=m2/sqrt(m0*m4);
%
vo=sqrt(m2/m0);
vp=sqrt(m4/m2);
%
alpha=vo/vp;
e=sqrt(1-alpha^2);
%
delta=sqrt(1-alpha_1);
%
arg=0.5*m+1;
gf=gamma(arg);
%
beta=sqrt(m2*M2m/(m0*Mkp2));
betaem=beta^m;
%
lambda_oc=betaem/alpha;
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
DNB=((vo*tau)/A)*gf*(sqrt(2)*sigma_s)^m;
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
DOC=DNB*lambda_oc;
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
a=0.926-0.033*m;
b=1.587*m-2.323;
ee=sqrt(1-alpha_2);
lambda_wl=a+(1-a)*(1-ee)^b;
%
DWL=DNB*lambda_wl;
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
lambda_ll=M2m^(m/2)/(vo*sigma_s^m);
DLL=DNB*lambda_ll;
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
h=1+alpha_1*alpha_2-(alpha_1+alpha_2);
term1=1.112*h*exp(2.11*alpha_2);
term2=(alpha_1-alpha_2);
%
b=(alpha_1-alpha_2)*(term1+term2)/(alpha_2-1)^2;
lambda_bt=(b+(1-b)*alpha_2^(m-1));
DBT=DNB*lambda_bt;
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
DAL=alpha_0p75^2*DNB;
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
[DZB]=sf_Zhao_Baker(fi,ai,m,A,df,sigma_s,tau,vp,m0,m1,m2,m4,alpha_2);
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
T=tau;
[DDK]=sf_Dirlik(m,A,T,m0,m1,m2,m4);
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
out1=sprintf('     Rate of Zero Crossings = %8.4g per sec',vo);
out2=sprintf('              Rate of Peaks = %8.4g per sec',vp);
out3=sprintf('  Irregularity Factor alpha = %8.4g ',alpha);
out4=sprintf('   Spectral Width Parameter = %8.4g ',e);
out42=sprintf('       Vanmarckes Parameter = %8.4g ',delta);
%
out5=sprintf('     Wirsching Light = %8.4g ',lambda_wl);
out6=sprintf('          Ortiz Chen = %8.4g ',lambda_oc);
out7=sprintf('      Lutes & Larsen = %8.4g ',lambda_ll);
%
 out8=sprintf('         Narrowband DNB = %7.3g ',DNB);
 out9=sprintf('             Dirlik DDK = %7.3g ',DDK); 
out10=sprintf('         Alpha 0.75 DAL = %7.3g ',DAL);
out11=sprintf('         Ortiz Chen DOC = %7.3g ',DOC);
out12=sprintf('         Zhao Baker DZB = %7.3g ',DZB);
out13=sprintf('       Lutes Larsen DLL = %7.3g ',DLL);
out14=sprintf('    Wirsching Light DWL = %7.3g ',DWL); 
out15=sprintf('   Benasciutti Tovo DBT = %7.3g ',DBT);
%
disp(' ');
disp(out1);
disp(out2);
disp(' ');
disp(out3);
disp(out4);
disp(out42);
disp(' ');
disp(' Lambda Values   ');
disp(' ');
disp(out5);
disp(out6);
disp(out7);
disp(' ');
disp(' Cumulative Damage Indices ');
disp(' ');
disp(out8);
disp(out9);
disp(out10);
disp(out11);
disp(out12);
disp(out13);
disp(out14);
disp(out15);
%
 out8=sprintf('         Narrowband DNB = %7.3g ',DNB);
 out9=sprintf('             Dirlik DDK = %7.3g ',DDK); 
out10=sprintf('         Alpha 0.75 DAL = %7.3g ',DAL);
out11=sprintf('         Ortiz Chen DOC = %7.3g ',DOC);
out12=sprintf('         Zhao Baker DZB = %7.3g ',DZB);
out13=sprintf('       Lutes Larsen DLL = %7.3g ',DLL);
out14=sprintf('    Wirsching Light DWL = %7.3g ',DWL); 
out15=sprintf('   Benasciutti Tovo DBT = %7.3g ',DBT);
%
disp(' ');
disp(' Average of DAL,DOC,DLL,DBT,DZB,DDK ');
%
av=(DAL+DOC+DLL+DBT+DZB+DDK)/6;
%
out16=sprintf('\n          average=%8.4g ',av);
disp(out16);
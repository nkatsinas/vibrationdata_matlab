%
disp(' ');
disp(' atmosphere_absorption.m  ver 1.0  April 29, 2009 ');
disp(' ');
disp(' by Tom Irvine  ');
disp(' ');
disp(' Calculation per ISO 9613-1:1993(E) ');
disp(' ');
%
clear alpha;
clear fn;
%
pr=101325;
%
T20=293.15;
%
disp(' ');
TC=input(' Enter temperature (degrees C)  ');
%
disp(' ');
pa=input(' Enter pressure (atm) ');
%
pa=pa/(9.8717e-006);
%
Prhat=pa/pr;
%
disp(' ');
rh=input(' Enter relative humidity percent '); 
%
T=TC+273.15;
%
tau=T/T20;
%
T01 = 273.16;
%
Csat=-6.8346*(T01/T)^1.261 + 4.6151;
Psat=10^Csat;
h=rh*Psat/Prhat;
%
frn=Prhat*(tau^-0.5)*(9 + 280*h*exp(-4.17*(tau^(-1/3)-1)));
fro=Prhat*(24 + 40400*h*(0.02+h)/(0.391+h));
%
out1=sprintf(' tau=%8.4g \n',tau);
disp(out1);
%
out1=sprintf(' frn=%8.4g Hz  fro=%8.4g Hz \n',frn,fro);
disp(out1);
%
out1=sprintf(' h=%8.4g  Psat=%8.4g  Prhat=%8.4g  Csat=%8.4g \n',h,Prhat,Psat,Csat);
disp(out1);
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	fc(1)=2.5;
	fc(2)=3.15;
	fc(3)=4.;;
	fc(4)=5.;
	fc(5)=6.3;
	fc(6)=8.;
	fc(7)=10.;
	fc(8)=12.5;
	fc(9)=16.;
	fc(10)=20.;
	fc(11)=25.;
	fc(12)=31.5;
	fc(13)=40.;
	fc(14)=50.;
	fc(15)=63.;
	fc(16)=80.;
	fc(17)=100.;
	fc(18)=125.;
	fc(19)=160.;
	fc(20)=200.;
	fc(21)=250.;
	fc(22)=315.;
	fc(23)=400.;
	fc(24)=500.;
	fc(25)=630.;
	fc(26)=800.;
	fc(27)=1000.;
	fc(28)=1250.;
	fc(29)=1600.;
	fc(30)=2000.;
	fc(31)=2500.;
	fc(32)=3150.;
	fc(33)=4000.;
	fc(34)=5000.;
	fc(35)=6300.;
	fc(36)=8000.;
	fc(37)=10000.;
	fc(38)=12500.;
	fc(39)=16000.;
	fc(40)=20000.;
    imax=40;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
disp(' ');
disp('  Freq(Hz)   alpha(dB/km)  ');
for(i=1:imax)
    f=fc(i);
%
    Nratio=frn + f^2/frn;
    Oratio=fro + f^2/fro;
%
    b1=0.10680*exp(-3352/T)/Nratio;
    b2=0.01275*exp(-2239.1/T)/Oratio;
%
    alpha(i)=8.686*f^2*sqrt(tau)*( ((1.84e-11)/Prhat) + (tau^(-3))*(b1+b2) );
%
    alpha(i)=alpha(i)*1000.;
    out1=sprintf(' %8.4g  %8.4g ',f,alpha(i));
    disp(out1);  
%
end
%
plot(fc,alpha);
grid on;
set(gca,'MinorGridLineStyle',':','GridLineStyle',':','XScale','log','YScale','log');
xlabel('Frequency (Hz) ');
ylabel('Absorption Coefficient (dB/km) ');
out1=sprintf('Absorption Coefficient:  T=%6.3g deg C  Relative Humidity=%6.3g percent',TC,rh);
title(out1);
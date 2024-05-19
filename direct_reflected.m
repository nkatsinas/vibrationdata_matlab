%
disp(' direct_reflected.m  ver 1.1  April 11, 2009 ');
disp(' by Tom Irvine  Email: tomirvine@aol.com ');
disp(' ');
disp(' This program calcupates the sound pressure at a'); 
disp(' given frequency propagating through the atmosphere'); 
disp(' due to both a direct wave and a wave reflected from '); 
disp(' the reactive, porous ground. ');
disp(' Reference: Crocker, Handbook of Acoustics ');
%
clear Direct_amp;
clear amp;
clear dB;
clear Q;
clear r;
clear dd;
clear Fd;
clear Rp;
clear fad_errorfc;
%
disp(' ');
h=input(' Enter source height (inch) ');
%
disp(' ');
g=input(' Enter receiver height (inch) ');
%
disp(' ');
f=input(' Enter frequency (Hz) ');
%
c=13500;  % inch/sec
%
lambda=c/f;
%
out1=sprintf(' wavelength = %8.4g in ',lambda); 
disp(out1);
%
disp(' ');
disp(' Enter length step (inch) ');
delta=input(' ');
%
disp(' Enter the total ground length (inch) ');
TL=input(' ');
M=round(TL/delta);
%
tpi=2*pi;
k=tpi/lambda;
%
omega=tpi*f;
omega2=omega^2;
%
j=sqrt(-1);
jk=j*k;
spi=sqrt(pi);
fpi=4*pi;
h2=h^2;
jspi=j*spi;
%
clear r;
clear amp;
%
%  Z = normalized ground impedance, assume porous ground
%
sigma = 200000;  %  kPa*sec/m^2    Grassland flow resistivity
srf=sigma/f;
Z= 1 + (0.0511*srf^0.75) + j*(0.0768*srf^0.73);   % C.15  Delaney and Bazely;
% 
%  Rp=Reflection coefficient
%
%  errorfc = complementary error function
%
%
progressbar % Create figure and set starting time 
%
Q=zeros(M,1);
Rp=zeros(M,1);
Fd=zeros(M,1);
fad_errorfc=zeros(M,1);
%
for(i=1:M)
%
    progressbar(i/M);
%
    ground_distance=i*delta;
    direct=sqrt(ground_distance^2+(g-h)^2);
    a=ground_distance/(1+(g/h));
    b=ground_distance-a;
%   
    reflected= sqrt(h^2+a^2) + sqrt(g^2+b^2);
% 
    A=exp(jk*direct)/(fpi*direct);
%
    B=exp(jk*reflected)/(fpi*reflected);
%    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
    ctheta=h/sqrt(h^2+a^2);
%
%   d = numerical distance
%
    beta=1/Z;
%    
    d=0.5*(1+j)*sqrt(k*reflected)*(beta+ctheta);  
%
%
   N=16;
   w = faddeeva(d,N);
%
    fad_errorfc(i)=w;
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%
    term=sqrt(0.5*k*reflected);
    
%
    dd(i)=w;
%
    Rp(i)=(Z*ctheta-1)/(Z*ctheta+1);
%
    Fd(i)=1+j*spi*fad_errorfc(i);
%
    Q(i)=Rp(i) + (1-Rp(i))*Fd(i);
    Direct_amp(i)=abs(A);
    amp(i)=abs(A + B*Q(i));
    r(i)=ground_distance;
    dB(i)=20*log10(abs(amp(i)/A));
%
%    disp(' ');
%    out1=sprintf(' A=%8.4g  A=%8.4g  B=%8.4g  B=%8.4g',real(A),imag(A),real(B),imag(B)); 
%    disp(out1);  
%    out1=sprintf(' gd=%8.4g  dir=%8.4g  ref=%8.4g',ground_distance,direct,reflected); 
%    disp(out1);
%    yyy=input(' ');
%
end
%
clear Sr;
clear Samp;
clear SDirect;
clear SdB;
clear SFd;
clear SRp;
clear SQ;
%
Sr=r(1:(M-1));
Samp=amp(1:(M-1));
SDirect_amp=Direct_amp(1:(M-1));
SFd=Fd(1:(M-1));
SRp=Rp(1:(M-1));
SQ=Q(1:(M-1));
%
figure(1);
plot(Sr,Samp,Sr,SDirect_amp);
legend ('Direct + Reflected','Direct Only');       
set(gca,'MinorGridLineStyle','none','GridLineStyle',':','XScale','log','YScale','log');
grid on; 
out1=sprintf('Pressure Ratio  freq = %8.4g Hz',f);
title(out1);
xlabel(' Distance from Source (inch)');
ylabel(' Pressure Ratio ');
%
figure(2);
SdB=dB(1:(M-1));
plot(Sr,SdB);
grid on;
set(gca,'MinorGridLineStyle','none','GridLineStyle',':','XScale','log','YScale','lin');
out1=sprintf('Difference Relative to Direct Wave Only  freq = %8.4g Hz',f);
disp(out1);
xlabel(' Distance from Source (inch)');
ylabel(' Difference (dB) ');
figure(3);
plot(Sr,SFd);
set(gca,'MinorGridLineStyle','none','GridLineStyle',':','XScale','log','YScale','lin');
grid on;
out1=sprintf('Boundary Loss Factor   freq = %8.4g Hz',f);
title(out1);
xlabel(' Distance from Source (inch)');
figure(4);
plot(Sr,real(SRp),Sr,imag(SRp));
legend ('Real','Imaginary');       
set(gca,'MinorGridLineStyle','none','GridLineStyle',':','XScale','log','YScale','lin');
grid on;
out1=sprintf('Reflection Coefficient Rp   freq = %8.4g Hz',f);
title(out1);
xlabel(' Distance from Source (inch)');
figure(5);
plot(Sr,real(SQ),Sr,imag(SQ));
legend ('Real','Imaginary');       
set(gca,'MinorGridLineStyle','none','GridLineStyle',':','XScale','log','YScale','lin');
grid on;
out1=sprintf('Spherical Wave Reflection Coefficient Q   freq = %8.4g Hz',f);
title(out1);
xlabel(' Distance from Source (inch)');
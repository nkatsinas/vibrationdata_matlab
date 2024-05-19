%
disp(' ');
disp(' shock_sine.m   ver 1.0  March 16, 2009');
disp(' by Tom Irvine  Email: tomirvine@aol.com ');
disp(' ');
disp(' This program shows how shock can be used to cover sine vibration ');
disp(' for component testing.');
disp(' ');
%
clear f;
clear fn;
clear H;
%
disp(' ');
disp(' Enter base excitation amplitude (G) ');
G=input(' ');
%
disp(' ');
disp(' Enter base excitation frequency (Hz)');
f=input(' ');
%
disp(' ');
disp(' Enter starting natural frequency (Hz)');
fs=input(' ');
%
disp(' Enter ending natural frequency (Hz)');
fend=input(' ');
%
disp(' ');
disp(' Enter sine duration (sec) ');
T=input(' ');
disp(' ');
%
disp(' ');
disp(' Enter amplification factor Q  (typically 10 <= Q <=50) ');
Q=input(' ');
disp(' ');
%
damp=1/(2*Q);
%
disp(' ');
disp(' Enter the fatigue exponent (typically 4 <= b <=6.4) ');
b=input(' ');
disp(' ');
%
disp(' ');
disp(' Enter the number of shock hits per axis ');
N=input(' ');
disp(' ');
%
nt=2000;
df=(fend-fs)/nt;
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
figure(1)
%
clear a;
clear H;
clear fn;
for(i=1:(nt+1))
    fn(i)=(i-1)*df+fs;
     rho=f/fn(i);
    a=(1-rho)^2+(2*damp*rho)^2;
    a=1/a; 
    a=a*(1+(2*damp*rho)^2);
    H(i)=sqrt(a);
%
end
%
clear X;
X=H*G;
%
clear SSS;
%
for(i=1:(nt+1))
    D=exp(-2*pi*damp/sqrt(1-damp^2));
    ccc= (1-D)*fn(i)*T/N;
    SSS(i)=X(i)*(ccc)^(1/b);
end
%
plot(fn,SSS,fn,X,'-.','Linewidth',2)
legend ('Fatigue','Peak');       
%       
xlabel(' Natural Frequency (Hz) ');
Ylabel(' Accel (G) ');
out1=sprintf('Required Shock Response Spectrum Q=%g for: \n %g G base input at %g Hz, %g sec',Q,G,f,T);
title(out1);
grid on;
set(gca,'MinorGridLineStyle',':','GridLineStyle',':','XScale','log','YScale','log');
%
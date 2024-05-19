function[y]=Bessel_SS(n,xx,mu)
%
JN1=besselj(n+1,xx);
JN =besselj(n,xx);
IN1=besseli(n+1,xx);
IN =besseli(n,xx);
T3 =2*xx/(1-mu);
%   
y=(IN*JN1)+(IN1*JN)-(JN*IN*T3);
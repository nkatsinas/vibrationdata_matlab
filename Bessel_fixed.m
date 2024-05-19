function[y]=Bessel_fixed(n,xx,mu)
%
JN1=besselj(n+1,xx);
JN =besselj(n,xx);
IN1=besseli(n+1,xx);
IN =besseli(n,xx);
T3 =2*xx/(1-mu);
%   
y=(JN*IN1)+(IN*JN1);

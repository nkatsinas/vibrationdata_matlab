

%  tolerance_factor_core_2.m  ver 1.0  by Tom Irvine  


function[k,lambda_int,Z,mu]=tolerance_factor_core_2(p,c,nsamples)

nu=nsamples-1;

zprob=p/100;
confidence=c/100; 

delta=sqrt(n)*zprob;


p = nctcdf(x,nu,delta,'upper');


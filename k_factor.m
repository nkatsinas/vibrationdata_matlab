
%
%  k_factor.m  ver 1.0  by Tom Irvine 
%
%  k factor for one-sided normal tolerance limit
%
%  p = probability percent  
%  c = confidence percent
%  nsamples = number of samples
%
%  k = tolerance factor
%  Zp = Z limit corresponding to probability area in the normal
%       distribution curve
%
%  nu = degrees of freedom
%  delta = Noncentrality parameters
%  T = Noncentral T-distribution abscissa
%
%  Matlab functions from Statistics and Machine Learning Toolbox:
%
%  norminv - Normal inverse cumulative distribution function  
%  nctinv  - Noncentral t inverse cumulative distribution function
%

function[k,Zp,delta,T]=k_factor(p,c,nsamples)

nu=nsamples-1;

probability=p/100;
confidence=c/100; 

Zp = norminv(probability);

delta=sqrt(nsamples)*Zp;

T = nctinv(confidence,nu,delta);

k=T/sqrt(nsamples);


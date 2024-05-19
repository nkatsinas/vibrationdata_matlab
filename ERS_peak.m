%
%  ERS_peak.m  ver 1.0  by Tom Irvine
%
function[ps]=ERS_peak(arg,alpha)

c=sqrt(2*log(arg));
r=c + 0.5772/c;  

ccc=(1-(1-alpha)^(1/arg));
        
term=-log(ccc);
        
ps=r*sqrt(term/log(arg));   % ECSS method
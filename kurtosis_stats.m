
% kurtosis_stats.m  ver 1.0  by Tom Irvine

function[mu,sd,rms,sk,kt]=kurtosis_stats(amp)

n=length(amp);
mu=mean(amp);
sd=std(amp);

 
ammu=amp-mu;
ammu3=ammu.^3;
ammu4=ammu.^4;
  
sk=sum(ammu3)/(n*sd^3);
kt=sum(ammu4)/(n*sd^4);

rms = hypot(sd, mu);
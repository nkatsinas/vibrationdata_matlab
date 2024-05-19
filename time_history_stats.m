%
%  time_history_stats.m  ver 1.0  by Tom Irvine
%
%  This script calculates the descriptive statistics for a time history.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  Input variables
%
%     amp = amplitude
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  Output variables
%
%     mu = mean
%     sd = standard deviation
%     rms = root-mean-square
%     sk = skewness
%     kt = kurtosis
%     max_amp = maximum amplitude
%     min_amp = minumum amplitude
%     max_abs_amp = maximum absolute amplitude
%     crest = crest factor
%     n = number of points
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
function[mu,sd,rms,sk,kt,max_amp,min_amp,max_abs_amp,crest,n]=time_history_stats(amp)

n=length(amp);
mu=mean(amp);
sd=std(amp);
 
ammu=amp-mu;
  
sk=sum(ammu.^3)/(n*sd^3);
kt=sum(ammu.^4)/(n*sd^4);

rms=sqrt(sd^2+mu^2);

max_amp=max(amp);
min_amp=min(amp);
max_abs_amp=max(abs([ max_amp  min_amp ]));

crest=max_abs_amp/sd;
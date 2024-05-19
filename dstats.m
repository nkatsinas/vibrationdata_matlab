%
%   dstats.m  ver 1.0  by Tom Irvine
%
function[amean,amax,amin,aabs,astd,arms,askew,akurt]=dstats(Y)
%
n=length(Y);
%
amean=mean(Y);
amax=max(Y);
amin=min(Y);
%
aabs=max([ abs(amax)  abs(amin)  ]);
%
astd=std(Y);
%
arms=sqrt( astd^2-amean^2);
%
kt=0;
sk=0;
%
Ym=Y-amean;
%
for i=1:n
        kt=kt+Ym(i)^4;
        sk=sk+Ym(i)^3;
end      

kt=kt/(n*astd^4);
sk=sk/(n*astd^3);
%
askew=sk;
akurt=kt;
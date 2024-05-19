
%  cross_correlation_function.m   ver 1.1  by Tom Irvine

function[xc,xmax,tmax]=cross_correlation_function(a,b,num,dt)

    r = xcorr(a,b);
    n=length(r);
    r=r/n;
    t=(0:n-1)*dt;
    t=t-mean(t);
    r=fix_size(r);
    t=fix_size(t);
    xc=[t r];

    [~,I]=max(abs(r));
%
    xmax=r(I);
    tmax=t(I);

%  cross_correlation_function_alt.m   ver 1.1  by Tom Irvine

function[xc,xmax,tmax]=cross_correlation_function_alt(a,b,num,dt)

    r = xcorr(a,b);
    n=length(r);
    r=r/n;
    t=(0:n-1)*dt;
    t=t-mean(t);
    r=fix_size(r);
    t=fix_size(t);
    xc=[t r];
    
    tmax=0;
    xmax=0;
    
    for i=1:n
        if(t(i)>=0 && abs(r(i))>xmax)
            tmax=t(i);
            xmax=abs(r(i));
        end
    end

   
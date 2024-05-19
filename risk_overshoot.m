
% risk_overshoot.m  ver 1.1  by Tom Irvine

function[ps]=risk_overshoot(fn,T,ax)

arg=fn*T;

[ps]=maximax_peak(fn,T); 

ccc=(1-(1-ax)^(1/arg));
        
term=-log(ccc);

if(arg<=1e+09)
        
    ps=ps*sqrt(term/log(arg));   % ECSS method 

else    

    n=floor(log10(arg));

    a=arg/10^n;

    L=log(a)+n*log(10);

    ps=ps*sqrt(term/L);

end    
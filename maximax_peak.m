%
%  maximax_peak.m  ver 1.1  by Tom Irvine
%

function[ps]=maximax_peak(fn,T)

arg=fn*T;

if(arg<=1.e+09)

    c=sqrt(2*log(arg));

else
    n=floor(log10(arg));

    a=arg/10^n;

    L=log(a)+n*log(10);

    c=sqrt(2*L);
end

ps=c + 0.5772/c;    
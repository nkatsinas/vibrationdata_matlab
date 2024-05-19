%
%    Pearson_coefficient.m  ver 1.0  by Tom Irvine
%
%    Pearson Product Moment Correlation
%
function[rho]=Pearson_coefficient(a,b)
%

a=fix_size(a);
b=fix_size(b);

n=length(a);

suma=sum(a);
sumb=sum(b);
a2=a.*a;
b2=b.*b;

num=n*sum(a.*b)-suma*sumb;

den=(n*sum(a2)-(sum(a)^2))*(n*sum(b2)-(sum(b)^2));

den=sqrt(den);

rho=num/den;

if(abs(rho)<1.0e-05)
    rho=0;
end
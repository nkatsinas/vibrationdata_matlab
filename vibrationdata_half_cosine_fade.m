%
%  vibrationdata half_cosine_fade.m  ver 1.1  by Tom Irvine 
%
%  by Tom Irvine
%
function[y]=half_cosine_fade(y,fper)
%
n=length(y);
%
na=floor(fper*n);
nb=n-na;
delta=n-nb;
%
for i=1:na
    arg=pi*(( (i-1)/(na-1) )+1); 
    y(i)=y(i)*0.5*(1+(cos(arg)));
end
%
for i=nb:n
    arg=pi*( (i-nb)/delta );
    y(i)=y(i)*(1+cos(arg))*0.5;
end
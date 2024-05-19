%
%  half_cosine_fade_np.m  ver 1.0  
%
%  by Tom Irvine
%
function[y]=half_cosine_fade_np(y,np)
%
na=np;

n=length(y);

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
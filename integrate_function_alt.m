%
%  integrate_function_alt.m  ver 1.2  by Tom Irvine
%
function[v]=integrate_function_alt(y,dt)
%
n=length(y);

v=zeros(n,1);

w=dt*cumtrapz(y);
w=fix_size(w);

v=w;

v(1)=y(1)*dt/2;
v(n)=v(n-1)+y(n)*dt/2;
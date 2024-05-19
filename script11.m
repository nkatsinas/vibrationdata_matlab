%
%   1D array
%
a=[1 2 3 4 5];
%
N=length(a);
%
for i=1:N
    x=a(i);
    y=sqrt(x);
    fprintf(' sqrt(%g)=%g \n',x,y);
end
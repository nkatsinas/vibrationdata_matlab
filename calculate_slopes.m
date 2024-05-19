
%  calculate_slopes.m  ver 1.0  by Tom Irvine

function[s,num]=calculate_slopes(fr,r)

num=length(fr);
%
s=zeros(num-1,1);
%
for i=1:(num-1)
    a=(log(r(i+1))-log(r(i)));
    b=(log(fr(i+1))-log(fr(i)));
    s(i)=a/b;
end
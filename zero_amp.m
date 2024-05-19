
%
%  zero_amp.m  ver 1.0  by Tom Irvine
%

function[b]=zero_amp(a,t1,t2)

[~,i1]=min(abs(a(:,1)-t1));
[~,i2]=min(abs(a(:,1)-t2));

b=a;

b(i1:i2,2)=0; 
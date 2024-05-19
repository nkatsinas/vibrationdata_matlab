
%
%  dcout.m  ver 1.0  by Tom Irvine
%

function[b]=dcout(a,tt)

[~,jj]=min(abs(a(:,1)-tt));

b=[a(:,1)     a(:,2)-mean(a(1:jj,2)) ]; 
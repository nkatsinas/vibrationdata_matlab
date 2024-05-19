

% Simpsons_rule.m  ver 1.0  by Tom Irvine
%
%  Number of input points should be odd
%


function[area]=Simpsons_rule(y,dx)


 y_odd=sum(y(3:2:end-1,:));   
y_even=sum(y(2:2:end-1,:));

area=( y(1)+(2*y_odd)+(4*y_even)+y(end) )*dx/3;

% quadratic_interpolation_function.m  ver 1.0  by Tom Irvine


function[y,yd]=quadratic_interpolation_function(x1,y1,x2,y2,x3,y3,x)

a = ((y3-y2)/(x3-x2)-(y2-y1)/(x2-x1))/(x3-x1);
b = ((y3-y2)/(x3-x2)*(x2-x1)+(y2-y1)/(x2-x1)*(x3-x2))/(x3-x1);

y = a*(x-x2)^2 + b*(x-x2) + y2;

yd = 2*a*(x-x2) + b;
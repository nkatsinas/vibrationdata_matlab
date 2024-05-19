%
%  find_max.m  ver 1.0  August 28, 2012
%
%  The input file should have two columns
%
function[xmax,ymax]=find_max(a)
%
    [C,I]=max(a);
    xmax=a(I(2),2);
    ymax=a(I(2),1);
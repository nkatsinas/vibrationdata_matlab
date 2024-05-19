%
%  find_max_alt.m  ver 1.0  by Tom Irvine
%
%  
function[xmax,ymax]=find_max_alt(a)
%
    [C,I]=max(a);
    ymax=a(I(2),2);
    xmax=a(I(2),1);
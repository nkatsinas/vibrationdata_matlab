%
%   flat_top_function.m  ver 1.1  by Tom Irvine
%
function[y]=flat_top_function(y)
%
    n=length(y);

    ys=std(y);

    fw = flattopwin(n);

    fw=fix_size(fw);

    y=y.*fw;

    y=y*ys/std(y);
       
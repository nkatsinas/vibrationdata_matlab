%
%  find_max_fmax.m  ver 1.0  by Tom Irvine
%
%  The input file should have two columns
%
function[xmax,ymax]=find_max_fmax(a,fmax)
%
    f=a(:,1);
    
    t = a<fmax;
    [mx,ix] = max(a(t));
    f = find(t);
    ix = f(ix);

    b=a(1:ix,:);

    [C,I]=max(b);
    xmax=b(I(2),2);
    ymax=b(I(2),1);
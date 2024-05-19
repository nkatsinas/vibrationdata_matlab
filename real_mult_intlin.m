%
%   real_mult_intlin.m  ver 1.0  by Tom Irvine
%
function Q2 = real_mult_intlin(x,y,df)
%
clear xi;
clear yi;
clear xL;
clear yL;
clear xiL;
clear yiL;
%
xi=min(x):df:max(x); 
%
xL=x;
yL=y;
xiL=xi;
%
yiL = interp1(xL,yL,xiL);
%
for i=1:length(xi)
    xi(i)=xiL(i);
    yi(i)=yiL(i);
end
Q2=[xi',yi'];
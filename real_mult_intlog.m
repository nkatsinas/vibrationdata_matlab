%
%   real_mult_intlog.m  ver 1.0  by Tom Irvine
%
function Q2 = real_mult_intlog(x,y,df)
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
xL=log10(x);
yL=log10(y);
xiL=log10(xi);
%
yiL = interp1(xL,yL,xiL);
%
for(i=1:length(xi))
    xi(i)=10^xiL(i);
    yi(i)=10^yiL(i);
end
Q2=[xi',yi'];
%
%  secant_method_sc.m  ver 1.0  by Tom Irvine
%
function[root]=secant_method_sc(term,i,b1,b2)
%
r1=term(i,b1);
r2=term(i,b2);
%
%   y=m*x+d;
%
for k=1:10
    m=(r2-r1)/(b2-b1);
    d=r1-m*b1;
%
    b3=-d/m;
    root=b3;
    r3=term(i,b3);
%
    if(abs(r3)<1.0e-20)
        break;
    end
%
    if((r3*r1)>0)
        b1=b3;
        r1=r3;
    else
        b2=b3;
        r2=r3;        
    end
%
end
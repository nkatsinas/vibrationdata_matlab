
%  linear_interpolation_function.m   ver 1.0  by Tom Irvine


function[ynew]=linear_interpolation_function(x1,y1,x2,y2,xnew)

if(xnew==x1)
    ynew=y1;
end
if(xnew==x2)
    ynew=y2;
end

if(xnew~=x1 && xnew~=x2)

    XL=x2-x1;
    c2=(xnew-x1)/XL;
    c1=1-c2;
    ynew= c1*y1 + c2*y2;

end
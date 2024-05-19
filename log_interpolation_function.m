

% log_interpolation_function.m  ver 1.0  by Tom Irvine

function[yn,n]=log_interpolation_function(x1,y1,x2,y2,xn)

    n=log(y2/y1)/log(x2/x1);
    
    yn=y1*(xn/x1)^n;

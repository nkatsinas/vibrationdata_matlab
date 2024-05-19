%
%    damped_sine_lsf_function.m  ver 1.1  by Tom Irvine
%
%    f(t)= a + (b*sin(omegad*(t-x5)) + c*cos(omegad*(t-x5))*exp(-domegan*(t-x5)
%
function[x1]=damped_sine_lsf_function(Y,Z)
%
    Y=fix_size(Y);
%
    ZZ=Z'*Z;
%
    x1=0;

    if(cond(ZZ)<1.0e+15)
%
        x1=ZZ\(Z'*Y);
   
    end     
%
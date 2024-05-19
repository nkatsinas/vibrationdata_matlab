%
%    damped_sine_lsf_function_alt_3.m  ver 1.1  by Tom Irvine
%
%    f(t)=exp(-damp*omega*t)*( A*cos(omega*t) + B*sin(omega*t) );
%
function[A,B]=damped_sine_lsf_function_alt_3(Y,t,omega,damp)
%
    na=length(Y);
%
    Z=zeros(na,2);

    for i=1:na
            omt=omega*t(i);
            ee=exp(-damp*omt);
            Z(i,1)=ee*cos(omt);
            Z(i,2)=ee*sin(omt);
    end
%
    V=pinv(Z'*Z)*(Z'*Y);
    
    A=V(1);
    B=V(2);   
%
    
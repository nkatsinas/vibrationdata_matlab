%
%    damped_sine_lsf_function_prony.m  ver 1.1  by Tom Irvine
%
%    f(t)=exp(-damp*omega*t)*(A*cos(omega*t) + B*sin(omega*t));
%
function[A,B]=damped_sine_lsf_function_prony(Y,t,omegan,damp)
%
    na=length(Y);
%
    Z=zeros(na,2);
%
    for i=1:na
            omt=omegan*t(i);
            ee=exp(-damp*omegan*t(i));
            Z(i,1)=ee*cos(omt);
            Z(i,2)=ee*sin(omt);
    end
 
%
    V=pinv(Z'*Z)*(Z'*Y);
    
    A=V(1);
    B=V(2);
          
%
    
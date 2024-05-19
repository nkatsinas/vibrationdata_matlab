%
%    sine_lsf_function_alt_delay.m  ver 1.1  by Tom Irvine
%
%    f(t)=A*cos(omega*t) + B*sin(omega*t) + C;
%
function[A,B,C]=sine_lsf_function_alt_delay(Y,t,omega,nstart)
%
    na=length(Y);
%
    Z=ones(na,3);
%
    for i=nstart:na
            omt=omega*t(i);
            Z(i,1)=cos(omt);
            Z(i,2)=sin(omt);
    end
%
    V=pinv(Z'*Z)*(Z'*Y);
    
    A=V(1);
    B=V(2);
    C=V(3);         
%
    
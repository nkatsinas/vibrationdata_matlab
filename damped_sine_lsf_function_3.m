%
%    sine_lsf_function_3.m  ver 1.1  by Tom Irvine
%
%    f(t)=  b*sin(omega*t) + c*cos(omega*t)
%
function[a,b,x1,x2,x3,y]=sine_lsf_function_3(Y,t,omega)
%
    na=length(Y);
%
    Z=ones(na,3);
%
    for i=1:na
            omt=omega*t(i);
            Z(i,2)=sin(omt);
            Z(i,3)=cos(omt);
    end
%
    V=pinv(Z'*Z)*(Z'*Y);
    
    a=V(1);
    b=V(2);
    c=V(3);
%
    x1=sqrt(b^2+c^2);
    x2=omega;
    x3=atan2(c,b);                
%
    y=a+x1*sin(x2*t+x3);
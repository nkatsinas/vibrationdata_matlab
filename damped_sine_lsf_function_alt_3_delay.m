%
%    damped_sine_lsf_function_alt_3_delay.m  ver 1.1  by Tom Irvine
%
%    f(t)=exp(-damp*omega*t)*( A*cos(omega*t) + B*sin(omega*t) );
%
function[A,B]=damped_sine_lsf_function_alt_3_delay(Y,t,omega,damp,delay)
%
    na=length(Y);
%
    Z=zeros(na,2);

    for i=1:na
            
            if(t(i)>=delay)
        
                omt=omega*(t(i)-delay);
                ee=exp(-damp*omt);
                Z(i,1)=ee*cos(omt);
                Z(i,2)=ee*sin(omt);
            
            end
    end
%
    V=pinv(Z'*Z)*(Z'*Y);
    
    A=V(1);
    B=V(2);   
%
    
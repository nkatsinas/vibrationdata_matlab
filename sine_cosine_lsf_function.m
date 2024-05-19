%
%    sine_cosine_lsf_function.m  ver 1.1  by Tom Irvine
%
%    f(t)= a + b*sin(omega*t) + c*cos(omega*t)
%
function[a,b,c,y,tau,P,AFT]=sine_cosine_lsf_function(Y,t,omega)
%
    na=length(Y);
%
    Z=ones(na,3);
%
    omt=omega*t;
    Z(:,2)=sin(omt);
    Z(:,3)=cos(omt);
   
%
    V=pinv(Z'*Z)*(Z'*Y);
    
    a=V(1);
    b=V(2);
    c=V(3);                
%
    arg=omega*t;
    
    y=a+b*sin(arg)+c*cos(arg);
    
    sigma=std(y);
    
    num=sum(sin(2*arg));
    den=sum(cos(2*arg));
    
    
    tau=(atan2(num,den))/(2*omega);
    
    arg=omega*(t-tau);
    
    
    A=(sum(y.*cos(arg)))^2;
    B=sum(cos(arg).^2);
    
    C=(sum(y.*sin(arg)))^2;
    D=sum(sin(arg).^2);
    
    
    P=(A/B)+(C/D);
    
    P=P/2;
    
    N=length(y);
    
    AFT=2*sqrt(P/N);
    
   
    
    
    
    
    
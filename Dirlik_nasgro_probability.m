
%  Dirlik_nasgro_probability.m  ver 1.0 by Tom Irvine

function[N,range,dz]=Dirlik_nasgro_probability(n,m0,Q,D1,D2,D3,ds,R)

N=zeros(n,1);

range=zeros(n,1);

dr=2*ds;

for i=1:n
    
    range(i)=(i-1)*dr;
    amp=range(i)/2;
    
    Z=amp/(sqrt(m0));
%    
    t1=(D1/Q)*exp(-Z/Q);  % exponential distribution
    a=-Z^2;
    b=2*R^2;
%    
    t2=(D2*Z/R^2)*exp(a/b);  % first Rayleigh distribution
    t3=D3*Z*exp(-Z^2/2);     % second Rayleigh distribution
%    
    pn=t1+t2+t3;

    p=pn;  
%    
    N(i)=p;
    
end

dz=dr/(2*sqrt(m0));


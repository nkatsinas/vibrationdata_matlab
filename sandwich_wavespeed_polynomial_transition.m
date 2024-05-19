%
%  sandwich_wavespeed_polynomial.m  ver 1.0  by Tom Irvine
%
function [ftrans]=sandwich_wavespeed_polynomial_transition(B,Bf,G,mpa,hc,Uc)

num=20000;

ratio=zeros(num,1);
f=zeros(num,1);

tpi=2*pi;

for i=1:20000
    
    f(i)=i;
    
    omega=tpi*f(i);

    sqrt_omega=sqrt(omega);
    
    cb=sqrt_omega*(B/mpa)^(1/4);
    cs=sqrt(G*hc/mpa);
    cbf=sqrt_omega*(2*Bf/mpa)^(1/4);
    
    a1=(cs^2/cb^4);
    a2=1;
    a3=-cs^2;
    a4=-cbf^4;
    
    p = [a1 a2 a3 a4];
    r = roots(p);
    
    cmin=1e+80;
    
    for j=1:length(r)
        
        if(imag(abs(r(j)))<1.0e-01)
            if(r(j)<cmin && r(j)>1.0e-04)
                cmin=r(j);
            end
        end    
        
    end    
    
    cp=sqrt(cmin);
    ratio(i)=Uc/cp;
    
end    

[c, index] = min(abs(1-ratio(:)));

ftrans=f(index);
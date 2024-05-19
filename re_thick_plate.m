%
%   re_thick_plate.m  ver 1.0  by Tom Irvine
%
%   radiation efficiency thick plate
%
%    a = smallest of length & width
%    b = largest of length & width
%    c = speed of sound
%    fcr = critical frequency
%
function[rad_eff]=re_thick_plate(freq,fcr,a,b,c)

f=freq;

NL=length(f);

P=2*a+2*b;
Ap=a*b;

fb=fcr+5*c/P;
    
fu=5*fb;

ret1=@(beta)(beta*P*c/(pi^2*Ap*fcr));

rad_eff=zeros(NL,1);
    
for i=1:NL
    
    beta=sqrt(f(i)/fcr);
        
    if(f(i)<=fb)
            rad_eff(i)=ret1(beta);
    end
    if(f(i)>=fb && f(i)<fu)
            
            beta=sqrt(fb/fcr);
            r1=ret1(beta);
            r2=1;
            
            f1=fb;
            f2=fu;
            
            slope=log10(r2/r1)/log10(f2/f1);
            
            rad_eff(i)=r1*(f(i)/fb)^slope;        
    end    
    if(f(i)>=fu)
            rad_eff(i)=1;
    end    
            
end    
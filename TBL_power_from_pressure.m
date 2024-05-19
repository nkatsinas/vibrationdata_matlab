%
%   TBL_power_from_pressure.m  ver 1.0  by Tom Irvine
%
function[P]=TBL_power_from_pressure(prms,Uc,cp,f,md,Ap,thick)

tpi=2*pi;

num=Ap*(prms^2);

ratio=Uc/cp;

if(Uc>=cp)
        
    den=(pi^2)*f*md*thick;

    P=ratio*(num/den);
    
else
    
    a1=1;
    a2=1;
    
    den=2*pi*f*md*thick;
    
    Ls=sqrt(Ap);
    
    Y1=(a1/6);
    Y2=a2*( Uc/(tpi*f*Ls) )^2;
    
    Y=Y1+Y2;
    
    P=ratio^3*(num/den)*Y;    
    
end
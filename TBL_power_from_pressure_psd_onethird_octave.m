%
%   TBL_power_from_pressure_psd_onethird_octave.m  ver 1.0  by Tom Irvine
%
function[P]=...
      TBL_power_from_pressure_psd_onethird_octave(pressure_psd,fc,Uc,cp,md,Ap,thick,a1,a2)

tpi=2*pi;

octd=(2^(1/6) - 2^(-1/6));

df=fc*octd;

prms=sqrt( pressure_psd*df );

num=Ap*(prms^2);

ratio=Uc/cp;

if(Uc>=cp)
        
    den=(pi^2)*fc*md*thick;

    P=ratio*(num/den);
    
else
    
    
    den=2*pi*fc*md*thick;
    
    Ls=sqrt(Ap);
    
    Y1=(a1/6);
    Y2=a2*( Uc/(tpi*fc*Ls) )^2;
    
    Y=Y1+Y2;
    
    P=ratio^3*(num/den)*Y;    
    
end


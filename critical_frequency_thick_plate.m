%
%  critical_frequency_thick_plate.m  ver 1.0  by Tom Irvine
%
function[fcr,kflag]=critical_frequency_thick_plate(c,thick,mu,rho,em)

    fcr=0;

    kflag=0;
    
    tpi=2*pi;
    
    mpa=rho*thick;
 
    G=em/(2*(1+mu));
    
    D=em*thick^3/(12*(1-mu^2));
    
    khat=sqrt(5/6);
    
    N=khat*G*thick;
    
    Q=c^2*mpa/N;
    
    if(Q>=0.98)
    
        kflag=1;
    
    else
        
        aa=(1/tpi^2)*(c^4*mpa/D)*(1/(1-Q));
        
        fcr=sqrt(aa);
    
    end

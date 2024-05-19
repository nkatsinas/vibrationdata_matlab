%
%   cylinder_sandwich_fcr.m  ver 1.1  by Tom Irvine
%
%   Facesheets:
%
%        em=elastic modulus
%        mu=Poisson ratio
%        tf=individual facesheet thickness
%        md=face sheet mass density (mass/volume)
%
%   Core:
%
%          G=shear modulus
%          h=core thickness
%    md_core=core mass density (mass/volume)
%
%   Output:
%
%     rho=total mass per area
%     fcr=critical frequency 
%
function[fcr,rho,D,N,mpa,kflag]=cylinder_sandwich_fcr(md,md_core,tf,h,em,mu,G,c)
%
kflag=0;
fcr=0;
  
tpi=2*pi;

hc=h;
    
[D,S,~,mpa]=honeycomb_sandwich_properties(em,G,mu,tf,hc,md,md_core);
    
rho=mpa;
    
t1=tf;
t2=tf;
    
N=sqrt(5/6)*G*hc*(1+((t1+t2)/hc))^2;
                
term=c^2*rho/S;
        
    if(term>=0.98)        
        
        out1=sprintf(' mpa=%8.4g  md_core=%8.4g ',mpa,md_core);        
        disp(out1);
    
        out1=sprintf(' c=%8.4g  rho=%8.4g  S=%8.4g  G=%8.4g',c,rho,S,G);        
        disp(out1);
        
        out1=sprintf(' term = %8.4g ',term);
        disp(out1);
        
        kflag=1;
    
    else
        
            
        num=(c^4*rho/D);
        den=(1-term);
        
        aa=num/den;
        
        omega_cr=sqrt(aa);
        fcr=omega_cr/tpi;
    
    end
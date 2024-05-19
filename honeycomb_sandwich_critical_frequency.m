%
%  honeycomb_sandwich_critical_frequency.m  ver 1.4  by Tom Irvine
%
%    fcr=critical frequency
%
%    em=skin elastic modulus
%     G=core shear modulus
%    tf=individual face sheet thickness
%    hc=core thickness 
%
%    md=skin density (mass/volume)
%    md_core=core density (mass/volume)
%    mpa= total mass per area
%
%    c=speed of sound
%
%    S=G*hc*(1+(tf/hc))^2;
%
function[fcr,mpa,kflag]=...
      honeycomb_sandwich_critical_frequency(em,G,mu,tf,hc,md,md_core,c,NSM_per_area)
%
    kflag=0;
    fcr=0;

    [D,S,~,mpa]=honeycomb_sandwich_properties(em,G,mu,tf,hc,md,md_core);  
            
    mpa=mpa+NSM_per_area;
   
%    [fcr]=honeycomb_sandwich_critical_frequency_core(mpa,c,S,D);
    
    B=D;
    v=mu;
    E=em;
    [Bf]=flexural_rigidity(E,tf,v); 

    [fcr]=honeycomb_sandwich_critical_frequency_core(mpa,c,S,B,Bf,G,hc);
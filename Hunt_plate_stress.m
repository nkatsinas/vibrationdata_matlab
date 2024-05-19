%
%  Hunt_plate_stress.m  ver 1.0  by Tom Irvine
%
function[Hunt_rms]=Hunt_plate_stress(E,rho,mu,a,b,vel_rms,ss)
%
    c=sqrt(E/rho);
 
    rho_c=rho*c;
 
    V=sqrt(3/(1-mu^2));
    
    den =(a^2+b^2);
 
    Hunt_sxx=V*(b^2+mu*a^2)/den; 
    Hunt_syy=V*(a^2+mu*b^2)/den;
 
    Hunt_rms=rho_c*vel_rms*sqrt( Hunt_sxx^2 + Hunt_syy^2 - Hunt_sxx*Hunt_syy );
 
%
    disp(' ');
    disp(' Hunt Maximum Global Stress ');
    out1=sprintf(' %8.4g %s RMS \n',Hunt_rms,ss);
    disp(out1);

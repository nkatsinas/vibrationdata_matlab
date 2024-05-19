%
%  Hunt_plate_stress_shock.m  ver 1.0  by Tom Irvine
%
function[Hunt_vM]=Hunt_plate_stress_shock(E,rho,mu,a,b,vel,ss)
%
    c=sqrt(E/rho);
 
    rho_c=rho*c;
 
    V=sqrt(3/(1-mu^2));
    
    den =(a^2+b^2);
 
    Hunt_sxx=rho_c*vel*V*(b^2+mu*a^2)/den; 
    Hunt_syy=rho_c*vel*V*(a^2+mu*b^2)/den;
 
%   
    Hunt_vM=sqrt( Hunt_sxx^2 + Hunt_syy^2 - Hunt_sxx*Hunt_syy );
 
%
    disp(' ');
    disp(' Hunt Maximum Global Stress ');
    out1=sprintf(' %8.4g %s RMS \n',Hunt_vM,ss);
    disp(out1);

%
%   rad_eff_sandwich_panel_function.m  ver 1.0  by Tom Irvine
%

function[rad_eff_half_space]=rad_eff_sandwich_panel_function(f,c,B,Bf,G,mpa,hc)

tpi=2*pi;

NL=length(f);

rad_eff_half_space=zeros(NL,1);


for i=1:NL
    
    omega=tpi*f(i);
    
    [cp]=sandwich_wavespeed_polynomial(omega,B,Bf,G,mpa,hc);
    
    ka=omega/c;
    kp=omega/cp;
   
    if(ka<1.5*kp)
        rad_eff_half_space(i)=0.47*( ka/kp )^2.24;    
    else
        rad_eff_half_space(i)=1.0;    
    end
       
end
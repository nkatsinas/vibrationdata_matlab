%
%  sandwich_wavespeed_polynomial_acoustic.m  ver 1.0  by Tom Irvine
%
function[fcross]=sandwich_wavespeed_polynomial_acoustic(B,Bf,G,mpa,hc,speed_sound)

tpi=2*pi;

omega_low=1*tpi;
omega_high=20000*tpi;

[clow]=sandwich_wavespeed_polynomial_core(omega_low,B,Bf,G,mpa,hc); 
[chigh]=sandwich_wavespeed_polynomial_core(omega_high,B,Bf,G,mpa,hc);

for i=1:36

    dc=chigh-clow;
    
    c2=(speed_sound-clow)/dc;
    c1=1-c2;
    omega_new=c1*omega_low + c2*omega_high;
    
    [cnew]=sandwich_wavespeed_polynomial_core(omega_new,B,Bf,G,mpa,hc);
    
    if(cnew<speed_sound)
        clow=cnew;
        omega_low=omega_new;
    else
        chigh=cnew;
        omega_high=omega_new;        
    end
    
end

fcross=omega_new/tpi;
%
%  SEA_honeycomb_sandwich_all.m  ver 1.0  by Tom Irvine
%

function[mph,fcr,f1,f2,rad_eff,total_mass,mpa_total]=...
              SEA_honeycomb_sandwich_all(E,G,v,Ap,tf,hc,rhof,rhoc,NSM,fc,c)

tpi=2*pi;    
     
nfc=length(fc);

NSM_per_area=NSM/Ap;

[B,S,~,mpa]=honeycomb_sandwich_properties(E,G,v,tf,hc,rhof,rhoc);
[Bf]=flexural_rigidity(E,tf,v);
 
[rad_eff]=rad_eff_sandwich_panel_function(fc,c,B,Bf,G,mpa,hc);  % shelf mpa only
 
[fcr,mpa_total,~]=honeycomb_sandwich_critical_frequency(E,G,v,tf,hc,rhof,rhoc,c,NSM_per_area);
 
 
total_mass=mpa_total*Ap;
 
mph=zeros(nfc,1);

for i=1:nfc
    
    omega=tpi*fc(i);
    
    [mph(i)]=Renji_modal_density(omega,Ap,S,B,mpa_total);
 
end    

[f1,f2]=shear_frequencies(E,G,v,tf,hc,rhof,rhoc);
            
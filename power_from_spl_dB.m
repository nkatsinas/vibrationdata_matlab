
%  ower_from_spl_dB.m  ver 1.0  by Tom Irvine

function[power,power_dB]=power_from_spl_dB(fc,dB,modal_dens,c,mass_per_area,rad_eff)

pressure_ref=20e-06;
power_ref=1.0e-12;

pressure=pressure_ref*10^(dB/20);
den=mass_per_area*(4*pi*fc^2);
    
power=c^2*rad_eff*pressure^2*modal_dens/den;       

if(power>power_ref)
    power_dB=10*log10(power/power_ref);
else
    power=power_ref;  
    power_dB=0;
end


%% out1=sprintf('fc=%8.4g mdens=%8.4g dB=%8.4g press=%8.4g  power=%8.4g',fc,modal_dens,dB,pressure,power);
%% disp(out1);



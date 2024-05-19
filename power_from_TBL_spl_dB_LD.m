
% power_from_TBL_spl_dB.m  ver 1.0  by Tom Irvine

function[power,power_dB,a1,a2]=power_from_TBL_spl_dB(fc,dB,mpa,Ap,L,Uc,cp,a1,a2)

pressure_ref=20e-06;
power_ref=1.0e-12;

pressure=pressure_ref*10^(dB/20);

ratio=Uc/cp;

p2TBL=pressure^2;





if(Uc>=cp)
    [power]=bw_slow(Ap,p2TBL,ratio,fc,mpa);
else 
    [power]=bw_fast(Ap,p2TBL,ratio,fc,mpa,L,Uc,a1,a2);
end

out1=sprintf(' fc=%8.4g Hz  Uc=%8.4g  cp=%8.4g  a1=%8.4g  a2=%8.4g ',fc,Uc,cp,a1,a2);
disp(out1);


if(power>power_ref)
    power_dB=10*log10(power/power_ref);
else
    power=power_ref;  
    power_dB=0;
end



function[power]=bw_slow(Ap,p2TBL,ratio,fc,mpa)
    
    num=Ap*p2TBL*ratio;
    den=pi^2*fc*mpa;
    
    power=num/den;


function[power]=bw_fast(Ap,p2TBL,ratio,fc,mpa,L,Uc,a1,a2)    
    
    term=(a1/6)+(a2*(Uc/(2*pi*fc*L))^2);
    
    num=Ap*p2TBL*ratio^3*term;
    den=2*pi*fc*mpa;
    
    power=num/den;    


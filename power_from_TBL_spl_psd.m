
% power_from_TBL_spl_psd.m  ver 1.0  by Tom Irvine

function[power,power_dB]=power_from_TBL_spl_psd(fc,pressure_psd,mpa,Ap,L,Uc,cp,a_1,a_2)

a1=a_1;
a2=a_2;

% pressure_ref=20e-06;

power_ref=1.0e-12;

df=fc*(2^(1/6)-1/(2^(1/6)));

p2TBL=pressure_psd*df;

ratio=Uc/cp;


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


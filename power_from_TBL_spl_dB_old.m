
% power_from_TBL_spl_dB.m  ver 1.0  by Tom Irvine

function[power,power_dB,a1,a2]=power_from_TBL_spl_dB(fc,dB,mpa,Ap,L,Uc,cp)

pressure_ref=20e-06;
power_ref=1.0e-12;

pressure=pressure_ref*10^(dB/20);

ratio=Uc/cp;

p2TBL=pressure^2;


out1=sprintf(' fc=%8.4g Hz  Uc=%8.4g  cp=%8.4g ',fc,Uc,cp);
disp(out1);

a1=1;
a2=1;


if(Uc>=cp)
    [power]=bw_slow(Ap,p2TBL,ratio,fc,mpa);
else
    [a1,a2]=calibrate_a1_a2(Ap,p2TBL,fc,mpa,L,Uc);  
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


function[a1,a2]=calibrate_a1_a2(Ap,p2TBL,fc,mpa,L,Uc)

error_max=1.0e+90;

thresh=2;

for i=1:200
    
    if(i<20 || rand()<0.5)
        a1=thresh+5*rand();
        a2=thresh+5*rand();
    else
        a1=a1r*(0.98+0.04*rand());
        a2=a2r*(0.98+0.04*rand());        
    end
    
    if(a1<thresh)
        a1=thresh;
    end
    if(a2<thresh)
        a2=thresh;
    end
        
    ratio_c=1;
    [power1]=bw_slow(Ap,p2TBL,ratio_c,fc,mpa);
    [power2]=bw_fast(Ap,p2TBL,ratio_c,fc,mpa,L,Uc,a1,a2);
    
    err=abs(power1-power2);
    
    if(err<error_max)
        error_max=err;
        a1r=a1;
        a2r=a2;
    end
    
end    

a1=a1r;
a2=a2r;




function[power]=bw_slow(Ap,p2TBL,ratio,fc,mpa)
    
    num=Ap*p2TBL*ratio;
    den=pi^2*fc*mpa;
    
    power=num/den;


function[power]=bw_fast(Ap,p2TBL,ratio,fc,mpa,L,Uc,a1,a2)    
    
    term=(a1/6)+(a2*(Uc/(2*pi*fc*L))^2);
    
    num=Ap*p2TBL*ratio^3*term;
    den=2*pi*fc*mpa;
    
    power=num/den;    


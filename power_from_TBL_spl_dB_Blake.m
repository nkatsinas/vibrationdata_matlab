
% power_from_TBL_spl_dB_Blake.m  ver 1.0  by Tom Irvine

function[power,power_dB,a1,a2]=power_from_TBL_spl_dB_Blake(fc,fh,dB,mpa,Ap,Uc,cp,gamma_1,gamma_3,Reynolds,delta_star)

tpi=2*pi;

eta=1;

deltaf=fc*(2^(1/6)-2^(-1/6));

omega_f=tpi*fc;
omega_h=tpi*fh;


pressure_ref=20e-06;
power_ref=1.0e-12;

pressure=pressure_ref*10^(dB/20);

phi_pp=pressure^2/deltaf;

ratio=Uc/cp;


M=mpa*Ap;

out1=sprintf(' fc=%8.4g Hz  Uc=%8.4g  cp=%8.4g ',fc,Uc,cp);
disp(out1);



if(fc<fh)

    term2=


    if( cp<Uc)  % slow

        term1=2/pi;
        term3=
        term4=

    end

    if( cp==Uc)  % coincidence

        term1=4/pi;
        term3=
        term4=


    end

    if( cp>Uc )  % fast

        term1=2/pi;
        term3=
        term4=

    end

end

v2=term1*term2*term3*term4;

power=M*eta*omega_f*v2;

if(power>power_ref)
    power_dB=10*log10(power/power_ref);
else
    power=power_ref;  
    power_dB=0;
end


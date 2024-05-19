disp(' ')
disp(' Bessel_H.m  ver 1.0   June 27, 2007')
disp(' by Tom Irvine  Email: tomirvine@aol.com ')
disp(' Bessel filter transfer function.')
clear H;
clear G;
clear G1;
clear G2;
clear fH;
clear A;
tpi=2*pi;
disp(' ')
disp(' Select type: 1=lowpass  2=highpass ')
typ=input(' ')
if(typ==1)
    lpf=input(' Enter lowpass frequency (Hz) ');
    fc=lpf;
end
if(typ==2)
    hpf=input(' Enter highpass frequency (Hz) ');
    fc=hpf;
end
%
L=input(' Enter order ');
dzero=(factorial(2*L))/((2^L)*factorial(L));
%
%  The following coefficiences are for "Reference Only."
%  They are not used directly in the transfer function calculation.
%
% sc=complex(sr,si)';
%
nn=5000;
df=fc/100;
for(i=1:nn)
    ff=i*df;
    fH(i)=ff;
    s=complex(0,(ff/fc));
    if(typ==2)
        s=1/s;
    end
    B(1)=1;
    B(2)=s+1;
    for(j=3:L+1)
        B(j)=(2*L-1)*B(j-1) + s^2*B(j-2);
    end
    H(i)=dzero/B(L+1);
%  
end
%
% fH=fH*fc*tpi;
%
figure(1);
plot(fH,abs(H));
set(gca,'MinorGridLineStyle','none','GridLineStyle',':','XScale','log','YScale','log');
grid on;
xlabel(' Frequency (Hz) ');
ylabel(' Magnitude ');
if(typ==1)
    out1=sprintf(' Bessel Lowpass Filter order=%d fc=%7.3g Hz ',L,lpf);
end
if(typ==2)
    out1=sprintf(' Bessel Highpass Filter order=%d fc=%7.3g Hz ',L,hpf);
end
%
title(out1);
%
figure(2);
plot(fH,angle(H)*180/pi);
set(gca,'MinorGridLineStyle','none','GridLineStyle',':','XScale','log','YScale','lin')
ylabel(' Phase(deg) ');
xlabel(' Frequency (Hz) ');
title(out1);
grid on;
%
figure(3);
plot(fH,real(H),fH,imag(H));
set(gca,'MinorGridLineStyle','none','GridLineStyle',':','XScale','log','YScale','lin')
ylabel(' Amplitude ');
xlabel(' Frequency (Hz) ');
title(out1);
legend ('real','imaginary');  
grid on;
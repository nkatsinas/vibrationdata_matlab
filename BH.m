disp(' ')
disp(' BH.m  ver 1.5   June 15, 2013')
disp(' by Tom Irvine  Email: tomirvine@aol.com ')
disp(' Butterworth sixth-order filter transfer function.')
clear H;
clear G;
clear G1;
clear G2;
clear fH;
clear A;
tpi=2*pi;
disp(' ')
disp(' Select type: 1=lowpass  2=highpass  3=bandpass')
typ=input(' ');
%
if(typ==1)
    lpf=input(' Enter lowpass frequency (Hz) ');
    fc=lpf;
end
if(typ==2)
    hpf=input(' Enter highpass frequency (Hz) ');
    fc=hpf;
end
%
if(typ==3)
    hpf=input(' Enter lower frequency(Hz) ');
    fc=hpf;
%
    lpf=input(' Enter upper frequency(Hz) ');
    fc=lpf;
end
%
disp(' ');
disp(' Refiltering for phase correction?  1=yes  2=no ');
ire=input(' ');
%
L=6;
LL=2*L;
%
%  The following coefficiences are for "Reference Only."
%  They are not used directly in the transfer function calculation.
%
for k=1:LL  
    arg  = (2*k+L-1)*pi/LL;
    sr(k)= cos(arg);
    si(k)= sin(arg);
end
sc=complex(sr,si)';
%
nn=5000;
df=fc/100;
%
H=zeros(nn,1);
fH=zeros(nn,1);
%
for i=1:nn
    ff=i*df;
    s=complex(0,(ff/fc));
%
    if(typ==2) % highpass
        s=1/s;
    end
%
    H1=s^2-2*cos(7*pi/12)*s+1;
    H2=s^2-2*cos(9*pi/12)*s+1;
    H3=s^2-2*cos(11*pi/12)*s+1;    
    A=H1*H2*H3;
%    
    A=1/A;
    H(i)=A;
    fH(i)=ff;
%
    if(ire==1)  % refiltering 
        H(i)=H(i)*conj(H(i));
    end
%
end
%
if(typ==3)  % bandpass
    G1=H;
    clear H;
    fc=hpf;
%    
    for i=1:nn 
        ff=i*df;       
        s=complex(0,(ff/fc));
        s=1/s;
%        
        H1=s^2-2*cos(7*pi/12)*s+1;
        H2=s^2-2*cos(9*pi/12)*s+1;
        H3=s^2-2*cos(11*pi/12)*s+1;    
        A=H1*H2*H3;
%    
        A=1/A;
        H(i)=A;
        if(ire==1)  % refiltering 
            H(i)=H(i)*conj(H(i));
        end
        G2(i)=H(i);
        H(i)=G2(i)'*G1(i);     
    end
end    
%
% fH=fH*fc*tpi;
%
figure(1);
plot(fH,abs(H));
set(gca,'MinorGridLineStyle',':','GridLineStyle',':','XScale','log','YScale','log');
grid on;
ymax=1;
ymin=ymax/100;
ylim([ ymin ymax ]);
xmax=10^(ceil(0.01+log10(fc)));
xmin=10^(floor(-0.01+log10(fc)));
xlim([ xmin xmax ]);
xlabel(' Frequency (Hz) ');
ylabel(' Magnitude ');
%
if(ire==1)
    if(typ==1)
        out1=sprintf(' Butterworth Lowpass Filter 6th order Refiltering fc=%g Hz ',lpf);
    end
    if(typ==2)
        out1=sprintf(' Butterworth Highpass Filter 6th order Refiltering fc=%g Hz ',hpf);
    end
    if(typ==3)
        out1=sprintf(' Butterworth Bandpass Filter 6th order Refiltering %g to %g Hz ',hpf,lpf);
    end
else
    if(typ==1)
        out1=sprintf(' Butterworth Lowpass Filter 6th order fc=%g Hz ',lpf);
    end
    if(typ==2)
        out1=sprintf(' Butterworth Highpass Filter 6th order fc=%g Hz ',hpf);
    end
    if(typ==3)
        out1=sprintf(' Butterworth Bandpass Filter 6th order %g to %g Hz ',hpf,lpf);
    end    
end
title(out1);
%
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
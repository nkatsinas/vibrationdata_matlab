disp(' ');
disp(' ocean_wave_PSD.m   ver 1.1   July 9, 2014 ');
disp(' Pierson-Moskowitz Spectrum ');
disp(' ');
disp(' by Tom Irvine, Email: tom@vibrationdata.com ');
disp(' ');
%
clear Somega;
clear Sf;
clear f;
%
disp(' Enter the wind speed (m/sec) at a height of 19.5 m above the sea surface ');
disp(' (Practical Range = 10 to 21 m/sec) ');
U=input(' ');
%
g = 9.81;
alpha = 8.1e-03;
beta=0.74;
omega_zero =g/U; 
tpi=2*pi;
%
fm=(0.877*g/U)/tpi;
%
out1=sprintf('\n peak frequency = %8.4g Hz \n',fm);
disp(out1);
%
fmax=0.5;
%
df = fmax/200;
%
for i=1:200
    if( (i*df)<=fmax )
        f(i)=i*df;
        omega=tpi*f;
        A=alpha*g^2/( (f(i)^5)*(tpi^4) );
        Sf(i)=A*exp(-(5/4)*(fm/f(i))^4);
    end
end
%
plot(f,Sf);
%
ylabel('Wave Spectral Density (m^2/Hz)');
xlabel('Frequency (Hz)');
out1=sprintf(' Pierson-Moskowitz Spectrum  U = %g m/sec at 19.5 m ',U);
title(out1);
AM=max(Sf);
ymax=500;
%
for i=1:1000
    YL=500-10*i;
    if(AM<YL)
        ymax=YL;
    end
    if(YL<=0)
        break;
    end
end
grid;
axis([0,fmax,0,ymax]);
%
Ocean_PSD=[f' Sf'];
%
disp(' ');
disp(' The output filename is: Ocean_PSD ');

%  bessel_transfer_function.m  ver 1.0  by Tom Irvine

function[fig_num]=bessel_transfer_function(fc,fig_num)


L=2;  % two-poles, second order

dzero=(factorial(2*L))/((2^L)*factorial(L));
%
nn=5000;
df=fc/100;
%
fH=zeros(nn,1);
H=zeros(nn,1);
B=zeros(L+1,1);
%
for i=1:nn
    ff=i*df;
    fH(i)=ff;
    s=complex(0,(ff/fc));
    B(1)=1;
    B(2)=s+1;
    for j=3:L+1
        B(j)=(2*L-1)*B(j-1) + s^2*B(j-2);
    end
    H(i)=dzero/B(L+1);
%  
end
%
lpf=fc;
out1=sprintf(' Bessel Lowpass Filter order=%d fc=%g Hz ',L,lpf);
%
%  Phase
%
figure(fig_num);
fig_num=fig_num+1;

subplot(3,1,1);

theta=angle(H)*180/pi;

plot(fH,theta);
ylim([-180,0]);
set(gca,'MinorGridLineStyle','none','GridLineStyle',':','XScale','log',...
                    'YScale','lin','ytick',[-180,-90,0]);
set(gca,'MinorGridLineStyle','none','GridLineStyle',':','XScale','log','YScale','lin')
ylabel(' Phase(deg) ');
xlabel(' Frequency (Hz) ');
title(out1);
grid on;
%
%  Magnitude
%
subplot(3,1,[2 3]);
plot(fH,abs(H));
set(gca,'MinorGridLineStyle','none','GridLineStyle',':','XScale','log','YScale','log');
grid on;
xlabel(' Frequency (Hz) ');
ylabel(' Magnitude ');

%
figure(fig_num);
fig_num=fig_num+1;

plot(fH,real(H),fH,imag(H));
set(gca,'MinorGridLineStyle','none','GridLineStyle',':','XScale','log','YScale','lin')
ylabel(' Amplitude ');
xlabel(' Frequency (Hz) ');
title(out1);
legend ('real','imaginary');  
grid on;

disp(' ')
disp(' Bessel_lowpass_filter.m  ver 1.0   November 10, 2012')
disp(' by Tom Irvine  Email: tom@vibrationdata.com ')
%
disp(' ');
disp(' Two-pole Bessel lowpass filter. ');
%
close all;
%
fig_num=1;
%
disp(' ');
disp(' The input time history must have two columns: time(sec) & amplitude');
%
[t,y,dt,sr,tmx,tmi,n,ncontinue]=enter_time_history();
%
figure(fig_num)
fig_num=fig_num+1;
plot(t,y);
grid on;
title('Input Signal');
xlabel('Time(sec)');
%
disp(' ');
disp(' The transfer function is -3 dB at the lowpass frequency. ');
disp(' ');
%
while(1)
    fc=input(' Enter lowpass frequency (Hz) ');
    if(fc<sr/2)
        break;
    else
        out1=sprintf('\n Lowpass filter must be < %8.4g Hz \n',sr/2);
        disp(out1);
    end
end
%
scale=1.3617;
OM=tan(pi*fc*dt/scale);
%
OM2=OM^2;
%
den=1+3*OM+3*OM2;
%
b0=3*OM2/den;
b1=2*b0;
b2=b0;
%
a1=2*(-1+3*OM2)/den;
a2=(1-3*OM+3*OM2)/den;
%
out1=sprintf('\n OM=%8.4g ',OM);
out2=sprintf(' b0=%8.4g  b1=%8.4g  b2=%8.4g ',b0,b1,b2);
out3=sprintf(' a1=%8.4g  a2=%8.4g ',a1,a2);
disp(out1);
disp(out2);
disp(out3);
%
forward=[ b0,  b1,  b2 ];
back   =[     1, a1, a2 ];
yf=filter(forward,back,y);
%
figure(fig_num)
fig_num=fig_num+1;
plot(t,yf);
grid on;
out1=sprintf('Lowpass Filtered Signal, fc=%8.4g Hz',fc);
title(out1);
xlabel('Time(sec)');
%
filtered_signal=[t yf];
%'
disp(' ');
disp(' Response array name:  filtered_signal ');
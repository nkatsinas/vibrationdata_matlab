%
%  sine function
%
amp=4;
freq=10;
duration=1;
sample_rate=400;
%
[a]=generate_sine(amp,freq,duration,sample_rate);
%
figure(1);
plot(a(:,1),a(:,2));
xlabel('Time (sec)');
ylabel('Accel (G)');
title('Sine Time History');
ylim([-5,5]);
grid on;

%
%  sine function
%
amp=4;
freq=10;
duration=1;
sample_rate=400;
time_step=1/sample_rate;
number_steps=floor(duration/time_step);
%
a=zeros(number_steps,2);
%
for i=1:number_steps
    time=(i-1)*time_step;
    a(i,1)=time;
    a(i,2)=amp*sin(2*pi*freq*time);
end
%
figure(1);
plot(a(:,1),a(:,2));
xlabel('Time (sec)');
ylabel('Accel (G)');
title('Sine Time History');
ylim([-5,5]);
grid on;
%
%  save array as sine in workspace
%
sine=a;    

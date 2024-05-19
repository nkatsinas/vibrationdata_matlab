%
%  white noise function
%
%  randn() is random with normal distribution
%
amp=4;
freq=10;
duration=20;
sample_rate=2000;
time_step=1/sample_rate;
number_steps=floor(duration/time_step);
%
a=zeros(number_steps,2);
%
for i=1:number_steps
    a(i,1)=(i-1)*time_step;
    a(i,2)=randn();   
end
%
a(:,2)=4*a(:,2)/std(a(:,2));
%
figure(1);
plot(a(:,1),a(:,2));
xlabel('Time (sec)');
ylabel('Accel (G)');
title('White Noise History');
ylim([-20,20]);
grid on;
%
figure(2)      
histogram(a(:,2),31)
ylabel('Counts');
title('Histogram');
xlabel('Accel(G)'); 

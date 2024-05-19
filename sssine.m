clear ylabel;
clear xlabel;

f=1;
T=1/f;
sr=50;
dur = 24;
t1=dur/3;
t2=2*dur/3;
t3=dur;

dt=1/sr;

nt=floor(dur/dt);

t=zeros(nt,1);
a=zeros(nt,1);
b=zeros(nt,1);

for i=1:nt
    
    t(i)=(i-1)*dt;
    
    a(i)=sin(2*pi*t(i)/T);
    b(i)=a(i);
    
    if(t(i)<=t1)
       
        b(i)=1*b(i);
        
    end
    if(t(i)>t1 && t(i)<=t2)
       
        b(i)=4*b(i);
        
    end    
    if(t(i)>t2 && t(i)<=t3)
       
        b(i)=2*b(i);
        
    end    
    
end   

hp=figure(999);


subplot(3,1,1);
plot(t,a);
grid on;
xlabel('Time');
title('Constant Amplitude Loading');
qmax=2;
ylim([-qmax,qmax]);
xlim([0 24]);
ylabel('Stress');
set(gca,'XTick',[],'YTick',[0]);

%
subplot(3,1,2);
plot(t,b);
grid on;
xlabel('Time');
title('Block Amplitude Loading');
qqq=get(gca,'ylim');
qmax=5;
ylim([-qmax,qmax]);
xlim([0 24]);
ylabel('Stress');
set(gca,'XTick',[],'YTick',[0]);

%
subplot(3,1,3);
plot(acc1(:,1),acc1(:,2));
grid on;
xlabel('Time');
ylabel('Stress');
title('Variable Amplitude Loading');
qmax=0.7;
ylim([-qmax,qmax]);
xlim([0 24]);
set(gca,'XTick',[],'YTick',[0]);

set(hp, 'Position', [50 50 750 750]);


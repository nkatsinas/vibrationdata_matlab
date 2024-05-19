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
    
    a(i)=100*sin(2*pi*t(i)/T);
    b(i)=a(i);
    
    if(t(i)<=t1)
       
        b(i)=1*b(i);
        
    end
    if(t(i)>t1 && t(i)<=t2)
       
        b(i)=1.5*b(i);
        
    end    
    if(t(i)>t2 && t(i)<=t3)
       
        b(i)=2*b(i);
        
    end    
    
end   

hp=figure(999);



%
figure(2);
plot(t,b);
grid on;
xlabel('Time');
title('Block Amplitude Loading');
qqq=get(gca,'ylim');
qmax=400;
ylim([-qmax,qmax]);
xlim([0 24]);
ylabel('Stress (MPa');

%



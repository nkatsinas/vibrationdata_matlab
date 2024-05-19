%
close all hidden;
close all;
%
clear t;
clear a;
clear fn;
clear x;
clear y;
clear amp;
clear Q;
clear b;


tpi=2*pi;



%
end_time=input('Enter time (sec)');

sr=20000;
dt=1/sr;

nt=floor(end_time/dt);

t=zeros(nt,1);

for i=1:nt
    t(i)=(i-1)*dt;
end

%
fn=zz_Q10_b4(:,1);

y1=zz_Q10_b4(:,2);  
y2=zz_Q10_b8(:,2);  
y3=zz_Q30_b4(:,2);  
y4=zz_Q30_b8(:,2);  


%
nf=length(fn);
%                  

a=zeros(nt,1);
x=zeros(nt,1);

[a,fds]=fds_synth3(y1,y2,y3,y4,fn,nf,dt,a,T,t);

new_th=[t a];

new_fds=fds;


figure(1)
plot(t,a);
xlabel('Time (sec)');
ylabel('Accel (G)');
grid on;

fig_num=2;

FS21=[fds(:,1) fds(:,2)];
FS22=[fds(:,1) fds(:,3)];
FS23=[fds(:,1) fds(:,4)];
FS24=[fds(:,1) fds(:,5)];

y1=[fn y1];
y2=[fn y2];
y3=[fn y3];
y4=[fn y4];

xmin=20;
xmax=2000;

[fig_num]=plot_fds_subplots_2x2_two_curves(fig_num,y1,y2,y3,y4,FS21,FS22,FS23,FS24,xmin,xmax);

std(new_th(:,2))


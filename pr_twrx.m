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

fig_num=1;

tpi=2*pi;

%
t=M6_AC_6325_th_bpf_abs(:,1);
a=M6_AC_6325_th_bpf_abs(:,2);
nt=length(t);


%
end_time=60;

[~,i]=min(abs(t-end_time));

t=t(1:i);

nt=length(t);
T=t(end)-t(1);
dt=T/(nt-1);

%
fn=M6_AC_6325_th_bpf_abs_fds_Q10_b4(:,1);

y=zz_567_Q10_b4_max(:,2);  

%
nf=length(fn);
%                  

Q=10;
b=4;

a=zeros(nt,1);
x=zeros(nt,1);

[a,fds]=fds_synth2(Q,b,x,y,fn,nf,dt,a,T,t);

new_th=[t a];

new_fds=fds;


figure(1)
plot(t,a);
xlabel('Time (sec)');
ylabel('Accel (G)');
grid on;


iu=1;
bex=b;
x_label='Natural Frequency (Hz)';
y_label='Damage';
ppp=[fn y];
qqq=new_fds;
leg_a='y';
leg_b='x';
nmetric=1;

fig_num=2;
[fig_num,h2]=plot_fds_two_h2(fig_num,x_label,y_label,ppp,qqq,leg_a,leg_b,Q,bex,iu,nmetric);





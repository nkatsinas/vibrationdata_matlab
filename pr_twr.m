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
ax=a;
%
nt=length(t);
T=t(end)-t(1);
dt=T/(nt-1);
%
fn=M6_AC_6325_th_bpf_abs_fds_Q10_b4(:,1);

x=M6_AC_6325_th_bpf_abs_fds_Q10_b4(:,2);
y=z567_fds_Q10_b4_max(:,2);  

%
nf=length(fn);
%
                      

Q=10;
b=4;

[a,fds]=fds_synth(Q,b,x,y,fn,nf,dt,a,T,t);


new_th=[t a];

data1=[t ax];
data2=[t a];
xlabel2=('Time (sec)');
ylabel1=('Accel (G)');
ylabel2=('Accel (G)');

t_string1='Input Time History';
t_string2='Modified Time History';

[fig_num]=subplots_two_linlin_two_titles_scale_same(fig_num,xlabel2,ylabel1,ylabel2,data1,data2,t_string1,t_string2);




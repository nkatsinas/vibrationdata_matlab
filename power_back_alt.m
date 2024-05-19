


clear a;
clear f;
clear spl;
clear pressure;
clear intensity;
clear power;
clear Lwb;

%%

a=[20	122.7
25	125.1
31.5	129
40	133.4
50	138.3
63	143
80	148.3
100	153.4
125	156.7
160	157.6
200	157.2
250	155.9
320	153.8
400	153.9
500	155.8
640	158.2
800	161.1
1000	163.2
1250	164.4
1600	163.7
2000	160.9];

f=a(:,1);
spl=a(:,2);

n=length(f);

pressure=zeros(n,1);
intensity=zeros(n,1);
power=zeros(n,1);
Lwb=zeros(n,1);

refa=20e-06;
refb=1.0e-12;

rhoc=415;       % Pa sec/m

m_per_inch=0.0254;

r=41+24;

r=r*m_per_inch;

for i=1:n
    pressure(i)=refa*10^(spl(i)/20);
    intensity(i)=(pressure(i))^2/rhoc;
    power(i)=2*pi*r^2*intensity(i);
    Lwb(i)=10*log10(power(i)/refb);
end

ppp=[f Lwb];

fig_num=1;

fmin=20;
fmax=2000;

x_label='Center Frequency (Hz)';
y_label='Power (dB)';
t_string='Sound Power';

[fig_num,h2]=...
    plot_loglin_function_h2(fig_num,x_label,y_label,t_string,ppp,fmin,fmax);
ylim([130,180]);

[oadb]=oaspl_function(Lwb)


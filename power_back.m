


clear a;
clear f;
clear spl;
clear pressure;
clear intensity;
clear power;
clear Lwb;
clear NN;
clear normalized_power;

clear X;
clear Y;

m_per_inch=0.0254;
N_per_lbf = 4.448;

F=15000;


Ue=12000*12;
de=25.6;

F=F*N_per_lbf;
Ue=Ue*m_per_inch;
de=de*m_per_inch;


aeff=0.01;

MP=F*Ue;

WOA=0.5*aeff*MP;

LW=10*log10(WOA)+120;

outp5=sprintf('\n overall acoustic power level LW = %8.4g dB ',LW);
outp6=sprintf(' Ref = 1.0e-12 Watts \n');  

disp(outp5);
disp(outp6);

%%


% smooth

asmooth=[20	122.7
25	125.1
31.5	129
40	133.4
50	138.3
63	143
80	148.3
100	153.4
125	156.7
160	157.6
1250	164.4
1600	163.7
2000	160.9
4000	154.9];

% rough

arough=[20	122.7
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



a=asmooth;


f=a(:,1);
spl=a(:,2)-3;

n=length(f);

pressure=zeros(n,1);
intensity=zeros(n,1);
power=zeros(n,1);
Lwb=zeros(n,1);
X=zeros(n,1);
Y=zeros(n,1);


refa=20e-06;
refb=1.0e-12;

rhoc=415;       % Pa sec/m



r=41+24;

r=r*m_per_inch;

for i=1:n
    pressure(i)=refa*10^(spl(i)/20);
    intensity(i)=(pressure(i))^2/rhoc;
    power(i)=2*pi*r^2*intensity(i);
    Lwb(i)=10*log10(power(i)/refb);
    Lwb(i)=Lwb(i)+2.7;

%% 		Lwb(i)= 10*log10(amp(i)/ref) +LW -10*log10(U/de) +10*log10(df);    
    
    df = ((2^(1/6))-1/(2^(1/6)))*f(i);

    qq=Lwb(i)-LW +10*log10(Ue/de)-10*log10(df);
    
    
%%    10*log10(amp(i)/ref) = qq
  
    Y(i)=qq;
    X(i)=f(i)*de/Ue;


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


NN=[X Y];

fmin=X(1);
fmax=X(end);

x_label='Strouhal Number (fde/Ue)';
y_label='Sound Power Level [(W(f)/WOA)(Ue/de)] (dB)';
t_string='Normalized Relative Sound Power Landing';

[fig_num,h2]=...
    plot_loglin_function_h2_yfree(fig_num,x_label,y_label,t_string,NN,fmin,fmax);

normalized_power=NN;

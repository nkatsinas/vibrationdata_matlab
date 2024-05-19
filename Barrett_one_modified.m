

fig_num=1;


% THM=evalin('base',FS);

pr1=[0.0200;
    0.0250;
    0.0315;
    0.0400;
    0.0500;
    0.0630;
    0.0800;
    0.1000;
    0.1250;
    0.1600;
    0.2000;
    0.2500;
    0.3150;
    0.4000;
    0.5000;
    0.6300;
    0.8000;
    1.0000;
    1.2500;
    1.6000;
    2.0000]*1000;

pr2=[136.0000;
  138.1000;
  140.1165;
  141.6000;
  142.8000;
  144.0438;
  145.4000;
  146.5000;
  146.6000;
  146.1000;
  145.4000;
  144.6000;
  143.8000;
  142.9000;
  142.2000;
  141.5000;
  140.6000;
  139.8000;
  138.6000;
  137.0000;
  135.7000];

pr=[pr1 pr2];

pr(1,:)=[];
pr(1,:)=[];
pr(1,:)=[];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% p31

pn=[20	134.2
25	135.1
31.5	137
40	137.7
50	137.8
63	138
80	138.5
100	138.5
125	138
160	137.6
200	136.9
250	135.9
315	135.1
400	134.7
500	133.6
630	132.7
800	132
1000	131
1250	129.4
1600	128
2000	127];

pn(1,:)=[];
pn(1,:)=[];
pn(1,:)=[];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Gr1=[ 25;
          40;
          50;
          63;
          80;
         100;
         125;
         160;
         200;
         250;
         315;
         400;
         500;
         630;
         800;
        1000;
        1250;
        1600;
        2000];

Gr2=[0.4737;
    2.1353;
    3.4169;
    6.8879;
    7.2995;
    4.2188;
    6.2926;
    5.8599;
   10.0000;
    6.5907;
    5.9976;
    4.0038;
    1.7735;
    2.2725;
    2.2320;
    1.1185;
    0.8878;
    1.0549;
    1.0549];    
    

Gr=[Gr1 Gr2];

Gr(1,:)=[];


    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% mass per area   lbm/ft2

rhor=1.12;   
rhon=1.942; 

rho_ratio=rhor/rhon;

sqrt_F=1;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

sz=size(Gr);

N=sz(1);

Gn=zeros(N,2);

Gn(:,1)=Gr(:,1);


for i=1:N
    
   delta_dB=pn(i,2)-pr(i,2);
   
   p_ratio=10^(delta_dB/20);
   
   R=p_ratio*sqrt_F;
   
   Gn(:,2)=Gr(:,2)*R^2*rho_ratio;
    
end

clear leg1
clear leg2

clear grms_r
clear grms_n


fn=Gn(:,1);
an=Gn(:,2);

fr=Gr(:,1);
ar=Gr(:,2);


[~,grms_n] = calculate_PSD_slopes(fn,an);
[~,grms_r] = calculate_PSD_slopes(fr,ar);



md=5;

fmin=Gn(1,1);
fmax=Gn(N,1);


%%%%%

x_label='Center Frequency (Hz)';
y_label='SPL (dB)';
t_string='One-Third Octave SPL';

ppp1=pr;
ppp2=pn;


[oadB_n]=overall_dB(pn(:,2));
[oadB_r]=overall_dB(pr(:,2));


leg2=sprintf('USA P31 Liftoff  %6.3g dB OASPL',oadB_n);
leg1=sprintf('Saturn V Reference  %6.3g dB OASPL',oadB_r);

[fig_num,h2]=plot_loglin_function_two_NW_h2(fig_num,x_label,...
               y_label,t_string,ppp1,ppp2,leg1,leg2,fmin,fmax);

%%%%%           

x_label='Frequency (Hz)';
y_label='Accel (G^2/Hz)';
t_string='Power Spectral Density Curves';

leg2=sprintf('USA P31 Liftoff  %7.3g GRMS',grms_n);
leg1=sprintf('Static Fire  %7.3g GRMS',grms_r);

ppp1=Gr;
ppp2=Gn;



[fig_num,h2]=plot_loglog_function_md_two_h2(fig_num,x_label,...
               y_label,t_string,ppp1,ppp2,leg1,leg2,fmin,fmax,md);


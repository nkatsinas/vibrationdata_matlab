fig_num=10;

winlen=8192;
winlen=4096;

[frf,f,coh] = modalfrf(x,y,fs,hann(winlen),0.5*winlen,'Sensor','vel');

H=frf*386;

md=4;
freq=f;
fmin=10;
fmax=200;
t_string='Mobility';
y_label='Magnitude ((in/sec)/lbf)';

[fig_num]=plot_frf_md(fig_num,freq,H,fmin,fmax,t_string,y_label,md);

ymin=0;
ymax=1.1;
ppp=[f coh];
x_label='Frequency (Hz)';
t_string='Coherence';
[fig_num,h2]=...
    plot_loglin_function_h2_ymax_coherence(fig_num,x_label,t_string,ppp,fmin,fmax,ymin,ymax);


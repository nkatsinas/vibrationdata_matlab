
%
%   psd_function.m  ver 1.2  by Tom Irvine
%
%   This script calculates the power spectral density of a time history
%   using the FFT method.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%   Input variables:
%
%     mr - mean removal - 1=yes  2=no
%     window - 1=rectangular  2=Hanning
%
%         Hanning window recommended for stationary vibration.
%         Use rectangular otherwise.
%
%     t1 & t2 - start and end times (sec) respectively
%
%     df  - desired frequency step (Hz) 
%           the script will come as close to this step as possible 
%
%     THM - time history - two columns - time(sec) & amplitude(unit)
%
%     ylab - time history amplitude such as 'G'
%
%     fmin - minimum plot frequency (Hz)
%     fmax - maximum plot frequency (Hz)
%
%        The maximum plot frequency should be <= Nyquist frequency
%        The Nyquist frequency is one-half the sample rate
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%   Output variables:
%
%     power spectral density - two columns - freq(Hz) & psd(unit^2/Hz)
%     rms - overall rms level
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%   External functions:
%
%     FFT_core
%     psd_core
%     fix_size
%     plot_loglog_function_md
%     xtick_label
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function[power_spectral_density,rms]=...
                                psd_function(mr,window,t1,t2,df,THM,ylab,fmin,fmax)
%

[~,i]=min(abs(t1-THM));
[~,j]=min(abs(t2-THM));

THM=THM(i:j,:);

tdif=diff(THM(:,1));

min_dt=min(tdif);
max_dt=max(tdif);

ratio=abs((max_dt-min_dt)/max_dt);

if(ratio>0.05)
    fprintf('\n\n min_dt=%8.4g  max_dt=%8.4g \n\n',min_dt,max_dt);
    warndlg('Time step must be constant');
    return;
end

t=THM(:,1);
amp=THM(:,2);

%%%%%

n=length(t);

dur=t(end)-t(1);
nj=floor(log2(n));

njt=min([12 nj]);

    num_seg=zeros(njt,1);
   time_seg=zeros(njt,1);
samples_seg=zeros(njt,1);
        ddf=zeros(njt,1);

for i=1:njt
    num_seg(i)=2^(i-1);
    time_seg(i)=dur/num_seg(i);
    samples_seg(i)=floor(n/num_seg(i));
    ddf(i)=1/time_seg(i);
end    

[~,nv]=min(abs( ddf-df));

NW=num_seg(nv);
mmm=samples_seg(nv);

% fprintf('\n NW=%d  statdof=%d  df=%8.4g Hz  \n\n',NW,NW*2,ddf(nv));
fprintf('\n Statistical degrees-of-freedom = %d \n frequency step =  %8.4g Hz \n ',NW*2,ddf(nv));

[freq,full,rms]=psd_core(mmm,NW,mr,window,amp,ddf(nv));

power_spectral_density=[freq full]; 

if(strcmp(ylab,'G'))
    ss=sprintf(' Overall %sRMS = %7.3g',ylab,rms);
else
    ss=sprintf(' Overall %s RMS = %7.3g',ylab,rms);
end

fig_num=1; 
md=6;
ppp=power_spectral_density;
x_label='Frequency (Hz)';
y_label=ylab;
t_string=sprintf('Power Spectral Density   %s',ss);

plot_loglog_function_md(fig_num,x_label,y_label,t_string,ppp,fmin,fmax,md);


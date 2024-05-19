%
%  PSD_syn_scale_time_history.m  ver 1.3  by Tom Irvine
%
function[TT,psd_th,dt]=PSD_syn_scale_time_history(psd_th,grms,np,tmax)
%
clear TT;
clear new_TT;
clear new_psd_th;
%
dt=tmax/(np-1);
TT=linspace(0,(np-1)*dt,np);
%
psd_th=detrend(psd_th);
%


out5 = sprintf('\n scale time history \n');
disp(out5)   

out4=sprintf(' np=%d  np*dt=%8.4g\n',np,np*dt);
disp(out4);

%
%  scale th
%
mu=mean(psd_th);
stddev=std(psd_th);
grmsout = sqrt(mu^2+stddev^2);
%
scale=grms/grmsout;
psd_th=psd_th*scale;

%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  Output
%
mu=mean(psd_th);
sd=std(psd_th);
mx=max(psd_th);
mi=min(psd_th);
rms=sqrt(sd^2+mu^2);
%
disp(' ')
n=length(psd_th);
out0 = sprintf(' number of points = %d ',n);
out1 = sprintf(' mean = %8.4g    std = %8.4g    rms = %8.4g \n',mu,sd,rms);
out2 = sprintf(' max  = %9.4g  ',mx);
out3 = sprintf(' min  = %9.4g  \n',mi);
%
disp(out0);
disp(out1);
disp(out2);
disp(out3);
%
disp(' ')
%
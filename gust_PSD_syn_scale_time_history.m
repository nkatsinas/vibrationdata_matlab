%
%  gust_PSD_syn_scale_time_history.m  ver 1.1  August 13, 2014
%
function[TT,psd_th]=gust_PSD_syn_scale_time_history(psd_th,grms,nL,dt,tmax)
%
clear TT;
TT=linspace(0,nL*dt,nL);
%
clear new_TT;
clear new_psd_th;
%
if(max(TT)>tmax)
    nnn=round(tmax/dt);
    new_TT=TT(1:nnn);
    new_psd_th=psd_th(1:nnn);
%
    clear TT;
    clear psd_th;
%
    TT=new_TT;
    psd_th=new_psd_th;
%
end
%
psd_th=detrend(psd_th);
%
out5 = sprintf('\n scale time history ');
disp(out5)   
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
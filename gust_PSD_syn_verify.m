%
%  gust_PSD_syn_verify.m  ver 1.0  November 15, 2012
%
function[freq,amp,NW,df,mr_choice,h_choice,den,mH]=...
                         gust_PSD_syn_verify(TT,psd_th,spec_grms,dt,fstart)
%
disp(' ')
disp(' PSD Calculation ');
%
mr_choice=1;  % mean removal yes
%
h_choice=2;   % Hanning Window
%
amp=double(psd_th);
%
n = length(amp);
%
tim=double(TT(1:n));
tim=tim';
%
mu=mean(amp);
sd=std(amp);
rms=sqrt(sd^2+mu^2);
%
disp(' ')
disp(' Input Time History Statistics ')
disp(' ')
tmx=max(tim);
tmi=min(tim);
% 
out3 = sprintf(' start  = %g sec    end = %g sec            ',tmi,tmx);
disp(out3)
%
out0 = sprintf(' number of points = %d ',n);
out1 = sprintf(' mean = %8.4g    std = %8.4g    rms = %8.4g ',mu,sd,rms);
disp(out0)
disp(out1)
%
disp(' ')
disp(' Time Step ');
dtmin=min(diff(tim));
dtmax=max(diff(tim));
%
out4 = sprintf(' dtmin  = %8.4g sec  ',dtmin);
out5 = sprintf(' dt     = %8.4g sec  ',dt);
out6 = sprintf(' dtmax  = %8.4g sec  ',dtmax);
disp(out4)
disp(out5)
disp(out6)
%
disp(' ')
disp(' Sample Rate ');
out4 = sprintf(' srmin  = %8.4g samples/sec  ',1/dtmax);
out5 = sprintf(' sr     = %8.4g samples/sec  ',1/dt);
out6 = sprintf(' srmax  = %8.4g samples/sec  \n',1/dtmin);
disp(out4)
disp(out5)
disp(out6)
%
if(((dtmax-dtmin)/dt)>0.01)
    disp(' ')
    disp(' Warning:  time step is not constant. ');
end
%
%%%%%%%%%%%%%%%  advise
%
[df,mmm,NW]=gust_PSD_advise(dt,n,fstart);
%
%%%  begin overlap
%
mH=((mmm/2)-1);
%
amp=amp*(spec_grms/std(amp));
%
clear length;
%
%
fmax=(mH-1)*df;
freq=linspace(0,fmax,mH);
%
den=df*(2*NW-1);
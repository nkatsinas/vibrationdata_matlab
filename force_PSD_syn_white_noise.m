%
%  force_PSD_syn_white_noise.m  ver 1.2  May 10, 2014
%
function[np,noct,dt,df,white_noise,tw]=force_PSD_syn_white_noise(tmax,dt)
%
disp(' ');
disp(' Generate White Noise ');
%
np=ceil(tmax/dt);
noct=ceil(log(np/2)/log(2));
np=2^noct;
dt=tmax/(np-1);
df=1/(np*dt);
%
white_noise=randn(np,1);
%
white_noise=fix_size(white_noise);
%
white_noise=white_noise-mean(white_noise);
%
tw=linspace(0,(np-1)*dt,np); 
%
disp(' ');
disp(' Adjusted parameters ');
out5 = sprintf('\n samples = %g',np);
disp(out5);
out5 = sprintf('\n dt = %g sec',dt);
disp(out5);
out5 = sprintf('\n df = %g Hz',df);
disp(out5);
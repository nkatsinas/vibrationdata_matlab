%
%  PSD_syn_white_noise_seed.m  ver 1.2  April 21, 2014
%
function[np,white_noise,tw]=PSD_syn_white_noise(tmax,dt,np,nseed)
%
%% disp(' ');
%% disp(' Generate White Noise ');
%



white_noise=randn(np,1);
%
white_noise=fix_size(white_noise);
%
white_noise=white_noise-mean(white_noise);
%
tw=linspace(0,(np-1)*dt,np); 
%
%% disp(' ');
%% disp(' Adjusted parameters ');
%% out5 = sprintf('\n samples = %g',np);
%% disp(out5);

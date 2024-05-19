%
%  PSD_syn_white_noise_seed.m  ver 1.3  by Tom Irvine  
%
function[np,white_noise,tw]=PSD_syn_white_noise_seed(dt,np,nseed)
%
disp(' ');
disp(' Generate White Noise ');

if(nseed==1)
    rng(1);
end

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

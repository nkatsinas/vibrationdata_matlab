%
%  gust_PSD_syn_white_noise.m  ver 1.1  August 13, 2014
%
function[np,np2,noct,mmm,m2,N,df,white_noise,tw]=...
                                          gust_PSD_syn_white_noise(tmax,dt)
%
np=ceil(tmax/dt);
out5 = sprintf('\n samples = %g',np);
disp(out5)
%     
np2=4*np;
[white_noise] = psd_syn_white(dt,tmax,np2);   
white_noise=fix_size(white_noise);
%
tw=linspace(0,(np2-1)*dt,np2); 
%
noct=floor(log(np2/2)/log(2));
mmm=2^noct;
m2=fix(mmm/2);
%
N=mmm;
df=1./(N*dt);
out5 = sprintf('\n df = %g Hz',df);
disp(out5)
%
%   simple_white_noise_filtered.m  ver 1.1  by Tom Irvine
%
%   This script generates a band-limited white noise time history which 
%   has a normal distribution
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  Input variables
%
%      mu = mean
%   sigma = standard deviation
%     dur = duration
%      sr = sample rate (Hz)
%    freq = low-pass filter cut-off frequency, Butterworth 6th order
%           Must be < than one-half the sample rate 
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  Output variables
%
%      X = white noise time history: time(sec) & amplitude
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  External function
%
%    Butterworth_filter_function.m 
%
%    freq = filter frequency for low or high-pass
%         = array with two frequencies for band-pass with lower & upper
%           frequencies in any order
%
%    iband:   1=low-pass  2=high-pass  3=band-pass 
%
%    iphase=1  for refiltering for phase correction
%          =2  for no refiltering
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
function[X]=simple_white_noise_filtered(mu,sigma,dur,sr,freq)

dt=1/sr;
nt=floor(dur/dt);

if(freq<sr/2)

    X=randn(nt,1)';

    iband=1;
    iphase=2;
    [X,~,~,~]=Butterworth_filter_function(X,dt,iband,freq,iphase);
    
    t=(0:nt-1)*dt;
    
    X=X-mean(X);
    X=X*sigma/std(X);
    X=X+mu;
    
    X=[t' X'];
    
else
    disp(' Filter frequency must be < one-half sample rate '); 
end
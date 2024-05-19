%
%   simple_white_noise_LPF.m  ver 1.1  by Tom Irvine
%
%   This script generates a white noise time history which has a 
%   normal distribution
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  Input variables
%
%      mu = mean
%   sigma = standard deviation
%      nt = number of points
%       f = low-pass filter cut-off frequency, Butterworth 6th order
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  Output variables
%
%     X = white noise time history amplitude array
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
function[X]=simple_white_noise_LPF(mu,sigma,nt,dt,f)


X=randn(nt,1);
X=fix_size(X);
%
X=X-mean(X);
X=X*sigma/std(X);
X=X+mu;

[X]=simple_Butterworth_LP_filter_function(X,dt,f);

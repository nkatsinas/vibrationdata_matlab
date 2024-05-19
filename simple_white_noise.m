%
%   simple_white_noise.m  ver 1.1  by Tom Irvine
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
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  Output variables
%
%     X = white noise time history amplitude array
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
function[X]=simple_white_noise(mu,sigma,nt)

X=randn(nt,1);

X=X-mean(X);
X=X*sigma/std(X);
X=X+mu;
%
%  mean_filter_function.m  ver 1.1  by Tom Irvine
%
%  mean filter of a time history
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  Input Variables
%
%            y = time history amplitude
%        npass = number of passes
%   windowSize = window size
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  Output Variable
%
%     mf = mean filtered time history amplitude
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
function[mf]=mean_filter_function(y,npass,windowSize)
    
b = (1/windowSize)*ones(1,windowSize);
a = 1;

for m=1:npass
    mf = filter(b,a,y);
    y=mf;  
end

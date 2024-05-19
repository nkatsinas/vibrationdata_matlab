% 
%    Butterworth_LP_filter_function.m   ver 2.4   by Tom Irvine 
% 
%    Butterworth filter, sixth-order, infinite impulse response,
%    cascade without phase correction               
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%    Input variables
%      
%       x = input amplitude
%      dt = time step (sec)
%       f = low-pass filter frequency (Hz)
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%    Output variables
%
%      y = response amplitude
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%    External functions
%
%       simple_filter_coefficients.m
%       simple_apply_filter.m
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
function[y]=simple_Butterworth_LP_filter_function(x,dt,f)

ns=length(x); 
%
iband=1;
%
iflag=1;
%
%****** calculate coefficients *******
%
[a,b,iflag] = simple_filter_coefficients(f,dt,iband,iflag);
%
if(iflag < 900 )
    [y]=simple_apply_filter(x,iphase,ns,a,b);
else
    disp('  Abnormal termination.  No output file generated. ');
end
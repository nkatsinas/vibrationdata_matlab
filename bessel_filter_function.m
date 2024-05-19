
% bessel_filter_function.m  ver 1.0  by Tom Irvine

%  This function performs a Bessel filter on an input time history
%
%  Input variables
%
%     fc = filter frequency
%     dt = time step, must be constant
%      y = input amplitude 1D array
%
%  Output arrays
%  
%    lpf = low pass filtered amplitude, direct
%    hpf = high pass filtered amplitude, indirect
%

function[lpf,hpf]=bessel_filter_function(fc,dt,y)

%
%  Calculate filter coefficients
%
scale=1.3617;
OM=tan(pi*fc*dt/scale);
% 
OM2=OM^2;
%
den=1+3*OM+3*OM2;
%
b0=3*OM2/den;
b1=2*b0;
b2=b0;
%
a1=2*(-1+3*OM2)/den;
a2=(1-3*OM+3*OM2)/den;
%
%  Apply filter
%
forward=[ b0,  b1,  b2 ];
back   =[     1, a1, a2 ];
yf=filter(forward,back,y);
%

lpf=yf;
hpf=(y-yf);
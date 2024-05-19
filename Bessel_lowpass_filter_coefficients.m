%
%  Bessel_lowpass_filter_coefficients.m  ver 1.0  November 12, 2012
%
function[a1,a2,b0,b1,b2]=Bessel_lowpass_filter_coefficients(fc,dt,scale)
%
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
out1=sprintf('\n OM=%8.4g ',OM);
out2=sprintf(' b0=%8.4g  b1=%8.4g  b2=%8.4g ',b0,b1,b2);
out3=sprintf(' a1=%8.4g  a2=%8.4g ',a1,a2);
disp(out1);
disp(out2);
disp(out3);
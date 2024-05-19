%
%   time_format_conversion.m  ver 1.0  by Tom Irvine
%
function[y,d,h,m,s]=time_format_conversion(tsec)

dsec=3600*24;
ysec=dsec*365;

y=floor(tsec/ysec);
d=floor((tsec-y*ysec)/dsec);

h=floor((tsec-y*ysec-d*dsec)/3600);
m=floor((tsec-y*ysec-d*dsec-h*3600)/60);
s=floor( tsec-y*ysec-d*dsec-h*3600-m*60);

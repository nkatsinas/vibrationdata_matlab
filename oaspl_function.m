%
%  oaspl_function.m  ver 1.2  by Tom Irvine
%
%  The script calculates the overall level for a sound pressure level
%  or any other function expressed in terms of dB.
%
%  The input is a 1D array of dB values
%
%  The output oadB is the overall level in dB.
%
%
function[oadB]=oaspl_function(dB)

oadB=10*log10(sum(10.^(dB/10)));  % Do not change!


%
%  overall_dB.m  ver 1.1  by Tom Irvine
%
function[oadB]=overall_dB(dB)
%
ms = 10.^(dB / 10);
oadB = 10 * log10(sum(ms));

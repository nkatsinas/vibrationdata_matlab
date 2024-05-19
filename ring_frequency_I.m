%
%   ring_frequency_I.m  ver 1.0  by Tom Irvine
%
function[fr,CL]=ring_frequency_I(em,md,d)
%
CL=sqrt(em/md);
%
fr=CL/(pi*d);
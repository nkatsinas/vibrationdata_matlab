
% max_min_times.m  ver 1.0  by Tom Irvine

function[tt_max,tt_min,mx,mi]=max_min_times(TT,amp)
%
    [mx,I]=max(amp);
    tt_max=TT(I);
%
    [mi,I]=min(amp);
    tt_min=TT(I);   
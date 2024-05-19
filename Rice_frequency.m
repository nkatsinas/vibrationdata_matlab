
% Rice_frequency.m  ver 1.0  by Tom Irvine

function[rf]=Rice_frequency(amp,dt)

[v]=differentiate_function(amp,dt);
rf=(std(v)/std(amp))/(2*pi);
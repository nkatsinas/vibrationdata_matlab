%
%  integrate_function.m  ver 1.4  by Tom Irvine
%
%  This script integrates a time history using the trapezodial rule.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  Input variables
%
%     y = input amplitude
%    dt = time step (sec) must be constant
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  Output variables
%
%    v = integrated amplitude 
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
function[v]=integrate_function(y,dt)
%
v=dt*cumtrapz(y);

if size(v, 2) > size(v, 1)
    v = v.';
end
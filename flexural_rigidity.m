%
%   flexural_rigidity.m  ver 1.0  by Tom Irvine
%
function[D]=flexural_rigidity(em,thick,mu)

D=em*thick^3/(12*(1-mu^2));
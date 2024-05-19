
% plate_bending_stiffness2.m  ver 1.0  by Tom Irvine

function[D,K]=plate_bending_stiffness2(E,t,mu)

D=E*(t^3)/(12*(1-mu^2));

K=E*t/(1-mu^2);
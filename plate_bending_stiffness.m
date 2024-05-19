
% plate_bending_stiffness.m  ver 1.0  by Tom Irvine

function[D]=plate_bending_stiffness(E,t,mu)

D=E*(t^3)/(12*(1-mu^2));
%
%   beam_bending_phase_speed.m  ver 1.0  by Tom Irvine
%
function[CB]=beam_bending_phase_speed(em,I,md,omega,area)


    num=em*I*omega^2;
    den=md*area;
    
    CB=( num/den )^(1/4);
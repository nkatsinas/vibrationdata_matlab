%
%   plate_bending_phase_speed_D.m  ver 1.0  by Tom Irvine 
%
%
%     D=flexural rigidity
%   mpa=mass/area
%    cb=bending wave phase speed
%
function[cb]=plate_bending_phase_speed_D(D,mpa,omega)
% 
cb=( (D/mpa)^(1/4))*sqrt(omega);   
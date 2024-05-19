%
%  crossover_frequency_thick_plate.m  ver 1.0  by Tom Irvine
%
%
%  Reference:  
%
%  R. Jones, Field Sound Insulatino of Load-Bearing Sandwich Panels
%  for Housing, Noise Control Engineering, March-April 1981.
%  Equation 12.  This equation is primarily for thick plates, but can
%  be adapted for sandwich panels.
%
function[fcross]=crossover_frequency_thick_plate(c,mu,rho,em,fcr)
%
G=em/(2*(1+mu));
%
Cs=sqrt(G/rho);

fcross=fcr*(Cs/c);
%
%  sea_beam_modal_density.m  ver 1.0 by Tom Irvine
%
function[beam_md,cbeam]=sea_beam_modal_density(MOI,A,em,md,freq,L)

tpi=2*pi;

k=sqrt(MOI/A);

cbeam=sqrt(em/md);

den=sqrt(tpi*freq*k*cbeam);
beam_md=L/den;
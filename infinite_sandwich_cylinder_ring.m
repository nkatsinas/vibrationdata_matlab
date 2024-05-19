%
%  infinite_sandwich_cylinder_ring.m  ver 1.0  by Tom Irvine
%
function[fring]=infinite_sandwich_cylinder_ring(K,mpa,diam)                         
                         
fring=(1/pi)*sqrt((K/diam^2)/mpa);

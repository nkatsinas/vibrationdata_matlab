

% aerodynamic_coincident_frequency.m  ver 1.0  by Tom Irvine

function[fc,omegac]=aerodynamic_coincident_frequency(Uc,mpa,diam)

omegac=Uc^2*sqrt(mpa/diam);

fc=omegac/(2*pi);

%
%    Renji_modal_density.m  ver 1.0  by Tom Irvine
%
%    Honeycomb sandwich panel
%
function[mdens]=Renji_modal_density(omega,Ap,S,D,mp)
  
tpi=2*pi;
  
f=omega/tpi;

S2=S^2;
    
om2=omega^2;
om4=omega^4;
mp2=mp^2;
T1=pi*Ap*mp*f/S;
Tn=mp*om2 + (2*S2/D);
Td=mp2*om4+(4*mp*om2*S2)/D;
    
mdens= T1*(1+ Tn/sqrt(Td));
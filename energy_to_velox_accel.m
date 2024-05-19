%
%   energy_to_velox_accel.m  ver 1.0  by Tom Irvine
%

function[velox,accel]=energy_to_velox_accel(energy,mass,omega)


NL=length(omega);

velox=zeros(NL,1);
accel=zeros(NL,1);

for i=1:NL
    velox(i)=sqrt(energy(i)/mass);
    accel(i)=velox(i)*omega(i);
end
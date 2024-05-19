%
%   energy_to_velox_accel_alt.m  ver 1.0  by Tom Irvine
%

function[velox,accel,v_label,vpsd_label]=...
                            energy_to_velox_accel_alt(iu,energy,mass,omega)

NL=length(omega);

velox=zeros(NL,1);
accel=zeros(NL,1);

for i=1:NL
    velox(i)=sqrt(energy(i)/mass);
    accel(i)=velox(i)*omega(i);
end

if(iu==1)
    v_label='in/sec';
    vpsd_label='Vel [(in/sec)^2/Hz]';
    
    accel=accel/386;
else
    v_label='mm/sec';
    vpsd_label='Vel [(mm/sec)^2/Hz]'; 
    
    velox=velox/1000;
    accel=accel/9.81;
end
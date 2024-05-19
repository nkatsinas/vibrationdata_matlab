%
%  characteristic_impedance.m  ver 1.0  by Tom Irvine
%

function[ri]=characteristic_impedance(m)
%
if(m==1) % air 0 deg c
    ri=428;       
end
if(m==2) % air 20 deg c
    ri=415;         
end
if(m==3) % water fresh
    ri=1.48e+06;         
end
if(m==4) % water sea
    ri=1.54e+06;         
end
if(m==5) % steam 
    ri=242;         
end
if(m==6) % ice 
    ri=2.95e+06;         
end
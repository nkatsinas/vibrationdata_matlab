%
%   re_thin_plate_free.m  ver 1.0  by Tom Irvine
%
%   radiation efficiency thin plate all edges free
%
%    a = smallest of length & width
%    b = largest of length & width
%    c = speed of sound
%    fcr = critical frequency
%
function[rad_eff]=re_thin_plate_free(freq,fcr,a,b,c)

P=2*a+2*b;
S=a*b;

fb=fcr+5*c/P;
f2=4*fb;


%%%

a1=P*c/(pi^2*S*fcr);
a2=sqrt(fcr/fcr);
rad_eff_2=a1*a2;

%%%



if(freq<=fb)
    a1=P*c/(pi^2*S*fcr);
    a2=sqrt(freq/fcr);
    rad_eff=a1*a2;
end
if(freq>fb);
    rad_eff=1/sqrt(1-(fcr/freq));
end

    
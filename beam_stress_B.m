

%  beam_stress_B  ver  1.1  by Tom Irvine
%
%  s is the elemental position fraction
%
%  0 <= s <=1   

function[B]=beam_stress_B(s,L)

% http://web.mae.ufl.edu/nkim/eml5526/Lect05.pdf

B(1)=-6+12*s;
B(2)=L*(-4+6*s);
B(3)=-B(1);
B(4)=L*(-2+6*s);

B=B/L^2;
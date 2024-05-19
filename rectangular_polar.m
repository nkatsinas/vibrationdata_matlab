
%  rectangular_polar.m  ver 1.0  by Tom Irvine

% Roark's Formulas for stress & Strain, 7th Edition, Warren C. Young

function[J]=rectangular_polar(width,thick)

a=max([ width, thick ]);
b=min([ width, thick ]);

ratio=b/a;

term=1-(ratio^4)/12;

J=(a*b^3)*((1/3)-0.21*ratio*term);
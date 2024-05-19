
%  beam_rectangular_hollow_geometry_alt.m  ver 1.0  by Tom Irvine

function[area,MOIy,MOIz,J,cnaz]=beam_rectangular_hollow_geometry_alt(width,height,thick)

b=width;
h=height;
t=thick;

tt=2*t;

area=b*h-(b-tt)*(h-tt);

MOIz=(1/12)*(b*h^3-(b-tt)*(h-tt)^3);
MOIy=(1/12)*(h*b^3-(h-tt)*(b-tt)^3);
        
J=MOIy+MOIz;
cnaz=h/2;

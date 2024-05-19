

%   pipe_geometry_wall_polar.m  ver 1.0  by Tom Irvine 

function[area,J,cna]=pipe_geometry_wall_polar(diameter,wall_thick)

ID=diameter-2*wall_thick;
area=pi*(diameter^2-ID^2)/4;
J=pi*(diameter^4-ID^4)/32;
cna=diameter/2;       

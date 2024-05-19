

%   pipe_geometry_wall_alt.m  ver 1.0  by Tom Irvine 

function[area,MOI,J,cna]=pipe_geometry_wall_alt(diameter,wall_thick)

ID=diameter-2*wall_thick;
area=pi*(diameter^2-ID^2)/4;
MOI=pi*(diameter^4-ID^4)/64;
cna=diameter/2;       
J=2*MOI;
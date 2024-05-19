

%   pipe_geometry_wall.m  ver 1.0  by Tom Irvine 

function[area,MOI,cna]=pipe_geometry_wall(diameter,wall_thick)

ID=diameter-2*wall_thick;
area=pi*(diameter^2-ID^2)/4;
MOI=pi*(diameter^4-ID^4)/64;
cna=diameter/2;       

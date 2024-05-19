

%   pipe_geometry_wall_6dof.m  ver 1.0  by Tom Irvine 

function[area,J,Iyy,Izz,cnay,cnaz]=pipe_geometry_wall_6dof(diameter,wall_thick)

ID=diameter-2*wall_thick;
area=pi*(diameter^2-ID^2)/4;

J=pi*(diameter^4-ID^4)/32;

Iyy=pi*(diameter^4-ID^4)/64;
Izz=Iyy;

cnay=diameter/2;       
cnaz=cnay;
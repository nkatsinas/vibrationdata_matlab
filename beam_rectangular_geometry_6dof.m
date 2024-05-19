
%  beam_rectangular_geometry_6dof.m  ver 1.0  by Tom Irvine

function[area,J,Iyy,Izz,cnay,cnaz]=beam_rectangular_geometry_6dof(width,thick)

        area=thick*width;
        
        [J]=rectangular_polar(width,thick);
        Iyy=(1/12)*width^3*thick;
        Izz=(1/12)*width*thick^3;
    
        cnay=thick/2;       
        cnaz=width/2;

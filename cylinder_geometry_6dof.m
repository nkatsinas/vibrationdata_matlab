
%  cylinder_geometry_6dof.m  ver 1.0  by Tom Irvine

function[area,J,Iyy,Izz,cnay,cnaz]=cylinder_geometry_6dof(diameter)

        area=pi*diameter^2/4;
        
        J=pi*(diameter^4)/32;
        
        Iyy=pi*(diameter^4)/64;
        Izz=Iyy;
        
        cnay=diameter/2;   
        cnaz=cnay;

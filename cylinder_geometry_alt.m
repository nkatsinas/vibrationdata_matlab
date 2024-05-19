
%  cylinder_geometry_alt.m  ver 1.0  by Tom Irvine

function[area,MOI,J,cna]=cylinder_geometry_alt(diameter)

        area=pi*diameter^2/4;
        MOI=pi*diameter^4/64; 
        cna=diameter/2;
        J=2*MOI;


%  cylinder_geometry.m  ver 1.0  by Tom Irvine

function[area,MOI,cna]=cylinder_geometry(diameter)

        area=pi*diameter^2/4;
        MOI=pi*diameter^4/64; 
        cna=diameter/2;   

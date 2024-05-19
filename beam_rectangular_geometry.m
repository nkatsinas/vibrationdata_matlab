
%  beam_rectangular_geometry.m  ver 1.0  by Tom Irvine

function[area,MOI,cna]=beam_rectangular_geometry(width,thick)

        area=thick*width;
        MOI=(1/12)*width*thick^3;
        cna=thick/2;

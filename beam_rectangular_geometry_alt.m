
%  beam_rectangular_geometry_alt.m  ver 1.0  by Tom Irvine

function[area,MOIy,MOIz,J,cnaz]=beam_rectangular_geometry_alt(width,thick)

        area=thick*width;
        MOIy=(1/12)*width^3*thick;
        MOIz=(1/12)*width*thick^3;
        J=MOIy+MOIz;
        cnaz=thick/2;

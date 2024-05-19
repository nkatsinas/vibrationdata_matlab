%
%   display_mass_per_area.m  ver 1.0  by Tom Irvine
%

function[]=display_mass_per_area(mp,iu)

if(iu==1)
    out1=sprintf('\n mass/area = %8.4g lbm/in^2',mp*386);
else
    out1=sprintf('\n mass/area = %8.4g kg/m^2',mp);   
end
disp(out1);
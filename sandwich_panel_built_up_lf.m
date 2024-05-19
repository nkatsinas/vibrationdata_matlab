%
%   sandwich_panel_built_up_lf.m  ver 1.0 by Tom Irvine
%
function[lf]=sandwich_panel_built_up_lf(f)

fp=500;

if(f<=fp)
    lf=0.05;
else
    lf=0.050*sqrt(fp/f);
end
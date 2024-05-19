

%  Ibeam_geometry.m  ver 1.0  by Tom Irvine

function[area,MOIz,MOIy]=Ibeam_geometry(B,H,Tf,Tw)

area=2*B*Tf+(H-2*Tf)*Tw;
MOIz=(1/12)*(B*H^3-(B-Tw)*(H-2*Tf)^3);
MOIy=(1/12)*(2*Tf*B^3+(H-2*Tf)*Tw^3);
%
%    area_annular_plate.m  ver 1.0  by Tom Irvine
%

function[area]=area_annular_plate(OD,ID)

r2=OD/2;
r1=ID/2;
 
area=pi*(r2^2-r1^2);
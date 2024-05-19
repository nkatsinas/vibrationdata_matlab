%
%   display_dynamic_pressure.m  ver 1.0  by Tom Irvine
%

function[]=display_dynamic_pressure(iu,p)

if(iu==1)
   out1=sprintf(' Dynamic Pressure = %8.4g psi ',p);
else
   out1=sprintf(' Dynamic Pressure = %8.4g Pa ',p);
end
disp(out1);
 


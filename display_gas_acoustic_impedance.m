%
%  display_gas_acoustic_impedance.m  ver 1.0 by Tom Irvine
%
function display_gas_acoustic_impedance(iu,rho_c)
 
if(iu==1)
    out1=sprintf(' Gas acoustic impedance = %8.4g psi sec/in',rho_c);
else
    out1=sprintf(' Gas acoustic impedance = %8.4g Rayls',rho_c);
end
disp(out1);
disp(' ');

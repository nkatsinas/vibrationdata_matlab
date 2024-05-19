%
%   vibrationdata_viscosity.m  ver 1.0  by Tom Irvine
%
%   Values for Air 
%
function[kvisc,dvisc]=vibrationdata_viscosity(temp_K,gas_md,iu)

S=120;      % K

b=1.458e-06;  % kg/( m sec sqrt(K) )

if(iu==1)
   b=b/6895;  % lbf sec/(in^2 sqrt(K))
end

dvisc= (b*temp_K^1.5)/(temp_K+S);  % Sutherland formula

kvisc=dvisc/gas_md;
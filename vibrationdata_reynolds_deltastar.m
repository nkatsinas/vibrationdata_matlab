%
%  vibrationdata_reynolds_deltastar.m  ver 1.1  by Tom Irvine
%
function[Rex,deltastar]=vibrationdata_reynolds_deltastar(x,M,Uinf,kvisc)

out1=sprintf('\n x=%8.4g  Uinf=%8.4g  kvisc=%8.4g \n',x,Uinf,kvisc);
disp(out1);

M2=M^2;

Rex = Uinf*x/kvisc;    % Equation (6.23) in heat transfer text

deltastar = x*0.0371*(Rex^(-0.2))*((9/7)+0.475*M2)/((1+0.13*M2)^0.64);

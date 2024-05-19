%
%   mass_law_transmission_loss.m  ver 1.0  by Tom Irvine
%

function[TL]=mass_law_transmission_loss(omega,mpa,rho_c_air,ni)

     term=((omega*mpa)/(2*rho_c_air))^2;
     TL_norm=10*log10(1 + term);
     
     if(ni==1)  % normal
         TL=TL_norm;
     end
     if(ni==2)  % field
         TL=TL_norm-5;
     end
     if(ni==3)  % random
         TL=TL_norm-10*log10(0.23*TL_norm);
     end
     
     if(TL<1)
         TL=1;
     end

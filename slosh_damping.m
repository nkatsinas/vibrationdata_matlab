%
disp(' ');
disp(' slosh_damping, ver 1.0   July 27 ');
disp(' by Tom Irvine ');
disp('  ');
disp(' Slosh damping in an unbaffled cylindrical tank. ');
disp(' Reference:  NASA SP-8009 ');
disp(' ');
%
clear a;
%
disp(' Enter acceleration of gravity (in/sec^2) ');
g=input(' ');
disp(' Enter the diameter (in) ');
diam=input(' ');
a=diam/2;
%
while(1)
   disp(' Select fluid: ');
   disp(' 1=water at 20 deg C   2=other');
   sf=input(' ');
   if(sf==1 || sf==2)
       break;
   end
end
%
if(sf==1)
  v=0.00155;  % in^2/sec   
end
if(sf==2)
  disp(' Enter the kinematic viscosity (in^2/sec) ');
  v=input(' ');
end
%
dec=4.98*(v^0.5)*(a^-0.75)*(g^-0.25);
damp=dec/(2*pi);
%
 out1=sprintf('\n log decrement = %8.4g ',dec);
   out2=sprintf(' damping ratio = %8.4g ',damp);
   out3=sprintf('               = %8.4g percent ',damp*100);
disp(out1);
disp(out2);
disp(out3);
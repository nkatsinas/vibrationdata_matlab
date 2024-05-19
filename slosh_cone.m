disp(' ');
disp(' slosh_cone.m   ver 1.2   June 7, 2013 ');
disp(' by Tom Irvine ');
%
disp(' ');
disp(' This program calculates the slosh frequency inside ');
disp(' a conical basin.');
disp(' ');
disp(' Assume');
disp(' 1. The liquid is homogeneous, inviscid, irrotational, & incompressible');  
disp(' 2. The boundaries of the basin are rigid ');   
disp(' 3. Small wave amplitudes, linear behavior');   
disp(' 4. The influence of the surrounding atmosphere is negligible');   
disp(' 5. The influence of surface tension is negligible');   
%
clear f;
clear g;
clear h;
clear D;
clear a;
clear b;
%
tpi=2*pi;
% 
disp(' ');
disp(' Enter acceleration of gravity (in/sec^2) ');
g=input(' ');
disp(' Enter Diameter of Fluid Surface (inch)');
d=input(' ');
disp(' Enter Cone Apex Angle (deg)');
alpha=input(' ');
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
beta=6.65e-09*alpha^4-3.03e-06*alpha^3+5.90e-04*alpha^2-0.0680*alpha+4.12;
%
fn=(beta/(2*pi))*sqrt(g/d);
%
out1=sprintf('\n fn = %8.4g Hz  ',fn);
disp(out1);
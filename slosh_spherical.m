disp(' ');
disp(' slosh_spherical.m   ver 1.2   June 7, 2013 ');
disp(' by Tom Irvine ');
%
disp(' ');
disp(' This program calculates the slosh frequency inside ');
disp(' a partially filled spherical container.');
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
disp(' Enter diameter of the sphere (inch)');
d=input(' ');
disp(' Enter the fluid height (inch)');
h=input(' ');
%
r=d/2;
%
x=h/d;
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
beta(1)=12.1*x^5-24.2*x^4+18.7*x^3-6.22*x^2+1.27*x+0.975;
beta(2)=(-0.2001)*x^5+(14.1148 )*x^4+(-26.1881)*x^3+(19.8671)*x^2+(-7.0447)*x+(3.2759);
beta(3)=19.3*x^4-37.7*x^3+29.5*x^2-10.8*x+4.50;
%
disp(' ');
for i=1:3
%
    fn=(beta(i)/(2*pi))*sqrt(g/r);
%
    out1=sprintf(' f%d = %8.4g Hz  beta=%8.4g',i,fn,beta(i));
    disp(out1);
%
end
%
disp(' ');
disp(' slosh_damping_ring_baffle.m, ver 1.0   July 27 ');
disp(' by Tom Irvine ');
disp('   ');
disp(' Slosh damping in a cylindrical tank with one ring baffle.');
disp(' Reference: NASA SP-8031,');
disp(' ');
%
clear a;
%
disp(' Enter the diameter (in) ');
diam=input(' ');
a=diam/2;
disp(' Enter the ring baffle width (in) ');
W=input(' ');
disp(' Enter the depth of the baffle (in) ');
dh=input(' ');
disp(' Enter the maximum wave height (in) ');
n=input(' ');
%
damp=2.83*exp(-4.6*dh/a)*(((2*W/a)-(W/a)^2)^1.5)*(n/a)^0.5;
dec=damp*(2*pi);
%
 out1=sprintf('\n log decrement = %8.4g ',dec);
   out2=sprintf(' damping ratio = %8.4g ',damp);
   out3=sprintf('               = %8.4g percent ',damp*100);
disp(out1);
disp(out2);
disp(out3);
%
%    gravity_altitude.m  ver 1.0  by Tom Irvine
%

% Write a gravity model to output the gravitational acceleration at an input geometric altitude:

disp('  ');
disp(' * * * * * ');
disp('   ');

% Earth
g0 = 9.80665;  %m/s^2
r = 6367445 ; %m

hg=input(' Enter altitude above sea level in meters: ');

[g] = Gravity(hg,g0,r);

fprintf('\n g = %8.4g m/sec^2 \n',g);

function [g] = Gravity(hg,g0,r)

    ha=r+hg;
    g=g0*(r/ha)^2;

end
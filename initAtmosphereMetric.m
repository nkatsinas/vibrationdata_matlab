%
%   initAtmosphereMetric.m  ver 1.0  by Tom Irvine
%
%   From Mark Jackson's class
%

function[AP] = initAtmosphereMetric()
%Initializes atmospheric parameters to metric values
%   Parameters are:
%   Geopotential   Lapse    
%      Height      Rate     Temp   Pressure
%       (m)        (K/m)   (degK)    (Pa)
% AP.a0:  Speed of sound at zero geopotential height
% AP.R:   Ideal gas constant 
%

%   Reference data:
%   Geopotential   Lapse    
%      Height       Rate	Temp   Pressure
%       (km)	   (C/km)   (C)    (Pa)
RefTable = [
        0.0         -6.5     15.0  101325;   %Troposphere
        11.000       0.0    -56.5  22632;    %Tropopause 
        20.000       1.0    -56.5  5474.9;   %Stratosphere
        32.000       2.8    -44.5  868.02;   %Stratosphere 
        47.000       0.0    -2.5   110.91;  %Stratopause
        51.000      -2.8    -2.5   66.939;  %Mesosphere 
        71.000      -2.0    -58.5  3.9564;  %Mesosphere 
        84.852       0.0    -86.2  0.3734;  %Mesopause 
];   

AP.AtmoTable(:,1)   = RefTable(:,1)*1000;       % convert to m
AP.AtmoTable(:,2)   = RefTable(:,2)./1000;      % convert to degK/m
AP.AtmoTable(:,3)   = RefTable(:,3) + 273.16;   % convert to Kelvin
AP.AtmoTable(:,4)   = RefTable(:,4);

AP.a0 = 340.3;      % m/s  speed of sound at h=0
AP.R  = 287.058;	% J/(kg*degK)
AP.gamma = 1.4;     % Ratio of Specific Heats

AP.Rplanet = 6367445 ;        % Mean of Polar and Equatorial 
                              % Earth radius in meters

end
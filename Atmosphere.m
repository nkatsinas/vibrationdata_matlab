%
%  Atmosphere.m  ver 1.0  by Tom Irvine
%
%  From Mark Jackson's class
%
%inputs:
% NOTE:  output units determined by units of parameters
% h_in  - input geometric altitude
% AP    - atmospheric parameters
%         AP.Ttable:  table of Altitudes, Lapse Rates and Temperatures with
%         columns:
%    Geometric     Lapse    
%      Height      Rate     Temp   Pressure
% AP.a0 -  Speed of sound at zero geopotential height
% AP.R  -  Ideal gas constant 
%
% g0 - acceleration of gravity at h=0
%
% 
% outputs:
% Tout  - Temperature
% pout  - pressure
% rhoout- density
% aout  - speed of sound

function [Tout,pout,rhoout,aout,h] = Atmosphere(h_in,AP,g0)


% convert altitude to geopotential altitude
    h = h_in*AP.Rplanet./(AP.Rplanet + h_in);

%determine which layer (atmospheric layer) we are in
    if(h < 0.0)
        layer = 1; % use troposphere for negative altitudes
    else
        layer = find( AP.AtmoTable(:,1) <= h, 1, 'last' ) ;
    end

% get parameters at lower end of this layer
    h1 = AP.AtmoTable(layer,1);
    L1  = AP.AtmoTable(layer,2);
    T1 = AP.AtmoTable(layer,3);
    P1 = AP.AtmoTable(layer,4);

% get parameters at upper end of this layer
    
% Pressure equations    
   
    dh=(h-h1);
   
    Tout=T1+L1*dh;
    
    if(L1~=0)
        pout= P1*(Tout/T1)^(-g0/(L1*AP.R));
    else
        pout= P1*exp(-g0*dh/(AP.R*T1));        
    end
    
    rhoout = pout/(AP.R*Tout);
    
% calculate the speed of sound (aout) from the temperature

    aout=sqrt(AP.gamma*AP.R*Tout);

end

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
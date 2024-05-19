


% M6


load('\Systems\Loads-Dynamics\Vibroacoustics\NS4\NS4.1_Flight_Test_SDFI\M6\CC1.3\MAT files\GRMS\AM03.mat');
M6_AM03_th=[ AM03.Time AM03.Data];

%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% M7


cd('\Systems\Loads-Dynamics\Vibroacoustics\NS4\NS4.2_Flight_Test_SDFI\M7\CC2.0-1\02_Channel_Data\AM03')
load('AM03.mat')
M7_AM03_th=[ AM03.Time AM03.Data];

cd('\Systems\Loads-Dynamics\Vibroacoustics\NS4\NS4.2_Flight_Test_SDFI\M7\CC2.0-1\02_Channel_Data\AM43')
load('AM43.mat')
M7_AM43_th=[ AM43.Time AM43.Data];

cd('\Systems\Loads-Dynamics\Vibroacoustics\NS4\NS4.2_Flight_Test_SDFI\M7\CC2.0-1\02_Channel_Data\AM49')
load('AM49.mat')
M7_AM49_th=[ AM49.Time AM49.Data];


%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% M8
cd('\Systems\Loads-Dynamics\Vibroacoustics\NS4\NS4.2_Flight_Test_SDFI\M8\CC2.0-1\02_Channel_Data\AM03')
load('AM03.mat')
M8_AM03_th=[ AM03.Time AM03.Data];

cd('\Systems\Loads-Dynamics\Vibroacoustics\NS4\NS4.2_Flight_Test_SDFI\M8\CC2.0-1\02_Channel_Data\AM43')
load('AM43.mat')
M8_AM43_th=[ AM43.Time AM43.Data];

cd('\Systems\Loads-Dynamics\Vibroacoustics\NS4\NS4.2_Flight_Test_SDFI\M8\CC2.0-1\02_Channel_Data\AM49')
load('AM49.mat')
M8_AM49_th=[ AM49.Time AM49.Data];


%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% M9


cd('\Systems\Loads-Dynamics\Vibroacoustics\NS4\NS4.2_Flight_Test_SDFI\M9\CC2.0-1\02_Channel_Data\AM43')
load('AM43.mat')
M9_AM43_th=[ AM43.Time AM43.Data];


cd('\Systems\Loads-Dynamics\Vibroacoustics\NS4\NS4.2_Flight_Test_SDFI\M9\CC2.0-1\02_Channel_Data\AM49')
load('AM49.mat')
M9_AM49_th=[ AM49.Time AM49.Data];

%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% P7


load('\Vehicle_SA\dynamic_environments_tmp\P7\CC2.0-1\02_Channel_Data\AM43\AM43.mat')
P7_AM43_th=[ AM43.Time AM43.Data];

load('\Vehicle_SA\dynamic_environments_tmp\P7\CC2.0-1\02_Channel_Data\AM49\AM49.mat')
P7_AM49_th=[ AM49.Time AM49.Data];

%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
cd('c:\users\tirvine\documents\matlab')
cmap(1,:)=[0 0 0.8];        % dark blue
cmap(2,:)=[0.8 0 0];        % red
cmap(3,:)=[0 0 0];          % black
cmap(4,:)=[0.6 0.3 0];      % brown
cmap(5,:)=[0 0.5 0.5];      % teal
cmap(6,:)=[1 0.5 0];        % orange
cmap(7,:)=[0.5 0.5 0];      % olive
cmap(8,:)=[0.13 0.55 0.13]; % forest green  
cmap(9,:)=[0.5 0 0];        % maroon
cmap(10,:)=[0.5 0.5 0.5 ];  % grey
cmap(11,:)=[1. 0.4 0.4];    % pink-orange
cmap(12,:)=[0.5 0.5 1];     % lavender

L=12;
W=4;
h=0.125;

P=zeros(8,3);

P(1,:)=[ 0 0 0  ];
P(2,:)=[ L 0 0 ];
P(3,:)=[ L 0 h ];

P(4,:)=[ 0 0 h ];
P(5,:)=[ 0 W 0 ];
P(6,:)=[ L W 0 ];
P(7,:)=[ L W h ];
P(8,:)=[ 0 W h ];

T(1,:)=[ 1 2 3 ];
T(2,:)=[ 1 3 4 ];
T(3,:)=[ 4 3 7 ];
T(4,:)=[ 4 7 8 ];
T(5,:)=[ 5 1 4 ];
T(6,:)=[ 5 4 8 ];
T(7,:)=[ 2 6 3 ];
T(8,:)=[ 6 7 3 ];
T(9,:)=[ 5 2 1 ];
T(10,:)=[ 5 6 2 ];
T(11,:)=[ 5 8 7 ];
T(12,:)=[ 5 7 6 ];

TR = triangulation(T,P);
figure(1);
a=trisurf(TR);
a.FaceVertexCData = cmap;


stlwrite(TR,'plate.stl'); 

thePde = createpde();
gm = importGeometry(thePde,'plate.stl');
figure(2)
pdegplot(gm,'FaceLabels','on');


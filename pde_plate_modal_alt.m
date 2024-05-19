close all hidden

clear model

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

gm = multicuboid(L,W,h);
model = createpde('structural','modal-solid');
model.Geometry = gm;

figure(2)
pdegplot(gm,'FaceLabels','on');

structuralProperties(model,'YoungsModulus',10e6, ...
                           'PoissonsRatio',0.3, ...
                           'MassDensity',0.1/386);
                       
structuralBC(model,'Face',3,'Constraint','fixed');

generateMesh(model,'Hmin',0.125,'Hmax',0.4);
figure(3); 
pdeplot3D(model);
title('Mesh with Quadratic Tetrahedral Elements');

RF = solve(model,'FrequencyRange',[-1,1000]*2*pi);
modeID = 1:numel(RF.NaturalFrequencies);


disp(' ');
% tmodalResults = table(modeID.',RF.NaturalFrequencies/2/pi);
% tmodalResults.Properties.VariableNames = {'Mode','Frequency'};
% disp(tmodalResults);

fn=RF.NaturalFrequencies/(2*pi);

N=min([length(fn) 6]);

disp(' Mode   fn(Hz)');
for i=1:N
    fprintf(' %d   %8.4g \n',i,fn(i));
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

fig_num=4;
[fig_num]=plotmodeshape(fig_num,RF,1,N);
[fig_num]=plotmodeshape(fig_num,RF,2,N);
[fig_num]=plotmodeshape(fig_num,RF,3,N);

function[fig_num]=plotmodeshape(fig_num,R,modeID,N)

scale = 0.05;
flexibleModes = 1:N;
 
% Create a model for plotting purpose.
deformedModel = createpde('structural','modal-solid');
 
% Undeformed mesh data
nodes = R.Mesh.Nodes;
elements = R.Mesh.Elements;
 
% Construct pseudo time-vector that spans one period of first six flexible
% modes.
omega = R.NaturalFrequencies(modeID);
timePeriod = 2*pi./R.NaturalFrequencies(modeID);
 

        % Construct a modal deformation matrix and its magnitude.
        modalDeformation = [R.ModeShapes.ux(:,flexibleModes(modeID))';
            R.ModeShapes.uy(:,flexibleModes(modeID))';
            R.ModeShapes.uz(:,flexibleModes(modeID))'];
        
        modalDeformationMag = sqrt(modalDeformation(1,:).^2 + ...
            modalDeformation(2,:).^2 + ...
            modalDeformation(3,:).^2);
        
        
        % Compute nodal locations of deformed mesh.
        pseudoTimeVector = timePeriod/4;
        nodesDeformed = nodes + scale.*modalDeformation*sin(omega*pseudoTimeVector);
        
        % Construct a deformed geometric shape using displaced nodes and
        % elements from unreformed mesh data.
        geometryFromMesh(deformedModel,nodesDeformed,elements);
        
        % Plot the deformed mesh with magnitude of mesh as color plot.
        %plot(modeID)
        figure(fig_num);
        pdeplot3D(deformedModel,'ColorMapData', modalDeformationMag)
        title(sprintf(['Flexible Mode %d\n', ...
            'Frequency = %8.4g Hz'], ...
            modeID,omega/2/pi));

       fig_num=fig_num+1; 
end





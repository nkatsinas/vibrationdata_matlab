function varargout = thick_rectangular_plate_bending_fea(varargin)
% THICK_RECTANGULAR_PLATE_BENDING_FEA MATLAB code for thick_rectangular_plate_bending_fea.fig
%      THICK_RECTANGULAR_PLATE_BENDING_FEA, by itself, creates a new THICK_RECTANGULAR_PLATE_BENDING_FEA or raises the existing
%      singleton*.
%
%      H = THICK_RECTANGULAR_PLATE_BENDING_FEA returns the handle to a new THICK_RECTANGULAR_PLATE_BENDING_FEA or the handle to
%      the existing singleton*.
%
%      THICK_RECTANGULAR_PLATE_BENDING_FEA('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in THICK_RECTANGULAR_PLATE_BENDING_FEA.M with the given input arguments.
%
%      THICK_RECTANGULAR_PLATE_BENDING_FEA('Property','Value',...) creates a new THICK_RECTANGULAR_PLATE_BENDING_FEA or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before thick_rectangular_plate_bending_fea_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to thick_rectangular_plate_bending_fea_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help thick_rectangular_plate_bending_fea

% Last Modified by GUIDE v2.5 27-Jul-2021 16:08:48

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @thick_rectangular_plate_bending_fea_OpeningFcn, ...
                   'gui_OutputFcn',  @thick_rectangular_plate_bending_fea_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before thick_rectangular_plate_bending_fea is made visible.
function thick_rectangular_plate_bending_fea_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to thick_rectangular_plate_bending_fea (see VARARGIN)

% Choose default command line output for thick_rectangular_plate_bending_fea
handles.output = hObject;

handles.elastic_modulus=0;
handles.mass_density=0;
handles.poisson=0;

handles.NSM=0;

handles.total_mass=0;

handles.length=0;
handles.width=0;
handles.thickness=0;

handles.material=1;
handles.unit=1;

handles.leftBC=1;
handles.topBC=1;
handles.rightBC=1;
handles.bottomBC=1;

set(handles.edit_fn,'Enable','off');
set(handles.NSMeditbox,'String','0');

clc;
bg = imread('plate_image.jpg');
image(bg);
axis off; 


handles.unit=get(handles.unitlistbox,'Value');

guidata(hObject, handles);




material_change(hObject, eventdata, handles);






% --- Outputs from this function are returned to the command line.
function varargout = thick_rectangular_plate_bending_fea_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in unitlistbox.
function unitlistbox_Callback(hObject, eventdata, handles)
% hObject    handle to unitlistbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns unitlistbox contents as cell array
%        contents{get(hObject,'Value')} returns selected item from unitlistbox
clear_answer(hObject, eventdata, handles);


handles.unit=get(handles.unitlistbox,'Value');


if(handles.unit==1)
   set(handles.elasticmodulustext,'String','Elastic Modulus (psi)');
   set(handles.massdensitytext,'String','Mass Density (lbm/in^3)');
   set(handles.NSMmasslabel,'String','Nonstructural Mass (lbm)');
   set(handles.totalmasslabel,'String','Total Mass (lbm)');   
   set(handles.widthtext,'String','Width(in)');
   set(handles.lengthtext,'String','Length(in)'); 
   set(handles.thicknesstext,'String','Thickness(in)'); 
   set(handles.text_plate_stiffness_D,'String','Bending Stiffness (lbf-in)');
   set(handles.text_hmin,'String','Min Element Dimension (in)'); 
   set(handles.text_hmax,'String','Max Element Dimension (in)');   
else
   set(handles.elasticmodulustext,'String','Elastic Modulus (GPa)'); 
   set(handles.massdensitytext,'String','Mass Density (kg/m^3)');
   set(handles.NSMmasslabel,'String','Nonstructural Mass (kg)');
   set(handles.totalmasslabel,'String','Total Mass (kg)'); 
   set(handles.widthtext,'String','Width(mm)');
   set(handles.lengthtext,'String','Length(mm)'); 
   set(handles.thicknesstext,'String','Thickness(mm)'); 
   set(handles.text_plate_stiffness_D,'String','Bending Stiffness (N-m)');  
   set(handles.text_hmin,'String','Min Element Dimension (mm)'); 
   set(handles.text_hmax,'String','Max Element Dimension (mm)');  
end

if(handles.material==5)
    set(handles.elasticmoduluseditbox,'String',' ');
    set(handles.massdensityeditbox,'String',' ');  
    set(handles.poissoneditbox,'String',' ');  
end

guidata(hObject, handles);

material_change(hObject, eventdata, handles); 





function clear_answer(hObject, eventdata, handles)
set(handles.edit_fn,'String',' ');
set(handles.edit_fn,'Enable','off');
set(handles.totalmasseditbox,'String',' ');
% Update handles structure
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function unitlistbox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to unitlistbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function calculate_total_mass(hObject, eventdata, handles)

L=str2num(get(handles.lengtheditbox,'String'));
W=str2num(get(handles.widtheditbox,'String'));
thick=str2num(get(handles.thicknesseditbox,'String'));
mass_density=str2num(get(handles.massdensityeditbox,'String'));
NSM=str2num(get(handles.NSMeditbox,'String'));

out1=sprintf('thickness=%8.4g',thick);
% disp(out1);

if(handles.unit==2)
    L=L/1000;
    W=W/1000;
    thick=thick/1000;
end    


vol=L*W*thick;

ss=sprintf('vol=%8.4g',vol);
% disp(ss);

structural_mass=mass_density*vol + NSM;

handles.total_mass=structural_mass;

ss=sprintf('%8.4g',structural_mass);
set(handles.totalmasseditbox,'String',ss,'Enable','on');

guidata(hObject, handles);


% --- Executes on selection change in materiallistbox.
function materiallistbox_Callback(hObject, eventdata, handles)
% hObject    handle to materiallistbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns materiallistbox contents as cell array
%        contents{get(hObject,'Value')} returns selected item from materiallistbox
clear_answer(hObject, eventdata, handles);
handles.material=get(hObject,'Value');

guidata(hObject, handles);

material_change(hObject, eventdata, handles); 



function material_change(hObject, eventdata, handles)

if(handles.unit==1)  % English
    if(handles.material==1) % aluminum
        handles.elastic_modulus=1e+007;
        handles.mass_density=0.1;  
    end  
    if(handles.material==2)  % steel
        handles.elastic_modulus=3e+007;
        handles.mass_density= 0.28;         
    end
    if(handles.material==3)  % copper
        handles.elastic_modulus=1.6e+007;
        handles.mass_density=  0.322;
    end
    if(handles.material==4)  % G10
        handles.elastic_modulus=2.7e+006;
        handles.mass_density=  0.065;
    end
else                 % metric
    if(handles.material==1)  % aluminum
        handles.elastic_modulus=70;
        handles.mass_density=  2700;
    end
    if(handles.material==2)  % steel
        handles.elastic_modulus=205;
        handles.mass_density=  7700;        
    end
    if(handles.material==3)   % copper
        handles.elastic_modulus=110;
        handles.mass_density=  8900;
    end
    if(handles.material==4)  % G10
        handles.elastic_modulus=18.6;
        handles.mass_density=  1800;
    end
end
 
if(handles.material==1) % aluminum
        handles.poisson=0.33;  
end  
if(handles.material==2)  % steel
        handles.poisson= 0.30;         
end
if(handles.material==3)  % copper
        handles.poisson=  0.33;
end
if(handles.material==4)  % G10
        handles.poisson=  0.12;
end

if(handles.material<5)
    ss1=sprintf('%8.4g',handles.elastic_modulus);
    ss2=sprintf('%8.4g',handles.mass_density);
    ss3=sprintf('%8.4g',handles.poisson);  
 
    set(handles.elasticmoduluseditbox,'String',ss1);
    set(handles.massdensityeditbox,'String',ss2);  
    set(handles.poissoneditbox,'String',ss3);  
end

guidata(hObject, handles);



% --- Executes during object creation, after setting all properties.
function materiallistbox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to materiallistbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function elasticmoduluseditbox_Callback(hObject, eventdata, handles)
% hObject    handle to elasticmoduluseditbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of elasticmoduluseditbox as text
%        str2double(get(hObject,'String')) returns contents of elasticmoduluseditbox as a double
clear_answer(hObject, eventdata, handles);

% --- Executes during object creation, after setting all properties.
function elasticmoduluseditbox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to elasticmoduluseditbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end








function poissoneditbox_Callback(hObject, eventdata, handles)
% hObject    handle to poissoneditbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of poissoneditbox as text
%        str2double(get(hObject,'String')) returns contents of poissoneditbox as a double
clear_answer(hObject, eventdata, handles);

% --- Executes during object creation, after setting all properties.
function poissoneditbox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to poissoneditbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in leftBClistbox.
function leftBClistbox_Callback(hObject, eventdata, handles)
% hObject    handle to leftBClistbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns leftBClistbox contents as cell array
%        contents{get(hObject,'Value')} returns selected item from leftBClistbox
clear_answer(hObject, eventdata, handles);
handles.leftBC=get(hObject,'Value');
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function leftBClistbox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to leftBClistbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in bottomBClistbox.
function bottomBClistbox_Callback(hObject, eventdata, handles)
% hObject    handle to bottomBClistbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns bottomBClistbox contents as cell array
%        contents{get(hObject,'Value')} returns selected item from bottomBClistbox
clear_answer(hObject, eventdata, handles);
handles.bottomBC=get(hObject,'Value');
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function bottomBClistbox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to bottomBClistbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in rightBClistbox.
function rightBClistbox_Callback(hObject, eventdata, handles)
% hObject    handle to rightBClistbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns rightBClistbox contents as cell array
%        contents{get(hObject,'Value')} returns selected item from rightBClistbox
clear_answer(hObject, eventdata, handles);
handles.rightBC=get(hObject,'Value');
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function rightBClistbox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to rightBClistbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in topBClistbox.
function topBClistbox_Callback(hObject, eventdata, handles)
% hObject    handle to topBClistbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns topBClistbox contents as cell array
%        contents{get(hObject,'Value')} returns selected item from topBClistbox
clear_answer(hObject, eventdata, handles);
handles.topBC=get(hObject,'Value');
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function topBClistbox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to topBClistbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function NSMeditbox_Callback(hObject, eventdata, handles)
% hObject    handle to NSMeditbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of NSMeditbox as text
%        str2double(get(hObject,'String')) returns contents of NSMeditbox as a double
clear_answer(hObject, eventdata, handles);
handles.NSM=str2num(get(hObject,'String')); 
guidata(hObject, handles);



% --- Executes during object creation, after setting all properties.
function NSMeditbox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to NSMeditbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function totalmasseditbox_Callback(hObject, eventdata, handles)
% hObject    handle to totalmasseditbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of totalmasseditbox as text
%        str2double(get(hObject,'String')) returns contents of totalmasseditbox as a double


% --- Executes during object creation, after setting all properties.
function totalmasseditbox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to totalmasseditbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_fn_Callback(hObject, eventdata, handles)
% hObject    handle to edit_fn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_fn as text
%        str2double(get(hObject,'String')) returns contents of edit_fn as a double


% --- Executes during object creation, after setting all properties.
function edit_fn_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_fn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in calculatepushbutton.
function calculatepushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to calculatepushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

disp(' ');
disp(' * * * * * ');
disp(' ');

calculate_total_mass(hObject, eventdata, handles);

E=str2num(get(handles.elasticmoduluseditbox,'String'));
mu=str2num(get(handles.poissoneditbox,'String'));
mass=str2num(get(handles.totalmasseditbox,'String'));

L=str2num(get(handles.lengtheditbox,'String'));
W=str2num(get(handles.widtheditbox,'String'));
thick=str2num(get(handles.thicknesseditbox,'String'));

hmin=str2num(get(handles.edit_hmin,'String'));
hmax=str2num(get(handles.edit_hmax,'String'));


out1=sprintf(' E=%8.4g  mu=%7.3g  total mass=%8.4g  ',E,mu,mass);
out2=sprintf(' L=%8.4g   W=%8.4g  thick=%8.4g  ',L,W,thick);

disp(out1);
disp(out2);

unit=get(handles.unitlistbox,'Value');

leftBC=get(handles.leftBClistbox,'Value');
topBC=get(handles.topBClistbox,'Value');
rightBC=get(handles.rightBClistbox,'Value');
bottomBC=get(handles.bottomBClistbox,'Value');

if(unit==1)
    mass=mass/386;
else
    L=L/1000;
    W=W/1000;
    thick=thick/1000;
    E=E*1e+09;
    hmin=hmin/1000;
    hmax=hmax/1000;
end

area=L*W;
vol=area*thick;
rho=mass/vol;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

gm = multicuboid(L,W,thick);
model = createpde('structural','modal-solid');
model.Geometry = gm;

fig_num=1;

figure(fig_num)
fig_num=fig_num+1;
pdegplot(gm,'EdgeLabels','on','VertexLabels','on');
title('Edge & Vertex Labels');

figure(fig_num)
fig_num=fig_num+1;
pdegplot(gm,'FaceLabels','on');
title('Face Labels');

structuralProperties(model,'YoungsModulus',E, ...
                           'PoissonsRatio',mu, ...
                           'MassDensity',rho);
                      
                       
if(leftBC==1)
    structuralBC(model,'Face',5,'Constraint','fixed');      
end
if(topBC==1)
    structuralBC(model,'Face',4,'Constraint','fixed');    
end
if(rightBC==1)
    structuralBC(model,'Face',3,'Constraint','fixed');    
end
if(bottomBC==1)
    structuralBC(model,'Face',6,'Constraint','fixed');        
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(leftBC==2)
    structuralBC(model,'Edge',2,'ZDisplacement',0);   
    structuralBC(model,'Vertex',2,'XDisplacement',0,'YDisplacement',0);  
    structuralBC(model,'Vertex',3,'XDisplacement',0,'YDisplacement',0);       
end
if(topBC==2)
    structuralBC(model,'Edge',3,'ZDisplacement',0);
    structuralBC(model,'Vertex',3,'XDisplacement',0,'YDisplacement',0);  
    structuralBC(model,'Vertex',4,'XDisplacement',0,'YDisplacement',0);    
end
if(rightBC==2)
    structuralBC(model,'Edge',4,'ZDisplacement',0);
    structuralBC(model,'Vertex',1,'XDisplacement',0,'YDisplacement',0);  
    structuralBC(model,'Vertex',4,'XDisplacement',0,'YDisplacement',0);     
end
if(bottomBC==2)
    structuralBC(model,'Edge',1,'ZDisplacement',0);  
    structuralBC(model,'Vertex',1,'XDisplacement',0,'YDisplacement',0);  
    structuralBC(model,'Vertex',2,'XDisplacement',0,'YDisplacement',0);     
end


                      
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

D=E*thick^3/(12*(1-mu^2));
sd=sprintf('%8.4g',D);
set(handles.edit_D,'String',sd,'Enable','on');

generateMesh(model,'Hmin',hmin,'Hmax',hmax);
figure(fig_num)
fig_num=fig_num+1;
pdeplot3D(model);
title('Mesh with Quadratic Tetrahedral Elements');

RF = solve(model,'FrequencyRange',[-1,1000]*2*pi);
modeID = 1:numel(RF.NaturalFrequencies);

disp(' ');

fn=RF.NaturalFrequencies/(2*pi);

fprintf(' BC: %d %d %d %d   \n\n',leftBC,topBC,rightBC,bottomBC); 

N=min([length(fn) 8]);

disp(' Mode   fn(Hz)');
for i=1:N
    fprintf(' %d   %8.4g \n',i,fn(i));
end

if(N==1)
    sss=sprintf(' %8.4g \n',fn(1));    
end
if(N==2)
    sss=sprintf(' %8.4g \n %8.4g \n ',fn(1),fn(2));    
end
if(N==3)
    sss=sprintf(' %8.4g \n %8.4g \n %8.4g \n ',fn(1),fn(2),fn(3));    
end
if(N==4)
    sss=sprintf(' %8.4g \n %8.4g \n %8.4g \n %8.4g \n ',fn(1),fn(2),fn(3),fn(4));    
end
if(N==5)
    sss=sprintf(' %8.4g \n %8.4g \n %8.4g \n %8.4g \n %8.4g \n ',fn(1),fn(2),fn(3),fn(4),fn(5));    
end
if(N>=6)
    sss=sprintf(' %8.4g \n %8.4g \n %8.4g \n %8.4g \n %8.4g \n %8.4g ',fn(1),fn(2),fn(3),fn(4),fn(5),fn(6));
end

if(N>=1)
    [fig_num]=plotmodeshape(fig_num,RF,1,N);
end
if(N>=2)
    [fig_num]=plotmodeshape(fig_num,RF,2,N);
end
if(N>=3)
    [fig_num]=plotmodeshape(fig_num,RF,3,N);
end
if(N>=4)
    [fig_num]=plotmodeshape(fig_num,RF,4,N);
end


try
    set(handles.edit_fn,'String',sss,'Enable','on');
    msgbox('Calculation complete');
catch
    warndlg('No natural frequencies found');
end
   
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



% --- Executes on button press in resetpushbutton.
function resetpushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to resetpushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
clear_answer(hObject, eventdata, handles);


function widtheditbox_Callback(hObject, eventdata, handles)
% hObject    handle to widtheditbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of widtheditbox as text
%        str2double(get(hObject,'String')) returns contents of widtheditbox as a double
clear_answer(hObject, eventdata, handles);
handles.width=str2num(get(hObject,'String')); 
guidata(hObject, handles);




% --- Executes during object creation, after setting all properties.
function widtheditbox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to widtheditbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function thicknesseditbox_Callback(hObject, eventdata, handles)
% hObject    handle to thicknesseditbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of thicknesseditbox as text
%        str2double(get(hObject,'String')) returns contents of thicknesseditbox as a double
clear_answer(hObject, eventdata, handles);


handles.thickness=str2num(get(hObject,'String')); 
guidata(hObject, handles);



% --- Executes during object creation, after setting all properties.
function thicknesseditbox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to thicknesseditbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function lengtheditbox_Callback(hObject, eventdata, handles)
% hObject    handle to lengtheditbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of lengtheditbox as text
%        str2double(get(hObject,'String')) returns contents of lengtheditbox as a double
clear_answer(hObject, eventdata, handles);
handles.length=str2num(get(hObject,'String')); 
guidata(hObject, handles);



% --- Executes during object creation, after setting all properties.
function lengtheditbox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to lengtheditbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function massdensityeditbox_Callback(hObject, eventdata, handles)
% hObject    handle to massdensityeditbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of massdensityeditbox as text
%        str2double(get(hObject,'String')) returns contents of massdensityeditbox as a double
clear_answer(hObject, eventdata, handles);
st=get(hObject,'String');
 
handles.mass_density=str2num(st); 
 
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function massdensityeditbox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to massdensityeditbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on key press with focus on lengtheditbox and none of its controls.
function lengtheditbox_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to lengtheditbox (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)

clear_answer(hObject, eventdata, handles);


% --- Executes on key press with focus on widtheditbox and none of its controls.
function widtheditbox_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to widtheditbox (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
clear_answer(hObject, eventdata, handles);


% --- Executes on key press with focus on massdensityeditbox and none of its controls.
function massdensityeditbox_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to massdensityeditbox (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)

clear_answer(hObject, eventdata, handles);



% --- Executes on key press with focus on NSMeditbox and none of its controls.
function NSMeditbox_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to NSMeditbox (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)

clear_answer(hObject, eventdata, handles);

% --- Executes on key press with focus on thicknesseditbox and none of its controls.
function thicknesseditbox_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to thicknesseditbox (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)

guidata(hObject, handles);



% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over lengtheditbox.
function lengtheditbox_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to lengtheditbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on key press with focus on poissoneditbox and none of its controls.
function poissoneditbox_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to poissoneditbox (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
clear_answer(hObject, eventdata, handles);


% --- Executes on key press with focus on elasticmoduluseditbox and none of its controls.
function elasticmoduluseditbox_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to elasticmoduluseditbox (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
clear_answer(hObject, eventdata, handles);


% --- Executes during object creation, after setting all properties.
function axes1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes1



function edit_D_Callback(hObject, eventdata, handles)
% hObject    handle to edit_D (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_D as text
%        str2double(get(hObject,'String')) returns contents of edit_D as a double


% --- Executes during object creation, after setting all properties.
function edit_D_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_D (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_hmin_Callback(hObject, eventdata, handles)
% hObject    handle to edit_hmin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_hmin as text
%        str2double(get(hObject,'String')) returns contents of edit_hmin as a double


% --- Executes during object creation, after setting all properties.
function edit_hmin_CreateFcn(hObject, eventdata, ~)
% hObject    handle to edit_hmin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_hmax_Callback(hObject, eventdata, handles)
% hObject    handle to edit_hmax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_hmax as text
%        str2double(get(hObject,'String')) returns contents of edit_hmax as a double


% --- Executes during object creation, after setting all properties.
function edit_hmax_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_hmax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function[fig_num]=plotmodeshape(fig_num,R,modeID,N)

scale = 0.06;
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
        pseudoTimeVector = 3*timePeriod/4;
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

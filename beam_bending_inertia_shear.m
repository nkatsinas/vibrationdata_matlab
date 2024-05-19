function varargout = beam_bending_inertia_shear(varargin)
% BEAM_BENDING_INERTIA_SHEAR MATLAB code for beam_bending_inertia_shear.fig
%      BEAM_BENDING_INERTIA_SHEAR, by itself, creates a new BEAM_BENDING_INERTIA_SHEAR or raises the existing
%      singleton*.
%
%      H = BEAM_BENDING_INERTIA_SHEAR returns the handle to a new BEAM_BENDING_INERTIA_SHEAR or the handle to
%      the existing singleton*.
%
%      BEAM_BENDING_INERTIA_SHEAR('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in BEAM_BENDING_INERTIA_SHEAR.M with the given input arguments.
%
%      BEAM_BENDING_INERTIA_SHEAR('Property','Value',...) creates a new BEAM_BENDING_INERTIA_SHEAR or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before beam_bending_inertia_shear_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to beam_bending_inertia_shear_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help beam_bending_inertia_shear

% Last Modified by GUIDE v2.5 18-Jan-2013 14:13:01

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @beam_bending_inertia_shear_OpeningFcn, ...
                   'gui_OutputFcn',  @beam_bending_inertia_shear_OutputFcn, ...
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


% --- Executes just before beam_bending_inertia_shear is made visible.
function beam_bending_inertia_shear_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to beam_bending_inertia_shear (see VARARGIN)

% Choose default command line output for beam_bending_inertia_shear
handles.output = hObject;

handles.leftBC=1;
handles.unit=1;
handles.material=1;
handles.cross_section=1;

handles.length=0;
handles.elastic_modulus=0;
handles.mass_density=0;

handles.thick=0;
handles.width=0;

handles.diameter=0;
handles.wall_thick=0;

handles.MOI=0;
handles.area=0;

handles.num=100;
handles.n=4;

set(handles.shear_factor_edit,'String','0.67');

handles.x=zeros(handles.num+1,1);

clc;
axes(handles.axes_beam_image);
bg = imread('beam_image_2.jpg');
image(bg);
axis off; 

set(handles.Answer,'Enable','off');

% Update handles structure
guidata(hObject, handles);

material_change(hObject, eventdata, handles);
geometry_change(hObject, eventdata, handles);

% UIWAIT makes beam_bending_inertia_shear wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = beam_bending_inertia_shear_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in leftBClistbox.
function leftBClistbox_Callback(hObject, eventdata, handles)
% hObject    handle to leftBClistbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns leftBClistbox contents as cell array
%        contents{get(hObject,'Value')} returns selected item from leftBClistbox
set(handles.Answer,'String',' ');
set(handles.Answer,'Enable','off');

cla;

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





% --- Executes on selection change in materiallistbox.
function materiallistbox_Callback(hObject, eventdata, handles)
% hObject    handle to materiallistbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns materiallistbox contents as cell array
%        contents{get(hObject,'Value')} returns selected item from materiallistbox

set(handles.Answer,'String',' ');
set(handles.Answer,'Enable','off');

cla;
handles.material=get(hObject,'Value');

material_change(hObject, eventdata, handles);

guidata(hObject, handles);


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
    if(handles.material==5)  % PVC
        handles.elastic_modulus=3.5e+005;
        handles.mass_density=  0.052;
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
    if(handles.material==5)  % PVC
        handles.elastic_modulus=24.1;
        handles.mass_density=  1440;
    end
end

if(handles.material<6)
    ss1=sprintf('%8.4g',handles.elastic_modulus);
    ss2=sprintf('%8.4g',handles.mass_density);

    set(handles.elasticmoduluseditbox,'String',ss1);
    set(handles.massdensityeditbox,'String',ss2);    
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
set(handles.Answer,'String',' ');
set(handles.Answer,'Enable','off');

cla;

string=get(hObject,'String');
handles.elastic_modulus=str2num(string);
guidata(hObject, handles);


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



function massdensityeditbox_Callback(hObject, eventdata, handles)
% hObject    handle to massdensityeditbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of massdensityeditbox as text
%        str2double(get(hObject,'String')) returns contents of massdensityeditbox as a double
set(handles.Answer,'String',' ');
set(handles.Answer,'Enable','off');

cla;
string=get(hObject,'String');

handles.mass_density=str2num(string);
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



function crosssectioneditbox1_Callback(hObject, eventdata, handles)
% hObject    handle to crosssectioneditbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of crosssectioneditbox1 as text
%        str2double(get(hObject,'String')) returns contents of crosssectioneditbox1 as a double
set(handles.Answer,'String',' ');
set(handles.Answer,'Enable','off');

cla;

handles.thick=0;
handles.diameter=0;
handles.area=0;

string=get(hObject,'String');

if(handles.cross_section==1) % rectangular
    handles.thick=str2num(string);
end
if(handles.cross_section==2) % pipe
    handles.diameter=str2num(string);   
end
if(handles.cross_section==3) % solid cylinder
    handles.diameter=str2num(string);    
end
if(handles.cross_section==4) % other
    handles.area=str2num(string);     
end


guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function crosssectioneditbox1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to crosssectioneditbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function crosssectioneditbox2_Callback(hObject, eventdata, handles)
% hObject    handle to crosssectioneditbox2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of crosssectioneditbox2 as text
%        str2double(get(hObject,'String')) returns contents of crosssectioneditbox2 as a double
set(handles.Answer,'String',' ');
set(handles.Answer,'Enable','off');

cla;



string=get(hObject,'String');

if(handles.cross_section==1) % rectangular
    handles.width=str2num(string);
end
if(handles.cross_section==2) % pipe
    handles.wall_thick=str2num(string);   
end
if(handles.cross_section==3) % solid cylinder
    % nothing to do    
end
if(handles.cross_section==4) % other
    handles.MOI=str2num(string);     
end

guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function crosssectioneditbox2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to crosssectioneditbox2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in crosssectionlistbox.
function crosssectionlistbox_Callback(hObject, eventdata, handles)
% hObject    handle to crosssectionlistbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns crosssectionlistbox contents as cell array
%        contents{get(hObject,'Value')} returns selected item from crosssectionlistbox
set(handles.Answer,'String',' ');
set(handles.Answer,'Enable','off');


n=get(hObject,'Value');

set(handles.shear_factor_edit,'String','0');

if(n==1)
    set(handles.shear_factor_edit,'String','0.67');
end
if(n==2 || n==3)
   set(handles.shear_factor_edit,'String','0.75');
end

cla;

handles.cross_section=n;

guidata(hObject, handles);

geometry_change(hObject, eventdata, handles)


function geometry_change(hObject, eventdata, handles)

set(handles.crosssectioneditbox2,'Enable','on');

if(handles.unit==1)
    if(handles.cross_section==1) % rectangular
        set(handles.crosssectionlabel1,'String','Thickness (in)');
        set(handles.crosssectionlabel2','String','Width (in)');
    end
    if(handles.cross_section==2) % pipe 
        set(handles.crosssectionlabel1,'String','Outer Diameter (in)');
        set(handles.crosssectionlabel2,'String','Wall Thickness (in)');    
    end
    if(handles.cross_section==3) % solid cylinder
        set(handles.crosssectionlabel1,'String','Diameter (in)');
        set(handles.crosssectionlabel2,'String',''); 
        set(handles.crosssectioneditbox2,'Enable','off');
    end
    if(handles.cross_section==4) % other
        set(handles.crosssectionlabel1,'String','Area (in^2)');
        set(handles.crosssectionlabel2,'String','Area Moment of Inertia(in^4)');    
    end
else
    if(handles.cross_section==1) % rectangular
        set(handles.crosssectionlabel1,'String','Thickness (mm)');
        set(handles.crosssectionlabel2','String','Width (mm)');
    end
    if(handles.cross_section==2) % pipe 
        set(handles.crosssectionlabel1,'String','Outer Diameter (mm)');
        set(handles.crosssectionlabel2,'String','Wall Thickness (mm)');    
    end
    if(handles.cross_section==3) % solid cylinder
        set(handles.crosssectionlabel1,'String','Diameter (mm)');
        set(handles.crosssectionlabel2,'String',''); 
        set(handles.crosssectioneditbox2,'Enable','off');
    end
    if(handles.cross_section==4) % other
        set(handles.crosssectionlabel1,'String','Area (mm^2)');
        set(handles.crosssectionlabel2,'String','Area Moment of Inertia(mm^4)');    
    end
end

set(handles.crosssectioneditbox1,'String',' ');
set(handles.crosssectioneditbox2,'String',' ');

handles.thick=0;
handles.width=0;

handles.diameter=0;
handles.wall_thick=0;

handles.MOI=0;
handles.area=0;

set(handles.Answer,'String',' ');
set(handles.Answer,'Enable','off');

cla;





% --- Executes during object creation, after setting all properties.
function crosssectionlistbox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to crosssectionlistbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Answer_Callback(hObject, eventdata, handles)
% hObject    handle to Answer (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Answer as text
%        str2double(get(hObject,'String')) returns contents of Answer as a double


% --- Executes during object creation, after setting all properties.
function Answer_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Answer (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit6_Callback(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit6 as text
%        str2double(get(hObject,'String')) returns contents of edit6 as a double


% --- Executes during object creation, after setting all properties.
function edit6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
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
set(handles.Answer,'String',' ');
set(handles.Answer,'Enable','off');

cla;

string=get(hObject,'String');

handles.length=str2num(string);
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


% --- Executes on selection change in unitslistbox.
function unitslistbox_Callback(hObject, eventdata, handles)
% hObject    handle to unitslistbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns unitslistbox contents as cell array
%        contents{get(hObject,'Value')} returns selected item from unitslistbox
set(handles.Answer,'String',' ');
set(handles.Answer,'Enable','off');

cla;

handles.unit=get(hObject,'Value');

guidata(hObject, handles);

material_change(hObject, eventdata, handles);
geometry_change(hObject, eventdata, handles);




if(handles.unit==1)
    set(handles.lengthlabel,'String','inch');
    set(handles.elasticmoduluslabel,'String','Elastic Modulus (lbf/in^2)');
    set(handles.massdensitylabel,'String','Mass Density (lbm/in^3)');
else
    set(handles.lengthlabel,'String','meter');
    set(handles.elasticmoduluslabel,'String','Elastic Modulus (GPa)'); 
    set(handles.massdensitylabel,'String','Mass Density (kg/m^3)');    
end

guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function unitslistbox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to unitslistbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function shear_factor_edit_Callback(hObject, eventdata, handles)
% hObject    handle to shear_factor_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of shear_factor_edit as text
%        str2double(get(hObject,'String')) returns contents of shear_factor_edit as a double


% --- Executes during object creation, after setting all properties.
function shear_factor_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to shear_factor_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.Answer,'String',' ');
set(handles.Answer,'Enable','off');

cla;


% --- Executes on key press with focus on lengtheditbox and none of its controls.
function lengtheditbox_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to lengtheditbox (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.Answer,'String',' ');
set(handles.Answer,'Enable','off');

cla;

% --- Executes on key press with focus on crosssectioneditbox1 and none of its controls.
function crosssectioneditbox1_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to crosssectioneditbox1 (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.Answer,'String',' ');
set(handles.Answer,'Enable','off');

cla;


% --- Executes on key press with focus on crosssectioneditbox2 and none of its controls.
function crosssectioneditbox2_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to crosssectioneditbox2 (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.Answer,'String',' ');
set(handles.Answer,'Enable','off');

cla;


% --- Executes on key press with focus on elasticmoduluseditbox and none of its controls.
function elasticmoduluseditbox_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to elasticmoduluseditbox (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.Answer,'String',' ');
set(handles.Answer,'Enable','off');

cla;


% --- Executes on key press with focus on massdensityeditbox and none of its controls.
function massdensityeditbox_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to massdensityeditbox (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.Answer,'String',' ');
set(handles.Answer,'Enable','off');

cla;




% --- Executes on button press in calculatebutton.
function calculatebutton_Callback(hObject, eventdata, handles)
% hObject    handle to calculatebutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

set(handles.Answer,'Enable','on');


fn=zeros(4,1);

E=str2num(get(handles.elasticmoduluseditbox,'String'));
rho=str2num(get(handles.massdensityeditbox,'String'));

LBC=get(handles.leftBClistbox,'Value');

L=str2num(get(handles.lengtheditbox,'String'));

k=str2num(get(handles.shear_factor_edit,'String'));

n=handles.n;

root=zeros(n,1);

if(L>1.0e-20 && L<1.0e+20)
    iflag=0;
else
    iflag=2;
    msgbox('Length error');
end


if(iflag==0)

    thick=handles.thick;
    width=handles.width;
    diameter=handles.diameter;
    wall_thick=handles.wall_thick;
    
    

    if(handles.unit==1) % English
        rho=rho/386;
    end
    if(handles.unit==2) % metric
        [E]=GPa_to_Pa(E);
        thick=thick/1000;
        width=width/1000;
        diameter=diameter/1000;
        wall_thick=wall_thick/1000;
    end
    

    if(handles.cross_section==1) % rectangular
       [area,MOI,~]=beam_rectangular_geometry(width,thick); 
    end
    if(handles.cross_section==2) % pipe
        [area,MOI,~]=pipe_geometry_wall(diameter,wall_thick);
    end
    if(handles.cross_section==3) % solid cylinder
        [area,MOI,~]=cylinder_geometry(diameter); 
    end
    if(handles.cross_section==4) % other
        area=handles.area;
        MOI=handles.MOI;
    end
  
%
   
    r2=MOI/area;
    r4=r2^2;
    r=sqrt(r2);
%
    mu=0.3;
    
    a2=E*MOI/(rho*area);
%
    G=E/(2*(1+mu));
%
    EKG=E/(k*G);
    EKG_term=1+EKG;
%   
    A=area;
    I=MOI;

    if(handles.unit==1)
        disp(' ');
out1=sprintf('     Elastic modulus = %9.4g lbf/in^2 ',E);
out2=sprintf('       Shear modulus = %9.4g lbf/in^2 ',G);
out3=sprintf('       Poisson ratio = %9.4g  ',mu);
out4=sprintf('        Mass density = %9.4g lbm/in^3',rho*386);
out5=sprintf('                     = %9.4g lbf sec^2/in^4 ',rho);
out6=sprintf('  Cross-section Area = %9.4g in^2',A);
out7=sprintf(' Area Moment Inertia = %9.4g in^4',I);
out8=sprintf('        Shear factor = %9.4g in^4',k);
out9=sprintf('  Beam radius of gyration = %9.4g in',r);
    else
        disp(' ');
out1=sprintf('     Elastic modulus = %9.4g Pa ',E);
out2=sprintf('       Shear modulus = %9.4g Pa ',G);
out3=sprintf('       Poisson ratio = %9.4g  ',mu);
out4=sprintf('        Mass density = %9.4g kg/m^3',rho);
out5=sprintf('                      ');
out6=sprintf('  Cross-section Area = %9.4g m^2',A);
out7=sprintf(' Area Moment Inertia = %9.4g m^4',I);
out8=sprintf('        Shear factor = %9.4g m^4',k);
out9=sprintf('  Beam radius of gyration = %9.4g m',r);        
    end
%
disp(out1);
disp(out2);
disp(out3);
disp(out4);
disp(out5);
disp(' ');
disp(out6);
disp(out7);
disp(out8);
disp(out9);    

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(LBC==1)
    for(n=1:3)
        npL=n*pi/L;
        npL2=npL^2;
        npL4=npL^4;
%
        A=(1+r2*(EKG_term)*npL2)^2;
        B=4*r2*(rho*a2/(k*G))*npL4;
%
        if(A>=B)
        else
            disp(' Warning: A<B ');
        end
%
        R=sqrt(A-B);
%
        om2=(1+r2*(1 + EKG)*npL2) - R;
        om2=k*G*om2/(2*r2*rho);
%
        omega=sqrt(om2);
        fn(n)=omega/(2*pi);
    end
%
    disp(' ');
    disp(' Natural Frequencies ');
    disp(' ');
%
    for n=1:3
        out1=sprintf(' f%d = %9.5g Hz ',n,fn(n));
        disp(out1);
    end
%
   fn_string=sprintf('%8.4g Hz\n %8.4g Hz\n %8.4g Hz',fn(1),fn(2),fn(3));
%
end
%
if(LBC==2)
%
    disp(' ');
    out0=sprintf('Southwell-Dunkerley Approximation\n (bending & shear only)\n');
    disp(out0);
%
    fb=sqrt(a2);
    fb=3.5156*fb/(2*pi*L^2);
    fs=sqrt(k*G/rho)/(4*L);
%
    A=(1/fb^2)+(1/fs^2);
    fn=sqrt(1/A);
%    
    out1=sprintf('\n\n fb= %8.4g Hz  bending \n fs= %8.4g Hz  shear \n fn= %8.4g Hz  combined\n\n',fb,fs,fn);
    disp(out1);
    disp(' ');
%
    fn_string=out0;
    fn_string=strcat(fn_string,out1);
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
    fstart=fn*0.6;
    df=0.5;
%
    LLL=round((fn-fstart)/0.5);
%
    out3=sprintf('\n\nBruch-Mitchell Method\n (bending, shear & rotary inertia)\n');
    fn_string=strcat(fn_string,out3);
%
    A=area;
    r2=MOI/(A*L^2);
    s2=E*MOI/(k*A*G*L^2);
    b2_initial=rho*A*L^4/(E*MOI);
%
    M=0;     % no end mass
    khat=0;
%
    term_initial=0.5*M*khat^2/(rho*A*L^3);
    MT_initial=M/(rho*A*L^2);
%
    Mbar=0;
    sigma2=0;
%
    clear ddd;
    clear ap;
    clear ff;
%
    LIMIT=50000;
    for i=1:LIMIT
        fn=(i-1)*df+fstart;
        omega=2*pi*fn;
        om2=omega^2;
        b2=b2_initial*om2;
        b=sqrt(b2);
        bsr2=b2*s2*r2;
        term=term_initial*b2;
%
        clear alpha2;
        clear beta2;
%
        sqterm = sqrt((r2-s2)^2+(4/b^2));
%
        alpha2= -(r2+s2) + sqterm;
        beta2=   (r2+s2) + sqterm;
%
        alpha2= alpha2*0.5;
         beta2=  beta2*0.5;       
%
        ap(i)=alpha2;
        ff(i)=fn;
%
        if( alpha2 > 1.0e-20) 
%
        alpha=sqrt(alpha2);
        beta=sqrt(beta2);
%
        bs2=b2*s2;
        MT=MT_initial*bs2;
%
        balpha=b*alpha;
        bbeta =b*beta;
%
        H1= (1-bs2*(alpha2+r2))*L/balpha;
        H2= (1-bs2*(alpha2+r2))*L/balpha;
        H3=-(1+bs2*(beta2-r2))*L/bbeta;
        H4= (1+bs2*(beta2-r2))*L/bbeta;
%
        ba=b*alpha;
        bb=b*beta;
%     
        coshba =cosh(ba);  
        sinhba =sinh(ba);
        cosbb  =cos(bb);  
        sinbb  =sin(bb);   
%
        MC=Mbar*b2;
        MCC=0.5*Mbar*sigma2*b2;
%        
        alphaC=(alpha2+s2)/alpha;
        betaC =(beta2-s2)/beta;  
%
        R1= (b/alpha)*sinhba + MC*coshba;
        R2= (b/alpha)*coshba + MC*sinhba;
        R3=  (b/beta)*sinbb  + MC*cosbb;
        R4= -(b/beta)*cosbb  + MC*sinbb;
%
        R1P= alphaC*( ba*coshba - MCC*sinhba);
        R2P= alphaC*( ba*sinhba - MCC*coshba);
        R3P= -betaC*( bb*cosbb  - MCC*sinbb);
        R4P=  betaC*(-bb*sinbb  - MCC*cosbb);
%
        M=zeros(4,4);
        M(1,1)=1;
        M(1,3)=1;
        M(2,2)=alphaC;
        M(2,4)=betaC;        
%
        M(3,1)= R1;
        M(3,2)= R2;
        M(3,3)= R3;
        M(3,4)= R4;
%        
        M(4,1)= R1P;
        M(4,2)= R2P;
        M(4,3)= R3P;
        M(4,4)= R4P;
%
        num=det(M);
        ddd(i)=abs(num);
%
        if(i>=2 &&  abs(real(num)) > abs(imag(num)))
            if(num*num_before<=0)
                out1=sprintf('\n fn=%8.4g Hz',fn);
                disp(out1);
                fn_string=strcat(fn_string,out1);
                break;
            end
        end
%
        num_before=num;
%
    end
    end
    disp(' ');
    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
set(handles.Answer,'String',fn_string);

end

guidata(hObject, handles);


% --- Executes on key press with focus on shear_factor_edit and none of its controls.
function shear_factor_edit_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to shear_factor_edit (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.Answer,'String',' ');
set(handles.Answer,'Enable','off');

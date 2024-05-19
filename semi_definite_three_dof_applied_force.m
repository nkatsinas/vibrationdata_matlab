function varargout = semi_definite_three_dof_applied_force(varargin)
% SEMI_DEFINITE_THREE_DOF_APPLIED_FORCE MATLAB code for semi_definite_three_dof_applied_force.fig
%      SEMI_DEFINITE_THREE_DOF_APPLIED_FORCE, by itself, creates a new SEMI_DEFINITE_THREE_DOF_APPLIED_FORCE or raises the existing
%      singleton*.
%
%      H = SEMI_DEFINITE_THREE_DOF_APPLIED_FORCE returns the handle to a new SEMI_DEFINITE_THREE_DOF_APPLIED_FORCE or the handle to
%      the existing singleton*.
%
%      SEMI_DEFINITE_THREE_DOF_APPLIED_FORCE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SEMI_DEFINITE_THREE_DOF_APPLIED_FORCE.M with the given input arguments.
%
%      SEMI_DEFINITE_THREE_DOF_APPLIED_FORCE('Property','Value',...) creates a new SEMI_DEFINITE_THREE_DOF_APPLIED_FORCE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before semi_definite_three_dof_applied_force_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to semi_definite_three_dof_applied_force_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help semi_definite_three_dof_applied_force

% Last Modified by GUIDE v2.5 07-Aug-2017 17:56:57

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @semi_definite_three_dof_applied_force_OpeningFcn, ...
                   'gui_OutputFcn',  @semi_definite_three_dof_applied_force_OutputFcn, ...
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


% --- Executes just before semi_definite_three_dof_applied_force is made visible.
function semi_definite_three_dof_applied_force_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to semi_definite_three_dof_applied_force (see VARARGIN)

% Choose default command line output for semi_definite_three_dof_applied_force
handles.output = hObject;


set(handles.pushbutton_constant_force,'Visible','off');

fstr='semidefinite_three_dof_force.jpg';
 
bg = imread(fstr);
info = imfinfo(fstr);
w = info.Width;  %An integer indicating the width of the image in pixels
h = info.Height; %An integer indicating the height of the image in pixels
 
axes(handles.axes1);
image(bg);
 
pos1 = getpixelposition(handles.uipanel_data,true);
pos2 = getpixelposition(handles.axes1,true);

x=round(0.5*pos1(3));
y=round(0.5*pos1(4)-0.5*h);
 
set(handles.axes1, ...
    'Visible', 'off', ...
    'Units', 'pixels', ...
    'Position', [x y w h]);
axis off;


 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

for i = 1:3
   for j=1:1
      data_m{i,j} = '';     
   end 
end
set(handles.uitable_mass,'Data',data_m); 

for i = 1:2
   for j=1:1
      data_s{i,j} = '';     
   end 
end
set(handles.uitable_stiffness,'Data',data_s); 



% Update handles structure
guidata(hObject, handles);

% UIWAIT makes semi_definite_three_dof_applied_force wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = semi_definite_three_dof_applied_force_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in units_listbox.
function units_listbox_Callback(hObject, eventdata, handles)
% hObject    handle to units_listbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns units_listbox contents as cell array
%        contents{get(hObject,'Value')} returns selected item from units_listbox

set(handles.pushbutton_constant_force,'Visible','off');

n=get(hObject,'Value');

if(n==1)
    set(handles.mass_unit_text,'String','Mass Unit: lbm');
    set(handles.stiffness_unit_text,'String','Stiffness Unit: lbf/in');    
else
    set(handles.mass_unit_text,'String','Mass Unit: kg'); 
    set(handles.stiffness_unit_text,'String','Stiffness Unit: N/m');     
end

% Update handles structure
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function units_listbox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to units_listbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function mass2_edit_Callback(hObject, eventdata, handles)
% hObject    handle to mass2_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of mass2_edit as text
%        str2double(get(hObject,'String')) returns contents of mass2_edit as a double


% --- Executes during object creation, after setting all properties.
function mass2_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to mass2_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function stiffness_edit_Callback(hObject, eventdata, handles)
% hObject    handle to stiffness_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of stiffness_edit as text
%        str2double(get(hObject,'String')) returns contents of stiffness_edit as a double


% --- Executes during object creation, after setting all properties.
function stiffness_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to stiffness_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function mass1_edit_Callback(hObject, eventdata, handles)
% hObject    handle to mass1_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of mass1_edit as text
%        str2double(get(hObject,'String')) returns contents of mass1_edit as a double


% --- Executes during object creation, after setting all properties.
function mass1_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to mass1_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in calculate_pushbutton.
function calculate_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to calculate_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

disp(' ');
disp(' * * * * ');

iu=get(handles.units_listbox,'value');

% * * * *

mA=char(get(handles.uitable_mass,'Data'));
mB=str2num(mA);
mV=mB(1:3);
mV=fix_size(mV);
mV=flipud(mV);

% * * * *

kA=char(get(handles.uitable_stiffness,'Data'));
kB=str2num(kA);
kV=kB(1:2);
kV=fix_size(kV);
kV=flipud(kV);

k1=kV(1);
k2=kV(2);

% * * * *

mass=zeros(3,3);

mass(1,1)=mV(1);
mass(2,2)=mV(2);
mass(3,3)=mV(3);

stiffness=[k1 -k1 0; -k1 k1+k2 -k2; 0 -k2 k2];

%
if(iu==1)
   mass=mass/386.;
end
%

[fn,ModeShapes,~,~]=three_dof_fn_results(mass,stiffness);

setappdata(0,'fn',fn);
setappdata(0,'ModeShapes',ModeShapes);
setappdata(0,'mass',mass);
setappdata(0,'stiffness',stiffness);
setappdata(0,'k1',k1);
setappdata(0,'k2',k2);

set(handles.pushbutton_constant_force,'Visible','on');

msgbox('Calculation complete.  Output written to Matlab Command Window.');



% --- Executes on button press in pushbutton_return.
function pushbutton_return_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_return (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close(semi_definite_three_dof_applied_force);


% --- Executes on button press in pushbutton_constant_force.
function pushbutton_constant_force_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_constant_force (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.s= semidefinite_three_dof_constant_force;
set(handles.s,'Visible','on');


% --- Executes on key press with focus on uitable_mass and none of its controls.
function uitable_mass_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to uitable_mass (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.TABLE)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.pushbutton_constant_force,'Visible','off');


% --- Executes on key press with focus on uitable_stiffness and none of its controls.
function uitable_stiffness_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to uitable_stiffness (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.TABLE)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.pushbutton_constant_force,'Visible','off');

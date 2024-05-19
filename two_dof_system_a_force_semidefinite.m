function varargout = two_dof_system_a_force_semidefinite(varargin)
% TWO_DOF_SYSTEM_A_FORCE_SEMIDEFINITE MATLAB code for two_dof_system_a_force_semidefinite.fig
%      TWO_DOF_SYSTEM_A_FORCE_SEMIDEFINITE, by itself, creates a new TWO_DOF_SYSTEM_A_FORCE_SEMIDEFINITE or raises the existing
%      singleton*.
%
%      H = TWO_DOF_SYSTEM_A_FORCE_SEMIDEFINITE returns the handle to a new TWO_DOF_SYSTEM_A_FORCE_SEMIDEFINITE or the handle to
%      the existing singleton*.
%
%      TWO_DOF_SYSTEM_A_FORCE_SEMIDEFINITE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TWO_DOF_SYSTEM_A_FORCE_SEMIDEFINITE.M with the given input arguments.
%
%      TWO_DOF_SYSTEM_A_FORCE_SEMIDEFINITE('Property','Value',...) creates a new TWO_DOF_SYSTEM_A_FORCE_SEMIDEFINITE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before two_dof_system_a_force_semidefinite_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to two_dof_system_a_force_semidefinite_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help two_dof_system_a_force_semidefinite

% Last Modified by GUIDE v2.5 14-Apr-2017 16:27:23

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @two_dof_system_a_force_semidefinite_OpeningFcn, ...
                   'gui_OutputFcn',  @two_dof_system_a_force_semidefinite_OutputFcn, ...
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


% --- Executes just before two_dof_system_a_force_semidefinite is made visible.
function two_dof_system_a_force_semidefinite_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to two_dof_system_a_force_semidefinite (see VARARGIN)

% Choose default command line output for two_dof_system_a_force_semidefinite
handles.output = hObject;


fstr='two_dof_a_force.jpg';

bg = imread(fstr);
info = imfinfo(fstr);
w = info.Width;  %An integer indicating the width of the image in pixels
h = info.Height; %An integer indicating the height of the image in pixels
 
axes(handles.axes1);
image(bg);
 
pos1 = getpixelposition(handles.pushbutton_return,true);
pos2 = getpixelposition(handles.uipanel_data,true);
 
set(handles.axes1, ...
    'Visible', 'off', ...
    'Units', 'pixels', ...
    'Position', [pos1(1) pos2(2) w h]);
axis off;



clear_buttons(hObject, eventdata, handles);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes two_dof_system_a_force_semidefinite wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = two_dof_system_a_force_semidefinite_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton_return.
function pushbutton_return_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_return (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

delete(two_dof_system_a_force);


% --- Executes on selection change in units_listbox.
function units_listbox_Callback(hObject, eventdata, handles)
% hObject    handle to units_listbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns units_listbox contents as cell array
%        contents{get(hObject,'Value')} returns selected item from units_listbox

n=get(handles.units_listbox,'Value');

if(n==1)
    set(handles.mass_unit_text,'String','Mass Unit: lbm');
    set(handles.stiffness_unit_text,'String','Stiffness Unit: lbf/in');    
else
    set(handles.mass_unit_text,'String','Mass Unit: kg'); 
    set(handles.stiffness_unit_text,'String','Stiffness Unit: N/m');     
end

clear_buttons(hObject, eventdata, handles)

%
function clear_buttons(hObject, eventdata, handles)
set(handles.pushbutton_enter_damping,'Visible','off');
set(handles.pushbutton_FRF,'Visible','off');
set(handles.pushbutton_sine,'Visible','off');
set(handles.pushbutton_arbitrary_pulse,'Visible','off');
set(handles.pushbutton_PSD,'Visible','off');
%

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


% --- Executes on button press in pushbutton_fn.
function pushbutton_fn_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_fn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

iu=get(handles.units_listbox,'value');

m1=str2num( get(handles.mass1_edit,'String' ));
m2=str2num( get(handles.mass2_edit,'String' ));
k=str2num( get(handles.stiffness_edit,'String' ));

mass=zeros(2,2);

mass(1,1)=m1;
mass(2,2)=m2;

stiffness=[k -k; -k k];

%
if(iu==1)
   mass=mass/386.;
end
%
disp(' ');
disp(' mass matrix ');
mass
disp(' ');
disp(' stiffness matrix ');
stiffness

%
disp(' ');
[fn,omega,ModeShapes,MST]=Generalized_Eigen(stiffness,mass,1);
%
%
setappdata(0,'unit',iu);
setappdata(0,'m2',mass);
setappdata(0,'k2',stiffness);
setappdata(0,'fn',fn);
setappdata(0,'ModeShapes',ModeShapes);

set(handles.pushbutton_enter_damping,'Visible','on');

msgbox('Calculation complete.  Output written to Matlab Command Window.');


% --- Executes on button press in pushbutton_enter_damping.
function pushbutton_enter_damping_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_enter_damping (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

set(handles.pushbutton_FRF,'Visible','on');
set(handles.pushbutton_sine,'Visible','on');
set(handles.pushbutton_arbitrary_pulse,'Visible','on');
set(handles.pushbutton_PSD,'Visible','on');


handles.s= two_dof_damping;
set(handles.s,'Visible','on');


% --- Executes on button press in pushbutton_arbitrary_pulse.
function pushbutton_arbitrary_pulse_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_arbitrary_pulse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.s= vibrationdata_two_dof_arbitrary_force_semidefinite;
set(handles.s,'Visible','on');


% --- Executes on button press in pushbutton_FRF.
function pushbutton_FRF_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_FRF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.s= vibrationdata_force_frf;
set(handles.s,'Visible','on');


% --- Executes on button press in pushbutton_sine.
function pushbutton_sine_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_sine (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.s=vibrationdata_two_dof_sine_force;
set(handles.s,'Visible','on');


% --- Executes on button press in pushbutton_PSD.
function pushbutton_PSD_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_PSD (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.s=vibrationdata_two_dof_psd_force;
set(handles.s,'Visible','on');

function varargout = vibrationdata_velocity_limit_yield_stress(varargin)
% VIBRATIONDATA_VELOCITY_LIMIT_YIELD_STRESS MATLAB code for vibrationdata_velocity_limit_yield_stress.fig
%      VIBRATIONDATA_VELOCITY_LIMIT_YIELD_STRESS, by itself, creates a new VIBRATIONDATA_VELOCITY_LIMIT_YIELD_STRESS or raises the existing
%      singleton*.
%
%      H = VIBRATIONDATA_VELOCITY_LIMIT_YIELD_STRESS returns the handle to a new VIBRATIONDATA_VELOCITY_LIMIT_YIELD_STRESS or the handle to
%      the existing singleton*.
%
%      VIBRATIONDATA_VELOCITY_LIMIT_YIELD_STRESS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in VIBRATIONDATA_VELOCITY_LIMIT_YIELD_STRESS.M with the given input arguments.
%
%      VIBRATIONDATA_VELOCITY_LIMIT_YIELD_STRESS('Property','Value',...) creates a new VIBRATIONDATA_VELOCITY_LIMIT_YIELD_STRESS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before vibrationdata_velocity_limit_yield_stress_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to vibrationdata_velocity_limit_yield_stress_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help vibrationdata_velocity_limit_yield_stress

% Last Modified by GUIDE v2.5 18-May-2021 11:58:02

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @vibrationdata_velocity_limit_yield_stress_OpeningFcn, ...
                   'gui_OutputFcn',  @vibrationdata_velocity_limit_yield_stress_OutputFcn, ...
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


% --- Executes just before vibrationdata_velocity_limit_yield_stress is made visible.
function vibrationdata_velocity_limit_yield_stress_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to vibrationdata_velocity_limit_yield_stress (see VARARGIN)

% Choose default command line output for vibrationdata_velocity_limit_yield_stress
handles.output = hObject;

set(handles.uipanel_results,'Visible','off');

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes vibrationdata_velocity_limit_yield_stress wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = vibrationdata_velocity_limit_yield_stress_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

E=str2double(get(handles.edit_E,'String'));
rho=str2double(get(handles.edit_rho,'String'));
Y=str2double(get(handles.edit_Y,'String'));

rho=rho/386;
c=sqrt(E/rho);

rhoc=rho*c;

nu=get(handles.listbox_yu,'Value');

if(nu==2)
    Y=Y*1000;
end

vbar=Y/rhoc;
vbeam=vbar/sqrt(3);
vpipe=vbar/sqrt(2);
vplate=vbar/2;
vcyl=vplate;

AE=Y^2/(2*E);

s1=sprintf('Speed of sound = %7.3g in/sec',c);
s2=sprintf('Velocity Rod Longitudinal = %7.3g in/sec',vbar);
s3=sprintf('Velocity Pipe Thin-walled Bending = %7.3g in/sec',vpipe);
s4=sprintf('Velocity Beam Rectangular Bending = %7.3g in/sec',vbeam);
s5=sprintf('Velocity Beam Solid Cylinder Bending = %7.3g in/sec',vcyl);
s6=sprintf('Velocity Plate Bending = %7.3g in/sec',vplate);
s7=sprintf('Absorbed Energy per Volume = %7.3g psi',AE);
             
sss = sprintf('\n %s \n\n %s \n\n %s \n\n %s \n\n %s \n\n %s \n\n %s',s1,s2,s3,s4,s5,s6,s7);             
             
set(handles.edit_results,'String',sss);


set(handles.uipanel_results,'Visible','on');



% --- Executes on button press in pushbutton_return.
function pushbutton_return_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_return (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

delete(vibrationdata_velocity_limit_yield_stress);



function edit_results_Callback(hObject, eventdata, handles)
% hObject    handle to edit_results (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_results as text
%        str2double(get(hObject,'String')) returns contents of edit_results as a double


% --- Executes during object creation, after setting all properties.
function edit_results_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_results (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_E_Callback(hObject, eventdata, handles)
% hObject    handle to edit_E (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_E as text
%        str2double(get(hObject,'String')) returns contents of edit_E as a double


% --- Executes during object creation, after setting all properties.
function edit_E_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_E (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_rho_Callback(hObject, eventdata, handles)
% hObject    handle to edit_rho (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_rho as text
%        str2double(get(hObject,'String')) returns contents of edit_rho as a double


% --- Executes during object creation, after setting all properties.
function edit_rho_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_rho (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_Y_Callback(hObject, eventdata, handles)
% hObject    handle to edit_Y (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_Y as text
%        str2double(get(hObject,'String')) returns contents of edit_Y as a double


% --- Executes during object creation, after setting all properties.
function edit_Y_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_Y (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_yu.
function listbox_yu_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_yu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_yu contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_yu
set(handles.uipanel_results,'Visible','off');

% --- Executes during object creation, after setting all properties.
function listbox_yu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_yu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on key press with focus on edit_E and none of its controls.
function edit_E_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_E (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.uipanel_results,'Visible','off');


% --- Executes on key press with focus on edit_rho and none of its controls.
function edit_rho_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_rho (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.uipanel_results,'Visible','off');


% --- Executes on key press with focus on edit_Y and none of its controls.
function edit_Y_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_Y (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.uipanel_results,'Visible','off');

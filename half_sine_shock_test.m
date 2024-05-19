function varargout = half_sine_shock_test(varargin)
% HALF_SINE_SHOCK_TEST MATLAB code for half_sine_shock_test.fig
%      HALF_SINE_SHOCK_TEST, by itself, creates a new HALF_SINE_SHOCK_TEST or raises the existing
%      singleton*.
%
%      H = HALF_SINE_SHOCK_TEST returns the handle to a new HALF_SINE_SHOCK_TEST or the handle to
%      the existing singleton*.
%
%      HALF_SINE_SHOCK_TEST('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in HALF_SINE_SHOCK_TEST.M with the given input arguments.
%
%      HALF_SINE_SHOCK_TEST('Property','Value',...) creates a new HALF_SINE_SHOCK_TEST or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before half_sine_shock_test_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to half_sine_shock_test_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help half_sine_shock_test

% Last Modified by GUIDE v2.5 09-Aug-2014 14:14:10

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @half_sine_shock_test_OpeningFcn, ...
                   'gui_OutputFcn',  @half_sine_shock_test_OutputFcn, ...
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


% --- Executes just before half_sine_shock_test is made visible.
function half_sine_shock_test_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to half_sine_shock_test (see VARARGIN)

% Choose default command line output for half_sine_shock_test
handles.output = hObject;

set(handles.uipanel_velocity,'Visible','off');
set(handles.uipanel_displacement,'Visible','off');
set(handles.uipanel_drop_height,'Visible','off');

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes half_sine_shock_test wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = half_sine_shock_test_OutputFcn(hObject, eventdata, handles) 
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

delete(half_sine_shock_test);

% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

set(handles.uipanel_velocity,'Visible','on');
set(handles.uipanel_displacement,'Visible','on');
set(handles.uipanel_drop_height,'Visible','on');

A=str2num(get(handles.edit_peak_accel,'String'));
T=str2num(get(handles.edit_duration,'String'));
n=get(handles.listbox_rebound,'Value');

A=A*386;
T=T/1000;

TC=2*A*T/pi;

if(n==1) %    0%
    
    max_v=0;
    min_v=-TC;    
    max_d=0;
    min_d=-TC*T/2;   
    
    H=TC^2/(2*386);

else     %  100%
    
    max_v=TC/2;
    min_v=-TC/2;    
    max_d=0;
    min_d=-TC*T/(2*pi);  
    
    H=TC^2/(8*386);
    
end    

s_TC=sprintf('%8.3g',TC);
s_max_v=sprintf('%8.3g',max_v);
s_min_v=sprintf('%8.3g',min_v);
s_max_d=sprintf('%8.3g',max_d);
s_min_d=sprintf('%8.3g',min_d);

s_H=sprintf('%8.3g',H);

set(handles.edit_dh,'String',s_H);
set(handles.edit_total_change,'String',s_TC);
set(handles.edit_maximum_velocity,'String',s_max_v);
set(handles.edit_minimum_velocity,'String',s_min_v);
set(handles.edit_maximum_disp,'String',s_max_d);
set(handles.edit_minimum_disp,'String',s_min_d);




function edit_peak_accel_Callback(hObject, eventdata, handles)
% hObject    handle to edit_peak_accel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_peak_accel as text
%        str2double(get(hObject,'String')) returns contents of edit_peak_accel as a double
clear_results(hObject, eventdata, handles);

% --- Executes during object creation, after setting all properties.
function edit_peak_accel_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_peak_accel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_duration_Callback(hObject, eventdata, handles)
% hObject    handle to edit_duration (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_duration as text
%        str2double(get(hObject,'String')) returns contents of edit_duration as a double

clear_results(hObject, eventdata, handles);

% --- Executes during object creation, after setting all properties.
function edit_duration_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_duration (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_rebound.
function listbox_rebound_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_rebound (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_rebound contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_rebound

clear_results(hObject, eventdata, handles);

% --- Executes during object creation, after setting all properties.
function listbox_rebound_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_rebound (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_maximum_disp_Callback(hObject, eventdata, handles)
% hObject    handle to edit_maximum_disp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_maximum_disp as text
%        str2double(get(hObject,'String')) returns contents of edit_maximum_disp as a double


% --- Executes during object creation, after setting all properties.
function edit_maximum_disp_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_maximum_disp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_minimum_disp_Callback(hObject, eventdata, handles)
% hObject    handle to edit_minimum_disp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_minimum_disp as text
%        str2double(get(hObject,'String')) returns contents of edit_minimum_disp as a double


% --- Executes during object creation, after setting all properties.
function edit_minimum_disp_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_minimum_disp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_total_change_Callback(hObject, eventdata, handles)
% hObject    handle to edit_total_change (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_total_change as text
%        str2double(get(hObject,'String')) returns contents of edit_total_change as a double


% --- Executes during object creation, after setting all properties.
function edit_total_change_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_total_change (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_minimum_velocity_Callback(hObject, eventdata, handles)
% hObject    handle to edit_minimum_velocity (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_minimum_velocity as text
%        str2double(get(hObject,'String')) returns contents of edit_minimum_velocity as a double


% --- Executes during object creation, after setting all properties.
function edit_minimum_velocity_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_minimum_velocity (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_maximum_velocity_Callback(hObject, eventdata, handles)
% hObject    handle to edit_maximum_velocity (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_maximum_velocity as text
%        str2double(get(hObject,'String')) returns contents of edit_maximum_velocity as a double


% --- Executes during object creation, after setting all properties.
function edit_maximum_velocity_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_maximum_velocity (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function clear_results(hObject, eventdata, handles)

set(handles.uipanel_velocity,'Visible','off');
set(handles.uipanel_displacement,'Visible','off');
set(handles.uipanel_drop_height,'Visible','off');



function edit_dh_Callback(hObject, eventdata, handles)
% hObject    handle to edit_dh (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_dh as text
%        str2double(get(hObject,'String')) returns contents of edit_dh as a double


% --- Executes during object creation, after setting all properties.
function edit_dh_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_dh (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

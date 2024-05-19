function varargout = KI_through_crack_right_angle(varargin)
% KI_THROUGH_CRACK_RIGHT_ANGLE MATLAB code for KI_through_crack_right_angle.fig
%      KI_THROUGH_CRACK_RIGHT_ANGLE, by itself, creates a new KI_THROUGH_CRACK_RIGHT_ANGLE or raises the existing
%      singleton*.
%
%      H = KI_THROUGH_CRACK_RIGHT_ANGLE returns the handle to a new KI_THROUGH_CRACK_RIGHT_ANGLE or the handle to
%      the existing singleton*.
%
%      KI_THROUGH_CRACK_RIGHT_ANGLE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in KI_THROUGH_CRACK_RIGHT_ANGLE.M with the given input arguments.
%
%      KI_THROUGH_CRACK_RIGHT_ANGLE('Property','Value',...) creates a new KI_THROUGH_CRACK_RIGHT_ANGLE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before KI_through_crack_right_angle_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to KI_through_crack_right_angle_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help KI_through_crack_right_angle

% Last Modified by GUIDE v2.5 18-Nov-2014 11:43:10

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @KI_through_crack_right_angle_OpeningFcn, ...
                   'gui_OutputFcn',  @KI_through_crack_right_angle_OutputFcn, ...
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


% --- Executes just before KI_through_crack_right_angle is made visible.
function KI_through_crack_right_angle_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to KI_through_crack_right_angle (see VARARGIN)

% Choose default command line output for KI_through_crack_right_angle
handles.output = hObject;

set(handles.uipanel_results,'Visible','off');

fstr='fplate_1.png';

bg = imread(fstr);
info = imfinfo(fstr);
w = info.Width;  %An integer indicating the width of the image in pixels
h = info.Height; %An integer indicating the height of the image in pixels
 
axes(handles.axes1);
image(bg);
pos1 = getpixelposition(handles.axes1,true);
 
set(handles.axes1, ...
    'Visible', 'off', ...
    'Units', 'pixels', ...
    'Position', [pos1(1) pos1(2) w h]);
axis off; 


%%%%%%%

listbox_units_Callback(hObject, eventdata, handles);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes KI_through_crack_right_angle wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = KI_through_crack_right_angle_OutputFcn(hObject, eventdata, handles) 
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

delete(KI_through_crack_right_angle);


% --- Executes on selection change in listbox_units.
function listbox_units_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_units (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_units contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_units
set(handles.uipanel_results,'Visible','off');

n=get(handles.listbox_units,'Value');

if(n==1)
    set(handles.text_length,'String','inch');
    set(handles.text_stress,'String','ksi');    
else
    set(handles.text_length,'String','mm'); 
    set(handles.text_stress,'String','MPa');       
end



% --- Executes during object creation, after setting all properties.
function listbox_units_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_units (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

n=get(handles.listbox_units,'Value');

sigma=str2num(get(handles.edit_stress,'String'));

two_a=str2num(get(handles.edit_length,'String'));

a=two_a/2;

KI=sigma*sqrt(pi*a);

MPa_per_ksi=6.894;
ksi_per_MPa=1/MPa_per_ksi;

m_per_inch=0.0254;
inch_per_m=1/m_per_inch;


if(n==1)
    KI_english=KI;
    KI_metric=KI_english*(MPa_per_ksi*sqrt(m_per_inch));
else
    KI_metric=KI;
    KI_english=KI_metric*(ksi_per_MPa*sqrt(inch_per_m));
end

sse=sprintf('%7.3g',KI_english);
ssm=sprintf('%7.3g',KI_metric);

set(handles.edit_KI_english,'String',sse);
set(handles.edit_KI_metric,'String',ssm);

set(handles.uipanel_results,'Visible','on');


function edit_KI_metric_Callback(hObject, eventdata, handles)
% hObject    handle to edit_KI_metric (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_KI_metric as text
%        str2double(get(hObject,'String')) returns contents of edit_KI_metric as a double


% --- Executes during object creation, after setting all properties.
function edit_KI_metric_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_KI_metric (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_KI_english_Callback(hObject, eventdata, handles)
% hObject    handle to edit_KI_english (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_KI_english as text
%        str2double(get(hObject,'String')) returns contents of edit_KI_english as a double


% --- Executes during object creation, after setting all properties.
function edit_KI_english_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_KI_english (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_length_Callback(hObject, eventdata, handles)
% hObject    handle to edit_length (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_length as text
%        str2double(get(hObject,'String')) returns contents of edit_length as a double


% --- Executes during object creation, after setting all properties.
function edit_length_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_length (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_stress_Callback(hObject, eventdata, handles)
% hObject    handle to edit_stress (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_stress as text
%        str2double(get(hObject,'String')) returns contents of edit_stress as a double


% --- Executes during object creation, after setting all properties.
function edit_stress_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_stress (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on key press with focus on edit_stress and none of its controls.
function edit_stress_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_stress (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.uipanel_results,'Visible','off');


% --- Executes on key press with focus on edit_length and none of its controls.
function edit_length_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_length (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.uipanel_results,'Visible','off');

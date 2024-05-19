function varargout = stress_through_crack_edge_right_angle(varargin)
% STRESS_THROUGH_CRACK_EDGE_RIGHT_ANGLE MATLAB code for stress_through_crack_edge_right_angle.fig
%      STRESS_THROUGH_CRACK_EDGE_RIGHT_ANGLE, by itself, creates a new STRESS_THROUGH_CRACK_EDGE_RIGHT_ANGLE or raises the existing
%      singleton*.
%
%      H = STRESS_THROUGH_CRACK_EDGE_RIGHT_ANGLE returns the handle to a new STRESS_THROUGH_CRACK_EDGE_RIGHT_ANGLE or the handle to
%      the existing singleton*.
%
%      STRESS_THROUGH_CRACK_EDGE_RIGHT_ANGLE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in STRESS_THROUGH_CRACK_EDGE_RIGHT_ANGLE.M with the given input arguments.
%
%      STRESS_THROUGH_CRACK_EDGE_RIGHT_ANGLE('Property','Value',...) creates a new STRESS_THROUGH_CRACK_EDGE_RIGHT_ANGLE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before stress_through_crack_edge_right_angle_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to stress_through_crack_edge_right_angle_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help stress_through_crack_edge_right_angle

% Last Modified by GUIDE v2.5 12-Oct-2016 11:18:27

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @stress_through_crack_edge_right_angle_OpeningFcn, ...
                   'gui_OutputFcn',  @stress_through_crack_edge_right_angle_OutputFcn, ...
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


% --- Executes just before stress_through_crack_edge_right_angle is made visible.
function stress_through_crack_edge_right_angle_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to stress_through_crack_edge_right_angle (see VARARGIN)

% Choose default command line output for stress_through_crack_edge_right_angle
handles.output = hObject;

fstr='fplate_edge2.jpg';

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




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

set(handles.uipanel_save,'Visible','off');

set(handles.listbox_KIC,'Value',1);

listbox_KIC_Callback(hObject, eventdata, handles);


% Update handles structure
guidata(hObject, handles);

% UIWAIT makes stress_through_crack_edge_right_angle wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = stress_through_crack_edge_right_angle_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

KIC=str2num(get(handles.edit_KIC,'String'));

KIC=KIC*(1.0e+06);

a=str2num(get(handles.edit_a,'String'));



a=a/1000;

stress=KIC/(1.1215*sqrt(pi*a));

stress=stress/(1.0e+06)

stress_ksi=stress*0.1450377;

%
out5 = sprintf('\n Stress = %10.3g MPa',stress);
disp(out5);
out6 = sprintf('\n        = %10.3g ksi\n',stress_ksi);
disp(out6)

ss=sprintf('%10.3g',stress);
set(handles.edit_stress,'String',ss);

ss_ksi=sprintf('%10.3g',stress_ksi);
set(handles.edit_stress_ksi,'String',ss_ksi);


set(handles.uipanel_save,'Visible','on');




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



function edit_stress_ksi_Callback(hObject, eventdata, handles)
% hObject    handle to edit_stress_ksi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_stress_ksi as text
%        str2double(get(hObject,'String')) returns contents of edit_stress_ksi as a double


% --- Executes during object creation, after setting all properties.
function edit_stress_ksi_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_stress_ksi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_a_Callback(hObject, eventdata, handles)
% hObject    handle to edit_a (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_a as text
%        str2double(get(hObject,'String')) returns contents of edit_a as a double


% --- Executes during object creation, after setting all properties.
function edit_a_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_a (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_KIC.
function listbox_KIC_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_KIC (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_KIC contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_KIC

set(handles.uipanel_save,'Visible','off');

n=get(handles.listbox_KIC,'Value');

KIC(1)= 16;  % Aluminum, Generic, Low
KIC(2)= 44;  % Aluminum, Generic, High
KIC(3)= 16;  % Aluminum, 7075, Low
KIC(4)= 41;  % Aluminum, 7075, High
KIC(5)= 6;   % Cast Iron, Low
KIC(6)= 20;  % Cast Iron, High
KIC(7)= 170; % Pressure-vessel Steel (HY130)
KIC(8)= 50;  % High-Strength Steel, Low
KIC(9)= 154; % High-Strength Steel, High
KIC(10)=140; % Mild Steel
KIC(11)= 77; % Titanium Alloy, Low
KIC(12)= 116; % Titanium Alloy, High
KIC(13)= 0.3; % Epoxy, Low
KIC(14)= 0.5; % Epoxy, High
KIC(15)= 0.2; % Cement/Concrete
KIC(16)= 10; % Cement/Concrete, Steel Reinforced, Low
KIC(17)= 15; % Cement/Concrete, Steel Reinforced, High


if(n==18)
    set(handles.edit_KIC,'String',' ');
else
    ss=sprintf('%g',KIC(n));
    set(handles.edit_KIC,'String',ss);    
end    
    


% --- Executes during object creation, after setting all properties.
function listbox_KIC_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_KIC (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_KIC_Callback(hObject, eventdata, handles)
% hObject    handle to edit_KIC (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_KIC as text
%        str2double(get(hObject,'String')) returns contents of edit_KIC as a double


% --- Executes during object creation, after setting all properties.
function edit_KIC_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_KIC (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function axes1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes1

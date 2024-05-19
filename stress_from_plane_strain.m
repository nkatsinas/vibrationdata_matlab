function varargout = stress_from_plane_strain(varargin)
% STRESS_FROM_PLANE_STRAIN MATLAB code for stress_from_plane_strain.fig
%      STRESS_FROM_PLANE_STRAIN, by itself, creates a new STRESS_FROM_PLANE_STRAIN or raises the existing
%      singleton*.
%
%      H = STRESS_FROM_PLANE_STRAIN returns the handle to a new STRESS_FROM_PLANE_STRAIN or the handle to
%      the existing singleton*.
%
%      STRESS_FROM_PLANE_STRAIN('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in STRESS_FROM_PLANE_STRAIN.M with the given input arguments.
%
%      STRESS_FROM_PLANE_STRAIN('Property','Value',...) creates a new STRESS_FROM_PLANE_STRAIN or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before stress_from_plane_strain_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to stress_from_plane_strain_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help stress_from_plane_strain

% Last Modified by GUIDE v2.5 10-Mar-2015 17:47:50

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @stress_from_plane_strain_OpeningFcn, ...
                   'gui_OutputFcn',  @stress_from_plane_strain_OutputFcn, ...
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


% --- Executes just before stress_from_plane_strain is made visible.
function stress_from_plane_strain_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to stress_from_plane_strain (see VARARGIN)

% Choose default command line output for stress_from_plane_strain
handles.output = hObject;


set(handles.uipanel_ct,'Visible','off');

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes stress_from_plane_strain wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = stress_from_plane_strain_OutputFcn(hObject, eventdata, handles) 
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

delete(stress_from_plane_strain);


% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


strain11=str2num(get(handles.edit_strain11,'String'));
strain22=str2num(get(handles.edit_strain22,'String'));
strain12=str2num(get(handles.edit_strain12,'String'));

E=str2num(get(handles.edit_E,'String'));
v=str2num(get(handles.edit_P,'String'));

strain=[ strain11 strain22 2*strain12]';

M=zeros(3,3);

M(1,1)=1-v;
M(2,2)=M(1,1);
M(1,2)=v;
M(2,1)=v;
M(3,3)=(1-2*v)/2;

den=(1+v)*(1-2*v);

M=M*E/den;

elasticity_tensor=M

stress = M*strain;

disp(' ');

out1=sprintf(' stress 11 = %8.4g ',stress(1));
out2=sprintf(' stress 12 = %8.4g ',stress(3));
out3=sprintf(' stress 22 = %8.4g ',stress(2));

disp(out1);
disp(out2);
disp(out3);


stress_array=[stress(1)  stress(3); stress(3)  stress(2)]


assignin('base', 'stress_array', stress_array);
disp(' Stress Array saved as:  stress_array');

set(handles.uipanel_ct,'Visible','on');

setappdata(0,'stress_array',stress_array);
setappdata(0,'stress_vector',stress);

msgbox('Results written to Command Window');



function edit_strain11_Callback(hObject, eventdata, handles)
% hObject    handle to edit_strain11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_strain11 as text
%        str2double(get(hObject,'String')) returns contents of edit_strain11 as a double


% --- Executes during object creation, after setting all properties.
function edit_strain11_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_strain11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_strain22_Callback(hObject, eventdata, handles)
% hObject    handle to edit_strain22 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_strain22 as text
%        str2double(get(hObject,'String')) returns contents of edit_strain22 as a double


% --- Executes during object creation, after setting all properties.
function edit_strain22_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_strain22 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_strain12_Callback(hObject, eventdata, handles)
% hObject    handle to edit_strain12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_strain12 as text
%        str2double(get(hObject,'String')) returns contents of edit_strain12 as a double


% --- Executes during object creation, after setting all properties.
function edit_strain12_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_strain12 (see GCBO)
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



function edit_P_Callback(hObject, eventdata, handles)
% hObject    handle to edit_P (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_P as text
%        str2double(get(hObject,'String')) returns contents of edit_P as a double


% --- Executes during object creation, after setting all properties.
function edit_P_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_P (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_direction.
function listbox_direction_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_direction (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_direction contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_direction


% --- Executes during object creation, after setting all properties.
function listbox_direction_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_direction (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_theta_Callback(hObject, eventdata, handles)
% hObject    handle to edit_theta (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_theta as text
%        str2double(get(hObject,'String')) returns contents of edit_theta as a double


% --- Executes during object creation, after setting all properties.
function edit_theta_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_theta (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_transform.
function pushbutton_transform_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_transform (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


theta=str2num(get(handles.edit_theta,'String'));
dir=get(handles.listbox_direction,'Value');

theta=theta*pi/180;

if(dir==1)
    theta=-theta;
end


c=cos(theta);
s=sin(theta);

c2=c^2;
s2=s^2;
sc=s*c;

T=[c2 s2 2*sc ; s2 c2 -2*sc; -sc sc (c^2-s^2) ]

stress_vector=getappdata(0,'stress_vector');




transformed_stress=T*stress_vector;

transformed_stress_array=[transformed_stress(1)  transformed_stress(3);...
                             transformed_stress(3)  transformed_stress(2)];

disp(' ');
out1=sprintf(' transformed stress 11 = %8.4g ',transformed_stress(1));
out2=sprintf(' transformed stress 12 = %8.4g ',transformed_stress(3));
out3=sprintf(' transformed stress 22 = %8.4g ',transformed_stress(2));

disp(out1);
disp(out2);
disp(out3);
disp(' ');
assignin('base', 'transformed_stress_array', transformed_stress_array);
disp(' Stress Array saved as:  transformed_stress_array');

msgbox('Results written to Command Window');

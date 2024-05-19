function varargout = VLA_unit_vector_normal_plane(varargin)
% VLA_UNIT_VECTOR_NORMAL_PLANE MATLAB code for VLA_unit_vector_normal_plane.fig
%      VLA_UNIT_VECTOR_NORMAL_PLANE, by itself, creates a new VLA_UNIT_VECTOR_NORMAL_PLANE or raises the existing
%      singleton*.
%
%      H = VLA_UNIT_VECTOR_NORMAL_PLANE returns the handle to a new VLA_UNIT_VECTOR_NORMAL_PLANE or the handle to
%      the existing singleton*.
%
%      VLA_UNIT_VECTOR_NORMAL_PLANE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in VLA_UNIT_VECTOR_NORMAL_PLANE.M with the given input arguments.
%
%      VLA_UNIT_VECTOR_NORMAL_PLANE('Property','Value',...) creates a new VLA_UNIT_VECTOR_NORMAL_PLANE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before VLA_unit_vector_normal_plane_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to VLA_unit_vector_normal_plane_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help VLA_unit_vector_normal_plane

% Last Modified by GUIDE v2.5 08-Jan-2015 12:03:31

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @VLA_unit_vector_normal_plane_OpeningFcn, ...
                   'gui_OutputFcn',  @VLA_unit_vector_normal_plane_OutputFcn, ...
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


% --- Executes just before VLA_unit_vector_normal_plane is made visible.
function VLA_unit_vector_normal_plane_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to VLA_unit_vector_normal_plane (see VARARGIN)

% Choose default command line output for VLA_unit_vector_normal_plane
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes VLA_unit_vector_normal_plane wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = VLA_unit_vector_normal_plane_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

delete(VLA_unit_vector_normal_plane);


% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

A(1)=str2num(get(handles.edit_ax,'String'));
A(2)=str2num(get(handles.edit_ay,'String'));
A(3)=str2num(get(handles.edit_az,'String'));


B(1)=str2num(get(handles.edit_bx,'String'));
B(2)=str2num(get(handles.edit_by,'String'));
B(3)=str2num(get(handles.edit_bz,'String'));


C(1)=str2num(get(handles.edit_cx,'String'));
C(2)=str2num(get(handles.edit_cy,'String'));
C(3)=str2num(get(handles.edit_cz,'String'));

disp(' ');
disp(' Vector V ');
V=B-A

disp(' ');
disp(' Vector W ');
W=C-A

N=cross(V,W);

N=N/norm(N);

disp(' ');
disp(' Unit Normal Vector ');
N

X1=[0,V(1)];
Y1=[0,V(2)];
Z1=[0,V(3)];

X2=[0,W(1)];
Y2=[0,W(2)];
Z2=[0,W(3)];

X3=[0,N(1)];
Y3=[0,N(2)];
Z3=[0,N(3)];


figure(1);
plot3(X1,Y1,Z1,X2,Y2,Z2,X3,Y3,Z3);
grid on;
xlabel('X');
ylabel('Y');
zlabel('Z');   
legend ('plane vector 1','plane vector 2','normal vector');     


msgbox(' Results written to Matlab Workspace. ');




function edit_ax_Callback(hObject, eventdata, handles)
% hObject    handle to edit_ax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_ax as text
%        str2double(get(hObject,'String')) returns contents of edit_ax as a double


% --- Executes during object creation, after setting all properties.
function edit_ax_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_ax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_ay_Callback(hObject, eventdata, handles)
% hObject    handle to edit_ay (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_ay as text
%        str2double(get(hObject,'String')) returns contents of edit_ay as a double


% --- Executes during object creation, after setting all properties.
function edit_ay_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_ay (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_az_Callback(hObject, eventdata, handles)
% hObject    handle to edit_az (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_az as text
%        str2double(get(hObject,'String')) returns contents of edit_az as a double


% --- Executes during object creation, after setting all properties.
function edit_az_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_az (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_bx_Callback(hObject, eventdata, handles)
% hObject    handle to edit_bx (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_bx as text
%        str2double(get(hObject,'String')) returns contents of edit_bx as a double


% --- Executes during object creation, after setting all properties.
function edit_bx_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_bx (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_by_Callback(hObject, eventdata, handles)
% hObject    handle to edit_by (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_by as text
%        str2double(get(hObject,'String')) returns contents of edit_by as a double


% --- Executes during object creation, after setting all properties.
function edit_by_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_by (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_bz_Callback(hObject, eventdata, handles)
% hObject    handle to edit_bz (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_bz as text
%        str2double(get(hObject,'String')) returns contents of edit_bz as a double


% --- Executes during object creation, after setting all properties.
function edit_bz_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_bz (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_cx_Callback(hObject, eventdata, handles)
% hObject    handle to edit_cx (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_cx as text
%        str2double(get(hObject,'String')) returns contents of edit_cx as a double


% --- Executes during object creation, after setting all properties.
function edit_cx_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_cx (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_cy_Callback(hObject, eventdata, handles)
% hObject    handle to edit_cy (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_cy as text
%        str2double(get(hObject,'String')) returns contents of edit_cy as a double


% --- Executes during object creation, after setting all properties.
function edit_cy_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_cy (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_cz_Callback(hObject, eventdata, handles)
% hObject    handle to edit_cz (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_cz as text
%        str2double(get(hObject,'String')) returns contents of edit_cz as a double


% --- Executes during object creation, after setting all properties.
function edit_cz_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_cz (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

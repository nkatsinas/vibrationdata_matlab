function varargout = point_bridge_two_structures(varargin)
% POINT_BRIDGE_TWO_STRUCTURES MATLAB code for point_bridge_two_structures.fig
%      POINT_BRIDGE_TWO_STRUCTURES, by itself, creates a new POINT_BRIDGE_TWO_STRUCTURES or raises the existing
%      singleton*.
%
%      H = POINT_BRIDGE_TWO_STRUCTURES returns the handle to a new POINT_BRIDGE_TWO_STRUCTURES or the handle to
%      the existing singleton*.
%
%      POINT_BRIDGE_TWO_STRUCTURES('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in POINT_BRIDGE_TWO_STRUCTURES.M with the given input arguments.
%
%      POINT_BRIDGE_TWO_STRUCTURES('Property','Value',...) creates a new POINT_BRIDGE_TWO_STRUCTURES or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before point_bridge_two_structures_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to point_bridge_two_structures_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help point_bridge_two_structures

% Last Modified by GUIDE v2.5 25-May-2016 14:57:14

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @point_bridge_two_structures_OpeningFcn, ...
                   'gui_OutputFcn',  @point_bridge_two_structures_OutputFcn, ...
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


% --- Executes just before point_bridge_two_structures is made visible.
function point_bridge_two_structures_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to point_bridge_two_structures (see VARARGIN)

% Choose default command line output for point_bridge_two_structures
handles.output = hObject;

listbox_units_Callback(hObject, eventdata, handles);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes point_bridge_two_structures wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = point_bridge_two_structures_OutputFcn(hObject, eventdata, handles) 
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
delete(point_bridge_two_structures);


% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

tpi=2*pi;

iu=get(handles.listbox_units,'Value');

f=str2num(get(handles.edit_freq,'String'));
 
n1=str2num(get(handles.edit_n1,'String'));
n2=str2num(get(handles.edit_n2,'String'));
 
Z1=str2num(get(handles.edit_Z1,'String'));
Z2=str2num(get(handles.edit_Z2,'String'));



omega=tpi*f;

n_rad_1=n1/tpi;
n_rad_2=n2/tpi;

A1=2/(pi*omega*n_rad_1);
A2=2/(pi*omega*n_rad_2);

B=real(Z1)*real(Z2)/(  (abs(Z1+Z2))^2  );

clf_12=A1*B;
clf_21=A2*B;


s1=sprintf('%8.4g',clf_12);
s2=sprintf('%8.4g',clf_21);

set(handles.edit_clf_12,'String',s1);
set(handles.edit_clf_21,'String',s2);

set(handles.uipanel_save,'Visible','on');




% --- Executes on selection change in listbox_units.
function listbox_units_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_units (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_units contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_units

set(handles.uipanel_save,'Visible','off');

iu=get(handles.listbox_units,'Value');

if(iu==1)
   set(handles.text_Z1,'String','Impedance (lbf-sec/in)'); 
   set(handles.text_Z2,'String','Impedance (lbf-sec/in)');    
else
   set(handles.text_Z1,'String','Impedance (N-sec/m)'); 
   set(handles.text_Z2,'String','Impedance (N-sec/m)');    
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



function edit_freq_Callback(hObject, eventdata, handles)
% hObject    handle to edit_freq (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_freq as text
%        str2double(get(hObject,'String')) returns contents of edit_freq as a double


% --- Executes during object creation, after setting all properties.
function edit_freq_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_freq (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_Z1_Callback(hObject, eventdata, handles)
% hObject    handle to edit_Z1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_Z1 as text
%        str2double(get(hObject,'String')) returns contents of edit_Z1 as a double


% --- Executes during object creation, after setting all properties.
function edit_Z1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_Z1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_Z2_Callback(hObject, eventdata, handles)
% hObject    handle to edit_Z2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_Z2 as text
%        str2double(get(hObject,'String')) returns contents of edit_Z2 as a double


% --- Executes during object creation, after setting all properties.
function edit_Z2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_Z2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_n1_Callback(hObject, eventdata, handles)
% hObject    handle to edit_n1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_n1 as text
%        str2double(get(hObject,'String')) returns contents of edit_n1 as a double


% --- Executes during object creation, after setting all properties.
function edit_n1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_n1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_n2_Callback(hObject, eventdata, handles)
% hObject    handle to edit_n2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_n2 as text
%        str2double(get(hObject,'String')) returns contents of edit_n2 as a double


% --- Executes during object creation, after setting all properties.
function edit_n2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_n2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_clf_12_Callback(hObject, eventdata, handles)
% hObject    handle to edit_clf_12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_clf_12 as text
%        str2double(get(hObject,'String')) returns contents of edit_clf_12 as a double


% --- Executes during object creation, after setting all properties.
function edit_clf_12_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_clf_12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_clf_21_Callback(hObject, eventdata, handles)
% hObject    handle to edit_clf_21 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_clf_21 as text
%        str2double(get(hObject,'String')) returns contents of edit_clf_21 as a double


% --- Executes during object creation, after setting all properties.
function edit_clf_21_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_clf_21 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on key press with focus on edit_freq and none of its controls.
function edit_freq_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_freq (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)

set(handles.uipanel_save,'Visible','off');


% --- Executes on key press with focus on edit_Z1 and none of its controls.
function edit_Z1_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_Z1 (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)

set(handles.uipanel_save,'Visible','off');


% --- Executes on key press with focus on edit_n1 and none of its controls.
function edit_n1_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_n1 (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.uipanel_save,'Visible','off');


% --- Executes on key press with focus on edit_Z2 and none of its controls.
function edit_Z2_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_Z2 (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.uipanel_save,'Visible','off');


% --- Executes on key press with focus on edit_n2 and none of its controls.
function edit_n2_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_n2 (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.uipanel_save,'Visible','off');


% --- Executes on button press in pushbutton_eq.
function pushbutton_eq_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_eq (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

A = imread('point_bridge_clf.jpg');
figure(999) 
imshow(A,'border','tight','InitialMagnification',100) 

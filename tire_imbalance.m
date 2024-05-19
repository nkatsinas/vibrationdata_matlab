function varargout = tire_imbalance(varargin)
% TIRE_IMBALANCE MATLAB code for tire_imbalance.fig
%      TIRE_IMBALANCE, by itself, creates a new TIRE_IMBALANCE or raises the existing
%      singleton*.
%
%      H = TIRE_IMBALANCE returns the handle to a new TIRE_IMBALANCE or the handle to
%      the existing singleton*.
%
%      TIRE_IMBALANCE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TIRE_IMBALANCE.M with the given input arguments.
%
%      TIRE_IMBALANCE('Property','Value',...) creates a new TIRE_IMBALANCE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before tire_imbalance_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to tire_imbalance_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help tire_imbalance

% Last Modified by GUIDE v2.5 03-Feb-2014 13:13:57

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @tire_imbalance_OpeningFcn, ...
                   'gui_OutputFcn',  @tire_imbalance_OutputFcn, ...
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


% --- Executes just before tire_imbalance is made visible.
function tire_imbalance_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to tire_imbalance (see VARARGIN)

% Choose default command line output for tire_imbalance
handles.output = hObject;


set(handles.listbox_speed,'value',1);
set(handles.listbox_diameter,'value',1);

clear_results(hObject, eventdata, handles);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes tire_imbalance wait for user response (see UIRESUME)
% uiwait(handles.figure1);


function clear_results(hObject, eventdata, handles)
%
set(handles.edit_1X,'enable','off');
set(handles.edit_2X,'enable','off');
set(handles.edit_1X,'String',' ');
set(handles.edit_2X,'String',' ');

% --- Outputs from this function are returned to the command line.
function varargout = tire_imbalance_OutputFcn(hObject, eventdata, handles) 
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
set(handles.edit_1X,'enable','on');
set(handles.edit_2X,'enable','on');

iunit_speed=get(handles.listbox_speed,'Value');
iunit_dia=get(handles.listbox_diameter,'Value');

speed=str2num(get(handles.edit_speed,'String'));
dia=str2num(get(handles.edit_diameter,'String'));

%
% convert speed to m/sec
%
if(iunit_speed==1)
    speed=speed*0.44704;
end
%
if(iunit_speed==2)
    speed=speed*0.3048;
end
%   
if(iunit_speed==3)  
    speed=speed* 0.27778; 
end
%
if(iunit_dia==1)
    dia=dia*0.0254;
end
%
if(iunit_dia==2)
    dia=dia*0.01 ;
end
%
circum = pi*dia;
freq = speed/circum;
%

s1=sprintf('%6.3g',freq);
s2=sprintf('%6.3g',2*freq);

set(handles.edit_1X,'String',s1);
set(handles.edit_2X,'String',s2);

% --- Executes on button press in pushbutton_return.
function pushbutton_return_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_return (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
delete(tire_imbalance);


function edit_speed_Callback(hObject, eventdata, handles)
% hObject    handle to edit_speed (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_speed as text
%        str2double(get(hObject,'String')) returns contents of edit_speed as a double


% --- Executes during object creation, after setting all properties.
function edit_speed_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_speed (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_1X_Callback(hObject, eventdata, handles)
% hObject    handle to edit_1X (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_1X as text
%        str2double(get(hObject,'String')) returns contents of edit_1X as a double


% --- Executes during object creation, after setting all properties.
function edit_1X_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_1X (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_2X_Callback(hObject, eventdata, handles)
% hObject    handle to edit_2X (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_2X as text
%        str2double(get(hObject,'String')) returns contents of edit_2X as a double


% --- Executes during object creation, after setting all properties.
function edit_2X_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_2X (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_diameter_Callback(hObject, eventdata, handles)
% hObject    handle to edit_diameter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_diameter as text
%        str2double(get(hObject,'String')) returns contents of edit_diameter as a double


% --- Executes during object creation, after setting all properties.
function edit_diameter_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_diameter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_speed.
function listbox_speed_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_speed (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_speed contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_speed
clear_results(hObject, eventdata, handles);

% --- Executes during object creation, after setting all properties.
function listbox_speed_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_speed (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_diameter.
function listbox_diameter_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_diameter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_diameter contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_diameter
clear_results(hObject, eventdata, handles);

% --- Executes during object creation, after setting all properties.
function listbox_diameter_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_diameter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on key press with focus on edit_speed and none of its controls.
function edit_speed_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_speed (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
clear_results(hObject, eventdata, handles);


% --- Executes on key press with focus on edit_diameter and none of its controls.
function edit_diameter_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_diameter (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
clear_results(hObject, eventdata, handles);

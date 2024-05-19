function varargout = tangential_velocity(varargin)
% TANGENTIAL_VELOCITY MATLAB code for tangential_velocity.fig
%      TANGENTIAL_VELOCITY, by itself, creates a new TANGENTIAL_VELOCITY or raises the existing
%      singleton*.
%
%      H = TANGENTIAL_VELOCITY returns the handle to a new TANGENTIAL_VELOCITY or the handle to
%      the existing singleton*.
%
%      TANGENTIAL_VELOCITY('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TANGENTIAL_VELOCITY.M with the given input arguments.
%
%      TANGENTIAL_VELOCITY('Property','Value',...) creates a new TANGENTIAL_VELOCITY or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before tangential_velocity_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to tangential_velocity_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help tangential_velocity

% Last Modified by GUIDE v2.5 03-Feb-2014 14:15:05

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @tangential_velocity_OpeningFcn, ...
                   'gui_OutputFcn',  @tangential_velocity_OutputFcn, ...
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


% --- Executes just before tangential_velocity is made visible.
function tangential_velocity_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to tangential_velocity (see VARARGIN)

% Choose default command line output for tangential_velocity
handles.output = hObject;

set(handles.listbox_frequency,'value',1);
set(handles.listbox_radius,'value',1);

clear_results(hObject, eventdata, handles)

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes tangential_velocity wait for user response (see UIRESUME)
% uiwait(handles.figure1);

function clear_results(hObject, eventdata, handles)
%
set(handles.edit_results,'String',' ');
set(handles.edit_results,'enable','off');


% --- Outputs from this function are returned to the command line.
function varargout = tangential_velocity_OutputFcn(hObject, eventdata, handles) 
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



set(handles.edit_results,'enable','on');

iunit_frequency=get(handles.listbox_frequency,'Value');
iunit_radius=get(handles.listbox_radius,'Value');

frequency=str2num(get(handles.edit_frequency,'String'));
radius=str2num(get(handles.edit_radius,'String'));

feet_per_meters=3.281;
meters_per_feet=1/feet_per_meters;

meters_per_inch=0.0254;

if(iunit_frequency==2)
   frequency=frequency/(2*pi);
end
if(iunit_frequency==3)
   frequency=frequency/60.;
end

if(iunit_radius==1) % convert inches to meters
   radius=radius*meters_per_inch;    
end
if(iunit_radius==2)  % convert feet to meters
   radius=radius*meters_per_feet; 
end

if(iunit_radius==4)  % convert mm to meters
   radius=radius/1000; 
end

omega=2*pi*frequency;

vel_mps=omega*radius;
vel_fps=vel_mps*feet_per_meters;

mach=vel_mps/343;

ca=omega^2*radius/9.81;

s1=sprintf(' Tangential Velocity \n\n %8.4g ft/sec \n %8.4g meters/sec \n\n Mach %7.3g at Sea Level\n\n Centripetal Acceleration \n\n %8.4g G',vel_fps,vel_mps,mach,ca);

set(handles.edit_results,'String',s1);


% --- Executes on button press in pushbutton_return.
function pushbutton_return_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_return (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
delete(tangential_velocity);


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



function edit_frequency_Callback(hObject, eventdata, handles)
% hObject    handle to edit_frequency (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_frequency as text
%        str2double(get(hObject,'String')) returns contents of edit_frequency as a double


% --- Executes during object creation, after setting all properties.
function edit_frequency_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_frequency (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_radius_Callback(hObject, eventdata, handles)
% hObject    handle to edit_radius (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_radius as text
%        str2double(get(hObject,'String')) returns contents of edit_radius as a double


% --- Executes during object creation, after setting all properties.
function edit_radius_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_radius (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_frequency.
function listbox_frequency_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_frequency (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_frequency contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_frequency
clear_results(hObject, eventdata, handles)

% --- Executes during object creation, after setting all properties.
function listbox_frequency_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_frequency (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_radius.
function listbox_radius_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_radius (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_radius contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_radius
clear_results(hObject, eventdata, handles);

% --- Executes during object creation, after setting all properties.
function listbox_radius_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_radius (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on key press with focus on edit_frequency and none of its controls.
function edit_frequency_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_frequency (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
clear_results(hObject, eventdata, handles);


% --- Executes on key press with focus on edit_radius and none of its controls.
function edit_radius_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_radius (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
clear_results(hObject, eventdata, handles);

function varargout = valve_acoustic_pressure(varargin)
% VALVE_ACOUSTIC_PRESSURE MATLAB code for valve_acoustic_pressure.fig
%      VALVE_ACOUSTIC_PRESSURE, by itself, creates a new VALVE_ACOUSTIC_PRESSURE or raises the existing
%      singleton*.
%
%      H = VALVE_ACOUSTIC_PRESSURE returns the handle to a new VALVE_ACOUSTIC_PRESSURE or the handle to
%      the existing singleton*.
%
%      VALVE_ACOUSTIC_PRESSURE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in VALVE_ACOUSTIC_PRESSURE.M with the given input arguments.
%
%      VALVE_ACOUSTIC_PRESSURE('Property','Value',...) creates a new VALVE_ACOUSTIC_PRESSURE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before valve_acoustic_pressure_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to valve_acoustic_pressure_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help valve_acoustic_pressure

% Last Modified by GUIDE v2.5 31-Jul-2019 11:16:03

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @valve_acoustic_pressure_OpeningFcn, ...
                   'gui_OutputFcn',  @valve_acoustic_pressure_OutputFcn, ...
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


% --- Executes just before valve_acoustic_pressure is made visible.
function valve_acoustic_pressure_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to valve_acoustic_pressure (see VARARGIN)

% Choose default command line output for valve_acoustic_pressure
handles.output = hObject;

listbox_units_Callback(hObject, eventdata, handles);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes valve_acoustic_pressure wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = valve_acoustic_pressure_OutputFcn(hObject, eventdata, handles) 
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

delete(valve_acoustic_pressure);


% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

disp(' ');
disp(' * * * * * * * * ');
disp(' ');

fig_num=1;


n=get(handles.listbox_units,'Value');

delta_P=str2num(get(handles.edit_delta_P,'String'));
U=str2num(get(handles.edit_U,'String'));
C=str2num(get(handles.edit_C,'String'));


Prms=12*delta_P*(U/C);

if(n==1)
    ss='psi rms';
    ref=2.9e-09; 
else
    ss='Pa rms';
    ref=20e-06;
end


dB=20*log10(Prms/ref);


out1=sprintf(' Internal overall SPL = %8.4g %s',Prms,ss);
out2=sprintf('                      = %8.4g dB  ref 20 micro Pa',dB);
disp(out1);
disp(out2);

msgbox('Results written to Command Window');
    
    
    
% --- Executes on selection change in listbox_units.
function listbox_units_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_units (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_units contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_units

n=get(handles.listbox_units,'Value');

if(n==1)
    set(handles.edit_C,'String','1125');
    set(handles.text_delta_P,'String','Pressure Drop (psi)');
    set(handles.text_U,'String','Downstream Velocity (ft/sec)');
    set(handles.text_C,'String','Speed of Sound (ft/sec)');
else
    set(handles.edit_C,'String','343');  
    set(handles.text_delta_P,'String','Pressure Drop (Pa)');
    set(handles.text_U,'String','Downstream Velocity (m/sec)'); 
    set(handles.text_C,'String','Speed of Sound (m/sec)');    
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



function edit_delta_P_Callback(hObject, eventdata, handles)
% hObject    handle to edit_delta_P (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_delta_P as text
%        str2double(get(hObject,'String')) returns contents of edit_delta_P as a double


% --- Executes during object creation, after setting all properties.
function edit_delta_P_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_delta_P (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_U_Callback(hObject, eventdata, handles)
% hObject    handle to edit_U (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_U as text
%        str2double(get(hObject,'String')) returns contents of edit_U as a double


% --- Executes during object creation, after setting all properties.
function edit_U_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_U (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_C_Callback(hObject, eventdata, handles)
% hObject    handle to edit_C (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_C as text
%        str2double(get(hObject,'String')) returns contents of edit_C as a double


% --- Executes during object creation, after setting all properties.
function edit_C_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_C (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_view.
function pushbutton_view_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_view (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

     A = imread('valve_noise.jpg');
     figure(999) 
     imshow(A,'border','tight','InitialMagnification',100) 


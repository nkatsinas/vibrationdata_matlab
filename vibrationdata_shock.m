function varargout = vibrationdata_shock(varargin)
% VIBRATIONDATA_SHOCK MATLAB code for vibrationdata_shock.fig
%      VIBRATIONDATA_SHOCK, by itself, creates a new VIBRATIONDATA_SHOCK or raises the existing
%      singleton*.
%
%      H = VIBRATIONDATA_SHOCK returns the handle to a new VIBRATIONDATA_SHOCK or the handle to
%      the existing singleton*.
%
%      VIBRATIONDATA_SHOCK('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in VIBRATIONDATA_SHOCK.M with the given input arguments.
%
%      VIBRATIONDATA_SHOCK('Property','Value',...) creates a new VIBRATIONDATA_SHOCK or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before vibrationdata_shock_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to vibrationdata_shock_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help vibrationdata_shock

% Last Modified by GUIDE v2.5 28-Jan-2018 14:35:56

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @vibrationdata_shock_OpeningFcn, ...
                   'gui_OutputFcn',  @vibrationdata_shock_OutputFcn, ...
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


% --- Executes just before vibrationdata_shock is made visible.
function vibrationdata_shock_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to vibrationdata_shock (see VARARGIN)

% Choose default command line output for vibrationdata_shock
handles.output = hObject;

set(handles.listbox_analysis_1,'Value',1);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes vibrationdata_shock wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = vibrationdata_shock_OutputFcn(hObject, eventdata, handles) 
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

delete(vibrationdata_shock);


% --- Executes on selection change in listbox_analysis_1.
function listbox_analysis_1_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_analysis_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_analysis_1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_analysis_1
pushbutton_analysis_1_Callback(hObject, eventdata, handles);

% --- Executes during object creation, after setting all properties.
function listbox_analysis_1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_analysis_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_analysis_1.
function pushbutton_analysis_1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_analysis_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

n=get(handles.listbox_analysis_1,'Value');

if(n==1)
    amplitude_conversion_utilities_a;
end
if(n==2)
    handles.s=classical_pulse_base_input;  
end
if(n==3)
    handles.s=vibrationdata_sdof_base;  
end
if(n==4)
    handles.s=vibrationdata_srs_base;  
end
if(n==5)
    handles.s=compare_two_half_sines;  
end
if(n==6)
    handles.s=half_sine_shock_test;  
end
if(n==7)
    handles.s=classical_shock_test_shaker;  
end

if(n==8)
    handles.s=accidental_drop_shock;  
end
if(n==9)
    handles.s=vibrationdata_shock_effective_duration;  
end
if(n==10)
    handles.s=vibrationdata_temporal_moments;  
end
if(n==11)
    handles.s=shock_propagation;  
end
if(n==12)
    vibrationdata_stress_velocity_a;  
end
if(n==13)
    spacecraft_clamp_band_SRS;  
end
if(n==14)
    handles.s=srs_spec_convert_Q; 
end
if(n==15)
    handles.s=SRS_spec_from_time_history; 
end
if(n==16)
    handles.s=vibrationdata_accel_SRS_PV_SRS; 
end
if(n==17)
    handles.s=classical_pulse_applied_force;
end

try
    set(handles.s,'Visible','on'); 
catch
end

% --- Executes on selection change in listbox_analysis_2.
function listbox_analysis_2_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_analysis_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_analysis_2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_analysis_2
pushbutton_analysis_2_Callback(hObject, eventdata, handles);

% --- Executes during object creation, after setting all properties.
function listbox_analysis_2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_analysis_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_analysis_2.
function pushbutton_analysis_2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_analysis_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

n=get(handles.listbox_analysis_2,'Value');

if(n==1)
    handles.s=vibrationdata_mdof_srs;  
end
if(n==2)
    handles.s=vibrationdata_mdof_srs_multiple;  
end
if(n==3)
    handles.s=vibrationdata_mdof_srs_multiple_sv;  
end


set(handles.s,'Visible','on'); 

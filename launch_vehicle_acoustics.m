function varargout = launch_vehicle_acoustics(varargin)
% LAUNCH_VEHICLE_ACOUSTICS MATLAB code for launch_vehicle_acoustics.fig
%      LAUNCH_VEHICLE_ACOUSTICS, by itself, creates a new LAUNCH_VEHICLE_ACOUSTICS or raises the existing
%      singleton*.
%
%      H = LAUNCH_VEHICLE_ACOUSTICS returns the handle to a new LAUNCH_VEHICLE_ACOUSTICS or the handle to
%      the existing singleton*.
%
%      LAUNCH_VEHICLE_ACOUSTICS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in LAUNCH_VEHICLE_ACOUSTICS.M with the given input arguments.
%
%      LAUNCH_VEHICLE_ACOUSTICS('Property','Value',...) creates a new LAUNCH_VEHICLE_ACOUSTICS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before launch_vehicle_acoustics_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to launch_vehicle_acoustics_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help launch_vehicle_acoustics

% Last Modified by GUIDE v2.5 08-Feb-2018 16:39:39

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @launch_vehicle_acoustics_OpeningFcn, ...
                   'gui_OutputFcn',  @launch_vehicle_acoustics_OutputFcn, ...
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


% --- Executes just before launch_vehicle_acoustics is made visible.
function launch_vehicle_acoustics_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to launch_vehicle_acoustics (see VARARGIN)

% Choose default command line output for launch_vehicle_acoustics
handles.output = hObject;


% Update handles structure
guidata(hObject, handles);

% UIWAIT makes launch_vehicle_acoustics wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = launch_vehicle_acoustics_OutputFcn(hObject, eventdata, handles) 
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

delete(launch_vehicle_acoustics);


% --- Executes on selection change in listbox_analysis.
function listbox_analysis_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_analysis (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_analysis contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_analysis


% --- Executes during object creation, after setting all properties.
function listbox_analysis_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_analysis (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_analyze.
function pushbutton_analyze_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_analyze (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

n=get(handles.listbox_analysis,'Value');

if(n==1)
    handles.s=speed_sound;    
end 
if(n==2)
    handles.s=dB_pressure_unit_conversion;    
end 
if(n==3)
    handles.s=liftoff;    
end 
if(n==4)
    handles.s=aerodynamic_flow;    
end 
if(n==5)
    handles.s=noise_reduction;    
end 
if(n==6)
    handles.s=launch_vehicle_vent_box_fn; 
end 
if(n==7)
    handles.s=cylinder_ring_frequency;
end
if(n==8)
    handles.s=Franken_method;
end
if(n==9)
    handles.s=vibrationdata_atmospheric_properties;
end

set(handles.s,'Visible','on');


% --- Executes on selection change in listbox1.
function listbox1_Callback(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox1


% --- Executes during object creation, after setting all properties.
function listbox1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

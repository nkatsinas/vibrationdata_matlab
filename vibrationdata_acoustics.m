function varargout = vibrationdata_acoustics(varargin)
% VIBRATIONDATA_ACOUSTICS MATLAB code for vibrationdata_acoustics.fig
%      VIBRATIONDATA_ACOUSTICS, by itself, creates a new VIBRATIONDATA_ACOUSTICS or raises the existing
%      singleton*.
%
%      H = VIBRATIONDATA_ACOUSTICS returns the handle to a new VIBRATIONDATA_ACOUSTICS or the handle to
%      the existing singleton*.
%
%      VIBRATIONDATA_ACOUSTICS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in VIBRATIONDATA_ACOUSTICS.M with the given input arguments.
%
%      VIBRATIONDATA_ACOUSTICS('Property','Value',...) creates a new VIBRATIONDATA_ACOUSTICS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before vibrationdata_acoustics_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to vibrationdata_acoustics_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help vibrationdata_acoustics

% Last Modified by GUIDE v2.5 19-Feb-2014 17:07:24

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @vibrationdata_acoustics_OpeningFcn, ...
                   'gui_OutputFcn',  @vibrationdata_acoustics_OutputFcn, ...
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


% --- Executes just before vibrationdata_acoustics is made visible.
function vibrationdata_acoustics_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to vibrationdata_acoustics (see VARARGIN)

% Choose default command line output for vibrationdata_acoustics
handles.output = hObject;

set(handles.listbox_analysis,'Value',1);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes vibrationdata_acoustics wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = vibrationdata_acoustics_OutputFcn(hObject, eventdata, handles) 
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

n=get(handles.listbox_analysis,'Value');

if(n==1)
    handles.s=speed_sound;    
end 
if(n==2)
    handles.s=vibrationdata_doppler;    
end 
if(n==3)
    handles.s=wavelength;    
end 
if(n==4)
    handles.s=dB_pressure_unit_conversion;    
end 
if(n==5)
    handles.s=Helmholtz_Resonator;    
end 
if(n==6)
    handles.s=transmission_loss_main;    
end 
if(n==7)
    handles.s=transmission_loss_coefficient;    
end 
if(n==8)
    handles.s=noise_reduction_source_receiver;    
end 
if(n==9)
    handles.s=noise_reduction_room;    
end 
if(n==10)
    handles.s=launch_vehicle_acoustics;
end 

set(handles.s,'Visible','on');


% --- Executes on button press in pushbutton_return.
function pushbutton_return_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_return (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
delete(vibrationdata_acoustics);


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

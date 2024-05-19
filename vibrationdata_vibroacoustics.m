function varargout = vibrationdata_vibroacoustics(varargin)
% VIBRATIONDATA_VIBROACOUSTICS MATLAB code for vibrationdata_vibroacoustics.fig
%      VIBRATIONDATA_VIBROACOUSTICS, by itself, creates a new VIBRATIONDATA_VIBROACOUSTICS or raises the existing
%      singleton*.
%
%      H = VIBRATIONDATA_VIBROACOUSTICS returns the handle to a new VIBRATIONDATA_VIBROACOUSTICS or the handle to
%      the existing singleton*.
%
%      VIBRATIONDATA_VIBROACOUSTICS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in VIBRATIONDATA_VIBROACOUSTICS.M with the given input arguments.
%
%      VIBRATIONDATA_VIBROACOUSTICS('Property','Value',...) creates a new VIBRATIONDATA_VIBROACOUSTICS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before vibrationdata_vibroacoustics_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to vibrationdata_vibroacoustics_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help vibrationdata_vibroacoustics

% Last Modified by GUIDE v2.5 24-Jul-2014 17:01:24

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @vibrationdata_vibroacoustics_OpeningFcn, ...
                   'gui_OutputFcn',  @vibrationdata_vibroacoustics_OutputFcn, ...
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


% --- Executes just before vibrationdata_vibroacoustics is made visible.
function vibrationdata_vibroacoustics_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to vibrationdata_vibroacoustics (see VARARGIN)

% Choose default command line output for vibrationdata_vibroacoustics
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes vibrationdata_vibroacoustics wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = vibrationdata_vibroacoustics_OutputFcn(hObject, eventdata, handles) 
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

delete(vibrationdata_vibroacoustics);


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


% --- Executes on button press in pushbutton_analysis.
function pushbutton_analysis_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_analysis (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

n=get(handles.listbox_analysis,'Value');

if(n==1)
    handles.s=panel_toolbox;
end  
if(n==2)
    handles.s=sandwich_panel_toolbox;
end
if(n==3)
    handles.s=vibrationdata_rectangular_plate_uniform_pressure;
end
if(n==4)
    handles.s=vibrationdata_rectangular_plate_oblique_incidence;
end
if(n==5)
    handles.s=Spann_method;
end
if(n==6)
    handles.s=Franken_method;
end
if(n==7)
    handles.s=Franken_method_multiple;
end
if(n==8)
    handles.s=Barrett_method;
end
if(n==9)
    handles.s=Barrett_method_multiple;
end

set(handles.s,'Visible','on')
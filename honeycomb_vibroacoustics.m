function varargout = honeycomb_vibroacoustics(varargin)
% HONEYCOMB_VIBROACOUSTICS MATLAB code for honeycomb_vibroacoustics.fig
%      HONEYCOMB_VIBROACOUSTICS, by itself, creates a new HONEYCOMB_VIBROACOUSTICS or raises the existing
%      singleton*.
%
%      H = HONEYCOMB_VIBROACOUSTICS returns the handle to a new HONEYCOMB_VIBROACOUSTICS or the handle to
%      the existing singleton*.
%
%      HONEYCOMB_VIBROACOUSTICS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in HONEYCOMB_VIBROACOUSTICS.M with the given input arguments.
%
%      HONEYCOMB_VIBROACOUSTICS('Property','Value',...) creates a new HONEYCOMB_VIBROACOUSTICS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before honeycomb_vibroacoustics_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to honeycomb_vibroacoustics_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help honeycomb_vibroacoustics

% Last Modified by GUIDE v2.5 18-Feb-2014 11:58:10

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @honeycomb_vibroacoustics_OpeningFcn, ...
                   'gui_OutputFcn',  @honeycomb_vibroacoustics_OutputFcn, ...
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


% --- Executes just before honeycomb_vibroacoustics is made visible.
function honeycomb_vibroacoustics_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to honeycomb_vibroacoustics (see VARARGIN)

% Choose default command line output for honeycomb_vibroacoustics
handles.output = hObject;

set(handles.listbox_analysis,'Value',1);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes honeycomb_vibroacoustics wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = honeycomb_vibroacoustics_OutputFcn(hObject, eventdata, handles) 
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

delete(honeycomb_vibroacoustics);

% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

n=get(handles.listbox_analysis,'Value');

if(n==1)
    handles.s=honeycomb_critical_frequency;    
end 
if(n==2)
    handles.s=honeycomb_bending_wave_speed;    
end 

set(handles.s,'Visible','on'); 


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

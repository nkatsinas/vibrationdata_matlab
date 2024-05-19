function varargout = structural_borne_wave_propagation(varargin)
% STRUCTURAL_BORNE_WAVE_PROPAGATION MATLAB code for structural_borne_wave_propagation.fig
%      STRUCTURAL_BORNE_WAVE_PROPAGATION, by itself, creates a new STRUCTURAL_BORNE_WAVE_PROPAGATION or raises the existing
%      singleton*.
%
%      H = STRUCTURAL_BORNE_WAVE_PROPAGATION returns the handle to a new STRUCTURAL_BORNE_WAVE_PROPAGATION or the handle to
%      the existing singleton*.
%
%      STRUCTURAL_BORNE_WAVE_PROPAGATION('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in STRUCTURAL_BORNE_WAVE_PROPAGATION.M with the given input arguments.
%
%      STRUCTURAL_BORNE_WAVE_PROPAGATION('Property','Value',...) creates a new STRUCTURAL_BORNE_WAVE_PROPAGATION or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before structural_borne_wave_propagation_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to structural_borne_wave_propagation_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help structural_borne_wave_propagation

% Last Modified by GUIDE v2.5 22-Mar-2016 09:39:34

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @structural_borne_wave_propagation_OpeningFcn, ...
                   'gui_OutputFcn',  @structural_borne_wave_propagation_OutputFcn, ...
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


% --- Executes just before structural_borne_wave_propagation is made visible.
function structural_borne_wave_propagation_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to structural_borne_wave_propagation (see VARARGIN)

% Choose default command line output for structural_borne_wave_propagation
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes structural_borne_wave_propagation wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = structural_borne_wave_propagation_OutputFcn(hObject, eventdata, handles) 
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

delete(structural_borne_wave_propagation);


% --- Executes on button press in pushbutton_analyze.
function pushbutton_analyze_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_analyze (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

n=get(handles.listbox_analyze,'Value');

if(n==1)
    handles.s=longitudinal_wave_rod_impedance_change; 
end

set(handles.s,'Visible','on'); 


% --- Executes on selection change in listbox_analyze.
function listbox_analyze_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_analyze (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_analyze contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_analyze


% --- Executes during object creation, after setting all properties.
function listbox_analyze_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_analyze (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

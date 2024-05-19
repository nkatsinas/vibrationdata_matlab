function varargout = rings_cylinders(varargin)
% RINGS_CYLINDERS MATLAB code for rings_cylinders.fig
%      RINGS_CYLINDERS, by itself, creates a new RINGS_CYLINDERS or raises the existing
%      singleton*.
%
%      H = RINGS_CYLINDERS returns the handle to a new RINGS_CYLINDERS or the handle to
%      the existing singleton*.
%
%      RINGS_CYLINDERS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in RINGS_CYLINDERS.M with the given input arguments.
%
%      RINGS_CYLINDERS('Property','Value',...) creates a new RINGS_CYLINDERS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before rings_cylinders_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to rings_cylinders_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help rings_cylinders

% Last Modified by GUIDE v2.5 01-Jul-2015 11:54:01

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @rings_cylinders_OpeningFcn, ...
                   'gui_OutputFcn',  @rings_cylinders_OutputFcn, ...
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


% --- Executes just before rings_cylinders is made visible.
function rings_cylinders_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to rings_cylinders (see VARARGIN)

% Choose default command line output for rings_cylinders
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes rings_cylinders wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = rings_cylinders_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


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
    handles.s=thin_ring;
end
if(n==2)
    cylinder_fn_a;   
end
if(n==3)
   handles.s=cylinder_ring_frequency; 
end

try
    set(handles.s,'Visible','on')
catch
end


% --- Executes on button press in pushbutton_return.
function pushbutton_return_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_return (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

delete(rings_cylinders);

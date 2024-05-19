function varargout = pipe_acoustics(varargin)
% PIPE_ACOUSTICS MATLAB code for pipe_acoustics.fig
%      PIPE_ACOUSTICS, by itself, creates a new PIPE_ACOUSTICS or raises the existing
%      singleton*.
%
%      H = PIPE_ACOUSTICS returns the handle to a new PIPE_ACOUSTICS or the handle to
%      the existing singleton*.
%
%      PIPE_ACOUSTICS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PIPE_ACOUSTICS.M with the given input arguments.
%
%      PIPE_ACOUSTICS('Property','Value',...) creates a new PIPE_ACOUSTICS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before pipe_acoustics_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to pipe_acoustics_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help pipe_acoustics

% Last Modified by GUIDE v2.5 18-Aug-2021 09:11:12

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @pipe_acoustics_OpeningFcn, ...
                   'gui_OutputFcn',  @pipe_acoustics_OutputFcn, ...
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


% --- Executes just before pipe_acoustics is made visible.
function pipe_acoustics_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to pipe_acoustics (see VARARGIN)

% Choose default command line output for pipe_acoustics
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes pipe_acoustics wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = pipe_acoustics_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton_analyze.
function pushbutton_analyze_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_analyze (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

n=get(handles.listbox,'Value');

if(n==1)
   handles.s=pipe_acoustic_frequencies; 
end
if(n==2)
   handles.s=pipe_breakout_transmission_loss; 
end
if(n==3)
   handles.s=pipe_prms;    
end
if(n==4)
   handles.s=pipe_peak_frequency; 
end
if(n==5)
   handles.s=pipe_internal_spl_estimate;
end

set(handles.s,'Visible','on');


% --- Executes on button press in pushbutton_return.
function pushbutton_return_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_return (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

delete(pipe_acoustics);


% --- Executes on selection change in listbox.
function listbox_Callback(hObject, eventdata, handles)
% hObject    handle to listbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox


% --- Executes during object creation, after setting all properties.
function listbox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

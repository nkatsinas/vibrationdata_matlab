function varargout = dboct(varargin)
% DBOCT MATLAB code for dboct.fig
%      DBOCT, by itself, creates a new DBOCT or raises the existing
%      singleton*.
%
%      H = DBOCT returns the handle to a new DBOCT or the handle to
%      the existing singleton*.
%
%      DBOCT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DBOCT.M with the given input arguments.
%
%      DBOCT('Property','Value',...) creates a new DBOCT or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before dboct_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to dboct_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help dboct

% Last Modified by GUIDE v2.5 09-Apr-2021 08:17:26

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @dboct_OpeningFcn, ...
                   'gui_OutputFcn',  @dboct_OutputFcn, ...
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


% --- Executes just before dboct is made visible.
function dboct_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to dboct (see VARARGIN)

% Choose default command line output for dboct
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes dboct wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = dboct_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton_same_frequencies.
function pushbutton_same_frequencies_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_same_frequencies (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.s=dboct_same_frequencies;    
set(handles.s,'Visible','on'); 


% --- Executes on button press in pushbutton_separate_frequencies.
function pushbutton_separate_frequencies_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_separate_frequencies (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.s=dboct_separate_frequencies;
set(handles.s,'Visible','on'); 


% --- Executes on button press in pushbutton_return.
function pushbutton_return_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_return (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
delete(dboct);


% --- Executes on button press in pushbutton_margin.
function pushbutton_margin_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_margin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.s=add_margin;    
set(handles.s,'Visible','on'); 


% --- Executes on button press in pushbutton_dB_Addition_Overall_Level.
function pushbutton_dB_Addition_Overall_Level_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_dB_Addition_Overall_Level (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.s=dB_Addition_overall;
set(handles.s,'Visible','on'); 


% --- Executes on button press in pushbutton_dB_Margin_RSS.
function pushbutton_dB_Margin_RSS_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_dB_Margin_RSS (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


handles.s=dB_Margin_RSS;    
set(handles.s,'Visible','on'); 


% --- Executes on button press in pushbutton_dB_difference.
function pushbutton_dB_difference_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_dB_difference (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.s=vibrationdata_dB_difference;    
set(handles.s,'Visible','on'); 


% --- Executes on button press in pushbutton_dB_Knockdown.
function pushbutton_dB_Knockdown_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_dB_Knockdown (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.s=dB_knockdown;    
set(handles.s,'Visible','on'); 

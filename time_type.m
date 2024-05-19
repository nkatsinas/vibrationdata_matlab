function varargout = time_type(varargin)
% TIME_TYPE MATLAB code for time_type.fig
%      TIME_TYPE, by itself, creates a new TIME_TYPE or raises the existing
%      singleton*.
%
%      H = TIME_TYPE returns the handle to a new TIME_TYPE or the handle to
%      the existing singleton*.
%
%      TIME_TYPE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TIME_TYPE.M with the given input arguments.
%
%      TIME_TYPE('Property','Value',...) creates a new TIME_TYPE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before time_type_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to time_type_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help time_type

% Last Modified by GUIDE v2.5 12-Sep-2020 18:02:11

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @time_type_OpeningFcn, ...
                   'gui_OutputFcn',  @time_type_OutputFcn, ...
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


% --- Executes just before time_type is made visible.
function time_type_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to time_type (see VARARGIN)

% Choose default command line output for time_type
handles.output = hObject;


% Update handles structure
guidata(hObject, handles);

% UIWAIT makes time_type wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = time_type_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton_start.
function pushbutton_start_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
setappdata(0,'Lflag',1);
delete(time_type);

% --- Executes on button press in pushbutton_end.
function pushbutton_end_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_end (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
setappdata(0,'Lflag',2);
delete(time_type);


% --- Executes on button press in pushbutton_both.
function pushbutton_both_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_both (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
setappdata(0,'Lflag',3);
delete(time_type);

% --- Executes on button press in pushbutton_cancel.
function pushbutton_cancel_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_cancel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
setappdata(0,'Lflag',4);
delete(time_type);

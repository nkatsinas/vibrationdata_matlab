function varargout = vibrationdata_saturation_main(varargin)
% VIBRATIONDATA_SATURATION_MAIN MATLAB code for vibrationdata_saturation_main.fig
%      VIBRATIONDATA_SATURATION_MAIN, by itself, creates a new VIBRATIONDATA_SATURATION_MAIN or raises the existing
%      singleton*.
%
%      H = VIBRATIONDATA_SATURATION_MAIN returns the handle to a new VIBRATIONDATA_SATURATION_MAIN or the handle to
%      the existing singleton*.
%
%      VIBRATIONDATA_SATURATION_MAIN('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in VIBRATIONDATA_SATURATION_MAIN.M with the given input arguments.
%
%      VIBRATIONDATA_SATURATION_MAIN('Property','Value',...) creates a new VIBRATIONDATA_SATURATION_MAIN or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before vibrationdata_saturation_main_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to vibrationdata_saturation_main_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help vibrationdata_saturation_main

% Last Modified by GUIDE v2.5 20-Sep-2021 12:00:24

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @vibrationdata_saturation_main_OpeningFcn, ...
                   'gui_OutputFcn',  @vibrationdata_saturation_main_OutputFcn, ...
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


% --- Executes just before vibrationdata_saturation_main is made visible.
function vibrationdata_saturation_main_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to vibrationdata_saturation_main (see VARARGIN)

% Choose default command line output for vibrationdata_saturation_main
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes vibrationdata_saturation_main wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = vibrationdata_saturation_main_OutputFcn(hObject, eventdata, handles) 
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

delete(vibrationdata_saturation_main);



% --- Executes on button press in pushbutton_bessel.
function pushbutton_bessel_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_bessel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.s=vibrationdata_bessel_filter_saturation;
set(handles.s,'Visible','on');     



% --- Executes on button press in pushbutton_mean.
function pushbutton_mean_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_mean (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.s=vibrationdata_mean_filter_saturation; 
set(handles.s,'Visible','on');     


% --- Executes on button press in pushbutton_butterworth.
function pushbutton_butterworth_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_butterworth (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.s=vibrationdata_butterworth_filter_saturation;
set(handles.s,'Visible','on');     

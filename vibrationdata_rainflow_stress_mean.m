function varargout = vibrationdata_rainflow_stress_mean(varargin)
% VIBRATIONDATA_RAINFLOW_STRESS_MEAN MATLAB code for vibrationdata_rainflow_stress_mean.fig
%      VIBRATIONDATA_RAINFLOW_STRESS_MEAN, by itself, creates a new VIBRATIONDATA_RAINFLOW_STRESS_MEAN or raises the existing
%      singleton*.
%
%      H = VIBRATIONDATA_RAINFLOW_STRESS_MEAN returns the handle to a new VIBRATIONDATA_RAINFLOW_STRESS_MEAN or the handle to
%      the existing singleton*.
%
%      VIBRATIONDATA_RAINFLOW_STRESS_MEAN('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in VIBRATIONDATA_RAINFLOW_STRESS_MEAN.M with the given input arguments.
%
%      VIBRATIONDATA_RAINFLOW_STRESS_MEAN('Property','Value',...) creates a new VIBRATIONDATA_RAINFLOW_STRESS_MEAN or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before vibrationdata_rainflow_stress_mean_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to vibrationdata_rainflow_stress_mean_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help vibrationdata_rainflow_stress_mean

% Last Modified by GUIDE v2.5 29-Jun-2015 10:30:18

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @vibrationdata_rainflow_stress_mean_OpeningFcn, ...
                   'gui_OutputFcn',  @vibrationdata_rainflow_stress_mean_OutputFcn, ...
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


% --- Executes just before vibrationdata_rainflow_stress_mean is made visible.
function vibrationdata_rainflow_stress_mean_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to vibrationdata_rainflow_stress_mean (see VARARGIN)

% Choose default command line output for vibrationdata_rainflow_stress_mean
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes vibrationdata_rainflow_stress_mean wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = vibrationdata_rainflow_stress_mean_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

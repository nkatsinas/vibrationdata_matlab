function varargout = rainflow_cycles(varargin)
% RAINFLOW_CYCLES MATLAB code for rainflow_cycles.fig
%      RAINFLOW_CYCLES, by itself, creates a new RAINFLOW_CYCLES or raises the existing
%      singleton*.
%
%      H = RAINFLOW_CYCLES returns the handle to a new RAINFLOW_CYCLES or the handle to
%      the existing singleton*.
%
%      RAINFLOW_CYCLES('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in RAINFLOW_CYCLES.M with the given input arguments.
%
%      RAINFLOW_CYCLES('Property','Value',...) creates a new RAINFLOW_CYCLES or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before rainflow_cycles_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to rainflow_cycles_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help rainflow_cycles

% Last Modified by GUIDE v2.5 30-Jul-2014 11:28:11

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @rainflow_cycles_OpeningFcn, ...
                   'gui_OutputFcn',  @rainflow_cycles_OutputFcn, ...
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


% --- Executes just before rainflow_cycles is made visible.
function rainflow_cycles_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to rainflow_cycles (see VARARGIN)

% Choose default command line output for rainflow_cycles
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes rainflow_cycles wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = rainflow_cycles_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
ata

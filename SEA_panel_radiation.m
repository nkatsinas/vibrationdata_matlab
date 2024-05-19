function varargout = SEA_panel_radiation(varargin)
% SEA_PANEL_RADIATION MATLAB code for SEA_panel_radiation.fig
%      SEA_PANEL_RADIATION, by itself, creates a new SEA_PANEL_RADIATION or raises the existing
%      singleton*.
%
%      H = SEA_PANEL_RADIATION returns the handle to a new SEA_PANEL_RADIATION or the handle to
%      the existing singleton*.
%
%      SEA_PANEL_RADIATION('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SEA_PANEL_RADIATION.M with the given input arguments.
%
%      SEA_PANEL_RADIATION('Property','Value',...) creates a new SEA_PANEL_RADIATION or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before SEA_panel_radiation_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to SEA_panel_radiation_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help SEA_panel_radiation

% Last Modified by GUIDE v2.5 11-Jan-2016 14:20:52

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @SEA_panel_radiation_OpeningFcn, ...
                   'gui_OutputFcn',  @SEA_panel_radiation_OutputFcn, ...
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


% --- Executes just before SEA_panel_radiation is made visible.
function SEA_panel_radiation_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to SEA_panel_radiation (see VARARGIN)

% Choose default command line output for SEA_panel_radiation
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes SEA_panel_radiation wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = SEA_panel_radiation_OutputFcn(hObject, eventdata, handles) 
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

delete(panel_point_force_single);

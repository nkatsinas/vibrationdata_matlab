function varargout = isolated_six_dof_four_isolators(varargin)
% ISOLATED_SIX_DOF_FOUR_ISOLATORS MATLAB code for isolated_six_dof_four_isolators.fig
%      ISOLATED_SIX_DOF_FOUR_ISOLATORS, by itself, creates a new ISOLATED_SIX_DOF_FOUR_ISOLATORS or raises the existing
%      singleton*.
%
%      H = ISOLATED_SIX_DOF_FOUR_ISOLATORS returns the handle to a new ISOLATED_SIX_DOF_FOUR_ISOLATORS or the handle to
%      the existing singleton*.
%
%      ISOLATED_SIX_DOF_FOUR_ISOLATORS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ISOLATED_SIX_DOF_FOUR_ISOLATORS.M with the given input arguments.
%
%      ISOLATED_SIX_DOF_FOUR_ISOLATORS('Property','Value',...) creates a new ISOLATED_SIX_DOF_FOUR_ISOLATORS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before isolated_six_dof_four_isolators_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to isolated_six_dof_four_isolators_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help isolated_six_dof_four_isolators

% Last Modified by GUIDE v2.5 02-Jan-2013 15:02:59

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @isolated_six_dof_four_isolators_OpeningFcn, ...
                   'gui_OutputFcn',  @isolated_six_dof_four_isolators_OutputFcn, ...
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


% --- Executes just before isolated_six_dof_four_isolators is made visible.
function isolated_six_dof_four_isolators_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to isolated_six_dof_four_isolators (see VARARGIN)

% Choose default command line output for isolated_six_dof_four_isolators
handles.output = hObject;

clc;
set(hObject, 'Units', 'pixels');
axes(handles.axes1);
bg = imread('isolated_box_main.jpg');
info.Width=485;
info.Height=418;

axes(handles.axes1);
image(bg);
set(handles.axes1, ...
    'Visible', 'off', ...
    'Units', 'pixels', ...
    'Position', [20 10 info.Width info.Height]);
axis off; 

handles.s1= isolated_6dof_4iso_calculation;
set(handles.s1,'Visible','off');

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes isolated_six_dof_four_isolators wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = isolated_six_dof_four_isolators_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.s1,'Visible','on');

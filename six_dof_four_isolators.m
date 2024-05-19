function varargout = six_dof_four_isolators(varargin)
% SIX_DOF_FOUR_ISOLATORS MATLAB code for six_dof_four_isolators.fig
%      SIX_DOF_FOUR_ISOLATORS, by itself, creates a new SIX_DOF_FOUR_ISOLATORS or raises the existing
%      singleton*.
%
%      H = SIX_DOF_FOUR_ISOLATORS returns the handle to a new SIX_DOF_FOUR_ISOLATORS or the handle to
%      the existing singleton*.
%
%      SIX_DOF_FOUR_ISOLATORS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SIX_DOF_FOUR_ISOLATORS.M with the given input arguments.
%
%      SIX_DOF_FOUR_ISOLATORS('Property','Value',...) creates a new SIX_DOF_FOUR_ISOLATORS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before six_dof_four_isolators_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to six_dof_four_isolators_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help six_dof_four_isolators

% Last Modified by GUIDE v2.5 11-Oct-2016 15:57:18

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @six_dof_four_isolators_OpeningFcn, ...
                   'gui_OutputFcn',  @six_dof_four_isolators_OutputFcn, ...
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


% --- Executes just before six_dof_four_isolators is made visible.
function six_dof_four_isolators_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to six_dof_four_isolators (see VARARGIN)

% Choose default command line output for six_dof_four_isolators
handles.output = hObject;


clc;

fstr='isolated_box_main.jpg';

bg = imread(fstr);
info = imfinfo(fstr);
w = info.Width;  %An integer indicating the width of the image in pixels
h = info.Height; %An integer indicating the height of the image in pixels
 
axes(handles.axes1);
image(bg);
pos1 = getpixelposition(handles.axes1,true);
 
set(handles.axes1, ...
    'Visible', 'off', ...
    'Units', 'pixels', ...
    'Position', [pos1(1) pos1(2) w h]);
axis off;


%% set(handles.s1,'Visible','off');

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes six_dof_four_isolators wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = six_dof_four_isolators_OutputFcn(hObject, eventdata, handles) 
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

handles.s1= isolated_6dof_4iso_calculation;
set(handles.s1,'Visible','on');


% --- Executes during object creation, after setting all properties.
function axes1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes1

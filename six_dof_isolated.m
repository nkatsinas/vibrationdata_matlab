function varargout = six_dof_isolated(varargin)
% SIX_DOF_ISOLATED MATLAB code for six_dof_isolated.fig
%      SIX_DOF_ISOLATED, by itself, creates a new SIX_DOF_ISOLATED or raises the existing
%      singleton*.
%
%      H = SIX_DOF_ISOLATED returns the handle to a new SIX_DOF_ISOLATED or the handle to
%      the existing singleton*.
%
%      SIX_DOF_ISOLATED('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SIX_DOF_ISOLATED.M with the given input arguments.
%
%      SIX_DOF_ISOLATED('Property','Value',...) creates a new SIX_DOF_ISOLATED or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before six_dof_isolated_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to six_dof_isolated_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help six_dof_isolated

% Last Modified by GUIDE v2.5 20-Jan-2015 08:58:04

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @six_dof_isolated_OpeningFcn, ...
                   'gui_OutputFcn',  @six_dof_isolated_OutputFcn, ...
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


% --- Executes just before six_dof_isolated is made visible.
function six_dof_isolated_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to six_dof_isolated (see VARARGIN)

% Choose default command line output for six_dof_isolated
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes six_dof_isolated wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = six_dof_isolated_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

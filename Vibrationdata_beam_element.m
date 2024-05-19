function varargout = Vibrationdata_beam_element(varargin)
% VIBRATIONDATA_BEAM_ELEMENT MATLAB code for Vibrationdata_beam_element.fig
%      VIBRATIONDATA_BEAM_ELEMENT, by itself, creates a new VIBRATIONDATA_BEAM_ELEMENT or raises the existing
%      singleton*.
%
%      H = VIBRATIONDATA_BEAM_ELEMENT returns the handle to a new VIBRATIONDATA_BEAM_ELEMENT or the handle to
%      the existing singleton*.
%
%      VIBRATIONDATA_BEAM_ELEMENT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in VIBRATIONDATA_BEAM_ELEMENT.M with the given input arguments.
%
%      VIBRATIONDATA_BEAM_ELEMENT('Property','Value',...) creates a new VIBRATIONDATA_BEAM_ELEMENT or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Vibrationdata_beam_element_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Vibrationdata_beam_element_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Vibrationdata_beam_element

% Last Modified by GUIDE v2.5 10-Apr-2014 15:46:50

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Vibrationdata_beam_element_OpeningFcn, ...
                   'gui_OutputFcn',  @Vibrationdata_beam_element_OutputFcn, ...
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


% --- Executes just before Vibrationdata_beam_element is made visible.
function Vibrationdata_beam_element_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Vibrationdata_beam_element (see VARARGIN)

% Choose default command line output for Vibrationdata_beam_element
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Vibrationdata_beam_element wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Vibrationdata_beam_element_OutputFcn(hObject, eventdata, handles) 
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

delete(Vibrationdata_beam_element);

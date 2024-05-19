function varargout = amplitude_conversion_utilities(varargin)
% AMPLITUDE_CONVERSION_UTILITIES MATLAB code for amplitude_conversion_utilities.fig
%      AMPLITUDE_CONVERSION_UTILITIES, by itself, creates a new AMPLITUDE_CONVERSION_UTILITIES or raises the existing
%      singleton*.
%
%      H = AMPLITUDE_CONVERSION_UTILITIES returns the handle to a new AMPLITUDE_CONVERSION_UTILITIES or the handle to
%      the existing singleton*.
%
%      AMPLITUDE_CONVERSION_UTILITIES('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in AMPLITUDE_CONVERSION_UTILITIES.M with the given input arguments.
%
%      AMPLITUDE_CONVERSION_UTILITIES('Property','Value',...) creates a new AMPLITUDE_CONVERSION_UTILITIES or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before amplitude_conversion_utilities_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to amplitude_conversion_utilities_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help amplitude_conversion_utilities

% Last Modified by GUIDE v2.5 12-Aug-2013 14:54:39

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @amplitude_conversion_utilities_OpeningFcn, ...
                   'gui_OutputFcn',  @amplitude_conversion_utilities_OutputFcn, ...
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


% --- Executes just before amplitude_conversion_utilities is made visible.
function amplitude_conversion_utilities_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to amplitude_conversion_utilities (see VARARGIN)

% Choose default command line output for amplitude_conversion_utilities
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes amplitude_conversion_utilities wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = amplitude_conversion_utilities_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton_ss_sine.
function pushbutton_ss_sine_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_ss_sine (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.s=sine_amplitude;
set(handles.s,'Visible','on'); 


% --- Executes on button press in pushbutton_srs_amplitude_conversion.
function pushbutton_srs_amplitude_conversion_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_srs_amplitude_conversion (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.s=srs_amplitude_conversion;
set(handles.s,'Visible','on');

% --- Executes on button press in pushbutton_return.
function pushbutton_return_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_return (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
delete(amplitude_conversion_utilities);


% --- Executes on key press with focus on pushbutton_srs_amplitude_conversion and none of its controls.
function pushbutton_srs_amplitude_conversion_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to pushbutton_srs_amplitude_conversion (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)

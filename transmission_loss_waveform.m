function varargout = transmission_loss_waveform(varargin)
% TRANSMISSION_LOSS_WAVEFORM MATLAB code for transmission_loss_waveform.fig
%      TRANSMISSION_LOSS_WAVEFORM, by itself, creates a new TRANSMISSION_LOSS_WAVEFORM or raises the existing
%      singleton*.
%
%      H = TRANSMISSION_LOSS_WAVEFORM returns the handle to a new TRANSMISSION_LOSS_WAVEFORM or the handle to
%      the existing singleton*.
%
%      TRANSMISSION_LOSS_WAVEFORM('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TRANSMISSION_LOSS_WAVEFORM.M with the given input arguments.
%
%      TRANSMISSION_LOSS_WAVEFORM('Property','Value',...) creates a new TRANSMISSION_LOSS_WAVEFORM or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before transmission_loss_waveform_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to transmission_loss_waveform_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help transmission_loss_waveform

% Last Modified by GUIDE v2.5 22-Jul-2021 10:11:29

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @transmission_loss_waveform_OpeningFcn, ...
                   'gui_OutputFcn',  @transmission_loss_waveform_OutputFcn, ...
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


% --- Executes just before transmission_loss_waveform is made visible.
function transmission_loss_waveform_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to transmission_loss_waveform (see VARARGIN)

% Choose default command line output for transmission_loss_waveform
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes transmission_loss_waveform wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = transmission_loss_waveform_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton_return.
function pushbutton_return_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_return (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

delete(transmission_loss_waveform);
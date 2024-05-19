function varargout = oblique_incidence_image(varargin)
% OBLIQUE_INCIDENCE_IMAGE MATLAB code for oblique_incidence_image.fig
%      OBLIQUE_INCIDENCE_IMAGE, by itself, creates a new OBLIQUE_INCIDENCE_IMAGE or raises the existing
%      singleton*.
%
%      H = OBLIQUE_INCIDENCE_IMAGE returns the handle to a new OBLIQUE_INCIDENCE_IMAGE or the handle to
%      the existing singleton*.
%
%      OBLIQUE_INCIDENCE_IMAGE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in OBLIQUE_INCIDENCE_IMAGE.M with the given input arguments.
%
%      OBLIQUE_INCIDENCE_IMAGE('Property','Value',...) creates a new OBLIQUE_INCIDENCE_IMAGE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before oblique_incidence_image_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to oblique_incidence_image_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help oblique_incidence_image

% Last Modified by GUIDE v2.5 01-Dec-2014 17:55:46

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @oblique_incidence_image_OpeningFcn, ...
                   'gui_OutputFcn',  @oblique_incidence_image_OutputFcn, ...
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


% --- Executes just before oblique_incidence_image is made visible.
function oblique_incidence_image_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to oblique_incidence_image (see VARARGIN)

% Choose default command line output for oblique_incidence_image
handles.output = hObject;

fstr='oblique.bmp';

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



% Update handles structure
guidata(hObject, handles);

% UIWAIT makes oblique_incidence_image wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = oblique_incidence_image_OutputFcn(hObject, eventdata, handles) 
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

delete(oblique_incidence_image);

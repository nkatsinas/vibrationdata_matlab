function varargout = ss_Ibeam_bending_static(varargin)
% SS_IBEAM_BENDING_STATIC MATLAB code for ss_Ibeam_bending_static.fig
%      SS_IBEAM_BENDING_STATIC, by itself, creates a new SS_IBEAM_BENDING_STATIC or raises the existing
%      singleton*.
%
%      H = SS_IBEAM_BENDING_STATIC returns the handle to a new SS_IBEAM_BENDING_STATIC or the handle to
%      the existing singleton*.
%
%      SS_IBEAM_BENDING_STATIC('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SS_IBEAM_BENDING_STATIC.M with the given input arguments.
%
%      SS_IBEAM_BENDING_STATIC('Property','Value',...) creates a new SS_IBEAM_BENDING_STATIC or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before ss_Ibeam_bending_static_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to ss_Ibeam_bending_static_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help ss_Ibeam_bending_static

% Last Modified by GUIDE v2.5 09-Jan-2020 18:09:29

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ss_Ibeam_bending_static_OpeningFcn, ...
                   'gui_OutputFcn',  @ss_Ibeam_bending_static_OutputFcn, ...
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


% --- Executes just before ss_Ibeam_bending_static is made visible.
function ss_Ibeam_bending_static_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to ss_Ibeam_bending_static (see VARARGIN)

% Choose default command line output for ss_Ibeam_bending_static
handles.output = hObject;

clc;

fstr='Ibeam1.jpg';

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


%%%

Nrows=1;
Ncolumns=4;



set(handles.uitable_data,'Data',cell(Nrows,Ncolumns));

%%%

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes ss_Ibeam_bending_static wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = ss_Ibeam_bending_static_OutputFcn(hObject, eventdata, handles) 
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

data=get(handles.uitable_data,'Data');
A=char(data);
  
B=str2double(A(1,:));
H=str2double(A(2,:));
Tf=str2double(A(3,:));
Tw=str2double(A(4,:));   

[area,MOIz,MOIy]=Ibeam_geometry(B,H,Tf,Tw)


% --- Executes on button press in pushbutton_return.
function pushbutton_return_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_return (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes during object creation, after setting all properties.
function pushbutton_calculate_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

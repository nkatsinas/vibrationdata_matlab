function varargout = SEA_four_subsystems_main(varargin)
% SEA_FOUR_SUBSYSTEMS_MAIN MATLAB code for SEA_four_subsystems_main.fig
%      SEA_FOUR_SUBSYSTEMS_MAIN, by itself, creates a new SEA_FOUR_SUBSYSTEMS_MAIN or raises the existing
%      singleton*.
%
%      H = SEA_FOUR_SUBSYSTEMS_MAIN returns the handle to a new SEA_FOUR_SUBSYSTEMS_MAIN or the handle to
%      the existing singleton*.
%
%      SEA_FOUR_SUBSYSTEMS_MAIN('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SEA_FOUR_SUBSYSTEMS_MAIN.M with the given input arguments.
%
%      SEA_FOUR_SUBSYSTEMS_MAIN('Property','Value',...) creates a new SEA_FOUR_SUBSYSTEMS_MAIN or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before SEA_four_subsystems_main_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to SEA_four_subsystems_main_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help SEA_four_subsystems_main

% Last Modified by GUIDE v2.5 01-Jan-2016 10:52:52

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @SEA_four_subsystems_main_OpeningFcn, ...
                   'gui_OutputFcn',  @SEA_four_subsystems_main_OutputFcn, ...
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


% --- Executes just before SEA_four_subsystems_main is made visible.
function SEA_four_subsystems_main_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to SEA_four_subsystems_main (see VARARGIN)

% Choose default command line output for SEA_four_subsystems_main
handles.output = hObject;

x1=30;
x2=480;

y1=110;
y2=330;


clc;

fstr='four_1.jpg';

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


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

fstr='four_2.jpg';

bg = imread(fstr);
info = imfinfo(fstr);
w = info.Width;  %An integer indicating the width of the image in pixels
h = info.Height; %An integer indicating the height of the image in pixels
 
axes(handles.axes2);
image(bg);
 
pos1 = getpixelposition(handles.axes2,true);
 
set(handles.axes2, ...
    'Visible', 'off', ...
    'Units', 'pixels', ...
    'Position', [pos1(1) pos1(2) w h]);
axis off;

 


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

fstr='four_3.jpg';

bg = imread(fstr);
info = imfinfo(fstr);
w = info.Width;  %An integer indicating the width of the image in pixels
h = info.Height; %An integer indicating the height of the image in pixels
 
axes(handles.axes3);
image(bg);
 
pos1 = getpixelposition(handles.axes3,true);
 
set(handles.axes3, ...
    'Visible', 'off', ...
    'Units', 'pixels', ...
    'Position', [pos1(1) pos1(2) w h]);
axis off;



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

fstr='four_4.jpg';

bg = imread(fstr);
info = imfinfo(fstr);
w = info.Width;  %An integer indicating the width of the image in pixels
h = info.Height; %An integer indicating the height of the image in pixels
 
axes(handles.axes4);
image(bg);
 
pos1 = getpixelposition(handles.axes4,true);
 
set(handles.axes4, ...
    'Visible', 'off', ...
    'Units', 'pixels', ...
    'Position', [pos1(1) pos1(2) w h]);
axis off;



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% Update handles structure
guidata(hObject, handles);

% UIWAIT makes SEA_four_subsystems_main wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = SEA_four_subsystems_main_OutputFcn(hObject, eventdata, handles) 
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

delete(SEA_four_subsystems_main);


% --- Executes during object creation, after setting all properties.
function axes1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes1


% --- Executes during object creation, after setting all properties.
function axes2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes2


% --- Executes on button press in pushbutton_upper_left.
function pushbutton_upper_left_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_upper_left (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.s=SEA_four_subsystems_1;       
set(handles.s,'Visible','on'); 


% --- Executes on button press in pushbutton_upper_right.
function pushbutton_upper_right_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_upper_right (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.s=SEA_four_subsystems_2;       
set(handles.s,'Visible','on'); 



% --- Executes on button press in pushbutton_lower_left.
function pushbutton_lower_left_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_lower_left (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.s=SEA_four_subsystems_3;       
set(handles.s,'Visible','on'); 


% --- Executes on button press in pushbutton_lower_right.
function pushbutton_lower_right_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_lower_right (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.s=SEA_four_subsystems_4;       
set(handles.s,'Visible','on'); 

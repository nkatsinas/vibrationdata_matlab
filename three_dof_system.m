function varargout = three_dof_system(varargin)
% THREE_DOF_SYSTEM MATLAB code for three_dof_system.fig
%      THREE_DOF_SYSTEM, by itself, creates a new THREE_DOF_SYSTEM or raises the existing
%      singleton*.
%
%      H = THREE_DOF_SYSTEM returns the handle to a new THREE_DOF_SYSTEM or the handle to
%      the existing singleton*.
%
%      THREE_DOF_SYSTEM('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in THREE_DOF_SYSTEM.M with the given input arguments.
%
%      THREE_DOF_SYSTEM('Property','Value',...) creates a new THREE_DOF_SYSTEM or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before three_dof_system_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to three_dof_system_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help three_dof_system

% Last Modified by GUIDE v2.5 29-Jul-2016 14:48:39

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @three_dof_system_OpeningFcn, ...
                   'gui_OutputFcn',  @three_dof_system_OutputFcn, ...
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


% --- Executes just before three_dof_system is made visible.
function three_dof_system_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to three_dof_system (see VARARGIN)

% Choose default command line output for three_dof_system
handles.output = hObject;

fstr='threedof1_sm.jpg';

bg = imread(fstr);
info = imfinfo(fstr);
w = info.Width;  %An integer indicating the width of the image in pixels
h = info.Height; %An integer indicating the height of the image in pixels
 
axes(handles.axes1);
image(bg);
 
pos1 = getpixelposition(handles.select_one_pushbutton,true);

xc=0.5*pos1(3)+pos1(1);
x=round(xc-0.5*w);
y=pos1(2)+1.4*pos1(4);

set(handles.axes1, ...
    'Visible', 'off', ...
    'Units', 'pixels', ...
    'Position', [x y w h]);
axis off;



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

fstr='threedof2_sm.jpg';

bg = imread(fstr);
info = imfinfo(fstr);
w = info.Width;  %An integer indicating the width of the image in pixels
h = info.Height; %An integer indicating the height of the image in pixels
 
axes(handles.axes2);
image(bg);
 
pos1 = getpixelposition(handles.select_two_pushbutton,true);

xc=0.5*pos1(3)+pos1(1);
x=round(xc-0.5*w);
y=pos1(2)+1.4*pos1(4);

set(handles.axes2, ...
    'Visible', 'off', ...
    'Units', 'pixels', ...
    'Position', [x y w h]);
axis off;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

fstr='threedof3_sm.jpg';

bg = imread(fstr);
info = imfinfo(fstr);
w = info.Width;  %An integer indicating the width of the image in pixels
h = info.Height; %An integer indicating the height of the image in pixels
 
axes(handles.axes3);
image(bg);
 
pos1 = getpixelposition(handles.select_three_pushbutton,true);

xc=0.5*pos1(3)+pos1(1);
x=round(xc-0.5*w);
y=pos1(2)+1.4*pos1(4);

set(handles.axes3, ...
    'Visible', 'off', ...
    'Units', 'pixels', ...
    'Position', [x y w h]);
axis off;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

fstr='threedof4_sm.jpg';

bg = imread(fstr);
info = imfinfo(fstr);
w = info.Width;  %An integer indicating the width of the image in pixels
h = info.Height; %An integer indicating the height of the image in pixels
 
axes(handles.axes4);
image(bg);
 
pos1 = getpixelposition(handles.select_four_pushbutton,true);

xc=0.5*pos1(3)+pos1(1);
x=round(xc-0.5*w);
y=pos1(2)+1.4*pos1(4);

set(handles.axes4, ...
    'Visible', 'off', ...
    'Units', 'pixels', ...
    'Position', [x y w h]);
axis off;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



% Update handles structure
guidata(hObject, handles);

% UIWAIT makes three_dof_system wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = three_dof_system_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in select_one_pushbutton.
function select_one_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to select_one_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.three_dof_a= three_dof_system_a;
set(handles.three_dof_a,'Visible','on');

% --- Executes on button press in select_two_pushbutton.
function select_two_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to select_two_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.three_dof_b= three_dof_system_b;
set(handles.three_dof_b,'Visible','on');

% --- Executes on button press in select_three_pushbutton.
function select_three_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to select_three_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.three_dof_c= three_dof_system_c;
set(handles.three_dof_c,'Visible','on');

% --- Executes during object creation, after setting all properties.
function axes1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes1


% --- Executes on button press in pushbutton_return.
function pushbutton_return_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_return (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
delete(three_dof_system);


% --- Executes on button press in select_four_pushbutton.
function select_four_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to select_four_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.three_dof_d= three_dof_system_d;
set(handles.three_dof_d,'Visible','on');


% --- Executes during object creation, after setting all properties.
function axes4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes4

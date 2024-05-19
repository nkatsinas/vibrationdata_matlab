function varargout = sdof_base(varargin)
% SDOF_BASE MATLAB code for sdof_base.fig
%      SDOF_BASE, by itself, creates a new SDOF_BASE or raises the existing
%      singleton*.
%
%      H = SDOF_BASE returns the handle to a new SDOF_BASE or the handle to
%      the existing singleton*.
%
%      SDOF_BASE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SDOF_BASE.M with the given input arguments.
%
%      SDOF_BASE('Property','Value',...) creates a new SDOF_BASE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before sdof_base_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to sdof_base_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help sdof_base

% Last Modified by GUIDE v2.5 11-Oct-2016 13:09:05

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @sdof_base_OpeningFcn, ...
                   'gui_OutputFcn',  @sdof_base_OutputFcn, ...
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


% --- Executes just before sdof_base is made visible.
function sdof_base_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to sdof_base (see VARARGIN)

% Choose default command line output for sdof_base
handles.output = hObject;

fstr='sdof_base_image.jpg';
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




set(handles.fn_edit,'Enable','off');

set(handles.damping_edit,'String','10');

setappdata(0,'Q',10);
setappdata(0,'damping',0.05);

buttons_off(hObject, eventdata, handles);

setappdata(0,'fig_num',1);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes sdof_base wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = sdof_base_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

function buttons_off(hObject, eventdata, handles)
set(handles.half_sine_pushbutton,'Enable','off');
set(handles.terminal_sawtooth_pushbutton,'Enable','off');
set(handles.arbitrary_pushbutton,'Enable','off');
set(handles.sine_pushbutton,'Enable','off');
set(handles.transmissibility_pushbutton,'Enable','off');
set(handles.PSD_pushbutton,'Enable','off');


function fn_edit_Callback(hObject, eventdata, handles)
% hObject    handle to fn_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of fn_edit as text
%        str2double(get(hObject,'String')) returns contents of fn_edit as a double


% --- Executes during object creation, after setting all properties.
function fn_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to fn_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in damping_listbox.
function damping_listbox_Callback(hObject, eventdata, handles)
% hObject    handle to damping_listbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns damping_listbox contents as cell array
%        contents{get(hObject,'Value')} returns selected item from damping_listbox

%%%%%%  clear_fn(hObject, eventdata, handles)

nd=get(hObject,'Value');



if(nd==1)
    Q=str2num(get(handles.damping_edit,'String'));
    damping=1/(2*Q);
else
   damping=str2num(get(handles.damping_edit,'String'));
   Q=1/(2*damping);
end

setappdata(0,'damping',damping);
setappdata(0,'Q',Q);

% --- Executes during object creation, after setting all properties.
function damping_listbox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to damping_listbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function damping_edit_Callback(hObject, eventdata, handles)
% hObject    handle to damping_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of damping_edit as text
%        str2double(get(hObject,'String')) returns contents of damping_edit as a double
nd=get(handles.damping_listbox,'Value');

if(nd==1)
    Q=str2num(get(handles.damping_edit,'String'));
    damping=1/(2*Q);
else
   damping=str2num(get(handles.damping_edit,'String'));
   Q=1/(2*damping);
end

setappdata(0,'damping',damping);
setappdata(0,'Q',Q);


% --- Executes during object creation, after setting all properties.
function damping_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to damping_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function mass_edit_Callback(hObject, eventdata, handles)
% hObject    handle to mass_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of mass_edit as text
%        str2double(get(hObject,'String')) returns contents of mass_edit as a double


% --- Executes during object creation, after setting all properties.
function mass_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to mass_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function stiffness_edit_Callback(hObject, eventdata, handles)
% hObject    handle to stiffness_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of stiffness_edit as text
%        str2double(get(hObject,'String')) returns contents of stiffness_edit as a double


% --- Executes during object creation, after setting all properties.
function stiffness_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to stiffness_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in units_listbox.
function units_listbox_Callback(hObject, eventdata, handles)
% hObject    handle to units_listbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns units_listbox contents as cell array
%        contents{get(hObject,'Value')} returns selected item from units_listbox
n=get(hObject,'Value');

if(n==1)
    set(handles.mass_text,'String','mass (lbm)');
    set(handles.stiffness_text,'String','stiffness (lbf/in)');    
else
    set(handles.mass_text,'String','mass (kg)');
    set(handles.stiffness_text,'String','stiffness (N/mm)');     
end

clear_fn(hObject, eventdata, handles)


% --- Executes during object creation, after setting all properties.
function units_listbox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to units_listbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in half_sine_pushbutton.
function half_sine_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to half_sine_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

display_damping(hObject, eventdata, handles);

handles.sdof_half_sine= sdof_half_sine;
set(handles.sdof_half_sine,'Visible','on')


function display_damping(hObject, eventdata, handles)

nd=get(handles.damping_listbox,'Value');

if(nd==1)
    Q=str2num(get(handles.damping_edit,'String'));
    damping=1/(2*Q);
else
   damping=str2num(get(handles.damping_edit,'String'));
   Q=1/(2*damping);
end

setappdata(0,'damping',damping);
setappdata(0,'Q',Q);

s3=sprintf('\n     Damping Ratio = %8.4g ',damping);
disp(s3);
s4=sprintf('                 Q = %8.4g ',Q);
disp(s4);



% --- Executes on button press in sine_pushbutton.
function sine_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to sine_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

display_damping(hObject, eventdata, handles);

handles.sdof_sine= sdof_steady_sine;
set(handles.sdof_sine,'Visible','on')

% --- Executes on button press in terminal_sawtooth_pushbutton.
function terminal_sawtooth_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to terminal_sawtooth_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
display_damping(hObject, eventdata, handles);

handles.terminal_sawtooth= sdof_terminal_sawtooth;
set(handles.terminal_sawtooth,'Visible','on')

% --- Executes on button press in transmissibility_pushbutton.
function transmissibility_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to transmissibility_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

display_damping(hObject, eventdata, handles);

handles.transmissibility= sdof_transmissibility;
set(handles.transmissibility,'Visible','on')

% --- Executes on button press in PSD_pushbutton.
function PSD_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to PSD_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

display_damping(hObject, eventdata, handles);

handles.PSD_pushbutton= sdof_PSD;
set(handles.PSD_pushbutton,'Visible','on')


% --- Executes on button press in fn_pushbutton.
function fn_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to fn_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

n=get(handles.units_listbox,'Value');

m=str2num(get(handles.mass_edit,'String'));
k=str2num(get(handles.stiffness_edit,'String'));

if(n==1)
    m=m/386;
else
    k=k*1000;
end

fn=sqrt(k/m)/(2*pi);

s1=sprintf('%8.4g',fn);

set(handles.fn_edit,'Enable','on');
set(handles.fn_edit,'String',s1);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



setappdata(0,'unit',n);
setappdata(0,'fn',fn);

set(handles.half_sine_pushbutton,'Enable','on');
set(handles.terminal_sawtooth_pushbutton,'Enable','on');
set(handles.arbitrary_pushbutton,'Enable','on');
set(handles.sine_pushbutton,'Enable','on');
set(handles.transmissibility_pushbutton,'Enable','on');
set(handles.PSD_pushbutton,'Enable','on');

s2=sprintf('\n Natural Frequency = %8.4g Hz',fn);
disp(s2);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


function clear_fn(hObject, eventdata, handles)
set(handles.fn_edit,'Enable','off');
set(handles.fn_edit,'String',' ');
buttons_off(hObject, eventdata, handles);

% --- Executes on key press with focus on mass_edit and none of its controls.
function mass_edit_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to mass_edit (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
clear_fn(hObject, eventdata, handles)


% --- Executes on key press with focus on stiffness_edit and none of its controls.
function stiffness_edit_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to stiffness_edit (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
clear_fn(hObject, eventdata, handles)


% --- Executes on key press with focus on damping_edit and none of its controls.
function damping_edit_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to damping_edit (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)

%%%  clear_fn(hObject, eventdata, handles)


% --- Executes on button press in arbitrary_pushbutton.
function arbitrary_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to arbitrary_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

display_damping(hObject, eventdata, handles);

handles.arbitary_pushbutton= sdof_arbitrary;
set(handles.arbitrary_pushbutton,'Visible','on')


% --- Executes during object creation, after setting all properties.
function uipanel7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to uipanel7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

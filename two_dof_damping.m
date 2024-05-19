function varargout = two_dof_damping(varargin)
% TWO_DOF_DAMPING MATLAB code for two_dof_damping.fig
%      TWO_DOF_DAMPING, by itself, creates a new TWO_DOF_DAMPING or raises the existing
%      singleton*.
%
%      H = TWO_DOF_DAMPING returns the handle to a new TWO_DOF_DAMPING or the handle to
%      the existing singleton*.
%
%      TWO_DOF_DAMPING('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TWO_DOF_DAMPING.M with the given input arguments.
%
%      TWO_DOF_DAMPING('Property','Value',...) creates a new TWO_DOF_DAMPING or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before two_dof_damping_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to two_dof_damping_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help two_dof_damping

% Last Modified by GUIDE v2.5 16-Jan-2013 15:27:28

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @two_dof_damping_OpeningFcn, ...
                   'gui_OutputFcn',  @two_dof_damping_OutputFcn, ...
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


% --- Executes just before two_dof_damping is made visible.
function two_dof_damping_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to two_dof_damping (see VARARGIN)

% Choose default command line output for two_dof_damping
handles.output = hObject;

handles.Q_list=1;
handles.uniform_list=1;

Q_listbox_Callback(hObject, eventdata, handles);
uniform_listbox_Callback(hObject, eventdata, handles);

value_boxes(hObject, eventdata, handles);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes two_dof_damping wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = two_dof_damping_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in save_pushbutton.
function save_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to save_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
clear damp;

disp(' ');
if(handles.Q_list==1) % Q
    disp(' Amplification Factors Q for Two Modes ');
else
    disp(' Viscous Damping Ratios for Two Modes  ');
end

if(handles.uniform_list==1) % uniform
 
    damp(1)=str2num(get(handles.d1_edit,'String'));
    damp(2)=damp(1);
else
    damp(1)=str2num(get(handles.d1_edit,'String'));
    damp(2)=str2num(get(handles.d2_edit,'String'));  
end

disp('Mode 1       2        ');
out1=sprintf(' %6.3g  %6.3g  ',...
                          damp(1),damp(2));
disp(out1);

if(handles.Q_list==1) % Q
    for i=1:2
        damp(i)=1/(2*damp(i));
    end
end

setappdata(0,'damping',damp);

damping_flag=1;
setappdata(0,'damping_flag',damping_flag);


msgbox('Damping values saved and displayed in Matlab Command Window.');

close(two_dof_damping);



function d1_edit_Callback(hObject, eventdata, handles)
% hObject    handle to d1_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of d1_edit as text
%        str2double(get(hObject,'String')) returns contents of d1_edit as a double


% --- Executes during object creation, after setting all properties.
function d1_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to d1_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function d2_edit_Callback(hObject, eventdata, handles)
% hObject    handle to d2_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of d2_edit as text
%        str2double(get(hObject,'String')) returns contents of d2_edit as a double


% --- Executes during object creation, after setting all properties.
function d2_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to d2_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in Q_listbox.
function Q_listbox_Callback(hObject, eventdata, handles)
% hObject    handle to Q_listbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns Q_listbox contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Q_listbox

n=get(handles.Q_listbox,'Value');

if(n==1)
    set(handles.Q_text,'String','Q');
else
    set(handles.Q_text,'String','Ratio');    
end

value_boxes(hObject, eventdata, handles);

guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function Q_listbox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Q_listbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in uniform_listbox.
function uniform_listbox_Callback(hObject, eventdata, handles)
% hObject    handle to uniform_listbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns uniform_listbox contents as cell array
%        contents{get(hObject,'Value')} returns selected item from uniform_listbox

value_boxes(hObject, eventdata, handles);

guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function uniform_listbox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to uniform_listbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function value_boxes(hObject, eventdata, handles)

set(handles.d1_edit,'Enable','off');
set(handles.d2_edit,'Enable','off');



set(handles.d1_edit,'String',' ');
set(handles.d2_edit,'String',' ');


set(handles.m1_text,'Visible','off');
set(handles.m2_text,'Visible','off');


set(handles.m1_text,'String',' ');
set(handles.m2_text,'String',' ');

m=get(handles.uniform_listbox,'Value');


if(m==1)
    set(handles.mode_text,'String',' ');
    set(handles.d1_edit,'Enable','on');
else
    set(handles.mode_text,'String','Mode');    
    set(handles.d1_edit,'Enable','on');
    set(handles.d2_edit,'Enable','on');

    
    set(handles.m1_text,'Visible','on');
    set(handles.m2_text,'Visible','on');

    set(handles.m1_text,'String','1');
    set(handles.m2_text,'String','2');
    
end



guidata(hObject, handles);

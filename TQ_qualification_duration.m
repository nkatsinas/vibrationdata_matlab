function varargout = TQ_qualification_duration(varargin)
% TQ_QUALIFICATION_DURATION MATLAB code for TQ_qualification_duration.fig
%      TQ_QUALIFICATION_DURATION, by itself, creates a new TQ_QUALIFICATION_DURATION or raises the existing
%      singleton*.
%
%      H = TQ_QUALIFICATION_DURATION returns the handle to a new TQ_QUALIFICATION_DURATION or the handle to
%      the existing singleton*.
%
%      TQ_QUALIFICATION_DURATION('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TQ_QUALIFICATION_DURATION.M with the given input arguments.
%
%      TQ_QUALIFICATION_DURATION('Property','Value',...) creates a new TQ_QUALIFICATION_DURATION or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before TQ_qualification_duration_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to TQ_qualification_duration_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help TQ_qualification_duration

% Last Modified by GUIDE v2.5 18-Dec-2020 09:42:05

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @TQ_qualification_duration_OpeningFcn, ...
                   'gui_OutputFcn',  @TQ_qualification_duration_OutputFcn, ...
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


% --- Executes just before TQ_qualification_duration is made visible.
function TQ_qualification_duration_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to TQ_qualification_duration (see VARARGIN)

% Choose default command line output for TQ_qualification_duration
handles.output = hObject;

set(handles.uipanel_result,'Visible','off');

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes TQ_qualification_duration wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = TQ_qualification_duration_OutputFcn(hObject, eventdata, handles) 
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

delete(TQ_qualification_duration);


% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

set(handles.uipanel_result,'Visible','on');

TMPE=str2double(get(handles.edit_TMPE,'String'));
TA=str2double(get(handles.edit_TA,'String'));
b=str2double(get(handles.edit_b,'String'));
M=str2double(get(handles.edit_M,'String'));


term=10^(M*b/20);

TQg=4*(TMPE+TA/term);

TQe=4*(TMPE+TA)/term;

ssg=sprintf('%d',round(TQg));
sse=sprintf('%d',round(TQe));

set(handles.edit_TQ_general,'String',ssg);
set(handles.edit_TQ_engine,'String',sse);


function edit_TMPE_Callback(hObject, eventdata, handles)
% hObject    handle to edit_TMPE (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_TMPE as text
%        str2double(get(hObject,'String')) returns contents of edit_TMPE as a double


% --- Executes during object creation, after setting all properties.
function edit_TMPE_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_TMPE (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_TA_Callback(hObject, eventdata, handles)
% hObject    handle to edit_TA (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_TA as text
%        str2double(get(hObject,'String')) returns contents of edit_TA as a double


% --- Executes during object creation, after setting all properties.
function edit_TA_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_TA (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_b_Callback(hObject, eventdata, handles)
% hObject    handle to edit_b (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_b as text
%        str2double(get(hObject,'String')) returns contents of edit_b as a double


% --- Executes during object creation, after setting all properties.
function edit_b_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_b (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_TQ_general_Callback(hObject, eventdata, handles)
% hObject    handle to edit_TQ_general (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_TQ_general as text
%        str2double(get(hObject,'String')) returns contents of edit_TQ_general as a double


% --- Executes during object creation, after setting all properties.
function edit_TQ_general_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_TQ_general (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_TQ_engine_Callback(hObject, eventdata, handles)
% hObject    handle to edit_TQ_engine (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_TQ_engine as text
%        str2double(get(hObject,'String')) returns contents of edit_TQ_engine as a double


% --- Executes during object creation, after setting all properties.
function edit_TQ_engine_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_TQ_engine (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_M_Callback(hObject, eventdata, handles)
% hObject    handle to edit_M (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_M as text
%        str2double(get(hObject,'String')) returns contents of edit_M as a double

set(handles.uipanel_result,'Visible','off');

% --- Executes during object creation, after setting all properties.
function edit_M_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_M (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on key press with focus on edit_TMPE and none of its controls.
function edit_TMPE_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_TMPE (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)

set(handles.uipanel_result,'Visible','off');


% --- Executes on key press with focus on edit_TA and none of its controls.
function edit_TA_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_TA (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)

set(handles.uipanel_result,'Visible','off');


% --- Executes on key press with focus on edit_b and none of its controls.
function edit_b_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_b (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)

set(handles.uipanel_result,'Visible','off');

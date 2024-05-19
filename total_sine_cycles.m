function varargout = total_sine_cycles(varargin)
% TOTAL_SINE_CYCLES MATLAB code for total_sine_cycles.fig
%      TOTAL_SINE_CYCLES, by itself, creates a new TOTAL_SINE_CYCLES or raises the existing
%      singleton*.
%
%      H = TOTAL_SINE_CYCLES returns the handle to a new TOTAL_SINE_CYCLES or the handle to
%      the existing singleton*.
%
%      TOTAL_SINE_CYCLES('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TOTAL_SINE_CYCLES.M with the given input arguments.
%
%      TOTAL_SINE_CYCLES('Property','Value',...) creates a new TOTAL_SINE_CYCLES or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before total_sine_cycles_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to total_sine_cycles_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help total_sine_cycles

% Last Modified by GUIDE v2.5 25-Jan-2014 14:07:37

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @total_sine_cycles_OpeningFcn, ...
                   'gui_OutputFcn',  @total_sine_cycles_OutputFcn, ...
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


% --- Executes just before total_sine_cycles is made visible.
function total_sine_cycles_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to total_sine_cycles (see VARARGIN)

% Choose default command line output for total_sine_cycles
handles.output = hObject;

set(handles.edit_results,'string',' ');
set(handles.edit_results,'enable','off');
set(handles.edit_octaves,'string',' ');
set(handles.edit_octaves,'enable','off');

set(handles.listbox_sweep_type,'value',1);


% Update handles structure
guidata(hObject, handles);

% UIWAIT makes total_sine_cycles wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = total_sine_cycles_OutputFcn(hObject, eventdata, handles) 
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
delete(total_sine_cycles)


% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.edit_results,'enable','on');
set(handles.edit_octaves,'enable','on');

f1=str2num(get(handles.edit_f1,'String'));
f2=str2num(get(handles.edit_f2,'String'));

T=str2num(get(handles.edit_duration,'String'));

ntype=get(handles.listbox_sweep_type,'value');

if(f1>f2)
    temp=f1;
    f1=f2;
    f2=temp;
end

octaves=log(f2/f1)/log(2);

if(ntype==2)
    cycles=0.5*( (f2-f1) / T  )*T^2 + f1*T;  % linear ok
else
    R=octaves/T;
    cycles=f1*( -1.+ 2^(R*T) )/( R*log(2) );
end    

out1=sprintf('%11.6g ',cycles);
set(handles.edit_results,'String',out1);

out1=sprintf('%7.3g ',octaves);
set(handles.edit_octaves,'String',out1);

function edit_results_Callback(hObject, eventdata, handles)
% hObject    handle to edit_results (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_results as text
%        str2double(get(hObject,'String')) returns contents of edit_results as a double


% --- Executes during object creation, after setting all properties.
function edit_results_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_results (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_sweep_type.
function listbox_sweep_type_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_sweep_type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_sweep_type contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_sweep_type
set(handles.edit_results,'string',' ');
set(handles.edit_results,'enable','off');
set(handles.edit_octaves,'string',' ');
set(handles.edit_octaves,'enable','off');

% --- Executes during object creation, after setting all properties.
function listbox_sweep_type_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_sweep_type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_f1_Callback(hObject, eventdata, handles)
% hObject    handle to edit_f1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_f1 as text
%        str2double(get(hObject,'String')) returns contents of edit_f1 as a double


% --- Executes during object creation, after setting all properties.
function edit_f1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_f1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_f2_Callback(hObject, eventdata, handles)
% hObject    handle to edit_f2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_f2 as text
%        str2double(get(hObject,'String')) returns contents of edit_f2 as a double


% --- Executes during object creation, after setting all properties.
function edit_f2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_f2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on key press with focus on edit_f1 and none of its controls.
function edit_f1_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_f1 (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.edit_results,'string',' ');
set(handles.edit_results,'enable','off');
set(handles.edit_octaves,'string',' ');
set(handles.edit_octaves,'enable','off');

% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over edit_f2.
function edit_f2_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to edit_f2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.edit_results,'string',' ');
set(handles.edit_results,'enable','off');
set(handles.edit_octaves,'string',' ');
set(handles.edit_octaves,'enable','off');


function edit_duration_Callback(hObject, eventdata, handles)
% hObject    handle to edit_duration (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_duration as text
%        str2double(get(hObject,'String')) returns contents of edit_duration as a double


% --- Executes during object creation, after setting all properties.
function edit_duration_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_duration (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_octaves_Callback(hObject, eventdata, handles)
% hObject    handle to edit_octaves (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_octaves as text
%        str2double(get(hObject,'String')) returns contents of edit_octaves as a double


% --- Executes during object creation, after setting all properties.
function edit_octaves_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_octaves (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over edit_duration.
function edit_duration_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to edit_duration (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.edit_results,'string',' ');
set(handles.edit_results,'enable','off');
set(handles.edit_octaves,'string',' ');
set(handles.edit_octaves,'enable','off');


% --- Executes on key press with focus on edit_duration and none of its controls.
function edit_duration_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_duration (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.edit_results,'string',' ');
set(handles.edit_results,'enable','off');
set(handles.edit_octaves,'string',' ');
set(handles.edit_octaves,'enable','off');


% --- Executes on key press with focus on edit_f2 and none of its controls.
function edit_f2_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_f2 (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.edit_results,'string',' ');
set(handles.edit_results,'enable','off');
set(handles.edit_octaves,'string',' ');
set(handles.edit_octaves,'enable','off');

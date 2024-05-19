function varargout = circuit_board_damping(varargin)
% CIRCUIT_BOARD_DAMPING MATLAB code for circuit_board_damping.fig
%      CIRCUIT_BOARD_DAMPING, by itself, creates a new CIRCUIT_BOARD_DAMPING or raises the existing
%      singleton*.
%
%      H = CIRCUIT_BOARD_DAMPING returns the handle to a new CIRCUIT_BOARD_DAMPING or the handle to
%      the existing singleton*.
%
%      CIRCUIT_BOARD_DAMPING('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CIRCUIT_BOARD_DAMPING.M with the given input arguments.
%
%      CIRCUIT_BOARD_DAMPING('Property','Value',...) creates a new CIRCUIT_BOARD_DAMPING or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before circuit_board_damping_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to circuit_board_damping_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help circuit_board_damping

% Last Modified by GUIDE v2.5 26-Apr-2018 09:25:02

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @circuit_board_damping_OpeningFcn, ...
                   'gui_OutputFcn',  @circuit_board_damping_OutputFcn, ...
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


% --- Executes just before circuit_board_damping is made visible.
function circuit_board_damping_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to circuit_board_damping (see VARARGIN)

% Choose default command line output for circuit_board_damping
handles.output = hObject;

set(handles.uipanel_save,'Visible','off');

listbox_excitation_Callback(hObject, eventdata, handles)

% Update handles structure
guidata(hObject, handles);


% --- Outputs from this function are returned to the command line.
function varargout = circuit_board_damping_OutputFcn(hObject, eventdata, handles) 
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

delete(circuit_board_damping)


% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

disp(' ');
disp(' * * * * * ');
disp(' ');

set(handles.uipanel_save,'Visible','on');

n=get(handles.listbox_structure,'Value');

if(n==1)
    A=1;
    disp('Beam-type Structure');
end
if(n==2)
    A=0.5;
    disp('Perimeter-supported PCB');    
end
if(n==3)
    A=0.25;
    disp('Small Electronic Chassis');      
end
disp(' ');

fn=str2num(get(handles.edit_fn,'String'));

Gin=str2num(get(handles.edit_Gin,'String'));


nex=get(handles.listbox_excitation,'Value');

if(nex==1)
    term=fn/(Gin^0.6);
    Q=A*term^0.76;
    out1=sprintf('Sine base excitation:  %g G',Gin);
else
    num=0.49*(A^1.15)*(fn^0.62);
    den=Gin^0.27;
    Q=num/den;   
    out1=sprintf('Random base excitation:  %g G^2/Hz',Gin); 
end
disp(out1);


damp=1/(2*Q);

sss=sprintf('\n viscous damping ratio = %6.2g \n\n Q=%7.3g ',damp,Q);

set(handles.edit_results,'String',sss);

out1=sprintf(' fn= %g Hz',fn);
disp(out1);

sss2=sprintf('\n viscous damping ratio = %6.2g \n Q=%7.3g ',damp,Q);
disp(sss2);



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


% --- Executes on selection change in listbox_structure.
function listbox_structure_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_structure (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_structure contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_structure


set(handles.uipanel_save,'Visible','off');



% --- Executes during object creation, after setting all properties.
function listbox_structure_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_structure (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_fn_Callback(hObject, eventdata, handles)
% hObject    handle to edit_fn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_fn as text
%        str2double(get(hObject,'String')) returns contents of edit_fn as a double


% --- Executes during object creation, after setting all properties.
function edit_fn_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_fn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_ext.
function listbox_ext_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_ext (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_ext contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_ext

n=get(handles.listbox_ext,'Value');

if(n==1)
    set(handles.text_Gin,'String','Base Input Sine (G)');
else
    set(handles.text_Gin,'String','Base Input PSD (G^2/Hz) at Natural Frequency');    
end


% --- Executes during object creation, after setting all properties.
function listbox_ext_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_ext (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_Gin_Callback(hObject, eventdata, handles)
% hObject    handle to edit_Gin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_Gin as text
%        str2double(get(hObject,'String')) returns contents of edit_Gin as a double


% --- Executes during object creation, after setting all properties.
function edit_Gin_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_Gin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function text_Gin_CreateFcn(hObject, eventdata, handles)
% hObject    handle to text_Gin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on key press with focus on edit_fn and none of its controls.
function edit_fn_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_fn (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.uipanel_save,'Visible','off');


% --- Executes on key press with focus on edit_Gin and none of its controls.
function edit_Gin_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_Gin (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.uipanel_save,'Visible','off');


% --- Executes on selection change in listbox_excitation.
function listbox_excitation_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_excitation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_excitation contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_excitation

set(handles.uipanel_save,'Visible','off');

nex=get(handles.listbox_excitation,'Value');

if(nex==1)
    set(handles.text_Gin,'String','Base Input Sine (G)');
else
    set(handles.text_Gin,'String','Base Input PSD (G^2/Hz) at Natural Frequency');    
end




% --- Executes during object creation, after setting all properties.
function listbox_excitation_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_excitation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

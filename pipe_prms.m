function varargout = pipe_prms(varargin)
% PIPE_PRMS MATLAB code for pipe_prms.fig
%      PIPE_PRMS, by itself, creates a new PIPE_PRMS or raises the existing
%      singleton*.
%
%      H = PIPE_PRMS returns the handle to a new PIPE_PRMS or the handle to
%      the existing singleton*.
%
%      PIPE_PRMS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PIPE_PRMS.M with the given input arguments.
%
%      PIPE_PRMS('Property','Value',...) creates a new PIPE_PRMS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before pipe_prms_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to pipe_prms_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help pipe_prms

% Last Modified by GUIDE v2.5 18-Aug-2021 09:00:58

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @pipe_prms_OpeningFcn, ...
                   'gui_OutputFcn',  @pipe_prms_OutputFcn, ...
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


% --- Executes just before pipe_prms is made visible.
function pipe_prms_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to pipe_prms (see VARARGIN)

% Choose default command line output for pipe_prms
handles.output = hObject;

listbox_delta_Callback(hObject, eventdata, handles);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes pipe_prms wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = pipe_prms_OutputFcn(hObject, eventdata, handles) 
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

Pa_per_psi = 6894.;
m_per_inch=0.0254;
m_per_ft = 0.3048;
kg_per_lbm=2.205;


iu=get(handles.listbox_units,'Value');

n=get(handles.listbox_delta,'Value');

delta=abs(str2num(get(handles.edit_delta,'String')));

if(iu==1)
    delta=delta*Pa_per_psi;
end

if(n==1)
    Mach=str2num(get(handles.edit_Mach,'String'));
else
    U=str2num(get(handles.edit_v,'String'));
    c=str2num(get(handles.edit_c,'String'));
    Mach=U/c;
end

Prms=12*delta*Mach;

Prms_dB=20*log10(Prms/20e-06);

ss=sprintf('%8.3g dB',Prms_dB);
set(handles.edit_spl,'String',ss);

tt=delta*Mach;

if(iu==1)
    tt=tt*Pa_per_psi;
end

tt=sprintf('%8.3g',tt);

set(handles.edit_dpm,'String',tt);

set(handles.uipanel_results,'Visible','on');


% --- Executes on button press in pushbutton_return.
function pushbutton_return_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_return (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

delete(pipe_prms)


% --- Executes on selection change in listbox_delta.
function listbox_delta_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_delta (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_delta contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_delta

change(hObject, eventdata, handles);


% --- Executes during object creation, after setting all properties.
function listbox_delta_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_delta (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function change(hObject, eventdata, handles)
%
iu=get(handles.listbox_units,'Value');


if(iu==1)
    ss='Pressure Drop (psi)';
else
    ss='Pressure Drop (Pa)';    
end
set(handles.text_p,'String',ss);

n=get(handles.listbox_delta,'Value');

set(handles.edit_v,'Visible','off');
set(handles.edit_c,'Visible','off'); 
set(handles.text_v,'Visible','off');
set(handles.text_c,'Visible','off'); 
set(handles.edit_Mach,'Visible','off');   
set(handles.text_Mach,'Visible','off'); 

if(n==1)
    set(handles.edit_Mach,'Visible','on');   
    set(handles.text_Mach,'Visible','on');        
else
    set(handles.edit_v,'Visible','on');
    set(handles.edit_c,'Visible','on'); 
    set(handles.text_v,'Visible','on');
    set(handles.text_c,'Visible','on'); 
    if(iu==1)
        ss='ft/sec';
    else
        ss='m/sec';
    end
    ss1=sprintf('Gas Velocity (%s)',ss);
    ss2=sprintf('Speed of Sound (%s)',ss);
    set(handles.text_v,'String',ss1);
    set(handles.text_c,'String',ss2);     
end    
  






set(handles.uipanel_results,'Visible','off');


% --- Executes on selection change in listbox_units.
function listbox_units_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_units (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_units contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_units
change(hObject, eventdata, handles);

% --- Executes during object creation, after setting all properties.
function listbox_units_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_units (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_delta_Callback(hObject, eventdata, handles)
% hObject    handle to edit_delta (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_delta as text
%        str2double(get(hObject,'String')) returns contents of edit_delta as a double


% --- Executes during object creation, after setting all properties.
function edit_delta_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_delta (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_spl_Callback(hObject, eventdata, handles)
% hObject    handle to edit_spl (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_spl as text
%        str2double(get(hObject,'String')) returns contents of edit_spl as a double


% --- Executes during object creation, after setting all properties.
function edit_spl_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_spl (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on key press with focus on edit_delta and none of its controls.
function edit_delta_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_delta (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.uipanel_results,'Visible','off');



function edit_Mach_Callback(hObject, eventdata, handles)
% hObject    handle to edit_Mach (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_Mach as text
%        str2double(get(hObject,'String')) returns contents of edit_Mach as a double


% --- Executes during object creation, after setting all properties.
function edit_Mach_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_Mach (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on key press with focus on edit_Mach and none of its controls.
function edit_Mach_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_Mach (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.uipanel_results,'Visible','off');



function edit_v_Callback(hObject, eventdata, handles)
% hObject    handle to edit_v (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_v as text
%        str2double(get(hObject,'String')) returns contents of edit_v as a double


% --- Executes during object creation, after setting all properties.
function edit_v_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_v (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_c_Callback(hObject, eventdata, handles)
% hObject    handle to edit_c (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_c as text
%        str2double(get(hObject,'String')) returns contents of edit_c as a double


% --- Executes during object creation, after setting all properties.
function edit_c_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_c (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_dpm_Callback(hObject, eventdata, handles)
% hObject    handle to edit_dpm (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_dpm as text
%        str2double(get(hObject,'String')) returns contents of edit_dpm as a double


% --- Executes during object creation, after setting all properties.
function edit_dpm_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_dpm (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on key press with focus on edit_v and none of its controls.
function edit_v_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_v (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.uipanel_results,'Visible','off');


% --- Executes on key press with focus on edit_c and none of its controls.
function edit_c_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_c (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.uipanel_results,'Visible','off');


% --- Executes on button press in pushbutton_freq.
function pushbutton_freq_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_freq (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.s=pipe_peak_frequency;

set(handles.s,'Visible','on');




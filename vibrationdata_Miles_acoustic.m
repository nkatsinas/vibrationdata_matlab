function varargout = vibrationdata_Miles_acoustic(varargin)
% VIBRATIONDATA_MILES_ACOUSTIC MATLAB code for vibrationdata_Miles_acoustic.fig
%      VIBRATIONDATA_MILES_ACOUSTIC, by itself, creates a new VIBRATIONDATA_MILES_ACOUSTIC or raises the existing
%      singleton*.
%
%      H = VIBRATIONDATA_MILES_ACOUSTIC returns the handle to a new VIBRATIONDATA_MILES_ACOUSTIC or the handle to
%      the existing singleton*.
%
%      VIBRATIONDATA_MILES_ACOUSTIC('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in VIBRATIONDATA_MILES_ACOUSTIC.M with the given input arguments.
%
%      VIBRATIONDATA_MILES_ACOUSTIC('Property','Value',...) creates a new VIBRATIONDATA_MILES_ACOUSTIC or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before vibrationdata_Miles_acoustic_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to vibrationdata_Miles_acoustic_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help vibrationdata_Miles_acoustic

% Last Modified by GUIDE v2.5 03-Oct-2018 12:23:15

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @vibrationdata_Miles_acoustic_OpeningFcn, ...
                   'gui_OutputFcn',  @vibrationdata_Miles_acoustic_OutputFcn, ...
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


% --- Executes just before vibrationdata_Miles_acoustic is made visible.
function vibrationdata_Miles_acoustic_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to vibrationdata_Miles_acoustic (see VARARGIN)

% Choose default command line output for vibrationdata_Miles_acoustic
handles.output = hObject;

change(hObject, eventdata, handles);


% Update handles structure
guidata(hObject, handles);

% UIWAIT makes vibrationdata_Miles_acoustic wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = vibrationdata_Miles_acoustic_OutputFcn(hObject, eventdata, handles) 
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

delete(vibrationdata_Miles_acoustic);


function clear_results(hObject, eventdata, handles)

set(handles.edit_grms,'Enable','off','String','');
set(handles.edit_three_sigma,'Enable','off','String','');




% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

iu=get(handles.listbox_unit,'Value');

n=get(handles.listbox_type,'Value');

fn=str2num(get(handles.edit_fn,'String'));

Q=str2num(get(handles.edit_Q,'String'));

reference=20e-06;


if(n==1)
    
    SPL=str2num(get(handles.edit_P,'String'));
    pressure_rms=reference*(10.^(SPL/20.) );
    df=fn*( 2^(1/6) - 1/(2^(1/6)) );
    
    if(iu==1)
        [psi_per_Pa]=pressure_unit_conversion();
        pressure_rms=pressure_rms*psi_per_Pa;
    end
    
    
    P=pressure_rms^2/df;

else
    P=str2num(get(handles.edit_P,'String'));
end




x=sqrt((pi/2)*P*fn*Q);

s1=sprintf('%8.3g',x);
s2=sprintf('%8.3g',3*x);

set(handles.edit_grms,'Enable','on','String',s1);
set(handles.edit_three_sigma,'Enable','on','String',s2);




function edit_grms_Callback(hObject, eventdata, handles)
% hObject    handle to edit_grms (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_grms as text
%        str2double(get(hObject,'String')) returns contents of edit_grms as a double


% --- Executes during object creation, after setting all properties.
function edit_grms_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_grms (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_three_sigma_Callback(hObject, eventdata, handles)
% hObject    handle to edit_three_sigma (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_three_sigma as text
%        str2double(get(hObject,'String')) returns contents of edit_three_sigma as a double


% --- Executes during object creation, after setting all properties.
function edit_three_sigma_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_three_sigma (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_P_Callback(hObject, eventdata, handles)
% hObject    handle to edit_P (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_P as text
%        str2double(get(hObject,'String')) returns contents of edit_P as a double


% --- Executes during object creation, after setting all properties.
function edit_P_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_P (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
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



function edit_Q_Callback(hObject, eventdata, handles)
% hObject    handle to edit_Q (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_Q as text
%        str2double(get(hObject,'String')) returns contents of edit_Q as a double


% --- Executes during object creation, after setting all properties.
function edit_Q_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_Q (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on key press with focus on edit_fn and none of its controls.
function edit_fn_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_fn (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)

clear_results(hObject, eventdata, handles);


% --- Executes on key press with focus on edit_Q and none of its controls.
function edit_Q_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_Q (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)

clear_results(hObject, eventdata, handles);


% --- Executes on key press with focus on edit_P and none of its controls.
function edit_P_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_P (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)

clear_results(hObject, eventdata, handles);



function edit_rd_rms_Callback(hObject, eventdata, handles)
% hObject    handle to edit_rd_rms (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_rd_rms as text
%        str2double(get(hObject,'String')) returns contents of edit_rd_rms as a double


% --- Executes during object creation, after setting all properties.
function edit_rd_rms_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_rd_rms (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_rd_ts_Callback(hObject, eventdata, handles)
% hObject    handle to edit_rd_ts (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_rd_ts as text
%        str2double(get(hObject,'String')) returns contents of edit_rd_ts as a double


% --- Executes during object creation, after setting all properties.
function edit_rd_ts_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_rd_ts (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_rd_rms_mm_Callback(hObject, eventdata, handles)
% hObject    handle to edit_rd_rms_mm (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_rd_rms_mm as text
%        str2double(get(hObject,'String')) returns contents of edit_rd_rms_mm as a double


% --- Executes during object creation, after setting all properties.
function edit_rd_rms_mm_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_rd_rms_mm (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_rd_ts_mm_Callback(hObject, eventdata, handles)
% hObject    handle to edit_rd_ts_mm (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_rd_ts_mm as text
%        str2double(get(hObject,'String')) returns contents of edit_rd_ts_mm as a double


% --- Executes during object creation, after setting all properties.
function edit_rd_ts_mm_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_rd_ts_mm (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_type.
function listbox_type_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_type contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_type

change(hObject, eventdata, handles);



% --- Executes during object creation, after setting all properties.
function listbox_type_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_unit.
function listbox_unit_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_unit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_unit contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_unit

change(hObject, eventdata, handles);


function change(hObject, eventdata, handles)

clear_results(hObject, eventdata, handles);

iu=get(handles.listbox_unit,'Value');

if(iu==1)
    pu='psi';
else
    pu='Pa';     
end

ss1=sprintf('Overall Level (%s RMS)',pu);
ss2=sprintf('3-sigma %s',pu);

set(handles.text_output1,'String',ss1);
set(handles.text_output2,'String',ss2);

n=get(handles.listbox_type,'Value');

if(n==1)
    ssu='SPL (dB) at Natural Frequency';
else
    ssu=sprintf('Pressure PSD (%s^2/Hz) at Natural Frequency',pu);
end    

set(handles.text_input1,'String',ssu);


% --- Executes during object creation, after setting all properties.
function listbox_unit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_unit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_equation.
function pushbutton_equation_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_equation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


A = imread('Miles_acoustic.jpg'); 

figure(999)
imshow(A,'border','tight','InitialMagnification',100) 

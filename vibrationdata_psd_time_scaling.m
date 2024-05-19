function varargout = vibrationdata_psd_time_scaling(varargin)
% VIBRATIONDATA_PSD_TIME_SCALING MATLAB code for vibrationdata_psd_time_scaling.fig
%      VIBRATIONDATA_PSD_TIME_SCALING, by itself, creates a new VIBRATIONDATA_PSD_TIME_SCALING or raises the existing
%      singleton*.
%
%      H = VIBRATIONDATA_PSD_TIME_SCALING returns the handle to a new VIBRATIONDATA_PSD_TIME_SCALING or the handle to
%      the existing singleton*.
%
%      VIBRATIONDATA_PSD_TIME_SCALING('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in VIBRATIONDATA_PSD_TIME_SCALING.M with the given input arguments.
%
%      VIBRATIONDATA_PSD_TIME_SCALING('Property','Value',...) creates a new VIBRATIONDATA_PSD_TIME_SCALING or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before vibrationdata_psd_time_scaling_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to vibrationdata_psd_time_scaling_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help vibrationdata_psd_time_scaling

% Last Modified by GUIDE v2.5 18-Dec-2014 09:48:10

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @vibrationdata_psd_time_scaling_OpeningFcn, ...
                   'gui_OutputFcn',  @vibrationdata_psd_time_scaling_OutputFcn, ...
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


% --- Executes just before vibrationdata_psd_time_scaling is made visible.
function vibrationdata_psd_time_scaling_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to vibrationdata_psd_time_scaling (see VARARGIN)

% Choose default command line output for vibrationdata_psd_time_scaling
handles.output = hObject;

set(handles.listbox_t1,'Value',3);
set(handles.listbox_t2,'Value',3);

set(handles.pushbutton_save,'Visible','off');

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes vibrationdata_psd_time_scaling wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = vibrationdata_psd_time_scaling_OutputFcn(hObject, eventdata, handles) 
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

delete(vibrationdata_psd_time_scaling);

% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

try
    FS=get(handles.edit_input_array_name,'String');
    A=evalin('base',FS);     
catch
    warndlg('Input PSD does not exist.');
    return;
end

n1=get(handles.listbox_t1,'Value');
n2=get(handles.listbox_t2,'Value');

t1=str2num(get(handles.edit_t1,'String'));
t2=str2num(get(handles.edit_t2,'String'));

t1o=t1;
t2o=t2;

b=str2num(get(handles.edit_b,'String'));

%%%

s1='sec';

if(n1==1)
    t1=t1*3600;
    s1='hr';
end
if(n1==2)
    t1=t1*60;
    s1='min';
end

%%%

s2='sec';

if(n2==1)
    t2=t2*3600;
    s2='hr';
end
if(n2==2)
    t2=t2*60;
    s2='min';
end

%%%

[~,input_rms] = calculate_PSD_slopes(A(:,1),A(:,2));


new_rms=(input_rms^b*(t1/t2))^(1/b);

scale=(new_rms/input_rms)^2;


B=A;

sz=size(A);

for i=1:sz(1)
    B(i,2)=A(i,2)*scale;
end

[~,output_rms] = calculate_PSD_slopes(B(:,1),B(:,2));

setappdata(0,'B',B);

set(handles.pushbutton_save,'Visible','on');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

fmin=min(A(:,1));
fmax=max(A(:,1));

xlab='Frequency (Hz)';
ylab='Accel (G^2/Hz)';

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

fig_num=1;

t_string=sprintf('Reference PSD  %6.3g GRMS  %g %s',input_rms,t1o,s1);    

[fig_num]=plot_PSD_function(fig_num,xlab,ylab,t_string,A,fmin,fmax);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

t_string=sprintf('New PSD  %6.3g GRMS  %g %s',output_rms,t2o,s2);    

[fig_num]=plot_PSD_function(fig_num,xlab,ylab,t_string,B,fmin,fmax);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

disp(' ');
disp(' Overall Levels ');
disp(' ');

out1=sprintf(' Reference PSD = %8.4g GRMS',input_rms);
out2=sprintf('       New PSD = %8.4g GRMS',output_rms);

disp(out1);
disp(out2);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

disp(' ');
disp('  New PSD ');
disp(' ');
disp('  Freq(Hz)  Accel(G^2/Hz) ');
disp(' ');

for i=1:sz(1)
    out1=sprintf(' %8.4g  %8.4g ',B(i,1),B(i,2));
    disp(out1);
end


delta=20*log10(output_rms/input_rms);

disp(' ');
out1=sprintf(' Difference =  %6.3g dB ',delta);
disp(out1);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% --- Executes on button press in pushbutton_save.
function pushbutton_save_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

data=getappdata(0,'B');

output_name=get(handles.edit_output_array_name,'String');

assignin('base', output_name, data);


h = msgbox('Save Complete'); 




function edit_output_array_name_Callback(hObject, eventdata, handles)
% hObject    handle to edit_output_array_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_output_array_name as text
%        str2double(get(hObject,'String')) returns contents of edit_output_array_name as a double


% --- Executes during object creation, after setting all properties.
function edit_output_array_name_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_output_array_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_input_array_name_Callback(hObject, eventdata, handles)
% hObject    handle to edit_input_array_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_input_array_name as text
%        str2double(get(hObject,'String')) returns contents of edit_input_array_name as a double


% --- Executes during object creation, after setting all properties.
function edit_input_array_name_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_input_array_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_t1_Callback(hObject, eventdata, handles)
% hObject    handle to edit_t1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_t1 as text
%        str2double(get(hObject,'String')) returns contents of edit_t1 as a double


% --- Executes during object creation, after setting all properties.
function edit_t1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_t1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_t2_Callback(hObject, eventdata, handles)
% hObject    handle to edit_t2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_t2 as text
%        str2double(get(hObject,'String')) returns contents of edit_t2 as a double


% --- Executes during object creation, after setting all properties.
function edit_t2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_t2 (see GCBO)
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


% --- Executes on key press with focus on edit_input_array_name and none of its controls.
function edit_input_array_name_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_input_array_name (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)

set(handles.pushbutton_save,'Visible','off');


% --- Executes on key press with focus on edit_b and none of its controls.
function edit_b_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_b (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.pushbutton_save,'Visible','off');


% --- Executes on key press with focus on edit_t1 and none of its controls.
function edit_t1_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_t1 (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.pushbutton_save,'Visible','off');


% --- Executes on key press with focus on edit_t2 and none of its controls.
function edit_t2_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_t2 (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.pushbutton_save,'Visible','off');


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on selection change in listbox_t1.
function listbox_t1_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_t1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_t1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_t1


% --- Executes during object creation, after setting all properties.
function listbox_t1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_t1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_t2.
function listbox_t2_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_t2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_t2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_t2


% --- Executes during object creation, after setting all properties.
function listbox_t2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_t2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

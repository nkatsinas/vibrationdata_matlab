function varargout = vibrationdata_input_trans_mult(varargin)
% VIBRATIONDATA_INPUT_TRANS_MULT MATLAB code for vibrationdata_input_trans_mult.fig
%      VIBRATIONDATA_INPUT_TRANS_MULT, by itself, creates a new VIBRATIONDATA_INPUT_TRANS_MULT or raises the existing
%      singleton*.
%
%      H = VIBRATIONDATA_INPUT_TRANS_MULT returns the handle to a new VIBRATIONDATA_INPUT_TRANS_MULT or the handle to
%      the existing singleton*.
%
%      VIBRATIONDATA_INPUT_TRANS_MULT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in VIBRATIONDATA_INPUT_TRANS_MULT.M with the given input arguments.
%
%      VIBRATIONDATA_INPUT_TRANS_MULT('Property','Value',...) creates a new VIBRATIONDATA_INPUT_TRANS_MULT or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before vibrationdata_input_trans_mult_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to vibrationdata_input_trans_mult_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help vibrationdata_input_trans_mult

% Last Modified by GUIDE v2.5 07-Sep-2021 19:21:48

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @vibrationdata_input_trans_mult_OpeningFcn, ...
                   'gui_OutputFcn',  @vibrationdata_input_trans_mult_OutputFcn, ...
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


% --- Executes just before vibrationdata_input_trans_mult is made visible.
function vibrationdata_input_trans_mult_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to vibrationdata_input_trans_mult (see VARARGIN)

% Choose default command line output for vibrationdata_input_trans_mult
handles.output = hObject;

listbox_trans_Callback(hObject, eventdata, handles);

set(handles.text_title,'Visible','off');
set(handles.edit_title,'Visible','off');

set(handles.pushbutton_replot,'Visible','off');

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes vibrationdata_input_trans_mult wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = vibrationdata_input_trans_mult_OutputFcn(hObject, eventdata, handles) 
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

delete(vibrationdata_input_trans_mult);


% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

fig_num=1;

itt=get(handles.listbox_trans,'Value');

nni=get(handles.listbox_interpolate,'Value');

clear length;
%
FS1=strtrim(get(handles.edit_array_1,'String'));
THM1=evalin('base',FS1);
%
FS2=strtrim(get(handles.edit_array_2,'String'));
THM2=evalin('base',FS2);

% szz =1  for display size on
%     =2  for display size off 

szz=1;

if(itt==2)
    THM2(:,2)=THM2(:,2).^2;
end

[ff,ab,rms]=trans_mult(szz,THM1,THM2,nni);


sd=sprintf('Response PSD   %7.4g rms overall  ',rms);
set(handles.edit_title,'String',sd,'Visible','on');
set(handles.text_title,'Visible','on');
%
stitle=get(handles.edit_title,'String');
sylabel=get(handles.edit_yaxis,'String');
%

md=7;

ppp=[ff ab];

x_label='Frequency (Hz)';
y_label=sylabel;
t_string=stitle;

fmin=str2num(get(handles.edit_f1,'String'));
fmax=str2num(get(handles.edit_f2,'String'));  

[fig_num]=plot_loglog_function_md(fig_num,x_label,y_label,t_string,ppp,fmin,fmax,md);

response_PSD=ppp;

setappdata(0,'response_PSD',response_PSD);

set(handles.pushbutton_save,'Enable','on');
set(handles.pushbutton_replot,'Visible','on');


% --- Executes on selection change in listbox_interpolate.
function listbox_interpolate_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_interpolate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_interpolate contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_interpolate


% --- Executes during object creation, after setting all properties.
function listbox_interpolate_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_interpolate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_title_Callback(hObject, eventdata, handles)
% hObject    handle to edit_title (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_title as text
%        str2double(get(hObject,'String')) returns contents of edit_title as a double


% --- Executes during object creation, after setting all properties.
function edit_title_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_title (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_yaxis_Callback(hObject, eventdata, handles)
% hObject    handle to edit_yaxis (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_yaxis as text
%        str2double(get(hObject,'String')) returns contents of edit_yaxis as a double


% --- Executes during object creation, after setting all properties.
function edit_yaxis_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_yaxis (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
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



function edit_output_array_Callback(hObject, eventdata, handles)
% hObject    handle to edit_output_array (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_output_array as text
%        str2double(get(hObject,'String')) returns contents of edit_output_array as a double


% --- Executes during object creation, after setting all properties.
function edit_output_array_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_output_array (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_save.
function pushbutton_save_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

data=getappdata(0,'response_PSD');

output_name=get(handles.edit_output_array,'String');
assignin('base', output_name, data);

h = msgbox('Save Complete'); 


function edit_array_1_Callback(hObject, eventdata, handles)
% hObject    handle to edit_array_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_array_1 as text
%        str2double(get(hObject,'String')) returns contents of edit_array_1 as a double


% --- Executes during object creation, after setting all properties.
function edit_array_1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_array_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_array_2_Callback(hObject, eventdata, handles)
% hObject    handle to edit_array_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_array_2 as text
%        str2double(get(hObject,'String')) returns contents of edit_array_2 as a double


% --- Executes during object creation, after setting all properties.
function edit_array_2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_array_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_replot.
function pushbutton_replot_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_replot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

fig_num=1;

md=7;

ppp=getappdata(0,'response_PSD');

stitle=get(handles.edit_title,'String');
sylabel=get(handles.edit_yaxis,'String');
%

x_label='Frequency (Hz)';
y_label=sylabel;
t_string=stitle;

fmin=str2num(get(handles.edit_f1,'String'));
fmax=str2num(get(handles.edit_f2,'String'));  

[fig_num]=plot_loglog_function_md(fig_num,x_label,y_label,t_string,ppp,fmin,fmax,md);



% --- Executes on button press in pushbutton_fatigue.
function pushbutton_fatigue_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_fatigue (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


handles.s= fatigue_toolbox;                  
       
set(handles.s,'Visible','on');


% --- Executes on selection change in listbox_trans.
function listbox_trans_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_trans (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_trans contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_trans

i=get(handles.listbox_trans,'Value');

if(i==1)
  ss='Power Transmissibility:  freq &  trans (unit^2/unit^2)';
else
  ss='Transmissibility:  freq &  trans (unit/unit)';    
end

set(handles.text_trans,'String',ss);


% --- Executes during object creation, after setting all properties.
function listbox_trans_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_trans (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

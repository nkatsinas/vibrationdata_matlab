function varargout = vibrationdata_equivalent_uniaxial(varargin)
% VIBRATIONDATA_EQUIVALENT_UNIAXIAL MATLAB code for vibrationdata_equivalent_uniaxial.fig
%      VIBRATIONDATA_EQUIVALENT_UNIAXIAL, by itself, creates a new VIBRATIONDATA_EQUIVALENT_UNIAXIAL or raises the existing
%      singleton*.
%
%      H = VIBRATIONDATA_EQUIVALENT_UNIAXIAL returns the handle to a new VIBRATIONDATA_EQUIVALENT_UNIAXIAL or the handle to
%      the existing singleton*.
%
%      VIBRATIONDATA_EQUIVALENT_UNIAXIAL('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in VIBRATIONDATA_EQUIVALENT_UNIAXIAL.M with the given input arguments.
%
%      VIBRATIONDATA_EQUIVALENT_UNIAXIAL('Property','Value',...) creates a new VIBRATIONDATA_EQUIVALENT_UNIAXIAL or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before vibrationdata_equivalent_uniaxial_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to vibrationdata_equivalent_uniaxial_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help vibrationdata_equivalent_uniaxial

% Last Modified by GUIDE v2.5 25-May-2017 17:08:01

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @vibrationdata_equivalent_uniaxial_OpeningFcn, ...
                   'gui_OutputFcn',  @vibrationdata_equivalent_uniaxial_OutputFcn, ...
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


% --- Executes just before vibrationdata_equivalent_uniaxial is made visible.
function vibrationdata_equivalent_uniaxial_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to vibrationdata_equivalent_uniaxial (see VARARGIN)

% Choose default command line output for vibrationdata_equivalent_uniaxial
handles.output = hObject;

listbox_stress_format_Callback(hObject, eventdata, handles);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes vibrationdata_equivalent_uniaxial wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = vibrationdata_equivalent_uniaxial_OutputFcn(hObject, eventdata, handles) 
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

delete(vibrationdata_equivalent_uniaxial);


% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

fig_num=1;

thu=get(handles.edit_input_array,'String');

if isempty(thu)
    warndlg('Time history does not exist');
    return;
else
    THM=evalin('base',thu);    
end

sz=size(THM);

ncols=sz(2);

n_stress_format=get(handles.listbox_stress_format,'Value');

if(n_stress_format==1 && ncols~=4)
   warndlg(' Input data must have four columns'); 
   return; 
end
if(n_stress_format==2 && ncols~=7)
   warndlg(' Input data must have four columns'); 
   return;
end

t=THM(:,1);

if(n_stress_format==1)
    
    sx=THM(:,2);
    sy=THM(:,3);
    txy=THM(:,4);

    [pstress]=stress_tensor_2D(sx,sy,txy);


end
if(n_stress_format==2)
    
    sx=THM(:,2);
    sy=THM(:,3);
    sz=THM(:,4);
    txy=THM(:,5);
    txz=THM(:,6);
    tyz=THM(:,7);
        
    [pstress]=stress_tensor_3D(sx,sy,sz,txy,txz,tyz);
    
end

[smap]=signed_max_abs_principal(pstress);
[svm]=signed_von_Mises(pstress);
[str]=signed_Tresca(pstress);



signed_map=[t smap ];
signed_svm=[t svm ];
signed_str=[t str ];

unsigned_map=[t abs(smap) ];
unsigned_svm=[t abs(svm) ];
unsigned_str=[t abs(str) ];


xlabel3=get(handles.edit_xlabel,'String');
ylabel1=get(handles.edit_ylabel,'String');
ylabel2=ylabel1;
ylabel3=ylabel1;

data1=signed_map;
data2=signed_svm;
data3=signed_str;

t_string1='Signed Max Principal';
t_string2='Signed von Mises';
t_string3='Signed Tresca';

[fig_num]=subplots_three_linlin_three_titles_ss(fig_num,xlabel3,ylabel1,ylabel2,ylabel3,data1,data2,data3,t_string1,t_string2,t_string3);


setappdata(0,'signed_map',signed_map);
setappdata(0,'signed_svm',signed_svm);
setappdata(0,'signed_str',signed_str);
setappdata(0,'unsigned_map',unsigned_map);
setappdata(0,'unsigned_svm',unsigned_svm);
setappdata(0,'unsigned_str',unsigned_str);

set(handles.uipanel_save,'Visible','on');


function edit_input_array_Callback(hObject, eventdata, handles)
% hObject    handle to edit_input_array (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_input_array as text
%        str2double(get(hObject,'String')) returns contents of edit_input_array as a double


% --- Executes during object creation, after setting all properties.
function edit_input_array_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_input_array (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_stress_format.
function listbox_stress_format_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_stress_format (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_stress_format contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_stress_format

set(handles.uipanel_save,'Visible','off');

n=get(handles.listbox_stress_format,'Value');

if(n==1)
    ss='The input array must have four columns:';
    tt='time, sx, sy, txy';
end
if(n==2)
    ss='The input array must have seven columns:';
    tt='time, sx, sy, sz, txy, txz, tyz';
end

set(handles.text_columns,'String',ss);
set(handles.text_column_labels,'String',tt);


% --- Executes during object creation, after setting all properties.
function listbox_stress_format_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_stress_format (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_xlabel_Callback(hObject, eventdata, handles)
% hObject    handle to edit_xlabel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_xlabel as text
%        str2double(get(hObject,'String')) returns contents of edit_xlabel as a double


% --- Executes during object creation, after setting all properties.
function edit_xlabel_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_xlabel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_ylabel_Callback(hObject, eventdata, handles)
% hObject    handle to edit_ylabel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_ylabel as text
%        str2double(get(hObject,'String')) returns contents of edit_ylabel as a double


% --- Executes during object creation, after setting all properties.
function edit_ylabel_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_ylabel (see GCBO)
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



n=get(handles.listbox_save,'Value');

if(n==1)
    data=getappdata(0,'unsigned_map');
end
if(n==2)
    data=getappdata(0,'unsigned_svm');
end
if(n==3)
    data=getappdata(0,'unsigned_map');
end
if(n==4)
    data=getappdata(0,'signed_map');
end
if(n==5)
    data=getappdata(0,'signed_svm');
end
if(n==6)
    data=getappdata(0,'unsigned_str');
end


output_name=get(handles.edit_output_array,'String');
assignin('base', output_name, data);

h = msgbox('Save Complete'); 


% --- Executes on selection change in listbox_save.
function listbox_save_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_save contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_save


% --- Executes during object creation, after setting all properties.
function listbox_save_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
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

function varargout = bolt_preload(varargin)
% BOLT_PRELOAD MATLAB code for bolt_preload.fig
%      BOLT_PRELOAD, by itself, creates a new BOLT_PRELOAD or raises the existing
%      singleton*.
%
%      H = BOLT_PRELOAD returns the handle to a new BOLT_PRELOAD or the handle to
%      the existing singleton*.
%
%      BOLT_PRELOAD('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in BOLT_PRELOAD.M with the given input arguments.
%
%      BOLT_PRELOAD('Property','Value',...) creates a new BOLT_PRELOAD or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before bolt_preload_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to bolt_preload_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help bolt_preload

% Last Modified by GUIDE v2.5 07-Jun-2020 10:47:39

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @bolt_preload_OpeningFcn, ...
                   'gui_OutputFcn',  @bolt_preload_OutputFcn, ...
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


% --- Executes just before bolt_preload is made visible.
function bolt_preload_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to bolt_preload (see VARARGIN)

% Choose default command line output for bolt_preload
handles.output = hObject;

set(handles.uipanel_results,'Visible','off');

%  change(hObject, eventdata, handles);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes bolt_preload wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = bolt_preload_OutputFcn(hObject, eventdata, handles) 
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




nthread=get(handles.listbox_thread,'Value');    
nsize=get(handles.listbox_size,'Value'); 

area_array(:,1)=[ 0.0037
0.00604
0.00796
0.00909
0.014
0.0175
0.0318
0.0524
0.0775
0.1063
0.1419
0.182
0.226
0.334
0.462
0.606
0.763
0.969
1.155
1.405];

area_array(:,2)=[0.00394
0.00661
0.0083
0.01015
0.01474
0.02
0.0364
0.058
0.0878
0.1187
0.1599
0.203
0.256
0.373
0.509
0.663
0.856
1.073
1.315
1.581];

area=area_array(nsize,nthread);

TS={'UNC','UNF'};
SS={'#2','#4','#5','#6','#8','#10','1/4 in','5/16 in','3/8 in','7/16 in','1/2 in',...
    '9/16 in','5/8 in','3/4 in','7/8 in','1 in','1-1/18 in','1-1/4 in','1-3/8 in','1-1/2 in','1-3/4 in','2 in'};

DS={'0.086','0.112','0.125','0.138','0.164','0.190'};


At=area;

c=str2double(get(handles.edit_c,'String'));

Sp=str2double(get(handles.edit_Sp,'String'));

F = c*At*Sp*1000;


if(nsize>=7)
    sss=sprintf(' %s %s \n\n Tensile Stress Area = %8.4g in^2 \n\n Proof Strength = %8.4g ksi \n\n Preload = %8.4g lbf ',TS{nthread},SS{nsize},area,Sp,F);
else
    sss=sprintf(' %s %s \n\n Nominal Diameter = %s in \n\n Tensile Stress Area = %8.4g in^2 \n\n Proof Strength = %8.4g ksi \n\n Preload = %8.4g lbf ',TS{nthread},SS{nsize},DS{nsize},area,Sp,F);    
end
    
set(handles.edit_results,'String',sss);

set(handles.uipanel_results,'Visible','on');


% --- Executes on button press in pushbutton_return.
function pushbutton_return_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_return (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
delete(bolt_preload);


% --- Executes on selection change in listbox_select.
function listbox_select_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_select (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_select contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_select

set(handles.uipanel_results,'Visible','off');

change(hObject, eventdata, handles);


% --- Executes during object creation, after setting all properties.
function listbox_select_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_select (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_T_Callback(hObject, eventdata, handles)
% hObject    handle to edit_T (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_T as text
%        str2double(get(hObject,'String')) returns contents of edit_T as a double


% --- Executes during object creation, after setting all properties.
function edit_T_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_T (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_units.
function listbox_units_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_units (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_units contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_units

change(hObject, eventdata, handles);


function change(hObject, eventdata, handles)





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



function edit_K_Callback(hObject, eventdata, handles)
% hObject    handle to edit_K (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_K as text
%        str2double(get(hObject,'String')) returns contents of edit_K as a double


% --- Executes during object creation, after setting all properties.
function edit_K_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_K (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_D_Callback(hObject, eventdata, handles)
% hObject    handle to edit_D (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_D as text
%        str2double(get(hObject,'String')) returns contents of edit_D as a double


% --- Executes during object creation, after setting all properties.
function edit_D_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_D (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_Fp_Callback(hObject, eventdata, handles)
% hObject    handle to edit_Fp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_Fp as text
%        str2double(get(hObject,'String')) returns contents of edit_Fp as a double


% --- Executes during object creation, after setting all properties.
function edit_Fp_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_Fp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



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


% --- Executes during object creation, after setting all properties.
function pushbutton_return_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pushbutton_return (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

delete(bolt_torque_preload);


% --- Executes on selection change in listbox_size.
function listbox_size_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_size (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_size contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_size
set(handles.uipanel_results,'Visible','off');

% --- Executes during object creation, after setting all properties.
function listbox_size_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_size (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_thread.
function listbox_thread_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_thread (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_thread contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_thread

set(handles.uipanel_results,'Visible','off');


% --- Executes during object creation, after setting all properties.
function listbox_thread_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_thread (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


disp(' ');
disp(' References: ');
disp('https://mechanicalc.com/reference/fastener-size-tables');
disp('https://www.engineersedge.com/material_science/bolt-preload-calculation.htm');
disp(' ');

msgbox('Reference URLs written to Command Window');



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



function edit_Sp_Callback(hObject, eventdata, handles)
% hObject    handle to edit_Sp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_Sp as text
%        str2double(get(hObject,'String')) returns contents of edit_Sp as a double


% --- Executes during object creation, after setting all properties.
function edit_Sp_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_Sp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

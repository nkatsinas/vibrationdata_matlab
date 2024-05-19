function varargout = bolt_torque_preload(varargin)
% BOLT_TORQUE_PRELOAD MATLAB code for bolt_torque_preload.fig
%      BOLT_TORQUE_PRELOAD, by itself, creates a new BOLT_TORQUE_PRELOAD or raises the existing
%      singleton*.
%
%      H = BOLT_TORQUE_PRELOAD returns the handle to a new BOLT_TORQUE_PRELOAD or the handle to
%      the existing singleton*.
%
%      BOLT_TORQUE_PRELOAD('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in BOLT_TORQUE_PRELOAD.M with the given input arguments.
%
%      BOLT_TORQUE_PRELOAD('Property','Value',...) creates a new BOLT_TORQUE_PRELOAD or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before bolt_torque_preload_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to bolt_torque_preload_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help bolt_torque_preload

% Last Modified by GUIDE v2.5 07-Jun-2020 07:52:48

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @bolt_torque_preload_OpeningFcn, ...
                   'gui_OutputFcn',  @bolt_torque_preload_OutputFcn, ...
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


% --- Executes just before bolt_torque_preload is made visible.
function bolt_torque_preload_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to bolt_torque_preload (see VARARGIN)

% Choose default command line output for bolt_torque_preload
handles.output = hObject;

change(hObject, eventdata, handles);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes bolt_torque_preload wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = bolt_torque_preload_OutputFcn(hObject, eventdata, handles) 
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

iu=get(handles.listbox_units,'Value');

n=get(handles.listbox_select,'Value');

T=str2double(get(handles.edit_T,'String'));
K=str2double(get(handles.edit_K,'String'));
D=str2double(get(handles.edit_D,'String'));
Fp=str2double(get(handles.edit_Fp,'String'));

if(iu==2)
    D=D/1000;
end


if(n==1)
    T=K*D*Fp;
end
if(n==2)
    Fp=T/(K*D);
end
if(n==3)
    D=T/(K*Fp);
end

if(iu==2)
    D=D*1000;
end


if(iu==1)
    sss=sprintf(' T=%8.4g in-lbf \n\n K=%8.4g \n\n D=%8.4g in \n\n Fp=%8.4g lbf',T,K,D,Fp);
else
    sss=sprintf(' T=%8.4g N-m \n\n K=%8.4g \n\n D=%8.4g mm \n\n Fp=%8.4g N',T,K,D,Fp);   
end
    
set(handles.edit_results,'String',sss);



% --- Executes on button press in pushbutton_return.
function pushbutton_return_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_return (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
delete(bolt_torque_preload);


% --- Executes on selection change in listbox_select.
function listbox_select_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_select (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_select contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_select

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


iu=get(handles.listbox_units,'Value');

if(iu==1)
    st='Torque (in-lbf)';
    sd='Diameter (in)';
    sp='Preload (lbf)';
else
    st='Torque (N-m)';
    sd='Diameter (mm)';
    sp='Preload (N)';
end

set(handles.text_T,'String',st);
set(handles.text_D,'String',sd);
set(handles.text_Fp,'String',sp);


set(handles.edit_T,'Visible','on');
set(handles.edit_D,'Visible','on');
set(handles.edit_Fp,'Visible','on');
set(handles.text_T,'Visible','on');
set(handles.text_D,'Visible','on');
set(handles.text_Fp,'Visible','on');

n=get(handles.listbox_select,'Value');

if(n==1)
    set(handles.edit_T,'Visible','off');
    set(handles.text_T,'Visible','off');
end
if(n==2)
    set(handles.edit_Fp,'Visible','off');
    set(handles.text_Fp,'Visible','off');
end
if(n==3)
    set(handles.edit_D,'Visible','off');
    set(handles.text_D,'Visible','off');
end





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

function varargout = mdof_enforced_acceleration_newmark(varargin)
% MDOF_ENFORCED_ACCELERATION_NEWMARK MATLAB code for mdof_enforced_acceleration_newmark.fig
%      MDOF_ENFORCED_ACCELERATION_NEWMARK, by itself, creates a new MDOF_ENFORCED_ACCELERATION_NEWMARK or raises the existing
%      singleton*.
%
%      H = MDOF_ENFORCED_ACCELERATION_NEWMARK returns the handle to a new MDOF_ENFORCED_ACCELERATION_NEWMARK or the handle to
%      the existing singleton*.
%
%      MDOF_ENFORCED_ACCELERATION_NEWMARK('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MDOF_ENFORCED_ACCELERATION_NEWMARK.M with the given input arguments.
%
%      MDOF_ENFORCED_ACCELERATION_NEWMARK('Property','Value',...) creates a new MDOF_ENFORCED_ACCELERATION_NEWMARK or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before mdof_enforced_acceleration_newmark_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to mdof_enforced_acceleration_newmark_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help mdof_enforced_acceleration_newmark

% Last Modified by GUIDE v2.5 21-Aug-2014 18:01:21

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @mdof_enforced_acceleration_newmark_OpeningFcn, ...
                   'gui_OutputFcn',  @mdof_enforced_acceleration_newmark_OutputFcn, ...
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


% --- Executes just before mdof_enforced_acceleration_newmark is made visible.
function mdof_enforced_acceleration_newmark_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to mdof_enforced_acceleration_newmark (see VARARGIN)

% Choose default command line output for mdof_enforced_acceleration_newmark
handles.output = hObject;

set(handles.listbox_units,'value',1);

set(handles.listbox_mass_unit,'value',1);

set(handles.listbox_enforced_dof,'value',1);


listbox_units_Callback(hObject, eventdata, handles)
listbox_enforced_dof_Callback(hObject, eventdata, handles)

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes mdof_enforced_acceleration_newmark wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = mdof_enforced_acceleration_newmark_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in listbox_units.
function listbox_units_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_units (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_units contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_units

iu=get(handles.listbox_units,'Value');

if(iu<=2)
    set(handles.text_mass, 'String', 'Mass');
    set(handles.text_damping_coefficient, 'String', 'Damping Coefficients (lbf in/sec)'); 
    set(handles.text_stiffness, 'String', 'Stiffness (lbf/in)');
    set(handles.listbox_mass_unit,'visible','on');
end
if(iu==3)
    set(handles.text_mass, 'String', 'Mass (kg)');
    set(handles.text_damping_coefficient, 'String', 'Damping Coefficients (N m/sec)');    
    set(handles.text_stiffness, 'String', 'Stiffness (N/m)');
    set(handles.listbox_mass_unit,'visible','off');    
end

if(iu==1)
    s1='Each acceleration array must have two columns:  time(sec) & accel(in/sec^2)';
end
if(iu==2)
    s1='Each acceleration array must have two columns:  time(sec) & accel(G)';
end
if(iu==3)
    s1='Each acceleration array must have two columns:  time(sec) & accel(m/sec^2)';
end

set(handles.text_accel_units,'String',s1);


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



function edit_mass_Callback(hObject, eventdata, handles)
% hObject    handle to edit_mass (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_mass as text
%        str2double(get(hObject,'String')) returns contents of edit_mass as a double


% --- Executes during object creation, after setting all properties.
function edit_mass_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_mass (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_cdamping_Callback(hObject, eventdata, handles)
% hObject    handle to edit_cdamping (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_cdamping as text
%        str2double(get(hObject,'String')) returns contents of edit_cdamping as a double


% --- Executes during object creation, after setting all properties.
function edit_cdamping_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_cdamping (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_stiffness_Callback(hObject, eventdata, handles)
% hObject    handle to edit_stiffness (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_stiffness as text
%        str2double(get(hObject,'String')) returns contents of edit_stiffness as a double


% --- Executes during object creation, after setting all properties.
function edit_stiffness_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_stiffness (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_mass_unit.
function listbox_mass_unit_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_mass_unit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_mass_unit contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_mass_unit


% --- Executes during object creation, after setting all properties.
function listbox_mass_unit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_mass_unit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_ea1_Callback(hObject, eventdata, handles)
% hObject    handle to edit_ea1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_ea1 as text
%        str2double(get(hObject,'String')) returns contents of edit_ea1 as a double


% --- Executes during object creation, after setting all properties.
function edit_ea1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_ea1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_ea2_Callback(hObject, eventdata, handles)
% hObject    handle to edit_ea2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_ea2 as text
%        str2double(get(hObject,'String')) returns contents of edit_ea2 as a double


% --- Executes during object creation, after setting all properties.
function edit_ea2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_ea2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_ea3_Callback(hObject, eventdata, handles)
% hObject    handle to edit_ea3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_ea3 as text
%        str2double(get(hObject,'String')) returns contents of edit_ea3 as a double


% --- Executes during object creation, after setting all properties.
function edit_ea3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_ea3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_ea4_Callback(hObject, eventdata, handles)
% hObject    handle to edit_ea4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_ea4 as text
%        str2double(get(hObject,'String')) returns contents of edit_ea4 as a double


% --- Executes during object creation, after setting all properties.
function edit_ea4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_ea4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_ea5_Callback(hObject, eventdata, handles)
% hObject    handle to edit_ea5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_ea5 as text
%        str2double(get(hObject,'String')) returns contents of edit_ea5 as a double


% --- Executes during object creation, after setting all properties.
function edit_ea5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_ea5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_ea6_Callback(hObject, eventdata, handles)
% hObject    handle to edit_ea6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_ea6 as text
%        str2double(get(hObject,'String')) returns contents of edit_ea6 as a double


% --- Executes during object creation, after setting all properties.
function edit_ea6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_ea6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_ea7_Callback(hObject, eventdata, handles)
% hObject    handle to edit_ea7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_ea7 as text
%        str2double(get(hObject,'String')) returns contents of edit_ea7 as a double


% --- Executes during object creation, after setting all properties.
function edit_ea7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_ea7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_ea8_Callback(hObject, eventdata, handles)
% hObject    handle to edit_ea8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_ea8 as text
%        str2double(get(hObject,'String')) returns contents of edit_ea8 as a double


% --- Executes during object creation, after setting all properties.
function edit_ea8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_ea8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_ea9_Callback(hObject, eventdata, handles)
% hObject    handle to edit_ea9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_ea9 as text
%        str2double(get(hObject,'String')) returns contents of edit_ea9 as a double


% --- Executes during object creation, after setting all properties.
function edit_ea9_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_ea9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_ea10_Callback(hObject, eventdata, handles)
% hObject    handle to edit_ea10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_ea10 as text
%        str2double(get(hObject,'String')) returns contents of edit_ea10 as a double


% --- Executes during object creation, after setting all properties.
function edit_ea10_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_ea10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function edit_ea11_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_ea10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_ea11_array_Callback(hObject, eventdata, handles)
% hObject    handle to edit_ea11_array (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_ea11_array as text
%        str2double(get(hObject,'String')) returns contents of edit_ea11_array as a double


% --- Executes during object creation, after setting all properties.
function edit_ea11_array_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_ea11_array (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_ea12_Callback(hObject, eventdata, handles)
% hObject    handle to edit_ea12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_ea12 as text
%        str2double(get(hObject,'String')) returns contents of edit_ea12 as a double


% --- Executes during object creation, after setting all properties.
function edit_ea12_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_ea12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_enforced_dof.
function listbox_enforced_dof_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_enforced_dof (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_enforced_dof contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_enforced_dof

set(handles.edit_ea1,'visible','off');
set(handles.edit_ea2,'visible','off');
set(handles.edit_ea3,'visible','off');
set(handles.edit_ea4,'visible','off');
set(handles.edit_ea5,'visible','off');
set(handles.edit_ea6,'visible','off');
set(handles.edit_ea7,'visible','off');
set(handles.edit_ea8,'visible','off');
set(handles.edit_ea9,'visible','off');
set(handles.edit_ea10,'visible','off');
set(handles.edit_ea11,'visible','off');
set(handles.edit_ea12,'visible','off');

set(handles.edit_ea1_array,'visible','off');
set(handles.edit_ea2_array,'visible','off');
set(handles.edit_ea3_array,'visible','off');
set(handles.edit_ea4_array,'visible','off');
set(handles.edit_ea5_array,'visible','off');
set(handles.edit_ea6_array,'visible','off');
set(handles.edit_ea7_array,'visible','off');
set(handles.edit_ea8_array,'visible','off');
set(handles.edit_ea9_array,'visible','off');
set(handles.edit_ea10_array,'visible','off');
set(handles.edit_ea11_array,'visible','off');
set(handles.edit_ea12_array,'visible','off');

number_ea=get(handles.listbox_enforced_dof,'Value');

if(number_ea>=1)
    set(handles.edit_ea1,'visible','on');
    set(handles.edit_ea1_array,'visible','on');    
end    
if(number_ea>=2)
    set(handles.edit_ea2,'visible','on');
    set(handles.edit_ea2_array,'visible','on');      
end  
if(number_ea>=3)
    set(handles.edit_ea3,'visible','on');
    set(handles.edit_ea3_array,'visible','on');      
end  
if(number_ea>=4)
    set(handles.edit_ea4,'visible','on');
    set(handles.edit_ea4_array,'visible','on');      
end    
if(number_ea>=5)
    set(handles.edit_ea5,'visible','on');
    set(handles.edit_ea5_array,'visible','on');      
end  
if(number_ea>=6)
    set(handles.edit_ea6,'visible','on');
    set(handles.edit_ea6_array,'visible','on');      
end  
if(number_ea>=7)
    set(handles.edit_ea7,'visible','on');
    set(handles.edit_ea7_array,'visible','on');      
end    
if(number_ea>=8)
    set(handles.edit_ea8,'visible','on');
    set(handles.edit_ea8_array,'visible','on');      
end  
if(number_ea>=9)
    set(handles.edit_ea9,'visible','on');
    set(handles.edit_ea9_array,'visible','on');      
end  
if(number_ea>=10)
    set(handles.edit_ea10,'visible','on');
    set(handles.edit_ea10_array,'visible','on');      
end    
if(number_ea>=11)
    set(handles.edit_ea11,'visible','on');
    set(handles.edit_ea11_array,'visible','on');      
end  
if(number_ea>=12)
    set(handles.edit_ea12,'visible','on');    
    set(handles.edit_ea12_array,'visible','on');  
end  


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% --- Executes during object creation, after setting all properties.
function listbox_enforced_dof_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_enforced_dof (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_ea1_array_Callback(hObject, eventdata, handles)
% hObject    handle to edit_ea1_array (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_ea1_array as text
%        str2double(get(hObject,'String')) returns contents of edit_ea1_array as a double


% --- Executes during object creation, after setting all properties.
function edit_ea1_array_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_ea1_array (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_ea2_array_Callback(hObject, eventdata, handles)
% hObject    handle to edit_ea2_array (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_ea2_array as text
%        str2double(get(hObject,'String')) returns contents of edit_ea2_array as a double


% --- Executes during object creation, after setting all properties.
function edit_ea2_array_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_ea2_array (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_ea3_array_Callback(hObject, eventdata, handles)
% hObject    handle to edit_ea3_array (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_ea3_array as text
%        str2double(get(hObject,'String')) returns contents of edit_ea3_array as a double


% --- Executes during object creation, after setting all properties.
function edit_ea3_array_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_ea3_array (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_ea4_array_Callback(hObject, eventdata, handles)
% hObject    handle to edit_ea4_array (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_ea4_array as text
%        str2double(get(hObject,'String')) returns contents of edit_ea4_array as a double


% --- Executes during object creation, after setting all properties.
function edit_ea4_array_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_ea4_array (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_ea5_array_Callback(hObject, eventdata, handles)
% hObject    handle to edit_ea5_array (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_ea5_array as text
%        str2double(get(hObject,'String')) returns contents of edit_ea5_array as a double


% --- Executes during object creation, after setting all properties.
function edit_ea5_array_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_ea5_array (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit23_Callback(hObject, eventdata, handles)
% hObject    handle to edit_ea6_array (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_ea6_array as text
%        str2double(get(hObject,'String')) returns contents of edit_ea6_array as a double


% --- Executes during object creation, after setting all properties.
function edit23_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_ea6_array (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_ea7_array_Callback(hObject, eventdata, handles)
% hObject    handle to edit_ea7_array (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_ea7_array as text
%        str2double(get(hObject,'String')) returns contents of edit_ea7_array as a double


% --- Executes during object creation, after setting all properties.
function edit_ea7_array_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_ea7_array (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_ea8_array_Callback(hObject, eventdata, handles)
% hObject    handle to edit_ea8_array (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_ea8_array as text
%        str2double(get(hObject,'String')) returns contents of edit_ea8_array as a double


% --- Executes during object creation, after setting all properties.
function edit_ea8_array_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_ea8_array (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_ea9_array_Callback(hObject, eventdata, handles)
% hObject    handle to edit_ea9_array (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_ea9_array as text
%        str2double(get(hObject,'String')) returns contents of edit_ea9_array as a double


% --- Executes during object creation, after setting all properties.
function edit_ea9_array_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_ea9_array (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_ea10_array_Callback(hObject, eventdata, handles)
% hObject    handle to edit_ea10_array (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_ea10_array as text
%        str2double(get(hObject,'String')) returns contents of edit_ea10_array as a double


% --- Executes during object creation, after setting all properties.
function edit_ea10_array_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_ea10_array (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit28_Callback(hObject, eventdata, handles)
% hObject    handle to edit_ea11_array (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_ea11_array as text
%        str2double(get(hObject,'String')) returns contents of edit_ea11_array as a double


% --- Executes during object creation, after setting all properties.
function edit28_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_ea11_array (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_ea12_array_Callback(hObject, eventdata, handles)
% hObject    handle to edit_ea12_array (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_ea12_array as text
%        str2double(get(hObject,'String')) returns contents of edit_ea12_array as a double


% --- Executes during object creation, after setting all properties.
function edit_ea12_array_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_ea12_array (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_ea6_array_Callback(hObject, eventdata, handles)
% hObject    handle to edit_ea6_array (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_ea6_array as text
%        str2double(get(hObject,'String')) returns contents of edit_ea6_array as a double


% --- Executes during object creation, after setting all properties.
function edit_ea6_array_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_ea6_array (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_sr_Callback(hObject, eventdata, handles)
% hObject    handle to edit_sr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_sr as text
%        str2double(get(hObject,'String')) returns contents of edit_sr as a double


% --- Executes during object creation, after setting all properties.
function edit_sr_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_sr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_endtime_Callback(hObject, eventdata, handles)
% hObject    handle to edit_endtime (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_endtime as text
%        str2double(get(hObject,'String')) returns contents of edit_endtime as a double


% --- Executes during object creation, after setting all properties.
function edit_endtime_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_endtime (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


n_units=get(handles.listbox_units,'Value');
mass_unit=get(handles.listbox_mass_unit,'Value');

iu=n_units;

sr=str2num(get(handles.edit_sr,'String'));
dur=str2num(get(handles.edit_endtime,'String'));

dt=1/sr;
nt=1+round(dur/dt);
%
t =  linspace(0,dur,nt);
nt=length(t);
t=t';

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

FS=get(handles.edit_mass,'String');
mass=evalin('base',FS);

if(mass_unit==1)
    mass=mass/386;
end    
 
FS=get(handles.edit_cdamping,'String');
cdamping=evalin('base',FS);
 
FS=get(handles.edit_stiffness,'String');
stiff=evalin('base',FS);

num=max(size(mass));
ndof=num;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


nem=get(handles.listbox_enforced_dof,'Value');

number_ea=nem;
 
ea=zeros(nem,1);
 
if(number_ea>=1)
     ea(1)=str2num(get(handles.edit_ea1,'String'));  
end 
if(number_ea>=2)
     ea(2)=str2num(get(handles.edit_ea2,'String'));
end  
if(number_ea>=3)
     ea(3)=str2num(get(handles.edit_ea3,'String'));    
end  
if(number_ea>=4)
     ea(4)=str2num(get(handles.edit_ea4,'String'));   
end 
if(number_ea>=5)
     ea(5)=str2num(get(handles.edit_ea5,'String'));
end  
if(number_ea>=6)
     ea(6)=str2num(get(handles.edit_ea6,'String'));    
end  
if(number_ea>=7)
     ea(7)=str2num(get(handles.edit_ea7,'String'));     
end 
if(number_ea>=8)
     ea(8)=str2num(get(handles.edit_ea8,'String'));  
end  
if(number_ea>=9)
     ea(9)=str2num(get(handles.edit_ea9,'String'));   
end
if(number_ea>=10)
     ea(10)=str2num(get(handles.edit_ea10,'String')); 
end 
if(number_ea>=11)
     ea(11)=str2num(get(handles.edit_ea11,'String'));  
end  
if(number_ea>=12)
     ea(12)=str2num(get(handles.edit_ea12,'String'));    
end



enforced_dof=ea;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

setappdata(0,'dt',dt);
setappdata(0,'sr',sr);
setappdata(0,'iu',iu);
setappdata(0,'ndof',ndof);
setappdata(0,'nt',nt);
setappdata(0,'t',t);
setappdata(0,'enforced_dof',enforced_dof);

ODE_acceleration_input_gui(hObject, eventdata, handles)             
             
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

FFI=getappdata(0,'FFI');
accel_dof=getappdata(0,'accel_dof');
nff=getappdata(0,'nff');
nfree=getappdata(0,'nfree');
free_dof=getappdata(0,'free_dof');
ngw=getappdata(0,'ngw');
enforced_dof=getappdata(0,'enforced_dof');


%
forig=zeros(nt,nem);
%
k=1;
for i=1:num
    nfi=accel_dof(i);
    if(nfi>0)
        forig(:,k)=FFI(:,nfi);
        k=k+1;
    end    
end


%
clear FFI;
FFI=forig;
%
for i=1:nem
    A=FFI(:,i);
    dv=detrend(cumtrapz(A));
    dvelox(:,i)=dv*dt;
end
%
for i=1:nem
    A=dvelox(:,i);
    dd=detrend(cumtrapz(A));
    ddisp(:,i)=dd*dt;    
end


if(max(size(mass))<=30)
    dispm=1;  % show partitioned matrices
end    


[fn,omega,ModeShapes,MST,Mwd,Cwd,Kwd,Mww,Cww,Kww,TT,T1,T2,KT,CT,MT]=...
   partition_matrices_mck(mass,cdamping,stiff,num,nfree,nem,free_dof,...
                                               enforced_dof,'accel',dispm);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%
omegan=omega;
%
clear r;
clear part;
clear ModalMass;
%
sz=size(Mww);
%
n_free_dof=sz(1);
%
num_modes=n_free_dof;
%
clear temp;
temp=ModeShapes(:,1:num_modes);
clear ModeShapes;
ModeShapes=temp;
MST=ModeShapes';
%
r=ones(num_modes,1);
%
part = MST*Mww*r;
%
if(size(part)<20)
    disp(' Participation Factors  ');
    part
end
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  displacement
%
%  d
%  v
%  acc
%
%%
n=num_modes;
%
M=Mww;
C=Cww;
K=Kww;
%
%%

[a0,a1,a2,a3,a4,a5,a6,a7]=Newmark_coefficients(dt);
%
KH=K+a0*M+a1*C;
%
inv_KH=pinv(KH); 

%
clear d;
clear v;
clear acc;
%
t=zeros(nt,1);
d=zeros(nt,nfree);
v=zeros(nt,nfree);
acc=zeros(nt,nfree);
%
U=zeros(n,1);
Ud=zeros(n,1);
Udd=zeros(n,1);
%
jj=1;
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
ns=size(U);
if(ns(2)>ns(1))
    U=U';
end
ns=size(Ud);
if(ns(2)>ns(1))
    Ud=Ud';
end
ns=size(Udd);
if(ns(2)>ns(1))
    Udd=Udd';
end
%%

for i=1:(nt-1)
%   
    FP=-Mwd*(FFI(i,:))';
%    
    FH=FP+M*(a0*U+a2*Ud+a3*Udd)+C*(a1*U+a4*Ud+a5*Udd);
%
%%    Un=KH\FH;
%
    Un=inv_KH*FH;
%
    Uddn=a0*(Un-U)-a2*Ud-a3*Udd;
    Udn=Ud+a6*Udd+a7*Uddn;
    U=Un;
    Ud=Udn;
    Udd=Uddn;
%
    d(i+1,:)=U';
    v(i+1,:)=Ud';
    acc(i+1,:)=Udd';
    t(i+1)=i*dt;   
%
end
   
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
clear d_save;
clear v_save;
clear a_save;
d_save=d;
v_save=v;
a_save=acc;
%
%    Transformation back to xd xf
%
%%    dT=TT*d';
%%    vT=TT*v';
%%    accT=TT*acc';
%
dT=(T1*ddisp' + T2*d')';
vT=(T1*dvelox' + T2*v')';
accT=(T1*FFI' + T2*acc')';
%
%  Put in original order
%
ZdT=[ ddisp  dT ];
ZvT=[ dvelox  vT ];
ZaccT=[ forig  accT ];
%
clear d;   
clear v;
clear acc;
d=zeros(nt,num);
v=zeros(nt,num);
acc=zeros(nt,num);

%
for i=1:num
   for j=1:nt
        d(j,ngw(i))=  (ZdT(j,i));        
        v(j,ngw(i))=  (ZvT(j,i));     
      acc(j,ngw(i))=(ZaccT(j,i));
   end
end
%

idet=get(handles.listbox_dtrend,'Value');
%
if(idet==1)
    for i=1:num
        p = polyfit(t,d(:,i),2);
        d(:,i)=d(:,i)-p(1)*t.^2 -p(2)*t -p(3);
        p = polyfit(t,d(:,i),0);  % use instead of detrend
        v(:,i)=v(:,i)-p(1);    
    end
end
%
if(iu==2)
    acc=acc/386;
end
%
if(iu==3)
    d=d/1000;
end
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
mdof_plot_ea(t,d,v,acc,num,iu)
%

dd=[t d];
vv=[t v];
aa=[t acc];

setappdata(0,'dd',dd);
setappdata(0,'vv',vv);
setappdata(0,'aa',aa);

if(num==3)
%
    if(iu==1)
        yl='Accel(in/sec^2)';
    end
    if(iu==2)
        yl='Accel(G)';          
    end
    if(iu==3)
        yl='Accel(m/sec^2)';    
    end
%
   figure(10);
   plot(t,acc(:,1));
   grid on;
   title('Mass 1');
   xlabel('Time (sec)');
   ylabel(yl);
%
   figure(11);
   plot(t,acc(:,2));
   grid on;
   title('Mass 2'); 
   xlabel('Time (sec)');
   ylabel(yl);
%
   figure(12);
   plot(t,acc(:,3));
   grid on;
   title('Mass 3'); 
   xlabel('Time (sec)');
   ylabel(yl);   
%
end


alias_flag=getappdata(0,'alias_flag');

if(alias_flag==1)
    warndlg('Increase sample rate to prevent aliasing.');
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
delete(mdof_enforced_acceleration_newmark);



function edit_ea11_Callback(hObject, eventdata, handles)
% hObject    handle to edit_ea11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_ea11 as text
%        str2double(get(hObject,'String')) returns contents of edit_ea11 as a double




function ODE_acceleration_input_gui(hObject, eventdata, handles)

%
%   ODE_acceleration_input_gui.m   ver 1.0  
%
%%%  function[FFI,accel_dof,nff,nfree,enforced_dof,free_dof,ngw]=...
%%%               ODE_acceleration_input_gui(iu,ndof,NT,t,enforced_dof,nem)

dt=getappdata(0,'dt');
sr=getappdata(0,'sr');
iu=getappdata(0,'iu');
ndof=getappdata(0,'ndof');
nt=getappdata(0,'nt');
t=getappdata(0,'t');
enforced_dof=getappdata(0,'enforced_dof');

nem=length(enforced_dof);
NT=nt;

number_ea=nem;              
              
ea=enforced_dof;

iflag=0;

 
if(number_ea>=1)
     FS=get(handles.edit_ea1_array,'String');
     THM1=evalin('base',FS);
     sz=size(THM1);
     n=sz(1);
     dt1=(THM1(n)-THM1(1))/(n-1);
     if(dt1<0.99*dt)
       iflag=1;  
     end
end 
if(number_ea>=2)
     FS=get(handles.edit_ea2_array,'String');
     THM2=evalin('base',FS);    
     dt2=(THM2(n)-THM2(1))/(n-1);
     if(dt2<0.99*dt)
       iflag=1;  
     end     
end  
if(number_ea>=3)
     FS=get(handles.edit_ea3_array,'String');
     THM3=evalin('base',FS);
     dt3=(THM3(n)-THM3(1))/(n-1);
     if(dt3<0.99*dt)
       iflag=1;  
     end     
end  
if(number_ea>=4)
     FS=get(handles.edit_ea4_array,'String');
     THM4=evalin('base',FS);
     dt4=(THM4(n)-THM4(1))/(n-1);
     if(dt4<0.99*dt)
       iflag=1;  
     end     
end 
if(number_ea>=5)
     FS=get(handles.edit_ea5_array,'String');
     THM5=evalin('base',FS);
     dt5=(THM5(n)-THM5(1))/(n-1);
     if(dt5<0.99*dt)
       iflag=1;  
     end     
end  
if(number_ea>=6)
     FS=get(handles.edit_ea6_array,'String');
     THM6=evalin('base',FS);
     dt6=(THM6(n)-THM6(1))/(n-1);
     if(dt6<0.99*dt)
       iflag=1;  
     end     
end  
if(number_ea>=7)
     FS=get(handles.edit_ea7_array,'String');
     THM7=evalin('base',FS);
     dt7=(THM7(n)-THM7(1))/(n-1);
     if(dt7<0.99*dt)
       iflag=1;  
     end     
end 
if(number_ea>=8)
     FS=get(handles.edit_ea8_array,'String');
     THM8=evalin('base',FS);
     dt8=(THM8(n)-THM8(1))/(n-1);
     if(dt8<0.99*dt)
       iflag=1;  
     end     
end  
if(number_ea>=9)
     FS=get(handles.edit_ea9_array,'String');
     THM9=evalin('base',FS);
     dt9=(THM9(n)-THM9(1))/(n-1);
     if(dt9<0.99*dt)
       iflag=1;  
     end     
end
if(number_ea>=10)
     FS=get(handles.edit_ea10_array,'String');
     THM10=evalin('base',FS);
     dt10=(THM10(n)-THM10(1))/(n-1);
     if(dt10<0.99*dt)
       iflag=1;  
     end     
end 
if(number_ea>=11)
     FS=get(handles.edit_ea11_array,'String');
     THM11=evalin('base',FS);
     dt11=(THM11(n)-THM11(1))/(n-1);
     if(dt11<0.99*dt)
       iflag=1;  
     end     
end  
if(number_ea>=12)
     FS=get(handles.edit_ea12_array,'String');
     THM12=evalin('base',FS);
     dt12=(THM12(n)-THM12(1))/(n-1);
     if(dt12<0.99*dt)
       iflag=1;  
     end     
end

setappdata(0,'alias_flag',iflag);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

num=ndof;
%
%%%%% disp(' ');
%%%%% disp(' Enter the number of acceleration files ');
%
%%%%% nff=input(' ');

nff=number_ea;
%
MAX=100000;
%
tt=zeros(MAX,nff);
ff=zeros(MAX,nff);
%
accel_dof=zeros(ndof,1);
%
for i=1:ndof
    accel_dof(i)=-999;
end    
%    
%% disp(' ');
%% disp(' Note: the first dof is 1 ');
%
for i=1:nff
%   
    if(i==1)
        F=THM1;
    end
    if(i==2)
        F=THM2;    
    end
    if(i==3)
        F=THM3;    
    end
    if(i==4)
        F=THM4;   
    end    
    if(i==5)
        F=THM5;    
    end
    if(i==6)
        F=THM6;   
    end
    if(i==7)
        F=THM7;    
    end
    if(i==8)
        F=THM8;    
    end 
    if(i==9)
        F=THM9;    
    end
    if(i==10)
        F=THM10;    
    end
    if(i==11)
        F=THM11;    
    end
    if(i==12)
        F=THM12;    
    end     
    
%    
    a=F(:,1);
    b=F(:,2);
%    
    L=length(a);
%    
    if(L>MAX)
        L=MAX;
    end
%    
    tt(1:L,i)=a(1:L);
    ff(1:L,i)=b(1:L);
%   
    accel_dof(enforced_dof(i))=i;
%
end 
%
% interpolate force
%
disp(' begin interpolation ');
%
FFI=zeros(NT,nff);
%
for i=1:nff
%
    clear tint;
    clear fint;
%
    tstart=tt(1,i);
    tt(:,i)=tt(:,i)-tstart;   
%
    last=MAX;
%    
    for(j=2:MAX)
        if(tt(j,i)<=tt(j-1,i))
            last=j-1;
            break
        end
    end      
%
    tint=tt(1:last,i);
    fint=ff(1:last,i);
%
    t=t';
    FFI(:,i) = interp1(tint,fint,t);
%
end 
%
if(iu==2)
    FFI=FFI*386;
end
%
j=1;
k=1;
for i=1:num
    if(accel_dof(i)>0)
        enforced_dof(k)=i;
        k=k+1;
    else
        free_dof(j)=i;
        j=j+1;
    end
end
%
nem=length(enforced_dof);
nfree=length(free_dof);
%
for i=1:nem
    ngw(i)=enforced_dof(i);
end
for i=1:nfree
    ngw(i+nem)=free_dof(i);
end
%
clear temp;
temp=sort(enforced_dof,'descend');
enforced_dof=temp;
%
clear temp;
temp=sort(free_dof,'descend');
free_dof=temp;
%
disp(' end interpolation ');
%
setappdata(0,'FFI',FFI);
setappdata(0,'accel_dof',accel_dof);
setappdata(0,'nff',nff);
setappdata(0,'nfree',nfree);
setappdata(0,'free_dof',free_dof);
setappdata(0,'enforced_dof',enforced_dof);
setappdata(0,'ngw',ngw);



% --- Executes on button press in pushbutton_save.
function pushbutton_save_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.s=mdof_newmark_save;    

set(handles.s,'Visible','on');


% --- Executes on selection change in listbox_dtrend.
function listbox_dtrend_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_dtrend (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_dtrend contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_dtrend


% --- Executes during object creation, after setting all properties.
function listbox_dtrend_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_dtrend (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

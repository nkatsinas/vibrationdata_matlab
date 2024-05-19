function varargout = SEA_one_subsystem(varargin)
% SEA_ONE_SUBSYSTEM MATLAB code for SEA_one_subsystem.fig
%      SEA_ONE_SUBSYSTEM, by itself, creates a new SEA_ONE_SUBSYSTEM or raises the existing
%      singleton*.
%
%      H = SEA_ONE_SUBSYSTEM returns the handle to a new SEA_ONE_SUBSYSTEM or the handle to
%      the existing singleton*.
%
%      SEA_ONE_SUBSYSTEM('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SEA_ONE_SUBSYSTEM.M with the given input arguments.
%
%      SEA_ONE_SUBSYSTEM('Property','Value',...) creates a new SEA_ONE_SUBSYSTEM or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before SEA_one_subsystem_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to SEA_one_subsystem_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help SEA_one_subsystem

% Last Modified by GUIDE v2.5 08-Jan-2016 11:04:39

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @SEA_one_subsystem_OpeningFcn, ...
                   'gui_OutputFcn',  @SEA_one_subsystem_OutputFcn, ...
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


% --- Executes just before SEA_one_subsystem is made visible.
function SEA_one_subsystem_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to SEA_one_subsystem (see VARARGIN)

% Choose default command line output for SEA_one_subsystem
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes SEA_one_subsystem wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = SEA_one_subsystem_OutputFcn(hObject, eventdata, handles) 
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

delete(SEA_one_subsystem);


% --- Executes on button press in pushbutton_mechanical_single.
function pushbutton_mechanical_single_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_mechanical_single (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

n=get(handles.listbox_mechanical_single,'Value');

if(n==1)
    handles.s=response_velocity_one_system;  
end
if(n==2)
    handles.s=response_velocity_one_system_force;      
end
if(n==3)
    handles.s=response_velocity_one_system_energy;   
end


set(handles.s,'Visible','on'); 



% --- Executes on selection change in listbox_type.
function listbox_type_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_type contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_type


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


% --- Executes on selection change in listbox_bands.
function listbox_bands_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_bands (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_bands contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_bands


% --- Executes during object creation, after setting all properties.
function listbox_bands_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_bands (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_multiple.
function pushbutton_multiple_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_multiple (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

n=get(handles.listbox_bands,'Value');

if(n==1)
    response_velocity_one_system_bands_a;  
end
if(n==2)
    handles.s=general_vibroacoustic_response;  
    set(handles.s,'Visible','on');
end
 


% --- Executes on selection change in listbox_mechanical_single.
function listbox_mechanical_single_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_mechanical_single (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_mechanical_single contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_mechanical_single


% --- Executes during object creation, after setting all properties.
function listbox_mechanical_single_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_mechanical_single (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox2.
function listbox2_Callback(hObject, eventdata, handles)
% hObject    handle to listbox2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox2


% --- Executes during object creation, after setting all properties.
function listbox2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_multiples.
function listbox_multiples_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_multiples (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_multiples contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_multiples


% --- Executes during object creation, after setting all properties.
function listbox_multiples_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_multiples (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_acoustical_single.
function listbox_acoustical_single_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_acoustical_single (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_acoustical_single contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_acoustical_single


% --- Executes during object creation, after setting all properties.
function listbox_acoustical_single_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_acoustical_single (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_acoustic_single.
function pushbutton_acoustic_single_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_acoustic_single (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

n=get(handles.listbox_acoustical_single,'Value');

if(n==1)
    handles.s=acoustic_pressure_from_energy;  
end
if(n==2)
    handles.s=freely_hung_panel_diffuse_field;  
end
if(n==3)
    handles.s=limp_panel;  
end


set(handles.s,'Visible','on'); 


% --- Executes on selection change in listbox_acoustical_multi.
function listbox_acoustical_multi_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_acoustical_multi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_acoustical_multi contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_acoustical_multi


% --- Executes during object creation, after setting all properties.
function listbox_acoustical_multi_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_acoustical_multi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_acoustic_multi.
function pushbutton_acoustic_multi_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_acoustic_multi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

n=get(handles.listbox_acoustical_multi,'Value');

if(n==1)
    handles.s=acoustic_pressure_from_energy_multi;  
end
if(n==2)
    handles.s=freely_hung_panel_diffuse_field_multi;  
end
if(n==3)    
    handles.s=limp_panel_multi;  
end


set(handles.s,'Visible','on'); 


% --- Executes on button press in pushbutton_panel.
function pushbutton_panel_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_panel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.s=panel_toolbox;   

set(handles.s,'Visible','on'); 

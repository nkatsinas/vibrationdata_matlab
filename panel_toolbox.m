function varargout = panel_toolbox(varargin)
% PANEL_TOOLBOX MATLAB code for panel_toolbox.fig
%      PANEL_TOOLBOX, by itself, creates a new PANEL_TOOLBOX or raises the existing
%      singleton*.
%
%      H = PANEL_TOOLBOX returns the handle to a new PANEL_TOOLBOX or the handle to
%      the existing singleton*.
%
%      PANEL_TOOLBOX('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PANEL_TOOLBOX.M with the given input arguments.
%
%      PANEL_TOOLBOX('Property','Value',...) creates a new PANEL_TOOLBOX or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before panel_toolbox_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to panel_toolbox_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help panel_toolbox

% Last Modified by GUIDE v2.5 12-Jan-2016 10:32:08

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @panel_toolbox_OpeningFcn, ...
                   'gui_OutputFcn',  @panel_toolbox_OutputFcn, ...
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


% --- Executes just before panel_toolbox is made visible.
function panel_toolbox_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to panel_toolbox (see VARARGIN)

% Choose default command line output for panel_toolbox
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes panel_toolbox wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = panel_toolbox_OutputFcn(hObject, eventdata, handles) 
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
delete(panel_toolbox);

% --- Executes on selection change in listbox_SEA.
function listbox_SEA_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_SEA (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_SEA contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_SEA


% --- Executes during object creation, after setting all properties.
function listbox_SEA_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_SEA (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_det.
function listbox_det_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_det (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_det contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_det


% --- Executes during object creation, after setting all properties.
function listbox_det_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_det (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_fea.
function listbox_fea_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_fea (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_fea contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_fea


% --- Executes during object creation, after setting all properties.
function listbox_fea_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_fea (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_SEA.
function pushbutton_SEA_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_SEA (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

n=get(handles.listbox_SEA,'Value');

if(n==1)
    handles.s=structural_wavespeed;      
end
if(n==2)
    handles.s=vibrationdata_modal_density;      
end
if(n==3)
    handles.s=homogeneous_panel_radiation_efficiency;      
end
if(n==4)
    handles.s=dissipation_loss_factor;      
end
if(n==5)
    handles.s=coupling_loss_factor;      
end
if(n==6)
    handles.s=mobility_impedance;      
end
if(n==7)
    handles.s=critical_frequency;      
end


set(handles.s,'Visible','on'); 


% --- Executes on selection change in listbox_rad.
function listbox_rad_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_rad (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_rad contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_rad


% --- Executes during object creation, after setting all properties.
function listbox_rad_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_rad (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_rad.
function pushbutton_rad_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_rad (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

n=get(handles.listbox_rad,'Value');

if(n==1)
    handles.s=acoustic_power_radiated_from_panel;      
end
if(n==2)
    handles.s=acoustic_power_radiated_from_panel_reverberant;      
end

set(handles.s,'Visible','on'); 


% --- Executes on button press in pushbutton_fea.
function pushbutton_fea_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_fea (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton_det.
function pushbutton_det_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_det (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

n=get(handles.listbox_det,'Value');

if(n==1)
    handles.s=structural_dynamics_plates;      
end
if(n==2)
    handles.s=vibrationdata_rectangular_plate_fea;       
end
if(n==3)
    handles.s=vibrationdata_rectangular_plate_uniform_pressure;
end
if(n==4)
    handles.s=vibrationdata_rectangular_plate_oblique_incidence;
end

set(handles.s,'Visible','on');


% --- Executes on selection change in listbox_resp_freely_hung.
function listbox_resp_freely_hung_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_resp_freely_hung (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_resp_freely_hung contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_resp_freely_hung


% --- Executes during object creation, after setting all properties.
function listbox_resp_freely_hung_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_resp_freely_hung (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_freely_hung.
function pushbutton_freely_hung_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_freely_hung (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

n=get(handles.listbox_resp_freely_hung,'Value');

if(n==1)
    handles.s=freely_hung_panel_diffuse_field;          
end
if(n==2)
    handles.s=freely_hung_panel_diffuse_field_multi;          
end

set(handles.s,'Visible','on'); 


% --- Executes on selection change in listbox_limp.
function listbox_limp_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_limp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_limp contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_limp


% --- Executes during object creation, after setting all properties.
function listbox_limp_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_limp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_limp.
function pushbutton_limp_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_limp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

n=get(handles.listbox_limp,'Value');

if(n==1)
    handles.s=limp_panel;  
end
if(n==2)
    handles.s=limp_panel_multi;  
end

set(handles.s,'Visible','on');


% --- Executes on selection change in listbox_point_force.
function listbox_point_force_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_point_force (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_point_force contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_point_force


% --- Executes during object creation, after setting all properties.
function listbox_point_force_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_point_force (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_point_force.
function pushbutton_point_force_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_point_force (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

n=get(handles.listbox_point_force,'Value');

if(n==1)
    handles.s=panel_point_force_single;  
end
if(n==2)
%%    handles.s=limp_panel_multi;  
end

set(handles.s,'Visible','on');


% --- Executes on selection change in listbox8.
function listbox8_Callback(hObject, eventdata, handles)
% hObject    handle to listbox8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox8 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox8


% --- Executes during object creation, after setting all properties.
function listbox8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton9.
function pushbutton9_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on selection change in listbox_response.
function listbox_response_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_response (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_response contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_response


% --- Executes during object creation, after setting all properties.
function listbox_response_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_response (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_response.
function pushbutton_response_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_response (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

n=get(handles.listbox_response,'Value');

if(n==1)
    handles.s=panel_deterministic;  
end
if(n==2)
    handles.s=SEA_diffuse_field_panel_response;  
end
if(n==3)
    handles.s=SEA_point_force_panel_response;  
end

set(handles.s,'Visible','on');


% --- Executes on selection change in listbox_radiation.
function listbox_radiation_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_radiation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_radiation contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_radiation


% --- Executes during object creation, after setting all properties.
function listbox_radiation_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_radiation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_radiation.
function pushbutton_radiation_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_radiation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

n=get(handles.listbox_radiation,'Value');

if(n==1)
    handles.s=SEA_panel_point_force_radiation;
end
if(n==2)
    handles.s=SEA_panel_velocity_radiation;  
end


set(handles.s,'Visible','on');


% --- Executes on selection change in listbox_acoustic_power.
function listbox_acoustic_power_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_acoustic_power (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_acoustic_power contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_acoustic_power


% --- Executes during object creation, after setting all properties.
function listbox_acoustic_power_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_acoustic_power (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_acoustic_power.
function pushbutton_acoustic_power_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_acoustic_power (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

n=get(handles.listbox_acoustic_power,'Value');

if(n==1)
    handles.s=equivalent_acoustic_power_panel;
else
    handles.s=equivalent_TBL_power_panel;
end
    
set(handles.s,'Visible','on');

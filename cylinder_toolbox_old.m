function varargout = cylinder_toolbox_old(varargin)
% CYLINDER_TOOLBOX_OLD MATLAB code for cylinder_toolbox_old.fig
%      CYLINDER_TOOLBOX_OLD, by itself, creates a new CYLINDER_TOOLBOX_OLD or raises the existing
%      singleton*.
%
%      H = CYLINDER_TOOLBOX_OLD returns the handle to a new CYLINDER_TOOLBOX_OLD or the handle to
%      the existing singleton*.
%
%      CYLINDER_TOOLBOX_OLD('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CYLINDER_TOOLBOX_OLD.M with the given input arguments.
%
%      CYLINDER_TOOLBOX_OLD('Property','Value',...) creates a new CYLINDER_TOOLBOX_OLD or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before cylinder_toolbox_old_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to cylinder_toolbox_old_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help cylinder_toolbox_old

% Last Modified by GUIDE v2.5 27-Sep-2018 17:15:22

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @cylinder_toolbox_old_OpeningFcn, ...
                   'gui_OutputFcn',  @cylinder_toolbox_old_OutputFcn, ...
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


% --- Executes just before cylinder_toolbox_old is made visible.
function cylinder_toolbox_old_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to cylinder_toolbox_old (see VARARGIN)

% Choose default command line output for cylinder_toolbox_old
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes cylinder_toolbox_old wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = cylinder_toolbox_old_OutputFcn(hObject, eventdata, handles) 
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
delete(cylinder_toolbox);

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
    handles.s=cylinder_critical_ring_frequencies;      
end
if(n==2)
    handles.s=radiation_efficiency_cylinder;      
end
if(n==3)
    handles.s=mobility_impedance;      
end
if(n==4)
    handles.s=dissipation_loss_factor;      
end
if(n==5)
    handles.s=unstiffened_cylinder_modal_density;      
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
    handles.s=cylinder_fn;      
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


% --- Executes on selection change in listbox_acoustic_field.
function listbox_acoustic_field_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_acoustic_field (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_acoustic_field contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_acoustic_field


% --- Executes during object creation, after setting all properties.
function listbox_acoustic_field_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_acoustic_field (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_acoustic_field.
function pushbutton_acoustic_field_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_acoustic_field (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

n=get(handles.listbox_acoustic_field,'Value');

nb=get(handles.listbox_band_apf,'Value');

if(n==1)
    
    if(nb==1)
        handles.s=SEA_equivalent_acoustic_power_cylinder; 
    else
        handles.s=SEA_equivalent_acoustic_power_cylinder_multi;        
    end
else
    if(nb==1)
        handles.s=SEA_cylinder_acoustic_response;          
    else
        handles.s=SEA_cylinder_acoustic_response_multi;
    end    
end    

set(handles.s,'Visible','on');


% --- Executes on selection change in listbox_force.
function listbox_force_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_force (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_force contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_force


% --- Executes during object creation, after setting all properties.
function listbox_force_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_force (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_force.
function pushbutton_force_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_force (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

n=get(handles.listbox_force,'Value');
nb=get(handles.listbox_band_other,'Value');

if(n==1)
    if(nb==1)
        handles.s=SEA_cylinder_force_response;  
    else
        handles.s=SEA_cylinder_force_response_multi;  
    end    
end   
    
set(handles.s,'Visible','on');


% --- Executes on selection change in listbox_band_apf.
function listbox_band_apf_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_band_apf (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_band_apf contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_band_apf


% --- Executes during object creation, after setting all properties.
function listbox_band_apf_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_band_apf (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_empirical.
function listbox_empirical_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_empirical (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_empirical contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_empirical


% --- Executes during object creation, after setting all properties.
function listbox_empirical_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_empirical (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_empirical.
function pushbutton_empirical_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_empirical (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

n=get(handles.listbox_empirical,'Value');

if(n==1)
    handles.s=Franken_method;      
end

set(handles.s,'Visible','on')


% --- Executes on selection change in listbox_band_other.
function listbox_band_other_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_band_other (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_band_other contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_band_other


% --- Executes during object creation, after setting all properties.
function listbox_band_other_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_band_other (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_band.
function listbox_band_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_band (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_band contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_band


% --- Executes during object creation, after setting all properties.
function listbox_band_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_band (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

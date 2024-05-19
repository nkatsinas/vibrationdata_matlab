function varargout = stress_toolbox(varargin)
% STRESS_TOOLBOX MATLAB code for stress_toolbox.fig
%      STRESS_TOOLBOX, by itself, creates a new STRESS_TOOLBOX or raises the existing
%      singleton*.
%
%      H = STRESS_TOOLBOX returns the handle to a new STRESS_TOOLBOX or the handle to
%      the existing singleton*.
%
%      STRESS_TOOLBOX('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in STRESS_TOOLBOX.M with the given input arguments.
%
%      STRESS_TOOLBOX('Property','Value',...) creates a new STRESS_TOOLBOX or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before stress_toolbox_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to stress_toolbox_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help stress_toolbox

% Last Modified by GUIDE v2.5 23-Apr-2016 14:38:20

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @stress_toolbox_OpeningFcn, ...
                   'gui_OutputFcn',  @stress_toolbox_OutputFcn, ...
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


% --- Executes just before stress_toolbox is made visible.
function stress_toolbox_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to stress_toolbox (see VARARGIN)

% Choose default command line output for stress_toolbox
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes stress_toolbox wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = stress_toolbox_OutputFcn(hObject, eventdata, handles) 
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

delete(stress_toolbox);


% --- Executes on button press in pushbutton_PA3.
function pushbutton_PA3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_PA3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

n=get(handles.listbox_misc,'Value');

if(n==1)
    handles.s=bearing_stress;
end  
if(n==2)
    handles.s=principal_stress_strain;
end
if(n==3)
    handles.s=stress_from_plane_strain;
end
if(n==4)
    handles.s=octahedral_stress;
end
if(n==5)
    handles.s=railcar_axle_four_point_bending;
end
if(n==6)
    handles.s=cylinder_torsion;
end
if(n==7)
    handles.s= vibrationdata_equivalent_uniaxial;   
end
if(n==8)
    handles.s= beam_peak_bending_stress;   
end   
    
set(handles.s,'Visible','on')


% --- Executes on button press in pushbutton_PA2.
function pushbutton_PA2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_PA2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

n=get(handles.listbox_PSD,'Value');

if(n==1)
    handles.s=vibrationdata_vrs_base ;
end  
if(n==2)
    handles.s=vibrationdata_stress_psd_fatigue;
end  
if(n==3)
    handles.s=vibrationdata_stress_psd_fatigue_nasgro;
end  
if(n==4)
    handles.s=vibrationdata_stress_psd_fatigue_mean;
end 
if(n==5)
    handles.s=vibrationdata_fatigue_life;
end 
if(n==6)
    handles.s=vibrationdata_fatigue_life_nonGaussian;
end 
if(n==7)
    handles.s=response_PSD_relative_damage;
end 
if(n==8)
    handles.s=Steinberg_PSD_fatigue;
end  

set(handles.s,'Visible','on')


% --- Executes on selection change in listbox_PSD.
function listbox_PSD_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_PSD (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_PSD contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_PSD


% --- Executes during object creation, after setting all properties.
function listbox_PSD_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_PSD (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_PA1.
function pushbutton_PA1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_PA1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

n=get(handles.listbox_TH,'Value');

if(n==1)
    handles.s=vibrationdata_rainflow;
end  
if(n==2)
    handles.s=vibrationdata_fds;
end  
if(n==3)
    handles.s=Steinberg_TH_fatigue;
end  
if(n==4)
    handles.s=simple_range_mean_counting;
end
if(n==5)
    handles.s=range_pair_counting;
end

set(handles.s,'Visible','on')


% --- Executes on selection change in listbox_TH.
function listbox_TH_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_TH (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_TH contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_TH



% --- Executes during object creation, after setting all properties.
function listbox_TH_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_TH (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_misc.
function listbox_misc_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_misc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_misc contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_misc


% --- Executes during object creation, after setting all properties.
function listbox_misc_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_misc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_PA4.
function pushbutton_PA4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_PA4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

n=get(handles.listbox_stress_TH,'Value');

if(n==1)
    handles.s=vibrationdata_rainflow_Miners_nasgro;
end  
if(n==2)
    handles.s=vibrationdata_rainflow_Miners_Basquin;
end  


set(handles.s,'Visible','on')


% --- Executes on selection change in listbox_stress_TH.
function listbox_stress_TH_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_stress_TH (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_stress_TH contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_stress_TH


% --- Executes during object creation, after setting all properties.
function listbox_stress_TH_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_stress_TH (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_multiaxis_th.
function pushbutton_multiaxis_th_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_multiaxis_th (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

n=get(handles.listbox_multiaxis_th,'Value');

if(n==1)
    handles.s=multiaxis_rainflow;
end  
if(n==2)
    handles.s=multiaxis_fatigue_damage_Basquin;
end  
if(n==3)
    handles.s=multiaxis_fatigue_damage_nagro;
end  


% --- Executes on selection change in listbox_multiaxis_th.
function listbox_multiaxis_th_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_multiaxis_th (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_multiaxis_th contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_multiaxis_th


% --- Executes during object creation, after setting all properties.
function listbox_multiaxis_th_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_multiaxis_th (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox5.
function listbox5_Callback(hObject, eventdata, handles)
% hObject    handle to listbox5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox5 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox5


% --- Executes during object creation, after setting all properties.
function listbox5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

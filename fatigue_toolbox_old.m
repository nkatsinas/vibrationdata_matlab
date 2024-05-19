function varargout = fatigue_toolbox_old(varargin)
% FATIGUE_TOOLBOX_OLD MATLAB code for fatigue_toolbox_old.fig
%      FATIGUE_TOOLBOX_OLD, by itself, creates a new FATIGUE_TOOLBOX_OLD or raises the existing
%      singleton*.
%
%      H = FATIGUE_TOOLBOX_OLD returns the handle to a new FATIGUE_TOOLBOX_OLD or the handle to
%      the existing singleton*.
%
%      FATIGUE_TOOLBOX_OLD('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in FATIGUE_TOOLBOX_OLD.M with the given input arguments.
%
%      FATIGUE_TOOLBOX_OLD('Property','Value',...) creates a new FATIGUE_TOOLBOX_OLD or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before fatigue_toolbox_old_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to fatigue_toolbox_old_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help fatigue_toolbox_old

% Last Modified by GUIDE v2.5 17-Jun-2017 16:17:41

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @fatigue_toolbox_old_OpeningFcn, ...
                   'gui_OutputFcn',  @fatigue_toolbox_old_OutputFcn, ...
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


% --- Executes just before fatigue_toolbox_old is made visible.
function fatigue_toolbox_old_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to fatigue_toolbox_old (see VARARGIN)

% Choose default command line output for fatigue_toolbox_old
handles.output = hObject;

set(handles.listbox_TH,'Value',1);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes fatigue_toolbox_old wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = fatigue_toolbox_old_OutputFcn(hObject, eventdata, handles) 
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

delete(fatigue_toolbox);


% --- Executes on button press in pushbutton_PA3.
function pushbutton_PA3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_PA3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

n=get(handles.listbox_eq,'Value');

if(n==1)
    handles.s=equivalent_sine_damage;
end  
if(n==2)
    handles.s=fatigue_sine_to_narrowband;
end  
if(n==3)
    handles.s=sine_on_random_composite_psd;
end 
if(n==4)
    handles.s= vibrationdata_srs_fds;  
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
    handles.s=simple_range_mean_counting;
end
if(n==4)
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


% --- Executes on selection change in listbox_eq.
function listbox_eq_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_eq (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_eq contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_eq



% --- Executes during object creation, after setting all properties.
function listbox_eq_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_eq (see GCBO)
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
    handles.s=multiaxis_fatigue_damage_nasgro;
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


% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

n=get(handles.listbox_misc,'Value');

if(n==1)
    handles.s=vibrationdata_miners;
end  
if(n==2)
    handles.s= pure_sine_stress_Basquin;  
end
if(n==3)
    handles.s= normal_shear_stress_constant;  
end
if(n==4)
    handles.s= normal_shear_stress_constant_out_phase;  
end
    
set(handles.s,'Visible','on')



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

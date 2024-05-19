function varargout = fatigue_toolbox(varargin)
% FATIGUE_TOOLBOX MATLAB code for fatigue_toolbox.fig
%      FATIGUE_TOOLBOX, by itself, creates a new FATIGUE_TOOLBOX or raises the existing
%      singleton*.
%
%      H = FATIGUE_TOOLBOX returns the handle to a new FATIGUE_TOOLBOX or the handle to
%      the existing singleton*.
%
%      FATIGUE_TOOLBOX('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in FATIGUE_TOOLBOX.M with the given input arguments.
%
%      FATIGUE_TOOLBOX('Property','Value',...) creates a new FATIGUE_TOOLBOX or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before fatigue_toolbox_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to fatigue_toolbox_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help fatigue_toolbox

% Last Modified by GUIDE v2.5 17-Jun-2017 16:52:28

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @fatigue_toolbox_OpeningFcn, ...
                   'gui_OutputFcn',  @fatigue_toolbox_OutputFcn, ...
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


% --- Executes just before fatigue_toolbox is made visible.
function fatigue_toolbox_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to fatigue_toolbox (see VARARGIN)

% Choose default command line output for fatigue_toolbox
handles.output = hObject;


listbox_analysis_type_Callback(hObject, eventdata, handles);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes fatigue_toolbox wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = fatigue_toolbox_OutputFcn(hObject, eventdata, handles) 
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


% --- Executes on button press in pushbutton_PA2.
function pushbutton_PA2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_PA2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)




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


% --- Executes on selection change in listbox_analysis_TH.
function listbox_analysis_TH_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_analysis_TH (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_analysis_TH contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_analysis_TH



% --- Executes during object creation, after setting all properties.
function listbox_analysis_TH_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_analysis_TH (see GCBO)
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


% --- Executes on selection change in listbox_analysis_type.
function listbox_analysis_type_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_analysis_type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_analysis_type contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_analysis_type

n=get(handles.listbox_analysis_type,'Value');

%  out1=sprintf('n=%d',n);
%  disp(out1);

try
    set(handles.listbox_analysis_TH, 'String','');
catch
    disp(' ref 1');
end

if(n==1) % General Time History Input, Single Axis

    string_th1{1}=sprintf('Rainflow Cycle Counting, Single Axis');
    string_th1{2}=sprintf('Fatigue Damage Spectrum for Acceleration Base Input');
    string_th1{3}=sprintf('Simple Range Mean Counting');
    string_th1{4}=sprintf('Range Pair Counting');
    string_th1{5}=sprintf('Batch Processing');

    set(handles.listbox_analysis_TH,'String',string_th1,'Value',1); 
    
    set(handles.uipanel1,'Title','General Time History Input, Single Axis');
    
end
if(n==2) % Stress Time History Input, Single Axis
   
    disp('n==2');
    
    string_th2{1}=sprintf('Basquin Coefficients, Mean Stress Correction');
    string_th2{2}=sprintf('Nasgro or MIL-HDBK-5J Coefficients');
    string_th2{3}=sprintf('Nasgro Long Block Input Format, Optional Endurance Knockdown');   
    string_th2{4}=sprintf('Rainflow Cycle Count, Nasgro Long Block Output Format');  
    string_th2{5}=sprintf('Batch Processing');    

    set(handles.listbox_analysis_TH,'String',string_th2,'Value',1); 

    set(handles.uipanel1,'Title','Stress Time History Input, Single Axis');

end
if(n==3) % Stress Time History Input, Multiaxis
    
    string_th3{1}=sprintf('Rainflow Cycle Counting, Hypersphere only');
    string_th3{2}=sprintf('Miners Damage for Multi-axis, Basquin');
    string_th3{3}=sprintf('Miners Damage for Multi-axis, MIL-HDBK-5J');
    set(handles.listbox_analysis_TH,'String',string_th3,'Value',1); 
    
    set(handles.uipanel1,'Title','Stress Time History Input, Multiaxis');
    

end
if(n==4) % Equivalence & Conversion Methods

    string_th4{1}=sprintf('Equivalent Sine Input for Given Damage Level');
    string_th4{2}=sprintf('Equivalent Narrowband Random PSD for Sine Input');
    string_th4{3}=sprintf('Convert Sine-on-Random Spec to Composite PSD');
    string_th4{4}=sprintf('Convert SRS to FDS');
    set(handles.listbox_analysis_TH,'String',string_th4,'Value',1); 

    set(handles.uipanel1,'Title','Equivalence & Conversion Methods');
    
    
end
if(n==5) % PSD Input
    
    string_th5{1}=sprintf('VRS & FDS for Base input PSD');
    string_th5{2}=sprintf('Miners Damage for Stress PSD, Basquin');
    string_th5{3}=sprintf('Miners Damage for Stress PSD, Nasgro & MIL-HDBK-5J');
    string_th5{4}=sprintf('Miners Damage for Stress PSD, Dirlik, Mean Stress Correction, Basquin');
    string_th5{5}=sprintf('Fatigue Life for Stress PSD, Basquin');
    string_th5{6}=sprintf('Fatigue Life for Stress PSD, non-Gaussian, Basquin');
    string_th5{7}=sprintf('Relative Damage for Response PSD (Dirlik Method)');
    string_th5{8}=sprintf('Dirlik Method, Batch Processing');
    string_th5{9}=sprintf('Accel PSD to Velox PSD to Stress PSD, Dirlik, Nasgro & MIL-HDBK-5J'); 
    string_th5{10}=sprintf('Convert Sine-on-Random Spec to Composite PSD');
    
    set(handles.listbox_analysis_TH,'String',string_th5,'Value',1); 

    set(handles.uipanel1,'Title','PSD Input');
    
    
end
if(n==6) % Miscellaneous
    
    string_th6{1}=sprintf('Miners Damage for (Stress Amplitude & Cycles), Basquin');
    string_th6{2}=sprintf('Pure Sine Stress Fatigue, Basquin');            
    string_th6{3}=sprintf('Shear & Normal Stress, Constant, in-phase');
    string_th6{4}=sprintf('Shear & Normal Stress, Constant, out-of-phase');
    string_th6{5}=sprintf('NASGRO/NASFORM parameters for an S-N Curve');
    
    set(handles.listbox_analysis_TH,'String',string_th6,'Value',1); 

    set(handles.uipanel1,'Title','Miscellaneous');
    
    
end


% --- Executes during object creation, after setting all properties.
function listbox_analysis_type_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_analysis_type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_analyze.
function pushbutton_analyze_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_analyze (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


m=get(handles.listbox_analysis_type,'Value');
n=get(handles.listbox_analysis_TH,'Value');


if(m==1) % General Time History Input, Single Axis

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
    if(n==5)
        handles.s=batch_rainflow;
    end
    
end
if(m==2) % Stress Time History Input, Single Axis
    
    if(n==1)
        handles.s=vibrationdata_rainflow_Miners_Basquin;
    end        
    if(n==2)
        handles.s=vibrationdata_rainflow_Miners_nasgro;
    end  
    if(n==3)
        handles.s=Fatigue_Damage_NASGRO_LB_input;
    end    
    if(n==4)
        handles.s=rainflow_NASGRO_LB_output;
    end      
    if(n==5)
        handles.s=batch_rainflow;
    end 

end
if(m==3) % Stress Time History Input, Multiaxis
    
    if(n==1)
        handles.s=multiaxis_rainflow;
    end  
    if(n==2)
        handles.s=multiaxis_fatigue_damage_Basquin;
    end  
    if(n==3)
        handles.s=multiaxis_fatigue_damage_nasgro;
    end      

end
if(m==4) % Equivalence & Conversion Methods

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
        handles.s=vibrationdata_srs_fds;  
    end    
    
end
if(m==5) % PSD Input

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
        handles.s=Dirlik_batch_main;
    end 
    if(n==9)
        handles.s=vibrationdata_accel_psd_fatigue_nasgro;
    end
    if(n==10)
        handles.s=sine_on_random_composite_psd;
    end    
end

if(m==6) % Miscellaneous

    if(n==1)
        handles.s=vibrationdata_miners;
    end  
    if(n==2)
        handles.s=pure_sine_stress_Basquin;  
    end
    if(n==3)
        handles.s=normal_shear_stress_constant;  
    end
    if(n==4)
        handles.s=normal_shear_stress_constant_out_phase;  
    end
    if(n==5)
        handles.s=sn_curvefit_NASGRO;  
    end
end

try
    set(handles.s,'Visible','on'); 
catch
    warndlg('Open failure');
    return;
end


% --- Executes during object creation, after setting all properties.
function pushbutton_analyze_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pushbutton_analyze (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

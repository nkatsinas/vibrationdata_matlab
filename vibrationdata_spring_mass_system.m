function varargout = vibrationdata_spring_mass_system(varargin)
% VIBRATIONDATA_SPRING_MASS_SYSTEM MATLAB code for vibrationdata_spring_mass_system.fig
%      VIBRATIONDATA_SPRING_MASS_SYSTEM, by itself, creates a new VIBRATIONDATA_SPRING_MASS_SYSTEM or raises the existing
%      singleton*.
%
%      H = VIBRATIONDATA_SPRING_MASS_SYSTEM returns the handle to a new VIBRATIONDATA_SPRING_MASS_SYSTEM or the handle to
%      the existing singleton*.
%
%      VIBRATIONDATA_SPRING_MASS_SYSTEM('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in VIBRATIONDATA_SPRING_MASS_SYSTEM.M with the given input arguments.
%
%      VIBRATIONDATA_SPRING_MASS_SYSTEM('Property','Value',...) creates a new VIBRATIONDATA_SPRING_MASS_SYSTEM or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before vibrationdata_spring_mass_system_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to vibrationdata_spring_mass_system_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help vibrationdata_spring_mass_system

% Last Modified by GUIDE v2.5 06-Oct-2017 12:34:35

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @vibrationdata_spring_mass_system_OpeningFcn, ...
                   'gui_OutputFcn',  @vibrationdata_spring_mass_system_OutputFcn, ...
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


% --- Executes just before vibrationdata_spring_mass_system is made visible.
function vibrationdata_spring_mass_system_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to vibrationdata_spring_mass_system (see VARARGIN)

% Choose default command line output for vibrationdata_spring_mass_system
handles.output = hObject;

listbox_dof_Callback(hObject, eventdata, handles);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes vibrationdata_spring_mass_system wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = vibrationdata_spring_mass_system_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in listbox_analysis_sdof.
function listbox_analysis_sdof_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_analysis_sdof (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_analysis_sdof contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_analysis_sdof




% --- Executes during object creation, after setting all properties.
function listbox_analysis_sdof_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_analysis_sdof (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_return.
function pushbutton_return_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_return (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
delete(vibrationdata_spring_mass_system);


% --- Executes on button press in pushbutton_analysis.
function pushbutton_analysis_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_analysis (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


n=get(handles.listbox_analysis_sdof,'Value');

if(n==1)
    handles.s=sdof_fn;
end
if(n==2)
    handles.s=steady;
end
if(n==3)
    handles.s=classical_pulse_base_input;
end
if(n==4)
    handles.s=vibrationdata_sdof_base;
end
if(n==5)
    handles.s=classical_pulse_applied_force;
end
if(n==6)
    handles.s=vibrationdata_sdof_Force;
end
if(n==7)
    handles.s=vibrationdata_psd_sdof_base;
end
if(n==8)
    handles.s=peak_sigma_random;       
end
if(n==9)
    handles.s=vibrationdata_sdof_transmissibility;
end
if(n==10)
    handles.s=sdof_free_vibration;
end
if(n==11)
    handles.s=vibrationdata_spring_surge;
end

set(handles.s,'Visible','on')


% --- Executes on selection change in listbox_analysis_tdof.
function listbox_analysis_tdof_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_analysis_tdof (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_analysis_tdof contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_analysis_tdof


% --- Executes during object creation, after setting all properties.
function listbox_analysis_tdof_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_analysis_tdof (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_analysis_tdof.
function pushbutton_analysis_tdof_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_analysis_tdof (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

 
n=get(handles.listbox_analysis_tdof,'Value');
 
if(n==1)
    handles.s=two_dof_system;
end
if(n==2)
    handles.s=two_dof_base;
end
if(n==3)
    handles.s=vibrationdata_two_dof_force;
end 
if(n==4)
    handles.s=three_dof_system;    
end    
if(n==5)
    handles.s=six_dof_four_isolators;
end 
if(n==6)
    handles.s=mdof_modal_arbitrary_force_main;
end 



set(handles.s,'Visible','on')


% --- Executes on selection change in listbox_analysis_mdof.
function listbox_analysis_mdof_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_analysis_mdof (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_analysis_mdof contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_analysis_mdof


% --- Executes during object creation, after setting all properties.
function listbox_analysis_mdof_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_analysis_mdof (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_MDOF.
function pushbutton_MDOF_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_MDOF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

n=get(handles.listbox_analysis_mdof,'Value');
 
 
if(n==1)
    handles.s=six_dof_four_isolators;
end 
if(n==2)
    handles.s=mdof_modal_arbitrary_force_main;
end 
if(n==3)
    handles.s=nm_mdof_enforced_acceleration;
end 
if(n==4)
    handles.s=nm_mdof_acceleration_force;
end 
if(n==5)
    handles.s=nm_mdof_enforced_displacement;
end 
if(n==6)
    handles.s=vibrationdata_fea_preprocessor;
end    

set(handles.s,'Visible','on')


% --- Executes during object creation, after setting all properties.
function pushbutton_MDOF_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pushbutton_MDOF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on selection change in listbox_analysis_three_dof.
function listbox_analysis_three_dof_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_analysis_three_dof (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_analysis_three_dof contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_analysis_three_dof


% --- Executes during object creation, after setting all properties.
function listbox_analysis_three_dof_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_analysis_three_dof (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_analyze_three_dof.
function pushbutton_analyze_three_dof_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_analyze_three_dof (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

n=get(handles.listbox_analysis_three_dof,'Value');
 
if(n==1)
    handles.s=three_dof_system;    
end
if(n==2)
    handles.s=three_dof_base_a;
end
if(n==3)
    handles.s=ESA_simple_spacecraft_model;
end
if(n==4)
    handles.s=ESA_simple_launcher_spacecraft_model;
end
if(n==5)
    handles.s=semi_definite_three_dof_applied_force;
end


set(handles.s,'Visible','on')


% --- Executes on selection change in listbox_dof.
function listbox_dof_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_dof (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_dof contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_dof

n=get(handles.listbox_dof,'Value');

set(handles.listbox_aux,'String',' ');   
set(handles.listbox_aux,'Value',1);

if(n==1)  % single
    string_w{1}=sprintf('Natural Frequency');
    string_w{2}=sprintf('Steady-State Sine Force or Acceleration Input');
    string_w{3}=sprintf('Classical Shock Base Input');
    string_w{4}=sprintf('Base Input, Time Domain');
    string_w{5}=sprintf('Classical Shock Applied Force');
    string_w{6}=sprintf('Applied Force, Time Domain');
    string_w{7}=sprintf('PSD Base Input');
    string_w{8}=sprintf('Peak Sigma for Random Base Input');
    string_w{9}=sprintf('Transmissibility for Base Excitation');
    string_w{10}=sprintf('Transfer Function for Applied Force');   
    string_w{11}=sprintf('Free Vibration Response to Initial Conditions');
    string_w{12}=sprintf('Spring Surge');
end
if(n==2)  % two
    string_w{1}=sprintf('System Natural Frequencies');
    string_w{2}=sprintf('System Base Excitation');
    string_w{3}=sprintf('System Applied Force');   
    string_w{4}=sprintf('System with Dashpots');
    string_w{5}=sprintf('Three Parameter Isolation System');  
    string_w{6}=sprintf('Automobile');    
end
if(n==3)  % three
    string_w{1}=sprintf('System Natural Frequencies');
    string_w{2}=sprintf('System Base Excitation');
    string_w{3}=sprintf('ESA Simple Spacecraft Model');
    string_w{4}=sprintf('ESA Simple Launcher/Spacecraft Model');
    string_w{5}=sprintf('Semidefinite System, Applied Force');
end
if(n==4)  % mdof
    string_w{1}=sprintf('Six-DOF Mass with Four Isolators');
    string_w{2}=sprintf('Six-DOF Mass with Arbitrary Number of Isolators');    
    string_w{3}=sprintf('MDOF System, Applied Arbitary Force');
    string_w{4}=sprintf('MDOF System, Enforced Acceleration');
    string_w{5}=sprintf('MDOF System, Acceleration & Force');
    string_w{6}=sprintf('MDOF System, Enforced Dispacement');
    string_w{7}=sprintf('FEA Preprocessor');
end

set(handles.listbox_aux,'String',string_w);   



% --- Executes during object creation, after setting all properties.
function listbox_dof_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_dof (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_aux.
function listbox_aux_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_aux (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_aux contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_aux


% --- Executes during object creation, after setting all properties.
function listbox_aux_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_aux (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_analyze_aux.
function pushbutton_analyze_aux_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_analyze_aux (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

n=get(handles.listbox_dof,'Value');

m=get(handles.listbox_aux,'Value');


if(n==1)  % single

    if(m==1)
        handles.s=sdof_fn;
    end
    if(m==2)
        handles.s=steady;
    end
    if(m==3)
        handles.s=classical_pulse_base_input;
    end
    if(m==4)
        handles.s=vibrationdata_sdof_base;
    end
    if(m==5)
        handles.s=classical_pulse_applied_force;
    end
    if(m==6)
        handles.s=vibrationdata_sdof_Force;
    end
    if(m==7)
        handles.s=vibrationdata_psd_sdof_base;
    end
    if(m==8)
        handles.s=peak_sigma_random;       
    end
    if(m==9)
        handles.s=vibrationdata_sdof_transmissibility;
    end
    if(m==10)
        handles.s=vibrationdata_sdof_transfer;
    end    
    if(m==11)
        handles.s=sdof_free_vibration;
    end
    if(m==12)
        handles.s=vibrationdata_spring_surge;
    end
    
end
if(n==2)  % two
    
    if(m==1)
        handles.s=two_dof_system;
    end
    if(m==2)
        handles.s=two_dof_base;
    end
    if(m==3)
        handles.s=vibrationdata_two_dof_force;
    end 
    if(m==4)
        handles.s=vibrationdata_two_dof_dashpots_force;
    end    
    if(m==5)
        handles.s=three_parameter_isolation_system;
    end
    if(m==6)
        handles.s=automobile_road;
    end    
    
end
if(n==3)  % three

    if(m==1)
        handles.s=three_dof_system;    
    end
    if(m==2)
        handles.s=three_dof_base_a;
    end
    if(m==3)
        handles.s=ESA_simple_spacecraft_model;
    end
    if(m==4)
        handles.s=ESA_simple_launcher_spacecraft_model;
    end
    if(m==5)
        handles.s=semi_definite_three_dof_applied_force;
    end

end
if(n==4)  % mdof

    if(m==1)
        handles.s=six_dof_four_isolators;
    end 
    if(m==2)
        handles.s=vibrationdata_arbitrary_isolators;
    end     
    if(m==3)
        handles.s=mdof_modal_arbitrary_force_main;
    end 
    if(m==4)
        handles.s=nm_mdof_enforced_acceleration;
    end 
    if(m==5)
        handles.s=nm_mdof_acceleration_force;
    end 
    if(m==6)
        handles.s=nm_mdof_enforced_displacement;
    end 
    if(m==7)
        handles.s=vibrationdata_fea_preprocessor;
    end    

end

set(handles.s,'Visible','on')



% --- Executes during object creation, after setting all properties.
function pushbutton_analyze_aux_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pushbutton_analyze_aux (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

function varargout = vibrationdata_spring_mass_system_old(varargin)
% VIBRATIONDATA_SPRING_MASS_SYSTEM_OLD MATLAB code for vibrationdata_spring_mass_system_old.fig
%      VIBRATIONDATA_SPRING_MASS_SYSTEM_OLD, by itself, creates a new VIBRATIONDATA_SPRING_MASS_SYSTEM_OLD or raises the existing
%      singleton*.
%
%      H = VIBRATIONDATA_SPRING_MASS_SYSTEM_OLD returns the handle to a new VIBRATIONDATA_SPRING_MASS_SYSTEM_OLD or the handle to
%      the existing singleton*.
%
%      VIBRATIONDATA_SPRING_MASS_SYSTEM_OLD('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in VIBRATIONDATA_SPRING_MASS_SYSTEM_OLD.M with the given input arguments.
%
%      VIBRATIONDATA_SPRING_MASS_SYSTEM_OLD('Property','Value',...) creates a new VIBRATIONDATA_SPRING_MASS_SYSTEM_OLD or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before vibrationdata_spring_mass_system_old_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to vibrationdata_spring_mass_system_old_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help vibrationdata_spring_mass_system_old

% Last Modified by GUIDE v2.5 06-Oct-2017 12:11:21

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @vibrationdata_spring_mass_system_old_OpeningFcn, ...
                   'gui_OutputFcn',  @vibrationdata_spring_mass_system_old_OutputFcn, ...
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


% --- Executes just before vibrationdata_spring_mass_system_old is made visible.
function vibrationdata_spring_mass_system_old_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to vibrationdata_spring_mass_system_old (see VARARGIN)

% Choose default command line output for vibrationdata_spring_mass_system_old
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes vibrationdata_spring_mass_system_old wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = vibrationdata_spring_mass_system_old_OutputFcn(hObject, eventdata, handles) 
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
    handles.s=automobile_road;
end
if(n==4)
    handles.s=vibrationdata_two_dof_force;
end 
if(n==5)
    handles.s=three_dof_system;    
end    
if(n==6)
    handles.s=six_dof_four_isolators;
end 
if(n==7)
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

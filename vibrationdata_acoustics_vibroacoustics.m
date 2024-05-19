function varargout = vibrationdata_acoustics_vibroacoustics(varargin)
% VIBRATIONDATA_ACOUSTICS_VIBROACOUSTICS MATLAB code for vibrationdata_acoustics_vibroacoustics.fig
%      VIBRATIONDATA_ACOUSTICS_VIBROACOUSTICS, by itself, creates a new VIBRATIONDATA_ACOUSTICS_VIBROACOUSTICS or raises the existing
%      singleton*.
%
%      H = VIBRATIONDATA_ACOUSTICS_VIBROACOUSTICS returns the handle to a new VIBRATIONDATA_ACOUSTICS_VIBROACOUSTICS or the handle to
%      the existing singleton*.
%
%      VIBRATIONDATA_ACOUSTICS_VIBROACOUSTICS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in VIBRATIONDATA_ACOUSTICS_VIBROACOUSTICS.M with the given input arguments.
%
%      VIBRATIONDATA_ACOUSTICS_VIBROACOUSTICS('Property','Value',...) creates a new VIBRATIONDATA_ACOUSTICS_VIBROACOUSTICS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before vibrationdata_acoustics_vibroacoustics_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to vibrationdata_acoustics_vibroacoustics_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help vibrationdata_acoustics_vibroacoustics

% Last Modified by GUIDE v2.5 16-Sep-2022 16:05:41

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @vibrationdata_acoustics_vibroacoustics_OpeningFcn, ...
                   'gui_OutputFcn',  @vibrationdata_acoustics_vibroacoustics_OutputFcn, ...
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


% --- Executes just before vibrationdata_acoustics_vibroacoustics is made visible.
function vibrationdata_acoustics_vibroacoustics_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to vibrationdata_acoustics_vibroacoustics (see VARARGIN)

% Choose default command line output for vibrationdata_acoustics_vibroacoustics
handles.output = hObject;

set(handles.listbox_analysis,'Value',1);
set(handles.listbox_aux,'Value',1);

set(handles.listbox_aux, 'String', '');
set(handles.uipanel_aux,'Visible','off');

listbox_analysis_Callback(hObject, eventdata, handles);


% Update handles structure
guidata(hObject, handles);

% UIWAIT makes vibrationdata_acoustics_vibroacoustics wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = vibrationdata_acoustics_vibroacoustics_OutputFcn(hObject, eventdata, handles) 
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

delete(vibrationdata_acoustics_vibroacoustics);

function abox(hObject, eventdata, handles)

    set(handles.text_aux,'String','Acoustics');  
    string_th{1}=sprintf('Speed of Sound');
    string_th{end+1}=sprintf('Doppler Shift');
    string_th{end+1}=sprintf('Wavelength');
    string_th{end+1}=sprintf('dB & Pressure Unit Conversion');
    string_th{end+1}=sprintf('Helmholtz Resonator');
    string_th{end+1}=sprintf('Transmission Loss through Partitions');
    string_th{end+1}=sprintf('Transmission Loss & Coefficient Conversion');
    string_th{end+1}=sprintf('Transmission Loss, Breakout from Duct or Pipe');   
    string_th{end+1}=sprintf('Transmission Loss, L-Beam, Waveforms');   
    string_th{end+1}=sprintf('Noise Reduction, Partition between Source & Receiver Room');
    string_th{end+1}=sprintf('Noise Reduction, Room from External Source');
    string_th{end+1}=sprintf('Acoustic Seismic Coupling'); 
    string_th{end+1}=sprintf('Sound Power, Intensity & Pressure');   
    string_th{end+1}=sprintf('Pipe Acoustics');  
    string_th{end+1}=sprintf('Sound Pressure Reverberant Room from Point Source');  
    set(handles.uipanel_aux,'Visible','on');
    set(handles.listbox_aux,'String',string_th)    


function vbox(hObject, eventdata, handles)     

    set(handles.text_aux,'String','vibroacoustics');

    string_th{1}=sprintf('Homogeneous Plate Vibroacoustics');
    string_th{2}=sprintf('Honeycomb Sandwich Panel Vibroacoustics');
    string_th{3}=sprintf('Baffled Rectangular Plate Subjected to Uniform Acoustic Pressure Field');
    string_th{4}=sprintf('Baffled Rectangular Plate Subjected to Uniform Acoustic Pressure Field, Alternate');    
    string_th{5}=sprintf('Baffled Rectangular Plate Subjected to Oblique Incidence Acoustic Pressure Field');
    string_th{6}=sprintf('Baffled or Unbaffled Rectangular Plate Subjected to Launchpad Acoustics');
    string_th{7}=sprintf('Spann Method for Component Mounting Surface Vibroacoustic Response');
    string_th{8}=sprintf('Franken Method for Cylindrical Shell Response to Acoustic Pressure Field');
    string_th{9}=sprintf('Franken Method, Multiple Shells');
    string_th{10}=sprintf('Barrett Empirical Scaling Method');
    string_th{11}=sprintf('Barrett Empirical Scaling Method, Multiple Structures');
    string_th{12}=sprintf('PSD Scaling Mass Density plus dB');
    
    set(handles.uipanel_aux,'Visible','on');
    set(handles.listbox_aux,'String',string_th);  
    
function LVbox(hObject, eventdata, handles)     

    set(handles.text_aux,'String','Launch Vehicle Vibroacoustics');

    string_th{1}=sprintf('Speed of Sound ');
    string_th{2}=sprintf('dB & Pressure Unit Conversion');
    string_th{3}=sprintf('Launch Vehicle Liftoff Acoustics');
    string_th{4}=sprintf('Launch Vehicle Aerodynamic Flow');
    string_th{5}=sprintf('Noise Reduction, Launch Vehicle');
    string_th{6}=sprintf('Launch Vehicle Vent Box/Cavity Natural Frequencies');
    string_th{7}=sprintf('Cylinder Ring Frequency');
    string_th{8}=sprintf('Franken Method for Cylindrical Shell Response to Acoustic Pressure Field');
    string_th{9}=sprintf('Atmospheric Properties');
    string_th{10}=sprintf('Engine Noise Power');

    set(handles.uipanel_aux,'Visible','on');
    set(handles.listbox_aux,'String',string_th);      

function rebox(hObject, eventdata, handles)   
    set(handles.text_aux,'String','Radiation Efficiency');
    string_th{1}=sprintf('Panel, Homogeneous, Baffled');
    string_th{2}=sprintf('Panel, Homogeneous, Freely-Suspended');   
    string_th{3}=sprintf('Panel, Honeycomb Sandwich, Baffled');
    string_th{4}=sprintf('Panel, Ribbed'); 
    string_th{5}=sprintf('Cylinder, Homogeneous');
    string_th{6}=sprintf('Cylinder, Honeycomb Sandwich');
 
    set(handles.uipanel_aux,'Visible','on');
    set(handles.listbox_aux,'String',string_th);      
    
    
 function lfbox(hObject, eventdata, handles)     
    
    set(handles.text_aux,'String','Loss Factor');
    string_th{1}=sprintf('Dissipation Loss Factor');
    string_th{2}=sprintf('Coupling Loss Factor');
    set(handles.uipanel_aux,'Visible','on');
    set(handles.listbox_aux,'String',string_th)       
    
function mdbox(hObject, eventdata, handles)
    
    set(handles.text_aux,'String','Modal Density');
    string_th{1}=sprintf('Modal Density');
    string_th{2}=sprintf('Modal Overlap');    
    set(handles.uipanel_aux,'Visible','on');
    set(handles.listbox_aux,'String',string_th)     
    
    
function epbox(hObject, eventdata, handles)
  
    set(handles.text_aux,'String','Energy & Power');
    string_th{1}=sprintf('Energy in a Single Subsystem');
    string_th{2}=sprintf('Power Input from Force');
    string_th{3}=sprintf('Acoustic Pressure from Energy');
    string_th{4}=sprintf('Acoustic Power from SPL');
    set(handles.uipanel_aux,'Visible','on');
    set(handles.listbox_aux,'String',string_th)        
    
    
function toolbox(hObject, eventdata, handles) 

    set(handles.text_aux,'String','Toolboxes');      
    string_th{1}=sprintf('Beam & Rod');
    string_th{2}=sprintf('Panel & Plate, Homogeneous');
    string_th{3}=sprintf('Panel & Plate, Sandwich');
    string_th{4}=sprintf('Cylinder, Homogeneous');
    string_th{5}=sprintf('Cylinder, Sandwich'); 
    set(handles.uipanel_aux,'Visible','on');
    set(handles.listbox_aux,'String',string_th);
    
    
function fwbox(hObject, eventdata, handles)
    
    set(handles.text_aux,'String','Frequency & Wavelengths');
    string_th{1}=sprintf('Wavelength');
    string_th{2}=sprintf('Cylinder Ring Frequency');
    string_th{3}=sprintf('Critical Frequency'); 
    set(handles.uipanel_aux,'Visible','on');
    set(handles.listbox_aux,'String',string_th)     
    
    
    
% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

set(handles.listbox_aux, 'String', '');
set(handles.uipanel_aux,'Visible','off');

n=get(handles.listbox_analysis,'Value');

if(n==1)
   abox(hObject, eventdata, handles); 
end

if(n==2)   
    vbox(hObject, eventdata, handles); 
end
if(n==3)
    handles.s=structural_wavespeed;
    set(handles.s,'Visible','on');     
end
if(n==4)
    handles.s=mobility_impedance;  
    set(handles.s,'Visible','on');     
end
if(n==5)
    handles.s=mass_ratio_methods;  
    set(handles.s,'Visible','on');     
end
if(n==6)
    handles.s=structural_borne_wave_propagation;
    set(handles.s,'Visible','on');     
end
if(n==7)
    handles.s=SEA_models;     
    set(handles.s,'Visible','on');     
end

if(n==8) % radiation efficiency
    rebox(hObject, eventdata, handles);     
end
if(n==9) % loss factor
    lfbox(hObject, eventdata, handles);     
end
if(n==10) % modal density
    mdbox(hObject, eventdata, handles);    
end
if(n==11) % energy & power
    epbox(hObject, eventdata, handles);  
end
if(n==12) % toolboxes
    toolbox(hObject, eventdata, handles);   
end
if(n==13) % frequency & wavelength
    fwbox(hObject, eventdata, handles);    
end

if(n==14) % launch vehicle acoustics
    LVbox(hObject, eventdata, handles); 
end
if(n==15) % Sandwich panel toolbox
    handles.s=sandwich_panel_toolbox;
    set(handles.s,'Visible','on'); 
end

if(n==16) % statistical response concentration
    handles.s=statistical_response_concentration; 
    set(handles.s,'Visible','on'); 
end



% --- Executes on selection change in listbox_analysis.
function listbox_analysis_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_analysis (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_analysis contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_analysis

set(handles.listbox_aux,'Value',1);

set(handles.listbox_aux, 'String', '');
set(handles.uipanel_aux,'Visible','off');

n=get(handles.listbox_analysis,'Value');

if(n==1)
   abox(hObject, eventdata, handles);  
end
if(n==2)
   vbox(hObject, eventdata, handles);  
end

if(n==8) % radiation efficiency
    rebox(hObject, eventdata, handles);      
end
if(n==9) % loss factor
    lfbox(hObject, eventdata, handles);   
end
if(n==10) % modal density
    mdbox(hObject, eventdata, handles); 
end
if(n==11) % energy & power
    epbox(hObject, eventdata, handles);  
end
if(n==12) % toolboxes
    toolbox(hObject, eventdata, handles);  
end
if(n==13) % frequency & wavelength
    fwbox(hObject, eventdata, handles);  
end

if(n==14)
    LVbox(hObject, eventdata, handles);
end





% --- Executes during object creation, after setting all properties.
function listbox_analysis_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_analysis (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_loss_factor.
function listbox_loss_factor_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_loss_factor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_loss_factor contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_loss_factor


% --- Executes during object creation, after setting all properties.
function listbox_loss_factor_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_loss_factor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_loss_factor.
function pushbutton_loss_factor_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_loss_factor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

n=get(handles.listbox_loss_factor,'Value');

if(n==1)
    handles.s=dissipation_loss_factor;      
end
if(n==2)
    handles.s=coupling_loss_factor;      
end

set(handles.s,'Visible','on'); 


% --- Executes on button press in pushbutton_modal.
function pushbutton_modal_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_modal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
n=get(handles.listbox_modal,'Value');

if(n==1)
    handles.s=vibrationdata_modal_density;      
end
if(n==2)
    handles.s=modal_overlap;      
end

 
set(handles.s,'Visible','on'); 



% --- Executes on selection change in listbox_modal.
function listbox_modal_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_modal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_modal contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_modal


% --- Executes during object creation, after setting all properties.
function listbox_modal_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_modal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_power.
function pushbutton_power_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_power (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

n=get(handles.listbox_power,'Value');


if(n==1)
    handles.s=energy_subsystem;      
end
if(n==2)
    handles.s=power_input_from_force_main;      
end
if(n==3)
    handles.s=acoustic_pressure_from_energy;      
end
if(n==4)
    handles.s=acoustic_power_from_SPL;      
end
 
set(handles.s,'Visible','on'); 



% --- Executes on selection change in listbox_power.
function listbox_power_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_power (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_power contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_power


% --- Executes during object creation, after setting all properties.
function listbox_power_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_power (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_frequency.
function listbox_frequency_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_frequency (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_frequency contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_frequency


% --- Executes during object creation, after setting all properties.
function listbox_frequency_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_frequency (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_frequency.
function pushbutton_frequency_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_frequency (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

n=get(handles.listbox_frequency,'Value');

if(n==1)
    handles.s=wavelength;      
end
if(n==2)
    handles.s=cylinder_ring_frequency;      
end
if(n==3)
    handles.s=critical_frequency;      
end

 
set(handles.s,'Visible','on'); 


% --- Executes on button press in pushbutton9.
function pushbutton9_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

num=get(handles.listbox_num_subsystems,'Value');

if(num==1)
    handles.s=SEA_one_subsystem;      
end
if(num==2)
    handles.s=SEA_two_subsystems;      
end
if(num==3)
    handles.s=SEA_three_subsystems_main;      
end
if(num==4)
    handles.s=SEA_four_subsystems_main;      
end

set(handles.s,'Visible','on'); 


% --- Executes on selection change in listbox_num_subsystems.
function listbox_num_subsystems_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_num_subsystems (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_num_subsystems contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_num_subsystems


% --- Executes during object creation, after setting all properties.
function listbox_num_subsystems_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_num_subsystems (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_toolbox.
function pushbutton_toolbox_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_toolbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

n=get(handles.listbox_toolboxes,'Value');

if(n==1)
    handles.s=beam_rod_toolbox;      
end
if(n==2)
    handles.s=panel_toolbox;      
end
if(n==3)
    handles.s=sandwich_panel_toolbox;      
end
if(n==4)
    handles.s=cylinder_toolbox;      
end
if(n==5)
    handles.s=sandwich_cylinder_toolbox;      
end
 
set(handles.s,'Visible','on'); 


% --- Executes on selection change in listbox_toolbox.
function listbox_toolbox_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_toolbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_toolbox contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_toolbox


% --- Executes during object creation, after setting all properties.
function listbox_toolbox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_toolbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_toolboxes.
function listbox_toolboxes_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_toolboxes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_toolboxes contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_toolboxes


% --- Executes during object creation, after setting all properties.
function listbox_toolboxes_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_toolboxes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox13.
function listbox13_Callback(hObject, eventdata, handles)
% hObject    handle to listbox13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox13 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox13


% --- Executes during object creation, after setting all properties.
function listbox13_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox13 (see GCBO)
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


% --- Executes on button press in pushbutton_aux.
function pushbutton_aux_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_aux (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


n=get(handles.listbox_analysis,'Value');
m=get(handles.listbox_aux,'Value');

if(n==1)
    if(m==1)
        handles.s=speed_sound;    
    end 
    if(m==2)
        vibrationdata_doppler_App_1;    
    end 
    if(m==3)
        handles.s=wavelength;    
    end 
    if(m==4)
        handles.s=dB_pressure_unit_conversion;    
    end 
    if(m==5)
        handles.s=Helmholtz_Resonator;    
    end 
    if(m==6)
        handles.s=transmission_loss_main;    
    end 
    if(m==7)
        handles.s=transmission_loss_coefficient;    
    end 
    if(m==8)
        handles.s=pipe_breakout_transmission_loss;    
    end      
    if(m==9)
        handles.s=transmission_loss_waveforms;    
    end     
    if(m==10)
        handles.s=noise_reduction_source_receiver;    
    end 
    if(m==11)
        handles.s=noise_reduction_room;    
    end 
    if(m==12)
        handles.s=acoustic_seismic_coupling;    
    end   
    if(m==13)
        handles.s=sound_power_intensity;    
    end
    if(m==14)
        handles.s=pipe_acoustics;    
    end
    if(m==15)
        handles.s=sound_pressure_reverberant_room;    
    end    
end

if(n==2)
    if(m==1)
        handles.s=panel_toolbox;
    end  
    if(m==2)
        handles.s=sandwich_panel_toolbox;
    end
    if(m==3)
        handles.s=vibrationdata_rectangular_plate_uniform_pressure;
    end
    if(m==4)
        handles.s=vibrationdata_rectangular_plate_uniform_pressure_alt;
    end    
    if(m==5)
        handles.s=vibrationdata_rectangular_plate_oblique_incidence;
    end
    if(m==6)
        handles.s=launchpad_baffled_plate;
    end    
    if(m==7)
        handles.s=Spann_method;
    end
    if(m==8)
        handles.s=Franken_method;
    end
    if(m==9)
        handles.s=Franken_method_multiple;
    end
    if(m==10)
        handles.s=Barrett_method;
    end
    if(m==11)
        handles.s=Barrett_method_multiple;
    end
    if(m==12)
        handles.s=psd_scaling_mass_density_plus_dB;
    end    
end
    
if(n==8) % radiation efficiency
    if(m==1)
        handles.s=radiation_efficiency_panel;
    end
    if(m==2)
        handles.s=radiation_efficiency_panel_free;
    end
    if(m==3)
        handles.s=radiation_efficiency_honeycomb_sandwich_panel;
    end
    if(m==4)
        handles.s=radiation_efficiency_ribbed_panel;
    end
    if(m==5)
        handles.s=radiation_efficiency_cylinder;
    end
    if(m==6)
        handles.s=radiation_efficiency_honeycomb_sandwich_cylinder;
    end
end
if(n==9) % loss factor
    if(m==1)
        handles.s=dissipation_loss_factor;      
    end
    if(m==2)
        handles.s=coupling_loss_factor;      
    end
end
if(n==10) % modal density
    if(m==1)
        handles.s=vibrationdata_modal_density;      
    end
    if(m==2)
        handles.s=modal_overlap;      
    end
end
if(n==11) % energy & power
    if(m==1)
        handles.s=energy_subsystem;      
    end
    if(m==2)
        handles.s=power_input_from_force_main;      
    end
    if(m==3)
        handles.s=acoustic_pressure_from_energy;      
    end
    if(m==4)
        handles.s=acoustic_power_from_SPL;      
    end       
end
if(n==12) % toolboxes
    if(m==1)
        handles.s=beam_rod_toolbox;      
    end
    if(m==2)
        handles.s=panel_toolbox;      
    end
    if(m==3)
        handles.s=sandwich_panel_toolbox;      
    end
    if(m==4)
        handles.s=cylinder_toolbox;      
    end
    if(m==5)
        handles.s=sandwich_cylinder_toolbox;      
    end    
end
if(n==13) % frequency & wavelength
    if(m==1)
        handles.s=wavelength;      
    end
    if(m==2)
        handles.s=cylinder_ring_frequency;      
    end
    if(m==3)
        handles.s=critical_frequency;      
    end
end
if(n==14) % launch vehicle acoustics
    if(m==1)
        handles.s=speed_sound;    
    end 
    if(m==2)
        handles.s=dB_pressure_unit_conversion;    
    end 
    if(m==3)
        handles.s=liftoff;    
    end 
    if(m==4)
        handles.s=aerodynamic_flow;    
    end 
    if(m==5)
        handles.s=noise_reduction;    
    end 
    if(m==6)
        handles.s=launch_vehicle_vent_box_fn; 
    end 
    if(m==7)
        handles.s=cylinder_ring_frequency;
    end
    if(m==8)
        handles.s=Franken_method;
    end
    if(m==9)
        handles.s=vibrationdata_atmospheric_properties;
    end    
    if(m==10)
        handles.s=engine_noise_power;
    end        
end    

try
    set(handles.s,'Visible','on'); 
catch
end

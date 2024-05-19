function varargout = sound_power_intensity(varargin)
% SOUND_POWER_INTENSITY MATLAB code for sound_power_intensity.fig
%      SOUND_POWER_INTENSITY, by itself, creates a new SOUND_POWER_INTENSITY or raises the existing
%      singleton*.
%
%      H = SOUND_POWER_INTENSITY returns the handle to a new SOUND_POWER_INTENSITY or the handle to
%      the existing singleton*.
%
%      SOUND_POWER_INTENSITY('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SOUND_POWER_INTENSITY.M with the given input arguments.
%
%      SOUND_POWER_INTENSITY('Property','Value',...) creates a new SOUND_POWER_INTENSITY or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before sound_power_intensity_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to sound_power_intensity_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help sound_power_intensity

% Last Modified by GUIDE v2.5 19-Aug-2020 15:44:31

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @sound_power_intensity_OpeningFcn, ...
                   'gui_OutputFcn',  @sound_power_intensity_OutputFcn, ...
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


% --- Executes just before sound_power_intensity is made visible.
function sound_power_intensity_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to sound_power_intensity (see VARARGIN)

% Choose default command line output for sound_power_intensity
handles.output = hObject;

listbox_input_Callback(hObject, eventdata, handles);

set(handles.edit_results,'Visible','off');

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes sound_power_intensity wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = sound_power_intensity_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

na=get(handles.listbox_input,'Value');
nv=get(handles.listbox_volume,'Value');
iu=get(handles.listbox_unit,'Value');
ru=get(handles.listbox_radius_unit,'Value');

amp=str2double(get(handles.edit_input,'String'));
r=str2double(get(handles.edit_radius,'String'));

rhoc=str2double(get(handles.edit_rhoc,'String'));

m_per_ft = 0.3048;
m_per_inch=0.0254;
Pa_per_psi=6894.76;

pressure_ref=20e-06;
power_ref=1.0e-12;
intensity_ref=1.0e-12;

if(na==1) % power
    if(iu==1)
        power_dB=amp;
        power_w=power_ref*10^(amp/10);
    else
        power_w=amp;
        power_dB=10*log10(power_w/power_ref);        
    end
end
if(na==2) % intensity
    if(iu==1)
        intensity_dB=amp;
        intensity_wpm2=intensity_ref*10^(amp/10);
    else
        intensity_wpm2=amp;
        intensity_dB=10*log10(intensity_wpm2/intensity_ref);        
    end
end
if(na==3) % pressure
    if(iu==1)
        pressure_dB=amp;
        pressure_Pa=pressure_ref*10^(amp/10);
    end
    if(iu==2)
        pressure_Pa=amp;
        pressure_dB=20*log10(pressure_Pa/pressure_ref); 
    end
    if(iu==3)
        pressure_Pa=amp*Pa_per_psi;
        pressure_dB=20*log10(pressure_Pa/pressure_ref);       
    end    
end


if(ru==2)
    r=r*m_per_ft;
end
if(ru==3)
    r=r*m_per_inch;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(nv==1)  % sphere
    area=4*pi*r^2;
else       % hemisphere
    area=2*pi*r^2;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(na==1) % power
    intensity_wpm2=power_w/area;
    intensity_dB=10*log10(intensity_wpm2/intensity_ref);
     
    pressure_Pa=sqrt(intensity_wpm2*rhoc);
    pressure_dB=20*log10(pressure_Pa/pressure_ref);
    pressure_psi=pressure_Pa/Pa_per_psi;
end
if(na==2) % intensity
    power_w=intensity_wpm2*area;
    power_dB=10*log10(power_w/power_ref);
     
    pressure_Pa=sqrt(intensity_wpm2*rhoc);
    pressure_psi=pressure_Pa/Pa_per_psi;
    pressure_dB=20*log10(pressure_Pa/pressure_ref);    
end
if(na==3) % pressure
    intensity_wpm2=pressure_Pa^2/rhoc;
    intensity_dB=10*log10(intensity_wpm2/intensity_ref);
    
    power_w=intensity_wpm2*area;
    power_dB=10*log10(power_w/power_ref);    
         
end


ss1=sprintf(' Power  \n  %8.4g dB ref 1 pico W \n  %8.4g W \n',power_dB,power_w);
ss2=sprintf(' Intensity  \n  %8.4g dB ref 1 pico W/m^2 \n  %8.4g W/m^2 \n',intensity_dB,intensity_wpm2);
ss3=sprintf(' Pressure \n  %8.4g dB ref 20 micro Pa \n  %8.4g Pa rms \n  %8.4g psi rms \n',pressure_dB,pressure_Pa,pressure_psi);


sss=sprintf(' %s \n %s \n %s ',ss1,ss2,ss3);

set(handles.edit_results,'Visible','on');

set(handles.edit_results,'String',sss, 'Max', 18);





% --- Executes on button press in pushbutton_return.
function pushbutton_return_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_return (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
delete(sound_power_intensity);


% --- Executes on selection change in listbox_input.
function listbox_input_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_input contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_input

set(handles.edit_results,'Visible','off');

n=get(handles.listbox_input,'value');

set(handles.listbox_unit,'String', '');

if(n==1)
    sss='Power';
    suu{1}='dB (ref 1 pico W)';
    suu{2}='W';   
end
if(n==2)
    sss='Intensity';
    suu{1}='dB (ref 1 pico W/m^2)';
    suu{2}='W/m^2';   
end
if(n==3)
    sss='Pressure';
    suu{1}='dB (ref 20 micro Pa)';
    suu{2}='Pa';
    suu{3}='psi';      
end

ttt=sprintf('%s Unit',sss);

set(handles.text_input,'String',sss);

set(handles.listbox_unit,'String',suu);

set(handles.text_input_unit,'String',ttt);


% --- Executes during object creation, after setting all properties.
function listbox_input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_volume.
function listbox_volume_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_volume (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_volume contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_volume
set(handles.edit_results,'Visible','off');

% --- Executes during object creation, after setting all properties.
function listbox_volume_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_volume (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_input_Callback(hObject, eventdata, handles)
% hObject    handle to edit_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_input as text
%        str2double(get(hObject,'String')) returns contents of edit_input as a double


% --- Executes during object creation, after setting all properties.
function edit_input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_unit.
function listbox_unit_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_unit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_unit contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_unit
set(handles.edit_results,'Visible','off');

% --- Executes during object creation, after setting all properties.
function listbox_unit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_unit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_radius_Callback(hObject, eventdata, handles)
% hObject    handle to edit_radius (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_radius as text
%        str2double(get(hObject,'String')) returns contents of edit_radius as a double


% --- Executes during object creation, after setting all properties.
function edit_radius_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_radius (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_radius_unit.
function listbox_radius_unit_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_radius_unit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_radius_unit contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_radius_unit
set(handles.edit_results,'Visible','off');

% --- Executes during object creation, after setting all properties.
function listbox_radius_unit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_radius_unit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_rhoc_Callback(hObject, eventdata, handles)
% hObject    handle to edit_rhoc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_rhoc as text
%        str2double(get(hObject,'String')) returns contents of edit_rhoc as a double


% --- Executes during object creation, after setting all properties.
function edit_rhoc_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_rhoc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_results_Callback(hObject, eventdata, handles)
% hObject    handle to edit_results (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_results as text
%        str2double(get(hObject,'String')) returns contents of edit_results as a double


% --- Executes during object creation, after setting all properties.
function edit_results_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_results (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on key press with focus on edit_rhoc and none of its controls.
function edit_rhoc_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_rhoc (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.edit_results,'Visible','off');


% --- Executes on key press with focus on edit_input and none of its controls.
function edit_input_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_input (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.edit_results,'Visible','off');


% --- Executes on key press with focus on edit_radius and none of its controls.
function edit_radius_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_radius (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.edit_results,'Visible','off');

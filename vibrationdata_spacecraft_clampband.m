function varargout = vibrationdata_spacecraft_clampband(varargin)
% VIBRATIONDATA_SPACECRAFT_CLAMPBAND MATLAB code for vibrationdata_spacecraft_clampband.fig
%      VIBRATIONDATA_SPACECRAFT_CLAMPBAND, by itself, creates a new VIBRATIONDATA_SPACECRAFT_CLAMPBAND or raises the existing
%      singleton*.
%
%      H = VIBRATIONDATA_SPACECRAFT_CLAMPBAND returns the handle to a new VIBRATIONDATA_SPACECRAFT_CLAMPBAND or the handle to
%      the existing singleton*.
%
%      VIBRATIONDATA_SPACECRAFT_CLAMPBAND('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in VIBRATIONDATA_SPACECRAFT_CLAMPBAND.M with the given input arguments.
%
%      VIBRATIONDATA_SPACECRAFT_CLAMPBAND('Property','Value',...) creates a new VIBRATIONDATA_SPACECRAFT_CLAMPBAND or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before vibrationdata_spacecraft_clampband_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to vibrationdata_spacecraft_clampband_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help vibrationdata_spacecraft_clampband

% Last Modified by GUIDE v2.5 02-Apr-2016 14:18:09

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @vibrationdata_spacecraft_clampband_OpeningFcn, ...
                   'gui_OutputFcn',  @vibrationdata_spacecraft_clampband_OutputFcn, ...
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


% --- Executes just before vibrationdata_spacecraft_clampband is made visible.
function vibrationdata_spacecraft_clampband_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to vibrationdata_spacecraft_clampband (see VARARGIN)

% Choose default command line output for vibrationdata_spacecraft_clampband
handles.output = hObject;

material_change(hObject, eventdata, handles);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes vibrationdata_spacecraft_clampband wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = vibrationdata_spacecraft_clampband_OutputFcn(hObject, eventdata, handles) 
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

iu=get(handles.listbox_units,'Value');



D=str2num(get(handles.edit_diameter,'String'));
E=str2num(get(handles.edit_elastic_modulus,'String'));
rho=str2num(get(handles.edit_mass_density,'String'));
beta=str2num(get(handles.edit_beta,'String'));
A=str2num(get(handles.edit_A,'String'));
T=str2num(get(handles.edit_tensile,'String'));



if(iu==1)  % English
    
    rho=rho/386;
    
else       % metric
    
    T=T*1000;
    [E]=GPa_to_Pa(E);
    D=D/1000;
    A=A/1000^2;
    
end    

R=D/2;


a_plateau=(beta*T)/(rho*A*R);


if(iu==1)
    a_plateau=a_plateau/386;
else
    a_plateau=a_plateau/9.81;    
end


[fr,CL]=ring_frequency_I(E,rho,D);


disp('       ');
disp(' * * * ');
disp('       ');

out1=sprintf('  Ring Frequency = %8.4g Hz',fr);
disp(out1);

if(fr<=100)
    warndlg(' Ring frequency is too low ');
    return;
end
if(fr>=9990)
    warndlg(' Ring frequency is too high ');
    return;
end

n=1;

freq_ratio=(fr/100)^n;

a1=a_plateau/freq_ratio;




disp('  ');
disp('   SRS Q=10 ');
disp('  ');
disp('  fn(Hz)   Accel(G) ');

out1=sprintf('    100  %7.4g',a1 );
out2=sprintf('%7.4g  %7.4g',fr,a_plateau);
out3=sprintf('  10000  %7.4g ',a_plateau);

disp(out1);
disp(out2);
disp(out3);
disp(' ');

ff=[100 fr 10000]';
aa=[a1 a_plateau a_plateau]';

clampband_srs=[ ff aa ];

assignin('base','clampband_srs',clampband_srs);

disp(' SRS output array:  clampband_srs  ');

fig_num=1;
fmin=100;
fmax=10000;
ppp=clampband_srs;
t_string='Clamp Band Release SRS Q=10';
x_label='Natural Frequency (Hz)';
y_label='Peak Accel (G)';
md=2;

[fig_num,h2]=plot_loglog_function_md_h2(fig_num,x_label,y_label,t_string,ppp,fmin,fmax,md);

msgbox('Results written to Command Window');


% --- Executes on button press in pushbutton_return.
function pushbutton_return_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_return (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

delete(vibrationdata_spacecraft_clampband);


% --- Executes on selection change in listbox_units.
function listbox_units_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_units (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_units contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_units
material_change(hObject, eventdata, handles);

% --- Executes during object creation, after setting all properties.
function listbox_units_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_units (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_material.
function listbox_material_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_material (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_material contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_material
material_change(hObject, eventdata, handles);

% --- Executes during object creation, after setting all properties.
function listbox_material_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_material (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_elastic_modulus_Callback(hObject, eventdata, handles)
% hObject    handle to edit_elastic_modulus (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_elastic_modulus as text
%        str2double(get(hObject,'String')) returns contents of edit_elastic_modulus as a double


% --- Executes during object creation, after setting all properties.
function edit_elastic_modulus_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_elastic_modulus (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_mass_density_Callback(hObject, eventdata, handles)
% hObject    handle to edit_mass_density (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_mass_density as text
%        str2double(get(hObject,'String')) returns contents of edit_mass_density as a double


% --- Executes during object creation, after setting all properties.
function edit_mass_density_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_mass_density (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function material_change(hObject, eventdata, handles)

handles.unit=get(handles.listbox_units,'Value');
handles.material=get(handles.listbox_material,'Value');


if(handles.unit==1)  % English
    
    set(handles.elastic_modulus_text,'String','Elastic Modulus (psi)');    
    set(handles.mass_density_text,'String','Mass Density (lbm/in^3)');
    set(handles.text_diameter,'String','Diameter (in)');
    set(handles.text_area_unit,'String','in^2');    
    set(handles.text_force_unit,'String','lbf');     
    

    if(handles.material==1) % aluminum
        handles.elastic_modulus=1e+007;
        handles.mass_density=0.1;  
    end  

else                 % metric
    
    set(handles.elastic_modulus_text,'String','Elastic Modulus (GPa)');  
    set(handles.mass_density_text,'String','Mass Density (kg/m^3)'); 
    set(handles.text_diameter,'String','Diameter (mm)');
    set(handles.text_area_unit,'String','mm^2');    
    set(handles.text_force_unit,'String','kN');    
    
    
    if(handles.material==1)  % aluminum
        handles.elastic_modulus=70;
        handles.mass_density=  2700;
    end

end

if(handles.material==1)
    ss1=sprintf('%8.4g',handles.elastic_modulus);
    ss2=sprintf('%8.4g',handles.mass_density); 
 
else
    handles.elastic_modulus=0;
    handles.mass_density=   0;
    
    ss1=' ';
    ss2=' ';
end

set(handles.edit_elastic_modulus,'String',ss1);
set(handles.edit_mass_density,'String',ss2);  



function mass_density_edit_Callback(hObject, eventdata, handles)
% hObject    handle to mass_density_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of mass_density_edit as text
%        str2double(get(hObject,'String')) returns contents of mass_density_edit as a double


% --- Executes during object creation, after setting all properties.
function mass_density_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to mass_density_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_diameter_Callback(hObject, eventdata, handles)
% hObject    handle to edit_diameter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_diameter as text
%        str2double(get(hObject,'String')) returns contents of edit_diameter as a double


% --- Executes during object creation, after setting all properties.
function edit_diameter_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_diameter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_beta_Callback(hObject, eventdata, handles)
% hObject    handle to edit_beta (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_beta as text
%        str2double(get(hObject,'String')) returns contents of edit_beta as a double


% --- Executes during object creation, after setting all properties.
function edit_beta_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_beta (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_A_Callback(hObject, eventdata, handles)
% hObject    handle to edit_A (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_A as text
%        str2double(get(hObject,'String')) returns contents of edit_A as a double


% --- Executes during object creation, after setting all properties.
function edit_A_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_A (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_tensile_Callback(hObject, eventdata, handles)
% hObject    handle to edit_tensile (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_tensile as text
%        str2double(get(hObject,'String')) returns contents of edit_tensile as a double


% --- Executes during object creation, after setting all properties.
function edit_tensile_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_tensile (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

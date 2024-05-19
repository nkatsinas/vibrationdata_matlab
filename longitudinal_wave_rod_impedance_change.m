function varargout = longitudinal_wave_rod_impedance_change(varargin)
% LONGITUDINAL_WAVE_ROD_IMPEDANCE_CHANGE MATLAB code for longitudinal_wave_rod_impedance_change.fig
%      LONGITUDINAL_WAVE_ROD_IMPEDANCE_CHANGE, by itself, creates a new LONGITUDINAL_WAVE_ROD_IMPEDANCE_CHANGE or raises the existing
%      singleton*.
%
%      H = LONGITUDINAL_WAVE_ROD_IMPEDANCE_CHANGE returns the handle to a new LONGITUDINAL_WAVE_ROD_IMPEDANCE_CHANGE or the handle to
%      the existing singleton*.
%
%      LONGITUDINAL_WAVE_ROD_IMPEDANCE_CHANGE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in LONGITUDINAL_WAVE_ROD_IMPEDANCE_CHANGE.M with the given input arguments.
%
%      LONGITUDINAL_WAVE_ROD_IMPEDANCE_CHANGE('Property','Value',...) creates a new LONGITUDINAL_WAVE_ROD_IMPEDANCE_CHANGE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before longitudinal_wave_rod_impedance_change_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to longitudinal_wave_rod_impedance_change_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help longitudinal_wave_rod_impedance_change

% Last Modified by GUIDE v2.5 22-Mar-2016 14:10:30

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @longitudinal_wave_rod_impedance_change_OpeningFcn, ...
                   'gui_OutputFcn',  @longitudinal_wave_rod_impedance_change_OutputFcn, ...
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


% --- Executes just before longitudinal_wave_rod_impedance_change is made visible.
function longitudinal_wave_rod_impedance_change_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to longitudinal_wave_rod_impedance_change (see VARARGIN)

% Choose default command line output for longitudinal_wave_rod_impedance_change
handles.output = hObject;

set(hObject, 'Units', 'pixels');
axes(handles.axes1);
bg = imread('longitudinal_impedance.jpg');
info.Width=344;
info.Height=176;
 
axes(handles.axes1);
image(bg);
set(handles.axes1, ...
    'Visible', 'off', ...
    'Units', 'pixels', ...
    'Position', [40 250 info.Width info.Height]);
axis off;

change_material_units(hObject, eventdata, handles);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes longitudinal_wave_rod_impedance_change wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = longitudinal_wave_rod_impedance_change_OutputFcn(hObject, eventdata, handles) 
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

delete(longitudinal_wave_rod_impedance_change);


% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

iu=get(handles.listbox_units,'Value');

A1=str2num(get(handles.edit_A1,'String'));
rho1=str2num(get(handles.edit_rho1,'String'));
E1=str2num(get(handles.edit_E1,'String'));

A2=str2num(get(handles.edit_A2,'String'));
rho2=str2num(get(handles.edit_rho2,'String'));
E2=str2num(get(handles.edit_E2,'String'));

if(iu==1)
   rho1=rho1/386;
   rho2=rho2/386;   
else
   A1=A1/1000^2; 
   A2=A2/1000^2;    
   [em_1]=GPa_to_Pa(em_1);
   [em_2]=GPa_to_Pa(em_2); 
end

c1=sqrt(E1/rho1);
c2=sqrt(E2/rho2);

Z1=A1*sqrt(E1*rho1);
Z2=A2*sqrt(E2*rho2);


stress_transmission_ratio=(Z2/Z1)*(2*Z1)^2/(Z1+Z2)^2;
stress_reflection_ratio=(Z1-Z2)/(Z1+Z2);


if(iu==1)
    c_unit='in/sec';
    z_unit='(lbf-sec)/in';    
else
    c_unit='m/sec';
    z_unit='(N-sec)/m';    
end

disp(' ');
disp(' * * * * * * * ');

disp(' ');
disp(' Longitudinal Wave Speed ');
disp('  ');

out1=sprintf(' Rod 1:  %8.4g %s',c1,c_unit);
out2=sprintf(' Rod 2:  %8.4g %s',c2,c_unit);
disp(out1);
disp(out2);


disp('  ');
disp(' Mechanical Impedance');
disp('  ');

out1=sprintf(' Rod 1:  %8.4g %s',Z1,z_unit);
out2=sprintf(' Rod 2:  %8.4g %s',Z2,z_unit);
disp(out1);
disp(out2);

disp('  ');
disp(' Stress & Velocity Ratios Relative to Incident');
disp('  ');

out1=sprintf('   Transmission:  %8.4g ',stress_transmission_ratio);
out2=sprintf('     Reflection:  %8.4g ',stress_reflection_ratio);
disp(out1);
disp(out2);

disp('  ');
disp('  Power & Energy Ratios Relative to Incident');
disp('  ');

power_reflection_ratio=(stress_reflection_ratio)^2;
power_transmission_ratio=1-power_reflection_ratio;


out1=sprintf('   Transmission:  %8.4g ',power_transmission_ratio);
out2=sprintf('     Reflection:  %8.4g ',power_reflection_ratio);
disp(out1);
disp(out2);



msgbox('Results written to Command Window');


function edit_A1_Callback(hObject, eventdata, handles)
% hObject    handle to edit_A1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_A1 as text
%        str2double(get(hObject,'String')) returns contents of edit_A1 as a double


% --- Executes during object creation, after setting all properties.
function edit_A1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_A1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_A2_Callback(hObject, eventdata, handles)
% hObject    handle to edit_A2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_A2 as text
%        str2double(get(hObject,'String')) returns contents of edit_A2 as a double


% --- Executes during object creation, after setting all properties.
function edit_A2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_A2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_rho1_Callback(hObject, eventdata, handles)
% hObject    handle to edit_rho1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_rho1 as text
%        str2double(get(hObject,'String')) returns contents of edit_rho1 as a double


% --- Executes during object creation, after setting all properties.
function edit_rho1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_rho1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_rho2_Callback(hObject, eventdata, handles)
% hObject    handle to edit_rho2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_rho2 as text
%        str2double(get(hObject,'String')) returns contents of edit_rho2 as a double


% --- Executes during object creation, after setting all properties.
function edit_rho2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_rho2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_E1_Callback(hObject, eventdata, handles)
% hObject    handle to edit_E1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_E1 as text
%        str2double(get(hObject,'String')) returns contents of edit_E1 as a double


% --- Executes during object creation, after setting all properties.
function edit_E1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_E1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_E2_Callback(hObject, eventdata, handles)
% hObject    handle to edit_E2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_E2 as text
%        str2double(get(hObject,'String')) returns contents of edit_E2 as a double


% --- Executes during object creation, after setting all properties.
function edit_E2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_E2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_units.
function listbox_units_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_units (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_units contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_units

change_material_units(hObject, eventdata, handles);


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

function change_material_units(hObject, eventdata, handles)


iu=get(handles.listbox_units,'Value');

if(iu==1)
    set(handles.text_area,'String','Cross-section Area (in^2)');
    set(handles.text_rho,'String','Mass Density  (lbm/in^3)');
    set(handles.text_E,'String','Elastic Modulus (psi)');
else
    set(handles.text_area,'String','Cross-section Area (mm^2)');
    set(handles.text_rho,'String','Mass Density  (kg/m^3)');
    set(handles.text_E,'String','Elastic Modulus (GPa)');     
end

%%%%%%%%

imat1=get(handles.listbox_material_1,'Value');

[elastic_modulus,mass_density,poisson]=six_materials(iu,imat1);
 
if(imat1<=6)
        ss1=sprintf('%8.4g',elastic_modulus);
        ss2=sprintf('%8.4g',mass_density);
else
        ss1=' ';
        ss2=' ';
end
 
set(handles.edit_E1,'String',ss1);
set(handles.edit_rho1,'String',ss2);

%%%%%%%%

imat2=get(handles.listbox_material_2,'Value');

[elastic_modulus,mass_density,~]=six_materials(iu,imat2);
 
if(imat2<=6)
        ss1=sprintf('%8.4g',elastic_modulus);
        ss2=sprintf('%8.4g',mass_density);
else
        ss1=' ';
        ss2=' ';
end
 
set(handles.edit_E2,'String',ss1);
set(handles.edit_rho2,'String',ss2);

%%%%%%%%



% --- Executes on selection change in listbox_material_1.
function listbox_material_1_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_material_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_material_1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_material_1
change_material_units(hObject, eventdata, handles);

% --- Executes during object creation, after setting all properties.
function listbox_material_1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_material_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_material_2.
function listbox_material_2_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_material_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_material_2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_material_2
change_material_units(hObject, eventdata, handles);

% --- Executes during object creation, after setting all properties.
function listbox_material_2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_material_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

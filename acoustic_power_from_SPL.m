function varargout = acoustic_power_from_SPL(varargin)
% ACOUSTIC_POWER_FROM_SPL MATLAB code for acoustic_power_from_SPL.fig
%      ACOUSTIC_POWER_FROM_SPL, by itself, creates a new ACOUSTIC_POWER_FROM_SPL or raises the existing
%      singleton*.
%
%      H = ACOUSTIC_POWER_FROM_SPL returns the handle to a new ACOUSTIC_POWER_FROM_SPL or the handle to
%      the existing singleton*.
%
%      ACOUSTIC_POWER_FROM_SPL('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ACOUSTIC_POWER_FROM_SPL.M with the given input arguments.
%
%      ACOUSTIC_POWER_FROM_SPL('Property','Value',...) creates a new ACOUSTIC_POWER_FROM_SPL or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before acoustic_power_from_SPL_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to acoustic_power_from_SPL_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help acoustic_power_from_SPL

% Last Modified by GUIDE v2.5 22-Sep-2017 16:40:46

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @acoustic_power_from_SPL_OpeningFcn, ...
                   'gui_OutputFcn',  @acoustic_power_from_SPL_OutputFcn, ...
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


% --- Executes just before acoustic_power_from_SPL is made visible.
function acoustic_power_from_SPL_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to acoustic_power_from_SPL (see VARARGIN)

% Choose default command line output for acoustic_power_from_SPL
handles.output = hObject;

change(hObject, eventdata, handles);

set(handles.pushbutton_vr,'Visible','off');

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes acoustic_power_from_SPL wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = acoustic_power_from_SPL_OutputFcn(hObject, eventdata, handles) 
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

delete(acoustic_power_from_SPL);


% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

disp('  ');
disp(' * * * * * * * ');
disp('  ');

iu=get(handles.listbox_units,'Value');


gas_mass_density=str2num(get(handles.edit_gas_mass_density,'String'));
setappdata(0,'gas_mass_density',gas_mass_density);

c=str2num(get(handles.edit_c,'String'));

mass_dens=str2num(get(handles.edit_mdens,'String')); 

c_orig=c;
mass_dens_orig=mass_dens;

if(iu==1)
    c=c*0.3048;                  % convert from ft/sec    to  m/sec
    mass_dens=mass_dens*4.8816 ; % convert from lbm/ft^2  to  kg/m^2
end


try  
    FS=get(handles.edit_input_array,'String');
    THM=evalin('base',FS);  
catch  
    warndlg('Input Array does not exist.  Try again.')
    return;
end

sz=size(THM);

if(sz(2)~=4)
   warndlg('Input array must have four columns'); 
   return; 
end

num=sz(1);

        fc=THM(:,1);
       spl=THM(:,2);
       rad=THM(:,3);
modal_dens=THM(:,4);

   power=zeros(num,1);
power_dB=zeros(num,1);

pressure_ref=20e-06;

power_ref=1.0e-12;

out1=sprintf('\n  c = %8.4g m/sec ',c);
disp(out1);
out1=sprintf('\n  mass density = %8.4g kg/m^2 \n',mass_dens);
disp(out1);

disp(' Zero dB References: ');
disp('   Pressure 20 micro Pa');
disp('   Power     1 pico Watt ');
disp(' ');

disp('   fc    SPL    Power  ');
disp('  (Hz)   (dB)    (dB)  ');

dB=spl;
mass_per_area=mass_dens;
rad_eff=rad;

for i=1:num
    
%    pressure=pressure_ref*10^(spl(i)/20);
%    den=mass_dens*(4*pi*fc(i)^2);
%    power(i)=c^2*rad(i)*pressure^2*modal_dens(i)/den;   
%    power_dB(i)=10*log10(power(i)/power_ref);
    
    [power(i),power_dB(i)]=power_from_spl_dB(fc(i),dB(i),modal_dens(i),c,mass_per_area,rad_eff(i));
    
    out1=sprintf('%7.1f  %6.1f  %6.1f',fc(i),spl(i),power_dB(i));
    disp(out1);
end

[oadb]=oaspl_function(power_dB);

data=[fc power_dB];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

setappdata(0,'fc',fc);
setappdata(0,'spl',spl);
setappdata(0,'rad',rad);
setappdata(0,'modal_dens',modal_dens);
setappdata(0,'iu',iu);
setappdata(0,'power_dB',power_dB);
setappdata(0,'c_orig',c_orig);
setappdata(0,'mass_dens_orig',mass_dens_orig);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

jf=1;

for i=num:-1:1
   if(modal_dens(i)<1.0e-20 || power_dB(i)<1.0e-20 )
       jf=i+1;
       break;
   end
end


ppp=[fc(jf:num) power(jf:num)];
fmin=min(fc);
fmax=max(fc);

fig_num=1;

t_string=sprintf('Acoustic Power');
x_label='Center Frequency (Hz)';
y_label='Power (W)';
[fig_num,h2]=plot_loglin_function_h2_yfree(fig_num,x_label,y_label,t_string,ppp,fmin,fmax);


%%%


ppp=[fc(jf:num) power_dB(jf:num)];

t_string=sprintf('Acoustic Power   Overall Level=%7.1f dB \n (ref 1 pico Watt)',oadb);
x_label='Center Frequency (Hz)';
y_label='Power (dB)';
[fig_num,h2]=plot_loglin_function_h2_yfree(fig_num,x_label,y_label,t_string,ppp,fmin,fmax);


try
    output_name=get(handles.edit_output_array,'String');
    assignin('base', output_name, data);
catch
    warndlg('Output failed. Check output array name.');
    return;
end

h = msgbox('Save Complete'); 

set(handles.pushbutton_vr,'Visible','on');

% --- Executes on selection change in listbox_system.
function listbox_system_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_system (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_system contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_system

change(hObject, eventdata, handles);


% --- Executes during object creation, after setting all properties.
function listbox_system_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_system (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
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
change(hObject, eventdata, handles);

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

function change(hObject, eventdata, handles)
%
iu=get(handles.listbox_units,'Value');

    % acoustic
  
    if(iu==1)
        set(handles.text_mdens,'String','Mass/Area (lbm/ft^2)');
        set(handles.text_gas_c,'String','Gas Speed of Sound (ft/sec)');         
        set(handles.edit_c,'String','1125');     
        set(handles.text_gas_mass_density,'String','Gas Mass Density (lbm/ft^3)');
        set(handles.edit_gas_mass_density,'String','0.076487');    
    else
        set(handles.text_mdens,'String','Mass/Area (kg/m^2)');        
        set(handles.text_gas_c,'String','Gas Speed of Sound (m/sec)');        
        set(handles.edit_c,'String','343');     
        set(handles.text_gas_mass_density,'String','Gas Mass Density (kg/m^3)'); 
        set(handles.edit_gas_mass_density,'String','1.225');           
    end   

set(handles.pushbutton_vr,'Visible','off');


function edit_velox_Callback(hObject, eventdata, handles)
% hObject    handle to edit_velox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_velox as text
%        str2double(get(hObject,'String')) returns contents of edit_velox as a double


% --- Executes during object creation, after setting all properties.
function edit_velox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_velox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_mass_Callback(hObject, eventdata, handles)
% hObject    handle to edit_mass (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_mass as text
%        str2double(get(hObject,'String')) returns contents of edit_mass as a double


% --- Executes during object creation, after setting all properties.
function edit_mass_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_mass (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on key press with focus on edit_velox and none of its controls.
function edit_velox_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_velox (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)

change(hObject, eventdata, handles);


% --- Executes on key press with focus on edit_mass and none of its controls.
function edit_mass_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_mass (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
change(hObject, eventdata, handles);



function edit_energy_Callback(hObject, eventdata, handles)
% hObject    handle to edit_energy (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_energy as text
%        str2double(get(hObject,'String')) returns contents of edit_energy as a double


% --- Executes during object creation, after setting all properties.
function edit_energy_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_energy (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_1_Callback(hObject, eventdata, handles)
% hObject    handle to edit_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_1 as text
%        str2double(get(hObject,'String')) returns contents of edit_1 as a double


% --- Executes during object creation, after setting all properties.
function edit_1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_pressure.
function listbox_pressure_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_pressure (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_pressure contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_pressure
change(hObject, eventdata, handles);

% --- Executes during object creation, after setting all properties.
function listbox_pressure_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_pressure (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_pressure_Callback(hObject, eventdata, handles)
% hObject    handle to edit_pressure (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_pressure as text
%        str2double(get(hObject,'String')) returns contents of edit_pressure as a double


% --- Executes during object creation, after setting all properties.
function edit_pressure_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_pressure (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_volume_Callback(hObject, eventdata, handles)
% hObject    handle to edit_volume (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_volume as text
%        str2double(get(hObject,'String')) returns contents of edit_volume as a double


% --- Executes during object creation, after setting all properties.
function edit_volume_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_volume (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_gas.
function listbox_gas_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_gas (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_gas contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_gas
change(hObject, eventdata, handles);

% --- Executes during object creation, after setting all properties.
function listbox_gas_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_gas (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_gas_md_Callback(hObject, eventdata, handles)
% hObject    handle to edit_gas_md (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_gas_md as text
%        str2double(get(hObject,'String')) returns contents of edit_gas_md as a double


% --- Executes during object creation, after setting all properties.
function edit_gas_md_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_gas_md (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_c_Callback(hObject, eventdata, handles)
% hObject    handle to edit_c (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_c as text
%        str2double(get(hObject,'String')) returns contents of edit_c as a double


% --- Executes during object creation, after setting all properties.
function edit_c_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_c (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit10_Callback(hObject, eventdata, handles)
% hObject    handle to edit_pressure (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_pressure as text
%        str2double(get(hObject,'String')) returns contents of edit_pressure as a double


% --- Executes during object creation, after setting all properties.
function edit10_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_pressure (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on key press with focus on edit_energy and none of its controls.
function edit_energy_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_energy (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.uipanel_pressure,'Visible','off');


% --- Executes on key press with focus on edit_volume and none of its controls.
function edit_volume_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_volume (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.uipanel_pressure,'Visible','off');


% --- Executes on key press with focus on edit_gas_md and none of its controls.
function edit_gas_md_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_gas_md (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.uipanel_pressure,'Visible','off');


% --- Executes on key press with focus on edit_c and none of its controls.
function edit_c_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_c (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.uipanel_pressure,'Visible','off');


% --- Executes on button press in pushbutton_eq.
function pushbutton_eq_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_eq (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

A = imread('equivalent_acoustic_power_cylinder.jpg');
figure(990) 
imshow(A,'border','tight','InitialMagnification',100); 



% --- Executes during object creation, after setting all properties.
function pushbutton_calculate_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called



function edit_mdens_Callback(hObject, eventdata, handles)
% hObject    handle to edit_mdens (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_mdens as text
%        str2double(get(hObject,'String')) returns contents of edit_mdens as a double


% --- Executes during object creation, after setting all properties.
function edit_mdens_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_mdens (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_input_array_Callback(hObject, eventdata, handles)
% hObject    handle to edit_input_array (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_input_array as text
%        str2double(get(hObject,'String')) returns contents of edit_input_array as a double


% --- Executes during object creation, after setting all properties.
function edit_input_array_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_input_array (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_output_array_Callback(hObject, eventdata, handles)
% hObject    handle to edit_output_array (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_output_array as text
%        str2double(get(hObject,'String')) returns contents of edit_output_array as a double


% --- Executes during object creation, after setting all properties.
function edit_output_array_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_output_array (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_vr.
function pushbutton_vr_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_vr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.s=acoustic_power_vibration_response;
set(handles.s,'Visible','on'); 



function edit_gas_mass_density_Callback(hObject, eventdata, handles)
% hObject    handle to edit_gas_mass_density (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_gas_mass_density as text
%        str2double(get(hObject,'String')) returns contents of edit_gas_mass_density as a double


% --- Executes during object creation, after setting all properties.
function edit_gas_mass_density_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_gas_mass_density (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

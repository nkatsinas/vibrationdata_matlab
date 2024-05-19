function varargout = vibrationdata_stress_velocity(varargin)
% VIBRATIONDATA_STRESS_VELOCITY MATLAB code for vibrationdata_stress_velocity.fig
%      VIBRATIONDATA_STRESS_VELOCITY, by itself, creates a new VIBRATIONDATA_STRESS_VELOCITY or raises the existing
%      singleton*.
%
%      H = VIBRATIONDATA_STRESS_VELOCITY returns the handle to a new VIBRATIONDATA_STRESS_VELOCITY or the handle to
%      the existing singleton*.
%
%      VIBRATIONDATA_STRESS_VELOCITY('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in VIBRATIONDATA_STRESS_VELOCITY.M with the given input arguments.
%
%      VIBRATIONDATA_STRESS_VELOCITY('Property','Value',...) creates a new VIBRATIONDATA_STRESS_VELOCITY or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before vibrationdata_stress_velocity_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to vibrationdata_stress_velocity_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help vibrationdata_stress_velocity

% Last Modified by GUIDE v2.5 13-Jan-2018 11:04:06

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @vibrationdata_stress_velocity_OpeningFcn, ...
                   'gui_OutputFcn',  @vibrationdata_stress_velocity_OutputFcn, ...
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


% --- Executes just before vibrationdata_stress_velocity is made visible.
function vibrationdata_stress_velocity_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to vibrationdata_stress_velocity (see VARARGIN)

% Choose default command line output for vibrationdata_stress_velocity
handles.output = hObject;

listbox_cross_section_Callback(hObject, eventdata, handles);

material_change(hObject, eventdata, handles);
listbox_structure_Callback(hObject, eventdata, handles);
clear_results(hObject, eventdata, handles);



% Update handles structure
guidata(hObject, handles);

% UIWAIT makes vibrationdata_stress_velocity wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = vibrationdata_stress_velocity_OutputFcn(hObject, eventdata, handles) 
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

delete(vibrationdata_stress_velocity);


function clear_results(hObject, eventdata, handles)
%
ss='';

set(handles.edit_stress,'String',ss);
set(handles.edit_wavespeed,'String','');


% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


v=str2num(get(handles.edit_v,'String'));

if(isempty(v))
    warndlg('Enter Peak Modal Velocity');
    return;
end


n_structure=get(handles.listbox_structure,'Value');
iu=get(handles.listbox_units,'Value');
n_mat=get(handles.materials_listbox,'Value');

E=str2num(get(handles.elastic_modulus_edit,'String'));
rho=str2num(get(handles.mass_density_edit,'String'));

if(iu==1)
    rho=rho/386;
else    
    [E]=GPa_to_Pa(E);
end

c=sqrt(E/rho);

rho_c=rho*c;

sc=sprintf('%8.4g',c);

set(handles.edit_wavespeed,'String',sc);

if(n_structure==1) % beam bending
    
    c_hat=str2num(get(handles.edit_c,'String'));

    stress=c_hat*rho_c*v;
    
    set(handles.text_c1,'Visible','on');
    set(handles.edit_c,'Visible','on');    

end
if(n_structure==2) % beam longitudinal
    
    stress=rho_c*v;

end
if(n_structure==3) % plate
    c_hat=str2num(get(handles.edit_c,'String')); 
    stress=c_hat*rho_c*v;  
end
if(n_structure==4) % complex equipment
    
    Lx=str2num(get(handles.edit_Lx,'String'));
    Ly=str2num(get(handles.edit_Ly,'String'));
    mu=str2num(get(handles.edit_mu,'String'));
    
    Lx2=Lx^2;
    Ly2=Ly^2;
    
    den=Lx2+Ly2;
    
    term0=rho_c*v;
    
    term1=sqrt(3/(1-mu^2));
    termx=( Ly2+mu*Lx2)/den;
    termy=( Lx2+mu*Ly2)/den;    
    
    stress1=term1*termx;   
    stress2=term1*termy; 

    
    stress=term0*(max([stress1 stress2]));
    
end
if(n_structure==5) % complex equipment
    c_hat=str2num(get(handles.edit_c,'String')); 
    stress=c_hat*rho_c*v;    
end

ss=sprintf('%8.5g',stress);
set(handles.edit_stress,'String',ss);

if(iu==1)
    ss2=sprintf('%8.5g',stress/1000);    
else
    ss2=sprintf('%8.5g',stress/1000^2);    
end

set(handles.edit_stress2,'String',ss2);

set(handles.uipanel_results,'Visible','on');


% --- Executes on selection change in listbox_units.
function listbox_units_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_units (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_units contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_units

material_change(hObject, eventdata, handles);
clear_results(hObject, eventdata, handles);

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


% --- Executes on selection change in materials_listbox.
function materials_listbox_Callback(hObject, eventdata, handles)
% hObject    handle to materials_listbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns materials_listbox contents as cell array
%        contents{get(hObject,'Value')} returns selected item from materials_listbox
material_change(hObject, eventdata, handles);
clear_results(hObject, eventdata, handles);

% --- Executes during object creation, after setting all properties.
function materials_listbox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to materials_listbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function elastic_modulus_edit_Callback(hObject, eventdata, handles)
% hObject    handle to elastic_modulus_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of elastic_modulus_edit as text
%        str2double(get(hObject,'String')) returns contents of elastic_modulus_edit as a double


% --- Executes during object creation, after setting all properties.
function elastic_modulus_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to elastic_modulus_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



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


function material_change(hObject, eventdata, handles)

set(handles.uipanel_results,'Visible','off');

handles.unit=get(handles.listbox_units,'Value');
handles.material=get(handles.materials_listbox,'Value');



if(handles.unit==1)  % English
    
    set(handles.elastic_modulus_text,'String','Elastic Modulus (psi)');    
    set(handles.mass_density_text,'String','Mass Density (lbm/in^3)');
    set(handles.wavespeed_text,'String','Wavespeed (in/sec)');
    set(handles.text_vu,'String','in/sec');
    set(handles.text_stress,'String','Max Stress (psi)'); 
    set(handles.text_stress2,'String','Max Stress (ksi)');    
    set(handles.text_Lxu,'String','in');
    set(handles.text_Lyu,'String','in');
    
    
    if(handles.material==1) % aluminum
        handles.elastic_modulus=1e+007;
        handles.mass_density=0.1;  
    end  
    if(handles.material==2)  % steel
        handles.elastic_modulus=3e+007;
        handles.mass_density= 0.28;         
    end
    if(handles.material==3)  % copper
        handles.elastic_modulus=1.6e+007;
        handles.mass_density=  0.322;
    end
else                 % metric
    
    set(handles.elastic_modulus_text,'String','Elastic Modulus (GPa)');  
    set(handles.mass_density_text,'String','Mass Density (kg/m^3)');
    set(handles.wavespeed_text,'String','Wavespeed (m/sec)');
    set(handles.text_vu,'String','m/sec');
    set(handles.text_stress,'String','Max Stress (Pa)');       
    set(handles.text_stress2,'String','Max Stress (MPa)'); 
    set(handles.text_Lxu,'String','m');
    set(handles.text_Lyu,'String','m');    
    
    if(handles.material==1)  % aluminum
        handles.elastic_modulus=70;
        handles.mass_density=  2700;
    end
    if(handles.material==2)  % steel
        handles.elastic_modulus=205;
        handles.mass_density=  7700;        
    end
    if(handles.material==3)   % copper
        handles.elastic_modulus=110;
        handles.mass_density=  8900;
    end
end

if(handles.material<=3)
    ss1=sprintf('%8.4g',handles.elastic_modulus);
    ss2=sprintf('%8.4g',handles.mass_density); 
 
else
    handles.elastic_modulus=0;
    handles.mass_density=   0;
    
    ss1=' ';
    ss2=' ';
end

set(handles.elastic_modulus_edit,'String',ss1);
set(handles.mass_density_edit,'String',ss2);  



% --- Executes on selection change in listbox_structure.
function listbox_structure_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_structure (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_structure contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_structure
set(handles.uipanel_results,'Visible','off');

n=get(handles.listbox_structure,'Value');

set(handles.text_aux,'String',' ');

set(handles.listbox_cross_section,'Visible','off');

set(handles.text_c1,'Visible','off');
set(handles.text_c2,'Visible','off');
set(handles.edit_c,'Visible','off');


set(handles.text_Lx,'Visible','off');
set(handles.edit_Lx,'Visible','off');
set(handles.text_Lxu,'Visible','off');
set(handles.text_Ly,'Visible','off');
set(handles.edit_Ly,'Visible','off');
set(handles.text_Lyu,'Visible','off');

if(n==1)
    set(handles.text_aux,'String','Cross Section');
    set(handles.listbox_cross_section,'Visible','on');
    
    set(handles.text_c1,'Visible','on');
    set(handles.edit_c,'Visible','on');   
    
end
if(n==3)
    set(handles.text_c1,'Visible','on');
    set(handles.edit_c,'Visible','on'); 
    set(handles.edit_c,'String','2');    
end
if(n==4)
    set(handles.text_Lx,'Visible','on');
    set(handles.edit_Lx,'Visible','on');
    set(handles.text_Lxu,'Visible','on');
    set(handles.text_Ly,'Visible','on');
    set(handles.edit_Ly,'Visible','on');
    set(handles.text_Lyu,'Visible','on');
end
if(n==5)
    set(handles.text_c1,'Visible','on');
    set(handles.text_c2,'Visible','on');
    set(handles.edit_c,'Visible','on'); 
    set(handles.edit_c,'String','8');    
end



% --- Executes during object creation, after setting all properties.
function listbox_structure_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_structure (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on key press with focus on elastic_modulus_edit and none of its controls.
function elastic_modulus_edit_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to elastic_modulus_edit (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.uipanel_results,'Visible','off');


% --- Executes on key press with focus on mass_density_edit and none of its controls.
function mass_density_edit_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to mass_density_edit (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.uipanel_results,'Visible','off');



function edit_wavespeed_Callback(hObject, eventdata, handles)
% hObject    handle to edit_wavespeed (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_wavespeed as text
%        str2double(get(hObject,'String')) returns contents of edit_wavespeed as a double


% --- Executes during object creation, after setting all properties.
function edit_wavespeed_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_wavespeed (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_cross_section.
function listbox_cross_section_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_cross_section (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_cross_section contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_cross_section

    n_cross=get(handles.listbox_cross_section,'Value');
    
    if(n_cross==1)  % solid cylinder
        sss='2';
    end
    if(n_cross==2)  % thin wall pipe
        sss='sqrt(2)';
    end    
    if(n_cross==3)  % rectangular 
        sss='sqrt(3)';        
    end    
  
    
    set(handles.text_c1,'Visible','on');
    set(handles.edit_c,'Visible','on','String',sss);   


set(handles.uipanel_results,'Visible','off');


% --- Executes during object creation, after setting all properties.
function listbox_cross_section_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_cross_section (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_v_Callback(hObject, eventdata, handles)
% hObject    handle to edit_v (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_v as text
%        str2double(get(hObject,'String')) returns contents of edit_v as a double


% --- Executes during object creation, after setting all properties.
function edit_v_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_v (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_stress_Callback(hObject, eventdata, handles)
% hObject    handle to edit_stress (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_stress as text
%        str2double(get(hObject,'String')) returns contents of edit_stress as a double


% --- Executes during object creation, after setting all properties.
function edit_stress_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_stress (see GCBO)
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


% --- Executes on key press with focus on edit_c and none of its controls.
function edit_c_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_c (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.uipanel_results,'Visible','off');


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over edit_v.
function edit_v_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to edit_v (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on key press with focus on edit_v and none of its controls.
function edit_v_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_v (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
clear_results(hObject, eventdata, handles);



function edit_stress2_Callback(hObject, eventdata, handles)
% hObject    handle to edit_stress2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_stress2 as text
%        str2double(get(hObject,'String')) returns contents of edit_stress2 as a double


% --- Executes during object creation, after setting all properties.
function edit_stress2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_stress2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_mu_Callback(hObject, eventdata, handles)
% hObject    handle to edit_mu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_mu as text
%        str2double(get(hObject,'String')) returns contents of edit_mu as a double


% --- Executes during object creation, after setting all properties.
function edit_mu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_mu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_Lx_Callback(hObject, eventdata, handles)
% hObject    handle to edit_Lx (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_Lx as text
%        str2double(get(hObject,'String')) returns contents of edit_Lx as a double


% --- Executes during object creation, after setting all properties.
function edit_Lx_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_Lx (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_Ly_Callback(hObject, eventdata, handles)
% hObject    handle to edit_Ly (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_Ly as text
%        str2double(get(hObject,'String')) returns contents of edit_Ly as a double


% --- Executes during object creation, after setting all properties.
function edit_Ly_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_Ly (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function pushbutton_calculate_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

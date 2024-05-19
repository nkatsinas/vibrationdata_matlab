function varargout = honeycomb_critical_frequency(varargin)
% HONEYCOMB_CRITICAL_FREQUENCY MATLAB code for honeycomb_critical_frequency.fig
%      HONEYCOMB_CRITICAL_FREQUENCY, by itself, creates a new HONEYCOMB_CRITICAL_FREQUENCY or raises the existing
%      singleton*.
%
%      H = HONEYCOMB_CRITICAL_FREQUENCY returns the handle to a new HONEYCOMB_CRITICAL_FREQUENCY or the handle to
%      the existing singleton*.
%
%      HONEYCOMB_CRITICAL_FREQUENCY('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in HONEYCOMB_CRITICAL_FREQUENCY.M with the given input arguments.
%
%      HONEYCOMB_CRITICAL_FREQUENCY('Property','Value',...) creates a new HONEYCOMB_CRITICAL_FREQUENCY or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before honeycomb_critical_frequency_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to honeycomb_critical_frequency_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help honeycomb_critical_frequency

% Last Modified by GUIDE v2.5 18-Feb-2014 12:54:12

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @honeycomb_critical_frequency_OpeningFcn, ...
                   'gui_OutputFcn',  @honeycomb_critical_frequency_OutputFcn, ...
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




% --- Executes just before honeycomb_critical_frequency is made visible.
function honeycomb_critical_frequency_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to honeycomb_critical_frequency (see VARARGIN)

% Choose default command line output for honeycomb_critical_frequency
handles.output = hObject;

set(handles.listbox_unit,'Value',1);
set(handles.listbox_materials,'Value',1);

listbox_unit_Callback(hObject, eventdata, handles);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes honeycomb_critical_frequency wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = honeycomb_critical_frequency_OutputFcn(hObject, eventdata, handles) 
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
delete(honeycomb_critical_frequency);

% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.edit_results,'Visible','on');

n_unit=get(handles.listbox_unit,'Value');

C=str2num(get(handles.edit_C,'String'));

tpi=2*pi;

E=str2num(get(handles.edit_elastic_modulus,'String'));

rho=str2num(get(handles.edit_mass_density,'String'));
core_rho=str2num(get(handles.edit_core_mass_density,'String'));

mu=str2num(get(handles.edit_poisson,'String'));

t1=str2num(get(handles.edit_top_thickness,'String'));
hc=str2num(get(handles.edit_core_thickness,'String'));
t2=str2num(get(handles.edit_bottom_thickness,'String'));


if(n_unit==1)
    rho=rho/386;
    core_rho=core_rho/386;
else
    [E]=GPa_to_Pa(E);
    t1=t1/1000;
    hc=hc/1000;
    t2=t2/1000;
end

h=hc+(1/2)*(t1+t2);

num=t1*t2*h^2;
den=t1+t2;

D=(E/(1-mu^2))*num/den;

G=E/(2*(1+mu));

N=sqrt(5/6)*G*hc*(1+((t1+t2)/hc))^2;
%
rho_area=rho*(t1+t2) + core_rho*hc;
rhoV=rho_area/(t1+t2+hc);
%
A=C^4*rhoV/D;
B=1-(C^2*rhoV/N);
f=(1/tpi)*sqrt(A/B);
%
if(B>0)
   s1=sprintf('%8.4g',f);
   set(handles.edit_results,'String',s1);   
else
   warndlg('Critical Frequency does not exist for this case.','Warning');
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



function edit_core_mass_density_Callback(hObject, eventdata, handles)
% hObject    handle to edit_core_mass_density (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_core_mass_density as text
%        str2double(get(hObject,'String')) returns contents of edit_core_mass_density as a double


% --- Executes during object creation, after setting all properties.
function edit_core_mass_density_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_core_mass_density (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_core_thickness_Callback(hObject, eventdata, handles)
% hObject    handle to edit_core_thickness (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_core_thickness as text
%        str2double(get(hObject,'String')) returns contents of edit_core_thickness as a double


% --- Executes during object creation, after setting all properties.
function edit_core_thickness_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_core_thickness (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_top_thickness_Callback(hObject, eventdata, handles)
% hObject    handle to edit_top_thickness (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_top_thickness as text
%        str2double(get(hObject,'String')) returns contents of edit_top_thickness as a double


% --- Executes during object creation, after setting all properties.
function edit_top_thickness_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_top_thickness (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_bottom_thickness_Callback(hObject, eventdata, handles)
% hObject    handle to edit_bottom_thickness (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_bottom_thickness as text
%        str2double(get(hObject,'String')) returns contents of edit_bottom_thickness as a double


% --- Executes during object creation, after setting all properties.
function edit_bottom_thickness_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_bottom_thickness (see GCBO)
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

clear_results(hObject, eventdata, handles);
n=get(handles.listbox_unit,'Value');

if(n==1)
    set(handles.text_elastic_modulus,'String','lbf/in^2');
    set(handles.text_mass_density,'String','lbm/in^3');
    set(handles.text_speed_c_unit,'String','in/sec');
    set(handles.text_thickness_1,'String','inch');
    set(handles.text_thickness_2,'String','inch');
    set(handles.text_thickness_3,'String','inch'); 
    set(handles.text_core_mass_density,'String','lbm/in^3');
    s1='13500';
else
    set(handles.text_elastic_modulus,'String','GPa');
    set(handles.text_mass_density,'String','kg/m^3');     
    set(handles.text_speed_c_unit,'String','m/sec');  
    set(handles.text_thickness_1,'String','mm');
    set(handles.text_thickness_2,'String','mm');
    set(handles.text_thickness_3,'String','mm');   
    set(handles.text_core_mass_density,'String','kg/m^3');    
    s1='343';
end

set(handles.edit_C,'String',s1);

mat_change(hObject, eventdata, handles);


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



function edit_C_Callback(hObject, eventdata, handles)
% hObject    handle to edit_C (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_C as text
%        str2double(get(hObject,'String')) returns contents of edit_C as a double


% --- Executes during object creation, after setting all properties.
function edit_C_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_C (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_materials.
function listbox_materials_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_materials (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_materials contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_materials
mat_change(hObject, eventdata, handles);

% --- Executes during object creation, after setting all properties.
function listbox_materials_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_materials (see GCBO)
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



function edit_poisson_Callback(hObject, eventdata, handles)
% hObject    handle to edit_poisson (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_poisson as text
%        str2double(get(hObject,'String')) returns contents of edit_poisson as a double


% --- Executes during object creation, after setting all properties.
function edit_poisson_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_poisson (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function clear_results(hObject, eventdata, handles)
%
set(handles.edit_results,'String','');
set(handles.edit_results,'Visible','off');

function mat_change(hObject, eventdata, handles)
%
n_unit=get(handles.listbox_unit,'Value');
n_mat=get(handles.listbox_materials,'Value');
 
if(n_unit==1)  % English
    if(n_mat==1) % aluminum
        handles.elastic_modulus=1e+007;
        handles.mass_density=0.1;  
    end  
    if(n_mat==2)  % steel
        handles.elastic_modulus=3e+007;
        handles.mass_density= 0.28;         
    end
    if(n_mat==3)  % copper
        handles.elastic_modulus=1.6e+007;
        handles.mass_density=  0.322;
    end
    if(n_mat==4)  % G10
        handles.elastic_modulus=2.7e+006;
        handles.mass_density=  0.065;
    end
else                 % metric
    if(n_mat==1)  % aluminum
        handles.elastic_modulus=70;
        handles.mass_density=  2700;
    end
    if(n_mat==2)  % steel
        handles.elastic_modulus=205;
        handles.mass_density=  7700;        
    end
    if(n_mat==3)   % copper
        handles.elastic_modulus=110;
        handles.mass_density=  8900;
    end
end
 
if(n_mat==1) % aluminum
        poisson=0.33;  
end  
if(n_mat==2)  % steel
        poisson= 0.30;         
end
if(n_mat==3)  % copper
        poisson=  0.33;
end
 
if(n_mat<4)
    ss1=sprintf('%8.4g',handles.elastic_modulus);
    ss2=sprintf('%8.4g',handles.mass_density);
    ss3=sprintf('%8.4g',poisson);  
 
    set(handles.edit_elastic_modulus,'String',ss1);
    set(handles.edit_mass_density,'String',ss2);  
    set(handles.edit_poisson,'String',ss3);  
else
    set(handles.edit_elastic_modulus,'String','');
    set(handles.edit_mass_density,'String','');  
    set(handles.edit_poisson,'String','');     
end

clear_results(hObject, eventdata, handles);


% --- Executes on key press with focus on edit_elastic_modulus and none of its controls.
function edit_elastic_modulus_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_elastic_modulus (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
clear_results(hObject, eventdata, handles);


% --- Executes on key press with focus on edit_mass_density and none of its controls.
function edit_mass_density_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_mass_density (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
clear_results(hObject, eventdata, handles);


% --- Executes on key press with focus on edit_poisson and none of its controls.
function edit_poisson_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_poisson (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
clear_results(hObject, eventdata, handles);


% --- Executes on key press with focus on edit_top_thickness and none of its controls.
function edit_top_thickness_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_top_thickness (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
clear_results(hObject, eventdata, handles);


% --- Executes on key press with focus on edit_core_thickness and none of its controls.
function edit_core_thickness_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_core_thickness (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
clear_results(hObject, eventdata, handles);


% --- Executes on key press with focus on edit_bottom_thickness and none of its controls.
function edit_bottom_thickness_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_bottom_thickness (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
clear_results(hObject, eventdata, handles);


% --- Executes on key press with focus on edit_C and none of its controls.
function edit_C_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_C (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
clear_results(hObject, eventdata, handles);


% --- Executes on key press with focus on edit_core_mass_density and none of its controls.
function edit_core_mass_density_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_core_mass_density (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
clear_results(hObject, eventdata, handles);

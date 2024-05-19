function varargout = plate_critical_frequency(varargin)
% PLATE_CRITICAL_FREQUENCY MATLAB code for plate_critical_frequency.fig
%      PLATE_CRITICAL_FREQUENCY, by itself, creates a new PLATE_CRITICAL_FREQUENCY or raises the existing
%      singleton*.
%
%      H = PLATE_CRITICAL_FREQUENCY returns the handle to a new PLATE_CRITICAL_FREQUENCY or the handle to
%      the existing singleton*.
%
%      PLATE_CRITICAL_FREQUENCY('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PLATE_CRITICAL_FREQUENCY.M with the given input arguments.
%
%      PLATE_CRITICAL_FREQUENCY('Property','Value',...) creates a new PLATE_CRITICAL_FREQUENCY or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before plate_critical_frequency_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to plate_critical_frequency_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help plate_critical_frequency

% Last Modified by GUIDE v2.5 17-Feb-2014 16:25:35

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @plate_critical_frequency_OpeningFcn, ...
                   'gui_OutputFcn',  @plate_critical_frequency_OutputFcn, ...
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




% --- Executes just before plate_critical_frequency is made visible.
function plate_critical_frequency_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to plate_critical_frequency (see VARARGIN)

% Choose default command line output for plate_critical_frequency
handles.output = hObject;

set(handles.listbox_unit,'Value',1);
set(handles.listbox_material,'Value',1);
set(handles.listbox_plate_type,'Value',1);

listbox_unit_Callback(hObject, eventdata, handles);
clear_results(hObject, eventdata, handles); 

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes plate_critical_frequency wait for user response (see UIRESUME)
% uiwait(handles.figure1);


function clear_results(hObject, eventdata, handles)
%
set(handles.edit_results,'Visible','off');
set(handles.edit_results,'String',' ');



% --- Outputs from this function are returned to the command line.
function varargout = plate_critical_frequency_OutputFcn(hObject, eventdata, handles) 
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

set(handles.edit_results,'Visible','on');

n_unit=get(handles.listbox_unit,'Value');
n_type=get(handles.listbox_plate_type,'Value');

C=str2num(get(handles.edit_C,'String'));
h=str2num(get(handles.edit_thickness,'String'));
rho=str2num(get(handles.edit_mass_density,'String'));
E=str2num(get(handles.edit_elastic_modulus,'String'));
v=str2num(get(handles.edit_poisson,'String'));

tpi=2*pi;

if(n_unit==1) % English
   rho=rho/386.;
else % metric
   h=h/1000.;
   E=E*10^9;
end


if(n_type==1)  % thin
%    
    num=12*(1-v^2)*rho;
    f=(C^2/(tpi*h))*sqrt(num/E);
%
    s1=sprintf('%8.4g',f);
    set(handles.edit_results,'String',s1);
%
else  % thick
%
    D= E*h^3/(12*(1-v^2));
    G=E/(2*(1+v));
    N=sqrt(5/6)*G*h;
%
    A=C^4*rho/D;
    B=1-(C^2*rho/N);
    f=(1/tpi)*sqrt(A/B);
%
   if(B>0)
     s1=sprintf('%8.4g',f);
     set(handles.edit_results,'String',s1);   
   else
      warndlg('Critical Frequency does not exist for this case.','Warning')
   end
%
end




% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
delete(plate_critical_frequency);

% --- Executes on selection change in listbox_plate_type.
function listbox_plate_type_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_plate_type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_plate_type contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_plate_type
clear_results(hObject, eventdata, handles);

% --- Executes during object creation, after setting all properties.
function listbox_plate_type_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_plate_type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
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
    set(handles.text_thickness_unit,'String','inch');
    set(handles.text_speed_c_unit,'String','in/sec');
    s1='13500';
else
    set(handles.text_elastic_modulus,'String','GPa');
    set(handles.text_mass_density,'String','kg/m^3');    
    set(handles.text_thickness_unit,'String','mm');    
    set(handles.text_speed_c_unit,'String','m/sec');    
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


% --- Executes on selection change in listbox_material.
function listbox_material_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_material (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_material contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_material
clear_results(hObject, eventdata, handles);
mat_change(hObject, eventdata, handles);


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



function edit_thickness_Callback(hObject, eventdata, handles)
% hObject    handle to edit_thickness (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_thickness as text
%        str2double(get(hObject,'String')) returns contents of edit_thickness as a double


% --- Executes during object creation, after setting all properties.
function edit_thickness_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_thickness (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
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


function mat_change(hObject, eventdata, handles)
%
n_unit=get(handles.listbox_unit,'Value');
n_mat=get(handles.listbox_material,'Value');
 
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
    if(n_mat==4)  % G10
        handles.elastic_modulus=18.6;
        handles.mass_density=  1800;
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
if(n_mat==4)  % G10
        poisson=  0.12;
end
 
if(n_mat<5)
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


% --- Executes on key press with focus on edit_elastic_modulus and none of its controls.
function edit_elastic_modulus_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_elastic_modulus (see GCBO)
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


% --- Executes on key press with focus on edit_thickness and none of its controls.
function edit_thickness_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_thickness (see GCBO)
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


% --- Executes on key press with focus on edit_C and none of its controls.
function edit_C_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_C (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
clear_results(hObject, eventdata, handles);

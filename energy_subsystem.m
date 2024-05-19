function varargout = energy_subsystem(varargin)
% ENERGY_SUBSYSTEM MATLAB code for energy_subsystem.fig
%      ENERGY_SUBSYSTEM, by itself, creates a new ENERGY_SUBSYSTEM or raises the existing
%      singleton*.
%
%      H = ENERGY_SUBSYSTEM returns the handle to a new ENERGY_SUBSYSTEM or the handle to
%      the existing singleton*.
%
%      ENERGY_SUBSYSTEM('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ENERGY_SUBSYSTEM.M with the given input arguments.
%
%      ENERGY_SUBSYSTEM('Property','Value',...) creates a new ENERGY_SUBSYSTEM or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before energy_subsystem_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to energy_subsystem_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help energy_subsystem

% Last Modified by GUIDE v2.5 14-Dec-2015 10:51:27

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @energy_subsystem_OpeningFcn, ...
                   'gui_OutputFcn',  @energy_subsystem_OutputFcn, ...
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


% --- Executes just before energy_subsystem is made visible.
function energy_subsystem_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to energy_subsystem (see VARARGIN)

% Choose default command line output for energy_subsystem
handles.output = hObject;

change(hObject, eventdata, handles);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes energy_subsystem wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = energy_subsystem_OutputFcn(hObject, eventdata, handles) 
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

delete(energy_subsystem);


% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

iu=get(handles.listbox_units,'Value');
ns=get(handles.listbox_system,'Value');

if(ns==1)  % mechanical
    
   v=str2num(get(handles.edit_velox,'String'));
   M=str2num(get(handles.edit_mass,'String'));         
    
   if(iu==1)
       M=M/386;       
   else
       v=v/1000;       
   end
   
   E=M*v^2;
   
else       % acoustic
    
   gas_md=str2num(get(handles.edit_gas_md,'String'));
   c=str2num(get(handles.edit_c,'String'));
   V=str2num(get(handles.edit_volume,'String'));
   p=str2num(get(handles.edit_pressure,'String'));
   
   pu=get(handles.listbox_pressure,'Value');
   
   if(pu==1)  % dB
       
       ref=20.0e-06;
       
       p=ref*10^(p/20); % Pa

       if(iu==1)
           p=p*0.020896;
       end
       
   else        
       if(iu==1)
           p=p*144;
       end
   end
   
   
   if(iu==1)
       
        gas_md=gas_md/32.2;
      
   end
   
   E=V*p^2/(gas_md*c^2);
              
end

sss=sprintf('%8.4g',E);

set(handles.edit_energy,'String',sss);

set(handles.uipanel_energy,'Visible','on');


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
ns=get(handles.listbox_system,'Value');

set(handles.uipanel_energy,'Visible','off');

if(iu==1)
   set(handles.text_eu,'String','ft-lbf'); 
else
   set(handles.text_eu,'String','J');     
end



set(handles.text_velox_main,'Visible','off');
set(handles.text_velox,'Visible','off');
set(handles.edit_velox,'Visible','off');
set(handles.text_mass,'Visible','off');
set(handles.edit_mass,'Visible','off');

set(handles.listbox_pressure,'Visible','off');
set(handles.text_pressure,'Visible','off');
set(handles.text_pressure_unit,'Visible','off');
set(handles.text_volume,'Visible','off');
set(handles.text_spu,'Visible','off');
set(handles.edit_pressure,'Visible','off');
set(handles.edit_volume,'Visible','off');
set(handles.text_ssg,'Visible','off');
set(handles.listbox_gas,'Visible','off');
set(handles.text_gas_md,'Visible','off');
set(handles.edit_gas_md,'Visible','off');
set(handles.edit_c,'Visible','off');
set(handles.text_gas_c,'Visible','off');


if(ns==1)  % mechanical
     
   set(handles.text_velox_main,'Visible','on');   
   set(handles.text_velox,'Visible','on');
   set(handles.edit_velox,'Visible','on');
   set(handles.text_mass,'Visible','on');
   set(handles.edit_mass,'Visible','on');    

    
   if(iu==1)
       set(handles.text_velox,'String','(in/sec) rms');
       set(handles.text_mass,'String','Mass (lbm)');       
   else
       set(handles.text_velox,'String','(mm/sec) rms'); 
       set(handles.text_mass,'String','Mass (kg)');       
   end
   
else       % acoustic

   set(handles.listbox_pressure,'Visible','on');
   set(handles.text_pressure,'Visible','on');
   set(handles.text_pressure_unit,'Visible','on');
   set(handles.text_volume,'Visible','on');    
   set(handles.text_spu,'Visible','on');
   set(handles.edit_pressure,'Visible','on');   
   set(handles.edit_volume,'Visible','on');   
   set(handles.text_ssg,'Visible','on');
   set(handles.listbox_gas,'Visible','on');
   set(handles.text_gas_md,'Visible','on');
   set(handles.edit_gas_md,'Visible','on');
   set(handles.edit_c,'Visible','on');
   set(handles.text_gas_c,'Visible','on');   
   
   
    ng=get(handles.listbox_gas,'Value');

    if(iu==1)
        
        set(handles.text_gas_md,'String','Gas Mass Density (lbm/ft^3)'); 
        set(handles.text_gas_c,'String','Gas Speed of Sound (ft/sec)');         

        if(ng==1)
            set(handles.edit_c,'String','1125');
            set(handles.edit_gas_md,'String','0.076487');       
        else
            set(handles.edit_c,'String',' ');   
            set(handles.edit_gas_md,'String',' ');        
        end

    else

        set(handles.text_gas_md,'String','Gas Mass Density (kg/m^3)');    
        set(handles.text_gas_c,'String','Gas Speed of Sound (m/sec)');        
        
        if(ng==1)
            set(handles.edit_c,'String','343');  
            set(handles.edit_gas_md,'String','1.225');         
        else
            set(handles.edit_c,'String',' ');      
            set(handles.edit_gas_md,'String',' ');          
        end    

    end   
   
   nl=get(handles.listbox_pressure,'Value');
   
   if(nl==1)
       set(handles.text_pressure_unit,'String','dB, ref 20 micro Pa');
   end
   
   set(handles.listbox_pressure, 'String','');
   string_pr{1}=sprintf('dB');
   
   if(iu==1)
       
       string_pr{2}=sprintf('psi');    
   
       set(handles.text_volume,'String','Volume (ft^3)');
       
        if(nl==2)
            set(handles.text_pressure_unit,'String','psi rms');
        end
        
   else
       
       string_pr{2}=sprintf('Pa'); 
       
       set(handles.text_volume,'String','Volume (m^3)'); 
       
        if(nl==2)
            set(handles.text_pressure_unit,'String','Pa rms');
        end       
       
   end
   
   set(handles.listbox_pressure,'String',string_pr)   
       
end    
   



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


% --- Executes on button press in pushbutton_eq.
function pushbutton_eq_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_eq (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

A = imread('energy_mass_velox.jpg');
figure(998),imshow(A,'border','tight','InitialMagnification',100)

% --- Executes on button press in pushbutton_eq_aco.
function pushbutton_eq_aco_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_eq_aco (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

A = imread('energy_aco_pressure.jpg');
figure(999),imshow(A,'border','tight','InitialMagnification',100)

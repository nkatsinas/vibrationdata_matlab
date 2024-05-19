function varargout = SDOF_response_unbalance(varargin)
% SDOF_RESPONSE_UNBALANCE MATLAB code for SDOF_response_unbalance.fig
%      SDOF_RESPONSE_UNBALANCE, by itself, creates a new SDOF_RESPONSE_UNBALANCE or raises the existing
%      singleton*.
%
%      H = SDOF_RESPONSE_UNBALANCE returns the handle to a new SDOF_RESPONSE_UNBALANCE or the handle to
%      the existing singleton*.
%
%      SDOF_RESPONSE_UNBALANCE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SDOF_RESPONSE_UNBALANCE.M with the given input arguments.
%
%      SDOF_RESPONSE_UNBALANCE('Property','Value',...) creates a new SDOF_RESPONSE_UNBALANCE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before SDOF_response_unbalance_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to SDOF_response_unbalance_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help SDOF_response_unbalance

% Last Modified by GUIDE v2.5 13-Feb-2014 06:24:17

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @SDOF_response_unbalance_OpeningFcn, ...
                   'gui_OutputFcn',  @SDOF_response_unbalance_OutputFcn, ...
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


% --- Executes just before SDOF_response_unbalance is made visible.
function SDOF_response_unbalance_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to SDOF_response_unbalance (see VARARGIN)

% Choose default command line output for SDOF_response_unbalance
handles.output = hObject;

set(handles.listbox_units,'Value',1);
set(handles.listbox_input_pair,'Value',1);
set(handles.listbox_excitation_frequency_unit,'Value',1);

clear_results(hObject, eventdata, handles);

listbox_units_Callback(hObject, eventdata, handles);

force_lbf=getappdata(0,'force_lbf');
    force_N=getappdata(0,'force_N');

set(handles.edit_damping,'String','0.05');    

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes SDOF_response_unbalance wait for user response (see UIRESUME)
% uiwait(handles.figure1);


function clear_results(hObject, eventdata, handles) 
%
set(handles.edit_displacement,'Visible','off');
set(handles.edit_velocity,'Visible','off');
set(handles.edit_acceleration,'Visible','off');
set(handles.edit_transmitted_force,'Visible','off');

set(handles.edit_displacement,'String',' ');
set(handles.edit_velocity,'String',' ');
set(handles.edit_acceleration,'String',' ');
set(handles.edit_transmitted_force,'String',' ');

set(handles.text_displacement,'Visible','off');
set(handles.text_velocity,'Visible','off');
set(handles.text_acceleration,'Visible','off');
set(handles.text_transmitted_force,'Visible','off');

set(handles.text_severity,'Visible','off');
set(handles.text_severity_1,'Visible','off');
set(handles.text_severity_2,'Visible','off');




% --- Outputs from this function are returned to the command line.
function varargout = SDOF_response_unbalance_OutputFcn(hObject, eventdata, handles) 
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

n=get(handles.listbox_units,'Value');

n_pair=get(handles.listbox_input_pair,'Value');

n_ext_freq=get(handles.listbox_excitation_frequency_unit,'Value');


force_lbf=getappdata(0,'force_lbf');
  force_N=getappdata(0,'force_N');
    

tpi=2*pi;
    
if(n_pair==1 || n_pair==2)
    mass=str2num(get(handles.edit_mass,'String'));
    if(n==1)
        mass=mass/386;
    end
end

if(n_pair==1 || n_pair==3)
    fn=str2num(get(handles.edit_natural_frequency,'String'));
    omegan=tpi*fn;
end

if(n_pair==2 || n_pair==3)
    stiffness=str2num(get(handles.edit_stiffness,'String'));
    if(n==2)
        stiffness=stiffness*1000;
    end    
end


if(n_pair==1)
    stiffness=mass*omegan^2;
    if(n==1)
        ss=sprintf('%8.4g',stiffness);
    else    
        stiff_Npmm=stiffness/1000;
        ss=sprintf('%8.4g',stiff_Npmm);
    end    
    set(handles.uipanel_enter_stiffness,'Visible','on');
    set(handles.edit_stiffness,'Visible','on');
    set(handles.edit_stiffness,'Enable','off');
    set(handles.edit_stiffness,'String',ss);        
end

if(n_pair==2)
    fn=sqrt(stiffness/mass)/tpi;
    omegan=tpi*fn;
    set(handles.uipanel_enter_natural_frequency,'Visible','on');
    set(handles.edit_natural_frequency,'Visible','on');
    set(handles.edit_natural_frequency,'Enable','off');
    sf=sprintf('%8.4g',fn);
    set(handles.edit_natural_frequency,'String',sf);    
end

if(n_pair==3)
    mass=stiffness/omegan^2;
    if(n==1)
        mass=mass*386;
    end
    set(handles.uipanel_enter_mass,'Visible','on');
    set(handles.edit_mass,'Visible','on');
    set(handles.edit_mass,'Enable','off');
    sm=sprintf('%8.4g',mass);
    set(handles.edit_mass,'String',sm);       
end

damp=str2num(get(handles.edit_damping,'String'));

f=str2num(get(handles.edit_excitation_frequency,'String'));

if(n_ext_freq==1)
   fext=f; 
else    
   fext=f/60;
end



omega=tpi*fext;



set(handles.edit_displacement,'Visible','on');
set(handles.edit_velocity,'Visible','on');
set(handles.edit_acceleration,'Visible','on');
set(handles.edit_transmitted_force,'Visible','on');

set(handles.text_displacement,'Visible','on');
set(handles.text_velocity,'Visible','on');
set(handles.text_acceleration,'Visible','on');
set(handles.text_transmitted_force,'Visible','on');

rho=omega/omegan;

if(n==1)
   ff=force_lbf;
else
   ff=force_N; 
end


den=sqrt( ( 1-rho^2 )^2 + (2*damp*rho)^2 );


d=(ff/stiffness)/den;

num=sqrt(1+(2*damp*rho)^2);

tf=ff*num/den;

v=omega*d;

a=omega^2*d;

if(n==2)
    d=d*1000;
end

if(n==1)
    a=a/386;
else
    a=a/9.81;
end

sd=sprintf('%8.4g',d);
sv=sprintf('%8.4g',v);
sa=sprintf('%8.4g',a);
stf=sprintf('%8.4g',tf);

set(handles.edit_displacement,'String',sd);
set(handles.edit_velocity,'String',sv);
set(handles.edit_acceleration,'String',sa);
set(handles.edit_transmitted_force,'String',stf);

set(handles.text_severity,'Visible','on');
set(handles.text_severity_1,'Visible','on');
set(handles.text_severity_2,'Visible','on');

if(n==2)
    v=v*39.37;
end

L=zeros(8,1);

L(1)=0.0049;
for i=2:8
    L(i)=L(i-1)*2;
end

if(v<L(1))
    s1='General Machine Vibration: Extremely Smooth';
end
if(L(1)<=v && v<L(2))
    s1='General Machine Vibration: Very Smooth';    
end
if(L(2)<=v && v<L(3))
    s1='General Machine Vibration: Smooth';        
end
if(L(3)<=v && v<L(4))
    s1='General Machine Vibration: Very Good';         
end
if(L(4)<=v && v<L(5))
    s1='General Machine Vibration: Good';      
end
if(L(5)<=v && v<L(6))
    s1='General Machine Vibration: Fair';      
end
if(L(6)<=v && v<L(7))
    s1='General Machine Vibration: Slightly Rough';     
end
if(L(7)<=v && v<L(8))
    s1='General Machine Vibration: Rough';        
end
if(v>=L(8))
    s1='General Machine Vibration: Very Rough';     
end


set(handles.text_severity_1,'String',s1);



P=zeros(8,1);

P(1)=0.001;
for i=2:8
    P(i)=P(i-1)*2;
end


if(v<P(1))
    s2='Machine Tool Vibration: Extremely Smooth';
end
if(P(1)<=v && v<P(2))
    s2='Machine Tool Vibration: Very Smooth';    
end
if(P(2)<=v && v<P(3))
    s2='Machine Tool Vibration: Smooth';        
end
if(P(3)<=v && v<P(4))
    s2='Machine Tool Vibration: Very Good';         
end
if(P(4)<=v && v<P(5))
    s2='Machine Tool Vibration: Good';      
end
if(P(5)<=v && v<P(6))
    s2='Machine Tool Vibration: Fair';      
end
if(P(6)<=v && v<P(7))
    s2='Machine Tool Vibration: Slightly Rough';     
end
if(P(7)<=v && v<P(8))
    s2='Machine Tool Vibration: Rough';        
end
if(v>=P(8))
    s2='Machine Tool Vibration: Very Rough';     
end


set(handles.text_severity_2,'String',s2);




% --- Executes on selection change in listbox_input_pair.
function listbox_input_pair_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_input_pair (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_input_pair contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_input_pair
clear_results(hObject, eventdata, handles);

n=get(handles.listbox_input_pair,'Value');

set(handles.uipanel_enter_stiffness,'Visible','on');
set(handles.uipanel_enter_natural_frequency,'Visible','on');
set(handles.uipanel_enter_mass,'Visible','on');

set(handles.edit_stiffness,'Visible','on');
set(handles.edit_natural_frequency,'Visible','on');
set(handles.edit_mass,'Visible','on');

set(handles.edit_natural_frequency,'Enable','on');
set(handles.edit_mass,'Enable','on');
set(handles.edit_stiffness,'Enable','on');
    
if(n==1)
   set(handles.uipanel_enter_stiffness,'Visible','off');
   set(handles.edit_stiffness,'Visible','off');   
end
if(n==2)
   set(handles.uipanel_enter_natural_frequency,'Visible','off');
   set(handles.edit_natural_frequency,'Visible','off');   
end
if(n==3)
    set(handles.uipanel_enter_mass,'Visible','off');
    set(handles.edit_mass,'Visible','off');    
end


% --- Executes during object creation, after setting all properties.
function listbox_input_pair_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_input_pair (see GCBO)
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
listbox_input_pair_Callback(hObject, eventdata, handles);
clear_results(hObject, eventdata, handles);

n=get(handles.listbox_units,'Value');


force_lbf=getappdata(0,'force_lbf');
  force_N=getappdata(0,'force_N');

if(n==1)
    set(handles.uipanel_unbalance_force,'Title','Unbalance Force (lbf)');
    s1=sprintf('%8.4g',force_lbf);    
    set(handles.uipanel_enter_mass,'Title','Enter Mass (lbm)');
    set(handles.uipanel_enter_stiffness,'Title','Enter Stiffness (lbf/in)');

    set(handles.text_displacement,'String','Displacement (in)');
    set(handles.text_velocity,'String','Velocity (in/sec)');
    set(handles.text_transmitted_force,'String','Transmitted Force (lbf)');

else
    set(handles.uipanel_unbalance_force,'Title','Unbalance Force (N)');
    s1=sprintf('%8.4g',force_N);
    set(handles.uipanel_enter_mass,'Title','Enter Mass (kg)');
    set(handles.uipanel_enter_stiffness,'Title','Enter Stiffness (N/mm)');
    
    set(handles.text_displacement,'String','Displacement (mm)');
    set(handles.text_velocity,'String','Velocity (m/sec)');
    set(handles.text_transmitted_force,'String','Transmitted Force (N)');    
end


set(handles.edit_unbalance_force,'String',s1);
    

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



function edit_unbalance_force_Callback(hObject, eventdata, handles)
% hObject    handle to edit_unbalance_force (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_unbalance_force as text
%        str2double(get(hObject,'String')) returns contents of edit_unbalance_force as a double


% --- Executes during object creation, after setting all properties.
function edit_unbalance_force_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_unbalance_force (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_return.
function pushbutton_return_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_return (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%
delete('SDOF_response_unbalance');


% --- Executes on selection change in listbox_excitation_frequency_unit.
function listbox_excitation_frequency_unit_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_excitation_frequency_unit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_excitation_frequency_unit contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_excitation_frequency_unit
clear_results(hObject, eventdata, handles);

% --- Executes during object creation, after setting all properties.
function listbox_excitation_frequency_unit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_excitation_frequency_unit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_excitation_frequency_Callback(hObject, eventdata, handles)
% hObject    handle to edit_excitation_frequency (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_excitation_frequency as text
%        str2double(get(hObject,'String')) returns contents of edit_excitation_frequency as a double


% --- Executes during object creation, after setting all properties.
function edit_excitation_frequency_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_excitation_frequency (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_natural_frequency_Callback(hObject, eventdata, handles)
% hObject    handle to edit_natural_frequency (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_natural_frequency as text
%        str2double(get(hObject,'String')) returns contents of edit_natural_frequency as a double


% --- Executes during object creation, after setting all properties.
function edit_natural_frequency_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_natural_frequency (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_stiffness_Callback(hObject, eventdata, handles)
% hObject    handle to edit_stiffness (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_stiffness as text
%        str2double(get(hObject,'String')) returns contents of edit_stiffness as a double


% --- Executes during object creation, after setting all properties.
function edit_stiffness_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_stiffness (see GCBO)
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


% --- Executes on key press with focus on edit_mass and none of its controls.
function edit_mass_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_mass (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
clear_results(hObject, eventdata, handles);


% --- Executes on key press with focus on edit_stiffness and none of its controls.
function edit_stiffness_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_stiffness (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
clear_results(hObject, eventdata, handles);


% --- Executes on key press with focus on edit_natural_frequency and none of its controls.
function edit_natural_frequency_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_natural_frequency (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
clear_results(hObject, eventdata, handles);


% --- Executes on key press with focus on edit_excitation_frequency and none of its controls.
function edit_excitation_frequency_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_excitation_frequency (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
clear_results(hObject, eventdata, handles);



function edit_displacement_Callback(hObject, eventdata, handles)
% hObject    handle to edit_displacement (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_displacement as text
%        str2double(get(hObject,'String')) returns contents of edit_displacement as a double


% --- Executes during object creation, after setting all properties.
function edit_displacement_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_displacement (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_velocity_Callback(hObject, eventdata, handles)
% hObject    handle to edit_velocity (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_velocity as text
%        str2double(get(hObject,'String')) returns contents of edit_velocity as a double


% --- Executes during object creation, after setting all properties.
function edit_velocity_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_velocity (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_acceleration_Callback(hObject, eventdata, handles)
% hObject    handle to edit_acceleration (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_acceleration as text
%        str2double(get(hObject,'String')) returns contents of edit_acceleration as a double


% --- Executes during object creation, after setting all properties.
function edit_acceleration_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_acceleration (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_transmitted_force_Callback(hObject, eventdata, handles)
% hObject    handle to edit_transmitted_force (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_transmitted_force as text
%        str2double(get(hObject,'String')) returns contents of edit_transmitted_force as a double


% --- Executes during object creation, after setting all properties.
function edit_transmitted_force_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_transmitted_force (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function edit_damping_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_damping (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called



function edit_damping_Callback(hObject, eventdata, handles)
% hObject    handle to edit_damping (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_damping as text
%        str2double(get(hObject,'String')) returns contents of edit_damping as a double
clear_results(hObject, eventdata, handles);

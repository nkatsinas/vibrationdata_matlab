function varargout = accidental_drop_shock(varargin)
% ACCIDENTAL_DROP_SHOCK MATLAB code for accidental_drop_shock.fig
%      ACCIDENTAL_DROP_SHOCK, by itself, creates a new ACCIDENTAL_DROP_SHOCK or raises the existing
%      singleton*.
%
%      H = ACCIDENTAL_DROP_SHOCK returns the handle to a new ACCIDENTAL_DROP_SHOCK or the handle to
%      the existing singleton*.
%
%      ACCIDENTAL_DROP_SHOCK('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ACCIDENTAL_DROP_SHOCK.M with the given input arguments.
%
%      ACCIDENTAL_DROP_SHOCK('Property','Value',...) creates a new ACCIDENTAL_DROP_SHOCK or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before accidental_drop_shock_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to accidental_drop_shock_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help accidental_drop_shock

% Last Modified by GUIDE v2.5 06-Feb-2014 17:13:11

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @accidental_drop_shock_OpeningFcn, ...
                   'gui_OutputFcn',  @accidental_drop_shock_OutputFcn, ...
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


% --- Executes just before accidental_drop_shock is made visible.
function accidental_drop_shock_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to accidental_drop_shock (see VARARGIN)

% Choose default command line output for accidental_drop_shock
handles.output = hObject;

set(handles.listbox_analysis,'Value',1);

set(handles.listbox_height_unit,'Value',1);
set(handles.listbox_frequency_unit,'Value',1);
set(handles.listbox_accel_unit,'Value',1);

listbox_analysis_Callback(hObject, eventdata, handles);

clear_results(hObject, eventdata, handles);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes accidental_drop_shock wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = accidental_drop_shock_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


function clear_results(hObject, eventdata, handles)
%
set(handles.edit_results_drop_height,'Visible','off');
set(handles.edit_results_fn,'Visible','off');
set(handles.edit_results_spring_displacement,'Visible','off');
set(handles.edit_results_velocity,'Visible','off');
set(handles.edit_results_acceleration,'Visible','off');

set(handles.text_results_drop_height,'Visible','off');
set(handles.text_results_fn,'Visible','off');
set(handles.text_results_spring_displacement,'Visible','off');
set(handles.text_results_velocity,'Visible','off');
set(handles.text_results_acceleration,'Visible','off');


% --- Executes on selection change in listbox_analysis.
function listbox_analysis_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_analysis (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_analysis contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_analysis
clear_results(hObject, eventdata, handles);

set(handles.text_height,'Visible','on');
set(handles.edit_height,'Visible','on');
set(handles.listbox_height_unit,'Visible','on');

set(handles.text_fn,'Visible','on');
set(handles.edit_fn,'Visible','on');
set(handles.listbox_frequency_unit,'Visible','on');

set(handles.text_peak_acceleration,'Visible','on');
set(handles.edit_peak_accel,'Visible','on');
set(handles.listbox_accel_unit,'Visible','on');

n=get(handles.listbox_analysis,'Value');

if(n==1)
    set(handles.text_peak_acceleration,'Visible','off');
    set(handles.edit_peak_accel,'Visible','off');
    set(handles.listbox_accel_unit,'Visible','off');
end
if(n==2)
    set(handles.text_height,'Visible','off');
    set(handles.edit_height,'Visible','off');
    set(handles.listbox_height_unit,'Visible','off');
end
if(n==3)
    set(handles.text_fn,'Visible','off');
    set(handles.edit_fn,'Visible','off');
    set(handles.listbox_frequency_unit,'Visible','off');
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


% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

tpi=2*pi;

set(handles.edit_results_drop_height,'Visible','on');
set(handles.edit_results_fn,'Visible','on');
set(handles.edit_results_spring_displacement,'Visible','on');
set(handles.edit_results_velocity,'Visible','on');
set(handles.edit_results_acceleration,'Visible','on');

set(handles.text_results_drop_height,'Visible','on');
set(handles.text_results_fn,'Visible','on');
set(handles.text_results_spring_displacement,'Visible','on');
set(handles.text_results_velocity,'Visible','on');
set(handles.text_results_acceleration,'Visible','on');

n=get(handles.listbox_analysis,'Value');

n_height=get(handles.listbox_height_unit,'Value');
  n_freq=get(handles.listbox_frequency_unit,'Value');
 n_accel=get(handles.listbox_accel_unit,'Value');

meters_per_inch=0.0254;
inches_per_meters=1./meters_per_inch;

meters_per_feet=0.3048;
feet_per_meters=1./meters_per_feet;
 
% height 

if(n==1 || n==3)
    a=str2num(get(handles.edit_height,'String'));
    if(n_height==1) % inch  
        h_in=a;
        h_ft=a/12;
        h_m=a*meters_per_inch;
    end           
    if(n_height==2) % ft
        h_ft=a;
        h_in=12*a;
        h_m=a*meters_per_feet;
    end           
    if(n_height==3) % meters
        h_m=a;
        h_ft=a*feet_per_meters;
        h_in=a*inches_per_meters;      
    end               
end     
 
%  omegan

if(n==1 || n==2)
    a=str2num(get(handles.edit_fn,'String'));
    if(n_freq==1) % Hz
        fn=a;
        omegan=fn*tpi;
    else          % rad/sec
        omegan=a;
        fn=omegan/tpi;
    end    
end    

%  acceleration

if(n==2 || n==3)
    a=str2num(get(handles.edit_peak_accel,'String'));
    if(n_accel==1) % G
        a_G=a;
        a_ipss=a*386.;
        a_ftpss=a*32.2;
        a_mpss=a*9.81;
    end    
    if(n_accel==2) % in/sec^2
        a_ipss=a;
        a_G=a/386.;
        a_ftpss=a/12;
        a_mpss=a*meters_per_inch;        
    end    
    if(n_accel==3) % ft/sec^2
        a_ftpss=a;  
        a_G=a/32.2;
        a_ipss=a*12;
        a_mpss=a*meters_per_feet;        
    end    
    if(n_accel==4) % m/sec^2
        a_mpss=a;
        a_G=a/9.81;
        a_ipss=a*inches_per_meters;
        a_ftpss=a*feet_per_meters;        
    end        
end    
 
G=9.81;

if(n==1)  % calculate acceleration
        a_mpss=omegan*sqrt(2*G*h_m);
        a_G=a_mpss/9.81;
        a_ipss=a_mpss*inches_per_meters;
        a_ftpss=a_mpss*feet_per_meters;  
end
if(n==2)  % drop height
        h_m=(a_mpss^2/omegan^2)/(2*G);
        h_ft=h_m*feet_per_meters;
        h_in=h_m*inches_per_meters; 
end
if(n==3)  % natural frequency
        omegan=a_mpss/sqrt(2*G*h_m);
        fn=omegan/tpi;  
end

sd_m=sqrt(2*G*h_m)/omegan;
sd_in=sd_m*inches_per_meters;
sd_ft=sd_m*feet_per_meters;
sd_mm=sd_m*1000;

v_mps=sd_m*omegan;
v_ips=sd_in*omegan;
v_fps=sd_ft*omegan;


s1=sprintf(' %8.4g in \n %8.4g ft \n\n %8.4g m',h_in,h_ft,h_m);
s2=sprintf(' %8.4g Hz \n %8.4g rad/sec',fn,omegan);
s3=sprintf(' %8.4g in \n %8.4g ft \n\n %8.4g mm',sd_in,sd_ft,sd_mm);
s4=sprintf(' %8.4g in/sec \n %8.4g ft/sec \n\n %8.4g m/sec',v_ips,v_fps,v_mps);
s5=sprintf(' %8.4g G \n\n %8.4g in/sec^2 \n %8.4g ft/sec^2 \n\n %8.4g m/sec^2',...
                                                a_G,a_ipss,a_ftpss,a_mpss);

set(handles.edit_results_drop_height,'MAX',5);
set(handles.edit_results_fn,'MAX',5);
set(handles.edit_results_spring_displacement,'MAX',5);
set(handles.edit_results_velocity,'MAX',5);
set(handles.edit_results_acceleration,'MAX',7);

set(handles.edit_results_drop_height,'String',s1);
set(handles.edit_results_fn,'String',s2);
set(handles.edit_results_spring_displacement,'String',s3);
set(handles.edit_results_velocity,'String',s4);
set(handles.edit_results_acceleration,'String',s5);


% --- Executes on button press in pushbutton_return.
function pushbutton_return_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_return (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
delete(accidental_drop_shock);



function edit_height_Callback(hObject, eventdata, handles)
% hObject    handle to edit_height (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_height as text
%        str2double(get(hObject,'String')) returns contents of edit_height as a double


% --- Executes during object creation, after setting all properties.
function edit_height_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_height (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_fn_Callback(hObject, eventdata, handles)
% hObject    handle to edit_fn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_fn as text
%        str2double(get(hObject,'String')) returns contents of edit_fn as a double


% --- Executes during object creation, after setting all properties.
function edit_fn_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_fn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_peak_accel_Callback(hObject, eventdata, handles)
% hObject    handle to edit_peak_accel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_peak_accel as text
%        str2double(get(hObject,'String')) returns contents of edit_peak_accel as a double


% --- Executes during object creation, after setting all properties.
function edit_peak_accel_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_peak_accel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_height_unit.
function listbox_height_unit_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_height_unit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_height_unit contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_height_unit
clear_results(hObject, eventdata, handles);

% --- Executes during object creation, after setting all properties.
function listbox_height_unit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_height_unit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_frequency_unit.
function listbox_frequency_unit_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_frequency_unit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_frequency_unit contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_frequency_unit
clear_results(hObject, eventdata, handles);

% --- Executes during object creation, after setting all properties.
function listbox_frequency_unit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_frequency_unit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_accel_unit.
function listbox_accel_unit_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_accel_unit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_accel_unit contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_accel_unit
clear_results(hObject, eventdata, handles);


% --- Executes during object creation, after setting all properties.
function listbox_accel_unit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_accel_unit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on key press with focus on edit_height and none of its controls.
function edit_height_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_height (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
clear_results(hObject, eventdata, handles);


% --- Executes on key press with focus on edit_fn and none of its controls.
function edit_fn_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_fn (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
clear_results(hObject, eventdata, handles);


% --- Executes on key press with focus on edit_peak_accel and none of its controls.
function edit_peak_accel_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_peak_accel (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
clear_results(hObject, eventdata, handles);



function edit_results_spring_displacement_Callback(hObject, eventdata, handles)
% hObject    handle to edit_results_spring_displacement (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_results_spring_displacement as text
%        str2double(get(hObject,'String')) returns contents of edit_results_spring_displacement as a double


% --- Executes during object creation, after setting all properties.
function edit_results_spring_displacement_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_results_spring_displacement (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_results_velocity_Callback(hObject, eventdata, handles)
% hObject    handle to edit_results_velocity (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_results_velocity as text
%        str2double(get(hObject,'String')) returns contents of edit_results_velocity as a double


% --- Executes during object creation, after setting all properties.
function edit_results_velocity_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_results_velocity (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_results_acceleration_Callback(hObject, eventdata, handles)
% hObject    handle to edit_results_acceleration (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_results_acceleration as text
%        str2double(get(hObject,'String')) returns contents of edit_results_acceleration as a double


% --- Executes during object creation, after setting all properties.
function edit_results_acceleration_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_results_acceleration (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_results_drop_height_Callback(hObject, eventdata, handles)
% hObject    handle to edit_results_drop_height (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_results_drop_height as text
%        str2double(get(hObject,'String')) returns contents of edit_results_drop_height as a double


% --- Executes during object creation, after setting all properties.
function edit_results_drop_height_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_results_drop_height (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_results_fn_Callback(hObject, eventdata, handles)
% hObject    handle to edit_results_fn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_results_fn as text
%        str2double(get(hObject,'String')) returns contents of edit_results_fn as a double


% --- Executes during object creation, after setting all properties.
function edit_results_fn_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_results_fn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

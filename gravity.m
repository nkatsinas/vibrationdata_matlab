function varargout = gravity(varargin)
% GRAVITY MATLAB code for gravity.fig
%      GRAVITY, by itself, creates a new GRAVITY or raises the existing
%      singleton*.
%
%      H = GRAVITY returns the handle to a new GRAVITY or the handle to
%      the existing singleton*.
%
%      GRAVITY('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GRAVITY.M with the given input arguments.
%
%      GRAVITY('Property','Value',...) creates a new GRAVITY or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before gravity_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to gravity_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help gravity

% Last Modified by GUIDE v2.5 17-Jan-2021 14:50:05

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @gravity_OpeningFcn, ...
                   'gui_OutputFcn',  @gravity_OutputFcn, ...
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


% --- Executes just before gravity is made visible.
function gravity_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to gravity (see VARARGIN)

% Choose default command line output for gravity
handles.output = hObject;

listbox_body_Callback(hObject, eventdata, handles);
listbox_units_Callback(hObject, eventdata, handles);

set(handles.uipanel_results,'Visible','off');

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes gravity wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = gravity_OutputFcn(hObject, eventdata, handles) 
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
delete(gravity);


% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

nb=get(handles.listbox_body,'Value');
nu=get(handles.listbox_units,'Value');

ft_per_m=3.28084;
Pa_per_psi = 6894.;
kgpm3_per_lbmpin3=27675;


r=str2double(get(handles.edit_radius,'String'));
alt=str2double(get(handles.edit_alt,'String'));

if(nb==1)
   g0 = 9.80665;  %m/s^2 
end

ha=r+alt;
g=g0*(r/ha)^2;

if(nu==3)
    g=g*ft_per_m;
end

if(nu==2)
    alt=alt*1000;
end
if(nu==3)
    alt=alt/ft_per_m;
end


[AP] = initAtmosphereMetric();
[Tout,pout,rhoout,aout,h] = Atmosphere(alt,AP,g0);

if(nu==3)
    pout=pout/Pa_per_psi;
    aout=aout*ft_per_m;
    rhoout=rhoout/kgpm3_per_lbmpin3
end

set(handles.uipanel_results,'Visible','on');


ss=sprintf('%8.4g',g);
set(handles.edit_g,'String',ss);

ss=sprintf('%8.4g',aout);
set(handles.edit_c,'String',ss);

ss=sprintf('%8.4g',pout);
set(handles.edit_P,'String',ss);

ss=sprintf('%8.4g',rhoout);
set(handles.edit_rho,'String',ss);

TC=Tout-273.15;
TF=TC*(9/5) + 32; 

ss=sprintf(' %8.4g K \n %8.4g deg C \n %8.4g deg F \n',Tout,TC,TF);
set(handles.edit_T,'String',ss, 'Min', 0, 'Max',4);


% --- Executes on selection change in listbox_body.
function listbox_body_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_body (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_body contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_body
 listbox_units_Callback(hObject, eventdata, handles);
set(handles.uipanel_results,'Visible','off');
 
 
% --- Executes during object creation, after setting all properties.
function listbox_body_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_body (see GCBO)
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
set(handles.uipanel_results,'Visible','off');
n=get(handles.listbox_units,'Value');

r_m = 6367445 ; %m
r_km = r_m/1000; % km

ft_per_m=3.28084;
r_ft=r_m*ft_per_m;

set(handles.text_g,'String','Acceleration (m/sec^2)');
set(handles.text_c,'String','Speed of Sound (m/sec)');
set(handles.text_P,'String','Pressure (Pa)');
set(handles.text_rho,'String','Air Density (kg/m^3)');

if(n==1)
    set(handles.text_radius,'String','Radius (m)');
    set(handles.text_alt,'String','Altitude above Sea Level (m)');
    ss=sprintf('%8.5g',r_m);
end
if(n==2)
    set(handles.text_radius,'String','Radius (km)');
    set(handles.text_alt,'String','Altitude above Sea Level (km)');    
    ss=sprintf('%8.5g',r_km);    
end
if(n==3)
    set(handles.text_radius,'String','Radius (ft)');
    set(handles.text_alt,'String','Altitude above Sea Level (ft)');    
    ss=sprintf('%8.5g',r_ft); 
    set(handles.text_g,'String','Acceleration (ft/sec^2)');
    set(handles.text_c,'String','Speed of Sound (ft/sec)');
    set(handles.text_P,'String','Pressure (psi)');
    set(handles.text_rho,'String','Air Density (lbm/in^3)');  
end

set(handles.edit_radius,'String',ss);


    

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



function edit_alt_Callback(hObject, eventdata, handles)
% hObject    handle to edit_alt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_alt as text
%        str2double(get(hObject,'String')) returns contents of edit_alt as a double


% --- Executes during object creation, after setting all properties.
function edit_alt_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_alt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on key press with focus on edit_radius and none of its controls.
function edit_radius_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_radius (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.uipanel_results,'Visible','off');


% --- Executes on key press with focus on edit_alt and none of its controls.
function edit_alt_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_alt (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.uipanel_results,'Visible','off');



function edit_g_Callback(hObject, eventdata, handles)
% hObject    handle to edit_g (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_g as text
%        str2double(get(hObject,'String')) returns contents of edit_g as a double


% --- Executes during object creation, after setting all properties.
function edit_g_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_g (see GCBO)
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



function edit_P_Callback(hObject, eventdata, handles)
% hObject    handle to edit_P (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_P as text
%        str2double(get(hObject,'String')) returns contents of edit_P as a double


% --- Executes during object creation, after setting all properties.
function edit_P_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_P (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_T_Callback(hObject, eventdata, handles)
% hObject    handle to edit_T (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_T as text
%        str2double(get(hObject,'String')) returns contents of edit_T as a double


% --- Executes during object creation, after setting all properties.
function edit_T_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_T (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_rho_Callback(hObject, eventdata, handles)
% hObject    handle to edit_rho (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_rho as text
%        str2double(get(hObject,'String')) returns contents of edit_rho as a double


% --- Executes during object creation, after setting all properties.
function edit_rho_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_rho (see GCBO)
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

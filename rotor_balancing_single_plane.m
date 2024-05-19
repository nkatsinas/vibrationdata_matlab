function varargout = rotor_balancing_single_plane(varargin)
% ROTOR_BALANCING_SINGLE_PLANE MATLAB code for rotor_balancing_single_plane.fig
%      ROTOR_BALANCING_SINGLE_PLANE, by itself, creates a new ROTOR_BALANCING_SINGLE_PLANE or raises the existing
%      singleton*.
%
%      H = ROTOR_BALANCING_SINGLE_PLANE returns the handle to a new ROTOR_BALANCING_SINGLE_PLANE or the handle to
%      the existing singleton*.
%
%      ROTOR_BALANCING_SINGLE_PLANE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ROTOR_BALANCING_SINGLE_PLANE.M with the given input arguments.
%
%      ROTOR_BALANCING_SINGLE_PLANE('Property','Value',...) creates a new ROTOR_BALANCING_SINGLE_PLANE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before rotor_balancing_single_plane_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to rotor_balancing_single_plane_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help rotor_balancing_single_plane

% Last Modified by GUIDE v2.5 16-Aug-2014 14:49:32

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @rotor_balancing_single_plane_OpeningFcn, ...
                   'gui_OutputFcn',  @rotor_balancing_single_plane_OutputFcn, ...
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


% --- Executes just before rotor_balancing_single_plane is made visible.
function rotor_balancing_single_plane_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to rotor_balancing_single_plane (see VARARGIN)

% Choose default command line output for rotor_balancing_single_plane
handles.output = hObject;

set(handles.listbox_units,'Value',1);
listbox_units_Callback(hObject, eventdata, handles)
clear_results(hObject, eventdata, handles);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes rotor_balancing_single_plane wait for user response (see UIRESUME)
% uiwait(handles.figure1);

function clear_results(hObject, eventdata, handles)
%
set(handles.edit_results_1,'String',' ');
set(handles.edit_results_1,'Visible','off');
set(handles.text_results_1,'Visible','off');

set(handles.edit_results_2,'String',' ');
set(handles.edit_results_2,'Visible','off');
set(handles.text_results_2,'Visible','off');

set(handles.edit_results_3,'String',' ');
set(handles.edit_results_3,'Visible','off');
set(handles.text_results_3,'Visible','off');

set(handles.edit_results_4,'String',' ');
set(handles.edit_results_4,'Visible','off');
set(handles.text_results_4,'Visible','off');



% --- Outputs from this function are returned to the command line.
function varargout = rotor_balancing_single_plane_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

set(handles.edit_results_1,'Visible','on');
set(handles.text_results_1,'Visible','on');
set(handles.edit_results_2,'Visible','on');
set(handles.text_results_2,'Visible','on');
set(handles.edit_results_3,'Visible','on');
set(handles.text_results_3,'Visible','on');
set(handles.edit_results_4,'Visible','on');
set(handles.text_results_4,'Visible','on');

iu=get(handles.listbox_units,'Value');


mo=str2num(get(handles.edit_trial_mass,'String'));
ta=str2num(get(handles.edit_trial_angle,'String'));
r=str2num(get(handles.edit_radius,'String'));
ta=ta*pi/180;

zom=str2num(get(handles.edit_initial_magnitude,'String'));
zop=str2num(get(handles.edit_initial_phase,'String'));
zop=zop*pi/180;

Zo=zom*(cos(zop)+(1i)*sin(zop));

zz=str2num(get(handles.edit_response_magnitude,'String'));
zp=str2num(get(handles.edit_response_phase,'String'));

theta=zp*pi/180;

T=mo*r*(cos(ta)+(1i)*sin(ta));

Zm=zz*(cos(theta)+(1i)*sin(theta)); 

Z=(Zm-Zo);
H=Z/T;

U=pinv(H)*Zo;
Uc=-U;

Uc_mass=sqrt(real(Uc)^2 + imag(Uc)^2);
Uc_phase=atan2(imag(Uc),real(Uc));

ph_1=Uc_phase*180/pi;

if(ph_1<0)
    ph_1=ph_1+360;
end    

Ut=Uc-T;
Ut_mass=sqrt(real(Ut)^2 + imag(Ut)^2);
Ut_phase=atan2(imag(Ut),real(Ut));

ph_2=Ut_phase*180/pi;
if(ph_2<0.)
     ph_2=360+ph_2;
end

if(iu==1)
   s1=sprintf('%8.4g oz-in  at %8.4g degrees ',Uc_mass,ph_1);
   s2=sprintf('%8.4g oz  at %8.4g degrees  at radius = %g inch',Uc_mass/r,ph_1,r);
   
   s3=sprintf('%8.4g oz-in  at %8.4g degrees ',Ut_mass,ph_2);
   s4=sprintf('%8.4g oz  at %8.4g degrees  at radius = %g inch',Ut_mass/r,ph_2,r);
   
else
   s1=sprintf('%8.4g grams-mm  at %8.4g degrees ',Uc_mass,ph_1);
   s2=sprintf('%8.4g grams  at %8.4g degrees  at radius = %g mm',Uc_mass/r,ph_1,r);   
   
   s3=sprintf('%8.4g grams-mm  at %8.4g degrees ',Ut_mass,ph_2);
   s4=sprintf('%8.4g grams  at %8.4g degrees  at radius = %g mm',Ut_mass/r,ph_2,r);  
   
end

set(handles.edit_results_1,'String',s1);
set(handles.edit_results_2,'String',s2);
set(handles.edit_results_3,'String',s3);
set(handles.edit_results_4,'String',s4);


% --- Executes on selection change in listbox_units.
function listbox_units_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_units (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_units contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_units

iu=get(handles.listbox_units,'Value');

if(iu==1)
   set(handles.text_trial_mass,'String','Mass (oz)');
   set(handles.text_radius,'String','Radius (in)'); 
   set(handles.text_magnitude,'String','Magnitude (mils)');
   set(handles.text_response_magnitude,'String','Magnitude (mils)');
else
   set(handles.text_trial_mass,'String','Mass( grams)');
   set(handles.text_radius,'String','Radius (mm)');
   set(handles.text_magnitude,'String','Magnitude (mm)');
   set(handles.text_response_magnitude,'String','Magnitude (mm)');
end

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



function edit_results_1_Callback(hObject, eventdata, handles)
% hObject    handle to edit_results_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_results_1 as text
%        str2double(get(hObject,'String')) returns contents of edit_results_1 as a double


% --- Executes during object creation, after setting all properties.
function edit_results_1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_results_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
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


% --- Executes on key press with focus on edit_radius and none of its controls.
function edit_radius_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_radius (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
clear_results(hObject, eventdata, handles);



function edit_trial_mass_Callback(hObject, eventdata, handles)
% hObject    handle to edit_trial_mass (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_trial_mass as text
%        str2double(get(hObject,'String')) returns contents of edit_trial_mass as a double


% --- Executes during object creation, after setting all properties.
function edit_trial_mass_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_trial_mass (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on key press with focus on edit_trial_mass and none of its controls.
function edit_trial_mass_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_trial_mass (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
clear_results(hObject, eventdata, handles);



function edit_initial_magnitude_Callback(hObject, eventdata, handles)
% hObject    handle to edit_initial_magnitude (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_initial_magnitude as text
%        str2double(get(hObject,'String')) returns contents of edit_initial_magnitude as a double


% --- Executes during object creation, after setting all properties.
function edit_initial_magnitude_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_initial_magnitude (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_initial_phase_Callback(hObject, eventdata, handles)
% hObject    handle to edit_initial_phase (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_initial_phase as text
%        str2double(get(hObject,'String')) returns contents of edit_initial_phase as a double


% --- Executes during object creation, after setting all properties.
function edit_initial_phase_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_initial_phase (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on key press with focus on edit_initial_magnitude and none of its controls.
function edit_initial_magnitude_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_initial_magnitude (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
clear_results(hObject, eventdata, handles);


% --- Executes on key press with focus on edit_initial_phase and none of its controls.
function edit_initial_phase_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_initial_phase (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
clear_results(hObject, eventdata, handles);



function edit_response_magnitude_Callback(hObject, eventdata, handles)
% hObject    handle to edit_response_magnitude (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_response_magnitude as text
%        str2double(get(hObject,'String')) returns contents of edit_response_magnitude as a double


% --- Executes during object creation, after setting all properties.
function edit_response_magnitude_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_response_magnitude (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_response_phase_Callback(hObject, eventdata, handles)
% hObject    handle to edit_response_phase (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_response_phase as text
%        str2double(get(hObject,'String')) returns contents of edit_response_phase as a double


% --- Executes during object creation, after setting all properties.
function edit_response_phase_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_response_phase (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on key press with focus on edit_response_magnitude and none of its controls.
function edit_response_magnitude_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_response_magnitude (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
clear_results(hObject, eventdata, handles);


% --- Executes on key press with focus on edit_response_phase and none of its controls.
function edit_response_phase_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_response_phase (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
clear_results(hObject, eventdata, handles);



function edit_trial_angle_Callback(hObject, eventdata, handles)
% hObject    handle to edit_trial_angle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_trial_angle as text
%        str2double(get(hObject,'String')) returns contents of edit_trial_angle as a double


% --- Executes during object creation, after setting all properties.
function edit_trial_angle_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_trial_angle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on key press with focus on edit_trial_angle and none of its controls.
function edit_trial_angle_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_trial_angle (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
clear_results(hObject, eventdata, handles);



function edit_results_2_Callback(hObject, eventdata, handles)
% hObject    handle to edit_results_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_results_2 as text
%        str2double(get(hObject,'String')) returns contents of edit_results_2 as a double


% --- Executes during object creation, after setting all properties.
function edit_results_2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_results_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_results_3_Callback(hObject, eventdata, handles)
% hObject    handle to edit_results_3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_results_3 as text
%        str2double(get(hObject,'String')) returns contents of edit_results_3 as a double


% --- Executes during object creation, after setting all properties.
function edit_results_3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_results_3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_results_4_Callback(hObject, eventdata, handles)
% hObject    handle to edit_results_4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_results_4 as text
%        str2double(get(hObject,'String')) returns contents of edit_results_4 as a double


% --- Executes during object creation, after setting all properties.
function edit_results_4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_results_4 (see GCBO)
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
delete(rotor_balancing_single_plane);
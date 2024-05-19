function varargout = rotor_balancing_two_plane(varargin)
% ROTOR_BALANCING_TWO_PLANE MATLAB code for rotor_balancing_two_plane.fig
%      ROTOR_BALANCING_TWO_PLANE, by itself, creates a new ROTOR_BALANCING_TWO_PLANE or raises the existing
%      singleton*.
%
%      H = ROTOR_BALANCING_TWO_PLANE returns the handle to a new ROTOR_BALANCING_TWO_PLANE or the handle to
%      the existing singleton*.
%
%      ROTOR_BALANCING_TWO_PLANE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ROTOR_BALANCING_TWO_PLANE.M with the given input arguments.
%
%      ROTOR_BALANCING_TWO_PLANE('Property','Value',...) creates a new ROTOR_BALANCING_TWO_PLANE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before rotor_balancing_two_plane_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to rotor_balancing_two_plane_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help rotor_balancing_two_plane

% Last Modified by GUIDE v2.5 11-Feb-2014 11:18:02

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @rotor_balancing_two_plane_OpeningFcn, ...
                   'gui_OutputFcn',  @rotor_balancing_two_plane_OutputFcn, ...
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


% --- Executes just before rotor_balancing_two_plane is made visible.
function rotor_balancing_two_plane_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to rotor_balancing_two_plane (see VARARGIN)

% Choose default command line output for rotor_balancing_two_plane
handles.output = hObject;

set(handles.listbox_units,'Value',1);
set(handles.listbox_runout,'Value',1);

clear_results(hObject, eventdata, handles);

listbox_units_Callback(hObject, eventdata, handles);
listbox_runout_Callback(hObject, eventdata, handles);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes rotor_balancing_two_plane wait for user response (see UIRESUME)
% uiwait(handles.figure1);

function clear_results(hObject, eventdata, handles)
%
set(handles.edit_results,'Visible','off');
set(handles.edit_results,'String',' ');


% --- Outputs from this function are returned to the command line.
function varargout = rotor_balancing_two_plane_OutputFcn(hObject, eventdata, handles) 
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

iu=get(handles.listbox_units,'Value');
n_run=get(handles.listbox_runout,'Value');

P=pi/180;

if(n_run==1)
    runout_mag_1=str2num(get(handles.edit_runout_mag_1,'String'));
    runout_mag_2=str2num(get(handles.edit_runout_mag_2,'String'));
    runout_phase_1=P*str2num(get(handles.edit_runout_phase_1,'String'));
    runout_phase_2=P*str2num(get(handles.edit_runout_phase_2,'String'));
    
    Zr(1)=runout_mag_1*(cos(runout_phase_1)+(1i)*sin(runout_phase_1));
    Zr(2)=runout_mag_2*(cos(runout_phase_2)+(1i)*sin(runout_phase_2));    
end

ro=str2num(get(handles.edit_radius,'String'));

% omega=2*pi*speed/60;

initial_mag_1=str2num(get(handles.edit_initial_mag_1,'String'));
initial_mag_2=str2num(get(handles.edit_initial_mag_2,'String'));
initial_phase_1=P*str2num(get(handles.edit_initial_phase_1,'String'));
initial_phase_2=P*str2num(get(handles.edit_initial_phase_2,'String'));

Zo(1)=initial_mag_1*(cos(initial_phase_1)+(1i)*sin(initial_phase_1));
Zo(2)=initial_mag_2*(cos(initial_phase_2)+(1i)*sin(initial_phase_2));


trial_mass(1)=str2num(get(handles.edit_trial_mass_one,'String'));
trial_mass(2)=str2num(get(handles.edit_trial_mass_two,'String'));
trial_angle(1)=P*str2num(get(handles.edit_trial_angle_1,'String'));
trial_angle(2)=P*str2num(get(handles.edit_trial_angle_2,'String'));

trial_mag_11=str2num(get(handles.edit_trial_mag_11,'String'));
trial_mag_12=str2num(get(handles.edit_trial_mag_12,'String'));
trial_phase_11=P*str2num(get(handles.edit_trial_phase_11,'String'));
trial_phase_12=P*str2num(get(handles.edit_trial_phase_12,'String'));

trial_mag_21=str2num(get(handles.edit_trial_mag_21,'String'));
trial_mag_22=str2num(get(handles.edit_trial_mag_22,'String'));
trial_phase_21=P*str2num(get(handles.edit_trial_phase_21,'String'));
trial_phase_22=P*str2num(get(handles.edit_trial_phase_22,'String'));


Zm(1,1)=trial_mag_11*(cos(trial_phase_11)+(1i)*sin(trial_phase_11));
Zm(1,2)=trial_mag_12*(cos(trial_phase_12)+(1i)*sin(trial_phase_12));

Zm(2,1)=trial_mag_21*(cos(trial_phase_21)+(1i)*sin(trial_phase_21));
Zm(2,2)=trial_mag_22*(cos(trial_phase_22)+(1i)*sin(trial_phase_22));



if(n_run==1)
    Zo=Zo-Zr;
    Zm(1,1)=Zm(1,1)-Zr(1);    
    Zm(1,2)=Zm(1,2)-Zr(2); 
    Zm(2,1)=Zm(2,1)-Zr(1);    
    Zm(2,2)=Zm(2,2)-Zr(2);     
end

r=ro;
mo=trial_mass;


T=zeros(2,1);

H=zeros(2,2);

for j=1:2  % balance plane
%    
    T(j)=mo(j)*r*(cos(trial_angle(j))+(1i)*sin(trial_angle(j)));
%    
    for k=1:2  % measurement plane
%        
        Z=Zm(j,k)-Zo(k);
        H(k,j)=Z/T(j);
%        
    end
end    

disp(' ');
disp(' Influence Coefficient Array')
H
%
ZZo=[Zo(1); Zo(2)];
U=pinv(H)*ZZo;

Uc=-U;
%
Uc_mass=zeros(2,1);
Uc_phase=zeros(2,1);
%
for i=1:2
    Uc_mass(i)=sqrt(real(Uc(i))^2 + imag(Uc(i))^2);
    Uc_phase(i)=atan2(imag(Uc(i)),real(Uc(i)));
end    
%
disp(' ');
disp(' Correction mass-radius & phase for trial mass removed ');
disp(' ');
%
ph=Uc_phase*180/pi;
%
for i=1:2
    if(ph(i)<0.)
        ph(i)=360+ph(i);
    end
%
    if(iu==1)
        out1=sprintf('%d.   %8.4g oz-in  at %8.4g degrees ',i,Uc_mass(i),ph(i));
    else
        out1=sprintf('%d.   %8.4g grams-mm  at %8.4g degrees ',i,Uc_mass(i),ph(i));
    end
%
    disp(out1);
end
%
disp(' ');
disp(' Correction mass phase for trial mass removed ');
disp(' ');
%
for i=1:2
%
    if(iu==1)
        out1=sprintf('%d.   %8.4g oz  at %8.4g degrees  at radius = %g inch',i,Uc_mass(i)/ro,ph(i),ro);
    else
        out1=sprintf('%d.   %8.4g grams  at %8.4g degrees at radius = %g mm',i,Uc_mass(i)/ro,ph(i),ro);
    end
    disp(out1);
end

sa=sprintf('Correction mass-radius & phase \n');
    
if(iu==1)
    sb=sprintf('%d.   %8.4g oz-in  at %8.4g degrees ',1,Uc_mass(1),ph(1));
    sc=sprintf('%d.   %8.4g oz-in  at %8.4g degrees ',2,Uc_mass(2),ph(2));
else
    sb=sprintf('%d.   %8.4g grams-mm  at %8.4g degrees ',1,Uc_mass(1),ph(1));
    sc=sprintf('%d.   %8.4g grams-mm  at %8.4g degrees ',2,Uc_mass(2),ph(2));    
end

s1=sprintf('%s\n %s\n %s\n',sa,sb,sc);
    
set(handles.edit_results,'Max',10);    
set(handles.edit_results,'Visible','on');
set(handles.edit_results,'String',s1);


    
if(iu==1)
    sar=sprintf('Correction mass & phase at radius = %g inch\n',ro);    
    sbr=sprintf('%d.   %8.4g oz  at %8.4g degrees',1,Uc_mass(1)/ro,ph(1));
    scr=sprintf('%d.   %8.4g oz  at %8.4g degrees',2,Uc_mass(2)/ro,ph(2));
else
    sar=sprintf('Correction mass & phase at radius = %g mm\n',ro);
    sbr=sprintf('%d.   %8.4g grams  at %8.4g degrees',1,Uc_mass(1)/ro,ph(1));
    scr=sprintf('%d.   %8.4g grams  at %8.4g degrees',2,Uc_mass(2)/ro,ph(2));    
end

s1=sprintf('%s\n %s\n %s\n\n%s\n %s \n %s',sa,sb,sc,sar,sbr,scr);
    
set(handles.edit_results,'Max',10);    
set(handles.edit_results,'Visible','on');
set(handles.edit_results,'String',s1);


% --- Executes on selection change in listbox_units.
function listbox_units_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_units (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_units contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_units

iu=get(handles.listbox_units,'Value');

if(iu==1)
    set(handles.text_runout_displacement,'String','Magnitude (mils)');
    set(handles.text_initial_displacement,'String','Magnitude (mils)');
    set(handles.text_mass_1,'String','Mass (oz)');
    set(handles.text_mass_2,'String','Mass (oz)');    
    set(handles.text_trial_magnitude,'String','Magnitude (mils)');
    s1='Enter Common Trial Mass Radius (in)';
else
    set(handles.text_runout_displacement,'String','Magnitude (mm)');
    set(handles.text_initial_displacement,'String','Magnitude (mm)'); 
    set(handles.text_mass_1,'String','Mass (grams)'); 
    set(handles.text_mass_2,'String','Mass (grams)');       
    set(handles.text_trial_magnitude,'String','Magnitude (mm)');    
    s1='Enter Common Trial Mass Radius (mm)';    
end
set(handles.uipanel_radius,'Title',s1);

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



function edit_speed_Callback(hObject, eventdata, handles)
% hObject    handle to edit_speed (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_speed as text
%        str2double(get(hObject,'String')) returns contents of edit_speed as a double


% --- Executes during object creation, after setting all properties.
function edit_speed_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_speed (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_runout_mag_1_Callback(hObject, eventdata, handles)
% hObject    handle to edit_runout_mag_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_runout_mag_1 as text
%        str2double(get(hObject,'String')) returns contents of edit_runout_mag_1 as a double


% --- Executes during object creation, after setting all properties.
function edit_runout_mag_1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_runout_mag_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_runout_phase_1_Callback(hObject, eventdata, handles)
% hObject    handle to edit_runout_phase_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_runout_phase_1 as text
%        str2double(get(hObject,'String')) returns contents of edit_runout_phase_1 as a double


% --- Executes during object creation, after setting all properties.
function edit_runout_phase_1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_runout_phase_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_runout_mag_2_Callback(hObject, eventdata, handles)
% hObject    handle to edit_runout_mag_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_runout_mag_2 as text
%        str2double(get(hObject,'String')) returns contents of edit_runout_mag_2 as a double


% --- Executes during object creation, after setting all properties.
function edit_runout_mag_2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_runout_mag_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_runout_phase_2_Callback(hObject, eventdata, handles)
% hObject    handle to edit_runout_phase_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_runout_phase_2 as text
%        str2double(get(hObject,'String')) returns contents of edit_runout_phase_2 as a double


% --- Executes during object creation, after setting all properties.
function edit_runout_phase_2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_runout_phase_2 (see GCBO)
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



function edit_initial_mag_1_Callback(hObject, eventdata, handles)
% hObject    handle to edit_initial_mag_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_initial_mag_1 as text
%        str2double(get(hObject,'String')) returns contents of edit_initial_mag_1 as a double


% --- Executes during object creation, after setting all properties.
function edit_initial_mag_1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_initial_mag_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_initial_phase_1_Callback(hObject, eventdata, handles)
% hObject    handle to edit_initial_phase_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_initial_phase_1 as text
%        str2double(get(hObject,'String')) returns contents of edit_initial_phase_1 as a double


% --- Executes during object creation, after setting all properties.
function edit_initial_phase_1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_initial_phase_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_initial_mag_2_Callback(hObject, eventdata, handles)
% hObject    handle to edit_initial_mag_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_initial_mag_2 as text
%        str2double(get(hObject,'String')) returns contents of edit_initial_mag_2 as a double


% --- Executes during object creation, after setting all properties.
function edit_initial_mag_2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_initial_mag_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_initial_phase_2_Callback(hObject, eventdata, handles)
% hObject    handle to edit_initial_phase_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_initial_phase_2 as text
%        str2double(get(hObject,'String')) returns contents of edit_initial_phase_2 as a double


% --- Executes during object creation, after setting all properties.
function edit_initial_phase_2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_initial_phase_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_trial_mass_one_Callback(hObject, eventdata, handles)
% hObject    handle to edit_trial_mass_one (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_trial_mass_one as text
%        str2double(get(hObject,'String')) returns contents of edit_trial_mass_one as a double


% --- Executes during object creation, after setting all properties.
function edit_trial_mass_one_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_trial_mass_one (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_trial_angle_1_Callback(hObject, eventdata, handles)
% hObject    handle to edit_trial_angle_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_trial_angle_1 as text
%        str2double(get(hObject,'String')) returns contents of edit_trial_angle_1 as a double


% --- Executes during object creation, after setting all properties.
function edit_trial_angle_1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_trial_angle_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_trial_mass_2_Callback(hObject, eventdata, handles)
% hObject    handle to edit_trial_mass_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_trial_mass_2 as text
%        str2double(get(hObject,'String')) returns contents of edit_trial_mass_2 as a double


% --- Executes during object creation, after setting all properties.
function edit_trial_mass_2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_trial_mass_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_trial_angle_2_Callback(hObject, eventdata, handles)
% hObject    handle to edit_trial_angle_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_trial_angle_2 as text
%        str2double(get(hObject,'String')) returns contents of edit_trial_angle_2 as a double


% --- Executes during object creation, after setting all properties.
function edit_trial_angle_2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_trial_angle_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_trial_mag_11_Callback(hObject, eventdata, handles)
% hObject    handle to edit_trial_mag_11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_trial_mag_11 as text
%        str2double(get(hObject,'String')) returns contents of edit_trial_mag_11 as a double


% --- Executes during object creation, after setting all properties.
function edit_trial_mag_11_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_trial_mag_11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_trial_phase_11_Callback(hObject, eventdata, handles)
% hObject    handle to edit_trial_phase_11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_trial_phase_11 as text
%        str2double(get(hObject,'String')) returns contents of edit_trial_phase_11 as a double


% --- Executes during object creation, after setting all properties.
function edit_trial_phase_11_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_trial_phase_11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_trial_mag_12_Callback(hObject, eventdata, handles)
% hObject    handle to edit_trial_mag_12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_trial_mag_12 as text
%        str2double(get(hObject,'String')) returns contents of edit_trial_mag_12 as a double


% --- Executes during object creation, after setting all properties.
function edit_trial_mag_12_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_trial_mag_12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_trial_phase_12_Callback(hObject, eventdata, handles)
% hObject    handle to edit_trial_phase_12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_trial_phase_12 as text
%        str2double(get(hObject,'String')) returns contents of edit_trial_phase_12 as a double


% --- Executes during object creation, after setting all properties.
function edit_trial_phase_12_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_trial_phase_12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on key press with focus on edit_speed and none of its controls.
function edit_speed_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_speed (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
clear_results(hObject, eventdata, handles);


% --- Executes on key press with focus on edit_radius and none of its controls.
function edit_radius_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_radius (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
clear_results(hObject, eventdata, handles);


% --- Executes on key press with focus on edit_runout_mag_1 and none of its controls.
function edit_runout_mag_1_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_runout_mag_1 (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
clear_results(hObject, eventdata, handles);


% --- Executes on key press with focus on edit_runout_phase_1 and none of its controls.
function edit_runout_phase_1_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_runout_phase_1 (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
clear_results(hObject, eventdata, handles);


% --- Executes on key press with focus on edit_runout_mag_2 and none of its controls.
function edit_runout_mag_2_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_runout_mag_2 (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
clear_results(hObject, eventdata, handles);


% --- Executes on key press with focus on edit_runout_phase_2 and none of its controls.
function edit_runout_phase_2_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_runout_phase_2 (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
clear_results(hObject, eventdata, handles);


% --- Executes on key press with focus on edit_initial_mag_1 and none of its controls.
function edit_initial_mag_1_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_initial_mag_1 (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
clear_results(hObject, eventdata, handles);


% --- Executes on key press with focus on edit_initial_phase_1 and none of its controls.
function edit_initial_phase_1_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_initial_phase_1 (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
clear_results(hObject, eventdata, handles);


% --- Executes on key press with focus on edit_initial_mag_2 and none of its controls.
function edit_initial_mag_2_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_initial_mag_2 (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
clear_results(hObject, eventdata, handles);


% --- Executes on key press with focus on edit_initial_phase_2 and none of its controls.
function edit_initial_phase_2_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_initial_phase_2 (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
clear_results(hObject, eventdata, handles);

% --- Executes on key press with focus on edit_trial_mass_one and none of its controls.
function edit_trial_mass_2_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_trial_mass_one (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
clear_results(hObject, eventdata, handles);

% --- Executes on key press with focus on edit_trial_mass_one and none of its controls.
function edit_trial_mass_one_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_trial_mass_one (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
clear_results(hObject, eventdata, handles);


% --- Executes on key press with focus on edit_trial_angle_1 and none of its controls.
function edit_trial_angle_1_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_trial_angle_1 (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
clear_results(hObject, eventdata, handles);


% --- Executes on key press with focus on edit_trial_mag_11 and none of its controls.
function edit_trial_mag_11_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_trial_mag_11 (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
clear_results(hObject, eventdata, handles);


% --- Executes on key press with focus on edit_trial_phase_11 and none of its controls.
function edit_trial_phase_11_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_trial_phase_11 (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
clear_results(hObject, eventdata, handles);




% --- Executes on key press with focus on edit_trial_angle_2 and none of its controls.
function edit_trial_angle_2_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_trial_angle_2 (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
clear_results(hObject, eventdata, handles);


% --- Executes on key press with focus on edit_trial_mag_12 and none of its controls.
function edit_trial_mag_12_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_trial_mag_12 (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
clear_results(hObject, eventdata, handles);


% --- Executes on key press with focus on edit_trial_phase_12 and none of its controls.
function edit_trial_phase_12_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_trial_phase_12 (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
clear_results(hObject, eventdata, handles);


% --- Executes on selection change in listbox_runout.
function listbox_runout_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_runout (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_runout contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_runout
clear_results(hObject, eventdata, handles);

n=get(handles.listbox_runout,'Value');

if(n==1)
    set(handles.uipanel_runout,'Visible','on');
    set(handles.text_runout_1,'Visible','on');
    set(handles.text_runout_2,'Visible','on');
    set(handles.text_runout_displacement,'Visible','on');
    set(handles.text_runout_phase,'Visible','on');
    set(handles.edit_runout_mag_1,'Visible','on');
    set(handles.edit_runout_mag_2,'Visible','on');
    set(handles.edit_runout_phase_1,'Visible','on');
    set(handles.edit_runout_phase_2,'Visible','on');    
else
    set(handles.uipanel_runout,'Visible','off');
    set(handles.text_runout_1,'Visible','off');
    set(handles.text_runout_2,'Visible','off');
    set(handles.text_runout_displacement,'Visible','off');
    set(handles.text_runout_phase,'Visible','off');
    set(handles.edit_runout_mag_1,'Visible','off');
    set(handles.edit_runout_mag_2,'Visible','off');
    set(handles.edit_runout_phase_1,'Visible','off');
    set(handles.edit_runout_phase_2,'Visible','off');      
end



% --- Executes during object creation, after setting all properties.
function listbox_runout_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_runout (see GCBO)
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



function edit23_Callback(hObject, eventdata, handles)
% hObject    handle to edit_trial_mass_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_trial_mass_2 as text
%        str2double(get(hObject,'String')) returns contents of edit_trial_mass_2 as a double


% --- Executes during object creation, after setting all properties.
function edit23_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_trial_mass_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit24_Callback(hObject, eventdata, handles)
% hObject    handle to edit_trial_angle_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_trial_angle_2 as text
%        str2double(get(hObject,'String')) returns contents of edit_trial_angle_2 as a double


% --- Executes during object creation, after setting all properties.
function edit24_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_trial_angle_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_trial_mag_21_Callback(hObject, eventdata, handles)
% hObject    handle to edit_trial_mag_21 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_trial_mag_21 as text
%        str2double(get(hObject,'String')) returns contents of edit_trial_mag_21 as a double


% --- Executes during object creation, after setting all properties.
function edit_trial_mag_21_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_trial_mag_21 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_trial_phase_21_Callback(hObject, eventdata, handles)
% hObject    handle to edit_trial_phase_21 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_trial_phase_21 as text
%        str2double(get(hObject,'String')) returns contents of edit_trial_phase_21 as a double


% --- Executes during object creation, after setting all properties.
function edit_trial_phase_21_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_trial_phase_21 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_trial_mag_22_Callback(hObject, eventdata, handles)
% hObject    handle to edit_trial_mag_22 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_trial_mag_22 as text
%        str2double(get(hObject,'String')) returns contents of edit_trial_mag_22 as a double


% --- Executes during object creation, after setting all properties.
function edit_trial_mag_22_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_trial_mag_22 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_trial_phase_22_Callback(hObject, eventdata, handles)
% hObject    handle to edit_trial_phase_22 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_trial_phase_22 as text
%        str2double(get(hObject,'String')) returns contents of edit_trial_phase_22 as a double


% --- Executes during object creation, after setting all properties.
function edit_trial_phase_22_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_trial_phase_22 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



% --- Executes on key press with focus on edit_trial_mag_21 and none of its controls.
function edit_trial_mag_21_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_trial_mag_21 (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
clear_results(hObject, eventdata, handles);


% --- Executes on key press with focus on edit_trial_phase_21 and none of its controls.
function edit_trial_phase_21_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_trial_phase_21 (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
clear_results(hObject, eventdata, handles);


% --- Executes on key press with focus on edit_trial_mag_22 and none of its controls.
function edit_trial_mag_22_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_trial_mag_22 (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
clear_results(hObject, eventdata, handles);


% --- Executes on key press with focus on edit_trial_phase_22 and none of its controls.
function edit_trial_phase_22_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_trial_phase_22 (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
clear_results(hObject, eventdata, handles);



function edit_trial_mass_two_Callback(hObject, eventdata, handles)
% hObject    handle to edit_trial_mass_two (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_trial_mass_two as text
%        str2double(get(hObject,'String')) returns contents of edit_trial_mass_two as a double


% --- Executes during object creation, after setting all properties.
function edit_trial_mass_two_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_trial_mass_two (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on key press with focus on edit_trial_mass_two and none of its controls.
function edit_trial_mass_two_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_trial_mass_two (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
clear_results(hObject, eventdata, handles);

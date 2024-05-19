function varargout = beam_spring_sine(varargin)
% BEAM_SPRING_SINE MATLAB code for beam_spring_sine.fig
%      BEAM_SPRING_SINE, by itself, creates a new BEAM_SPRING_SINE or raises the existing
%      singleton*.
%
%      H = BEAM_SPRING_SINE returns the handle to a new BEAM_SPRING_SINE or the handle to
%      the existing singleton*.
%
%      BEAM_SPRING_SINE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in BEAM_SPRING_SINE.M with the given input arguments.
%
%      BEAM_SPRING_SINE('Property','Value',...) creates a new BEAM_SPRING_SINE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before beam_spring_sine_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to beam_spring_sine_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help beam_spring_sine

% Last Modified by GUIDE v2.5 27-Jul-2015 11:55:46

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @beam_spring_sine_OpeningFcn, ...
                   'gui_OutputFcn',  @beam_spring_sine_OutputFcn, ...
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


% --- Executes just before beam_spring_sine is made visible.
function beam_spring_sine_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to beam_spring_sine (see VARARGIN)

% Choose default command line output for beam_spring_sine
handles.output = hObject;

set(handles.uipanel_results,'Visible','off');

iu=getappdata(0,'unit');

if(iu==1)
   set(handles.text_force,'String','lbf'); 
else
   set(handles.text_force,'String','N');     
end


% Update handles structure
guidata(hObject, handles);

% UIWAIT makes beam_spring_sine wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = beam_spring_sine_OutputFcn(hObject, eventdata, handles) 
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

delete(beam_spring_sine);


% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

tpi=2*pi;
 
 freq=str2num(get(handles.edit_freq,'String'));
force=str2num(get(handles.edit_force,'String'));
  
        
      damp=getappdata(0,'damp_ratio');
ModeShapes=getappdata(0,'ModeShapes_full');
        fn=getappdata(0,'fn');
        iu=getappdata(0,'unit');
        xx=getappdata(0,'xx');
         E=getappdata(0,'E');        
       cna=getappdata(0,'cna');  
         L=getappdata(0,'L'); 
        
 
%
sz=size(ModeShapes);
dof=(sz(1));
 
%
QE=ModeShapes;
fnv=fn;
dampv=damp;
nf=length(freq);
num_modes=length(fnv);
%
omn=tpi*fnv;
omn2=omn.*omn;
%

%
omega=zeros(nf,1);
omega2=zeros(nf,1);
%
for i=1:nf
    omega(i)=2*pi*freq(i);
    omega2(i)=(omega(i))^2;
end
%
nrb=0;
for i=1:num_modes
    if(fn(i)<0.001)
        nrb=nrb+1;
    end
end
%
if(nrb>=1)
    disp(' ');
    out1=sprintf(' %d Rigid-body modes detected. \n\n Rigid-body modes will be suppressed.',nrb);
    disp(out1);
end
%
num_columns=get(handles.listbox_number_modes,'Value');

out1=sprintf('\n    Total number of modes =%d',num_modes);
disp(out1);
out2=sprintf(' Included number of modes =%d \n',num_columns);
disp(out2);


%
sz=size(QE);
if(num_columns>sz(2))
    num_columns=sz(2);
end
%
ii=get(handles.listbox_response_location,'Value');
kk=get(handles.listbox_force_location,'Value');
 
ns=dof-2;
 
aa=round(ns/4)+1;
bb=round(ns/2)+1;
cc=round(3*ns/4)+1;
 
nn=[1 aa bb cc dof-1];
 
i=nn(ii);
k=nn(kk);
 
 
disp('  ');
 
disp('Length  dof Reference ');
disp(' ');
out1=sprintf('     0   %d',nn(1));
out2=sprintf(' 1/4 L   %d',nn(2));
out3=sprintf(' 1/2 L   %d',nn(3));
out4=sprintf(' 3/4 L   %d',nn(4));
out5=sprintf('     L   %d',nn(5));
 
disp(out1);
disp(out2);
disp(out3);
disp(out4);
disp(out5);
 
%%%

iam=1;
    [H_disp_force]=...
    transfer_core(freq,fnv,dampv,QE,omn2,omega,omega2,iam,nf,num_columns,i,k,nrb);
    HM_disp=abs(H_disp_force);
    HP_disp=-atan2(imag(H_disp_force),real(H_disp_force))*180/pi;

    d_f_mag=HM_disp;
    d_f_mag_phase=[freq HP_disp];
    d_f_mag_complex=H_disp_force;

iam=2;
    [H_velox_force]=...
    transfer_core(freq,fnv,dampv,QE,omn2,omega,omega2,iam,nf,num_columns,i,k,nrb);
    HM_velox=abs(H_velox_force);
    HP_velox=-atan2(imag(H_velox_force),real(H_velox_force))*180/pi;

    v_f_mag=HM_velox;
    v_f_mag_phase=[freq HP_velox];
    v_f_mag_complex=H_velox_force;

iam=3;
    [H_accel_force]=...
    transfer_core(freq,fnv,dampv,QE,omn2,omega,omega2,iam,nf,num_columns,i,k,nrb);

    if(iu==1)
        scale=386;
    else
        scale=9.81;
    end
    
    H_accel_force= H_accel_force/scale;

    HM_accel=abs(H_accel_force); 
    HP_accel=-atan2(imag(H_accel_force),real(H_accel_force))*180/pi;
    
    a_f_mag_phase=[freq HP_accel];
    a_f_mag_complex=H_accel_force;

iam=6;    
    
    [H_stress_force]=...
    transfer_beam_stress_fea(freq,fnv,dampv,QE,omn2,nf,num_columns,i,k,nrb,ii,xx,E,cna,L);

    HM_stress=abs(H_stress_force); 
    HP_stress=-atan2(imag(H_stress_force),real(H_stress_force))*180/pi; 

    stress_f_mag=[freq HM_stress];
    stress_f_mag_phase=[freq HM_stress HP_stress];
    stress_f_mag_complex=[freq H_stress_force];

%%%%%%

disp(' ');
disp(' Response ');
disp(' ');


if(iu==1)
  out1=sprintf('   Displacement = %7.3g in',force*HM_disp);
  out2=sprintf('\n       Velocity = %7.3g in/sec',force*HM_velox);
  out3=sprintf('\n   Acceleration = %7.3g G',force*HM_accel);  
  out4=sprintf('\n Bending Stress = %7.3g ksi',force*HM_stress/1000);  
else
  out1=sprintf('   Displacement = %7.3g mm',1000*force*HM_disp);
  out2=sprintf('\n       Velocity = %7.3g cm/sec',100*force*HM_velox);
  out3=sprintf('\n   Acceleration = %7.3g G',force*HM_accel);      
  out4=sprintf('\n Bending Stress = %7.3g Pa',force*HM_stress);  
end

disp(out1);
disp(out2);
disp(out3);
disp(out4);

set(handles.uipanel_results,'Visible','on');

ss=strcat(out1,out2);
sss=strcat(ss,out3);
ssss=strcat(sss,out4);

set(handles.edit_results,'String',ssss);



function edit_freq_Callback(hObject, eventdata, handles)
% hObject    handle to edit_freq (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_freq as text
%        str2double(get(hObject,'String')) returns contents of edit_freq as a double


% --- Executes during object creation, after setting all properties.
function edit_freq_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_freq (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_force_Callback(hObject, eventdata, handles)
% hObject    handle to edit_force (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_force as text
%        str2double(get(hObject,'String')) returns contents of edit_force as a double


% --- Executes during object creation, after setting all properties.
function edit_force_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_force (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_force_location.
function listbox_force_location_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_force_location (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_force_location contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_force_location
set(handles.uipanel_results,'Visible','off');

% --- Executes during object creation, after setting all properties.
function listbox_force_location_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_force_location (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_response_location.
function listbox_response_location_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_response_location (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_response_location contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_response_location
set(handles.uipanel_results,'Visible','off');

% --- Executes during object creation, after setting all properties.
function listbox_response_location_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_response_location (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_number_modes.
function listbox_number_modes_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_number_modes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_number_modes contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_number_modes
set(handles.uipanel_results,'Visible','off');

% --- Executes during object creation, after setting all properties.
function listbox_number_modes_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_number_modes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox3.
function listbox3_Callback(hObject, eventdata, handles)
% hObject    handle to listbox3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox3 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox3


% --- Executes during object creation, after setting all properties.
function listbox3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox3 (see GCBO)
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


% --- Executes on key press with focus on edit_freq and none of its controls.
function edit_freq_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_freq (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.uipanel_results,'Visible','off');


% --- Executes on key press with focus on edit_force and none of its controls.
function edit_force_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_force (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.uipanel_results,'Visible','off');

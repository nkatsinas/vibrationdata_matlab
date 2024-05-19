function varargout = beam_spring_force_frf(varargin)
% BEAM_SPRING_FORCE_FRF MATLAB code for beam_spring_force_frf.fig
%      BEAM_SPRING_FORCE_FRF, by itself, creates a new BEAM_SPRING_FORCE_FRF or raises the existing
%      singleton*.
%
%      H = BEAM_SPRING_FORCE_FRF returns the handle to a new BEAM_SPRING_FORCE_FRF or the handle to
%      the existing singleton*.
%
%      BEAM_SPRING_FORCE_FRF('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in BEAM_SPRING_FORCE_FRF.M with the given input arguments.
%
%      BEAM_SPRING_FORCE_FRF('Property','Value',...) creates a new BEAM_SPRING_FORCE_FRF or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before beam_spring_force_frf_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to beam_spring_force_frf_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help beam_spring_force_frf

% Last Modified by GUIDE v2.5 28-Jul-2015 17:28:24

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @beam_spring_force_frf_OpeningFcn, ...
                   'gui_OutputFcn',  @beam_spring_force_frf_OutputFcn, ...
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


% --- Executes just before beam_spring_force_frf is made visible.
function beam_spring_force_frf_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to beam_spring_force_frf (see VARARGIN)

% Choose default command line output for beam_spring_force_frf
handles.output = hObject;

set(handles.uipanel_save,'Visible','off');

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes beam_spring_force_frf wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = beam_spring_force_frf_OutputFcn(hObject, eventdata, handles) 
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

delete(beam_spring_force_frf);


% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


tpi=2*pi;

fmin=str2num(get(handles.fstart_edit,'String'));
fmax=str2num(get(handles.fend_edit,'String'));
  
    if(fmin<=0.01)
        fmin=0.01;
    end    
    
    minf=fmin;
    maxf=fmax;

      damp=getappdata(0,'damp_ratio');
ModeShapes=getappdata(0,'ModeShapes_full');
        fn=getappdata(0,'fn');
        iu=getappdata(0,'unit');
        xx=getappdata(0,'xx');
         E=getappdata(0,'E');        
       cna=getappdata(0,'cna');  
         L=getappdata(0,'L');
         
try
   fig_num=getappdata(0,'fig_num');
catch 
   fig_num=1;
end

if( length(fig_num)==0)
    fig_num=1;
end        

%
sz=size(ModeShapes);
dof=(sz(1));

%
N=48;
%
[freq,omega,np]=frequencies_octave_spaced(fmin,fmax,N);

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
out1=sprintf('\n number of modes =%d \n',num_modes);
disp(out1);
%
omega2=zeros(nf,1);
%
for i=1:nf
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


%
%%%%%%
%%%%%%

freq=fix_size(freq);

iam=1;
    [H_disp_force]=...
    transfer_core(freq,fnv,dampv,QE,omn2,omega,omega2,iam,nf,num_columns,i,k,nrb);
    HM_disp=abs(H_disp_force);
    HP_disp=-atan2(imag(H_disp_force),real(H_disp_force))*180/pi;
    ymax=max(HM_disp);
    ymin=min(HM_disp);
    [fig_num]=...
    transfer_from_modes_plots2(iu,iam,i,k,fig_num,minf,maxf,ymin,ymax,freq,HM_disp,HP_disp);
    d_f_mag=[freq HM_disp];
    d_f_mag_phase=[freq HM_disp HP_disp];
    d_f_mag_complex=[freq H_disp_force];
    
iam=2;
    [H_velox_force]=...
    transfer_core(freq,fnv,dampv,QE,omn2,omega,omega2,iam,nf,num_columns,i,k,nrb);
    HM_velox=abs(H_velox_force);
    HP_velox=-atan2(imag(H_velox_force),real(H_velox_force))*180/pi;
    ymax=max(HM_velox);
    ymin=min(HM_velox);    
    [fig_num]=...
    transfer_from_modes_plots2(iu,iam,i,k,fig_num,minf,maxf,ymin,ymax,freq,HM_velox,HP_velox);   
    v_f_mag=[freq HM_velox];
    v_f_mag_phase=[freq HM_velox HP_velox];
    v_f_mag_complex=[freq H_velox_force];

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
    ymax=max(HM_accel);
    ymin=min(HM_accel);    
    [fig_num]=...
    transfer_from_modes_plots2(iu,iam,i,k,fig_num,minf,maxf,ymin,ymax,freq,HM_accel,HP_accel);
    a_f_mag=[freq HM_accel];
    a_f_mag_phase=[freq HM_accel HP_accel];
    a_f_mag_complex=[freq H_accel_force];

%    
%%%%%%
%
try

    [H_stress_force]=...
    transfer_beam_stress_fea(freq,fnv,dampv,QE,omn2,nf,num_columns,i,k,nrb,ii,xx,E,cna,L);
   
    HM_stress=abs(H_stress_force); 
    HP_stress=-atan2(imag(H_stress_force),real(H_stress_force))*180/pi;  
    
    ymax=max(HM_stress);
    ymin=min(HM_stress);
    iam=6;
    [fig_num]=...
    transfer_from_modes_plots2(iu,iam,i,k,fig_num,minf,maxf,ymin,ymax,freq,HM_stress,HP_stress);    
    stress_f_mag=[freq HM_stress];
    stress_f_mag_phase=[freq HM_stress HP_stress];
    stress_f_mag_complex=[freq H_stress_force];
catch    
end
    
%
%%%%%%
%
    setappdata(0,'a_f_mag',a_f_mag);
    setappdata(0,'a_f_mag_phase',a_f_mag_phase);    
    setappdata(0,'a_f_mag_complex',a_f_mag_complex);       

    setappdata(0,'v_f_mag',v_f_mag);
    setappdata(0,'v_f_mag_phase',v_f_mag_phase);    
    setappdata(0,'v_f_mag_complex',v_f_mag_complex);  

    setappdata(0,'d_f_mag',d_f_mag);
    setappdata(0,'d_f_mag_phase',d_f_mag_phase);    
    setappdata(0,'d_f_mag_complex',d_f_mag_complex); 
    
    
    try
    
        setappdata(0,'stress_f_mag',stress_f_mag);
        setappdata(0,'stress_f_mag_phase',stress_f_mag_phase);    
        setappdata(0,'stress_f_mag_complex',stress_f_mag_complex);    
    
    end

    setappdata(0,'fig_num',fig_num);
%%%

set(handles.uipanel_save,'Visible','on');




function edit5_Callback(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit5 as text
%        str2double(get(hObject,'String')) returns contents of edit5 as a double


% --- Executes during object creation, after setting all properties.
function edit5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit6_Callback(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit6 as text
%        str2double(get(hObject,'String')) returns contents of edit6 as a double


% --- Executes during object creation, after setting all properties.
function edit6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit4_Callback(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit4 as text
%        str2double(get(hObject,'String')) returns contents of edit4 as a double


% --- Executes during object creation, after setting all properties.
function edit4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_save.
function pushbutton_save_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

na=get(handles.listbox_amplitude_type,'Value');
nf=get(handles.listbox_format,'Value');


if(na==1 && nf==1)
    data=getappdata(0,'a_f_mag');
end
if(na==1 && nf==2)
    data=getappdata(0,'a_f_mag_phase');    
end
if(na==1 && nf==3)
    data=getappdata(0,'a_f_mag_complex');       
end


if(na==2 && nf==1)
    data=getappdata(0,'v_f_mag');    
end
if(na==2 && nf==2)
    data=getappdata(0,'v_f_mag_phase');       
end
if(na==2 && nf==3)
    data=getappdata(0,'v_f_mag_complex');      
end


if(na==3 && nf==1)
    data=getappdata(0,'d_f_mag');        
end
if(na==3 && nf==2)
    data=getappdata(0,'d_f_mag_phase');       
end
if(na==3 && nf==3)
    data=getappdata(0,'d_f_mag_complex');       
end


if(na==4 && nf==1)
    data=getappdata(0,'stress_f_mag');
end
if(na==4 && nf==2)
    data=getappdata(0,'stress_f_mag_phase');    
end
if(na==4 && nf==3)
    data=getappdata(0,'stress_f_mag_complex');       
end


output_name=get(handles.edit_output_array,'String');
assignin('base', output_name, data);
 
msgbox('Data saved');


% --- Executes on selection change in listbox_amplitude_type.
function listbox_amplitude_type_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_amplitude_type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_amplitude_type contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_amplitude_type


% --- Executes during object creation, after setting all properties.
function listbox_amplitude_type_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_amplitude_type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_output_array_Callback(hObject, eventdata, handles)
% hObject    handle to edit_output_array (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_output_array as text
%        str2double(get(hObject,'String')) returns contents of edit_output_array as a double


% --- Executes during object creation, after setting all properties.
function edit_output_array_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_output_array (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_format.
function listbox_format_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_format (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_format contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_format


% --- Executes during object creation, after setting all properties.
function listbox_format_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_format (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function fstart_edit_Callback(hObject, eventdata, handles)
% hObject    handle to fstart_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of fstart_edit as text
%        str2double(get(hObject,'String')) returns contents of fstart_edit as a double


% --- Executes during object creation, after setting all properties.
function fstart_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to fstart_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function fend_edit_Callback(hObject, eventdata, handles)
% hObject    handle to fend_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of fend_edit as text
%        str2double(get(hObject,'String')) returns contents of fend_edit as a double


% --- Executes during object creation, after setting all properties.
function fend_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to fend_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
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
set(handles.uipanel_save,'Visible','off');

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


% --- Executes on selection change in listbox_force_location.
function listbox_force_location_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_force_location (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_force_location contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_force_location
set(handles.uipanel_save,'Visible','off');

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
set(handles.uipanel_save,'Visible','off');

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


% --- Executes on key press with focus on fstart_edit and none of its controls.
function fstart_edit_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to fstart_edit (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.uipanel_save,'Visible','off');


% --- Executes on key press with focus on fend_edit and none of its controls.
function fend_edit_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to fend_edit (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.uipanel_save,'Visible','off');

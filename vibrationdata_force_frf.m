function varargout = vibrationdata_force_frf(varargin)
% VIBRATIONDATA_FORCE_FRF MATLAB code for vibrationdata_force_frf.fig
%      VIBRATIONDATA_FORCE_FRF, by itself, creates a new VIBRATIONDATA_FORCE_FRF or raises the existing
%      singleton*.
%
%      H = VIBRATIONDATA_FORCE_FRF returns the handle to a new VIBRATIONDATA_FORCE_FRF or the handle to
%      the existing singleton*.
%
%      VIBRATIONDATA_FORCE_FRF('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in VIBRATIONDATA_FORCE_FRF.M with the given input arguments.
%
%      VIBRATIONDATA_FORCE_FRF('Property','Value',...) creates a new VIBRATIONDATA_FORCE_FRF or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before vibrationdata_force_frf_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to vibrationdata_force_frf_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help vibrationdata_force_frf

% Last Modified by GUIDE v2.5 24-Apr-2015 17:38:57

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @vibrationdata_force_frf_OpeningFcn, ...
                   'gui_OutputFcn',  @vibrationdata_force_frf_OutputFcn, ...
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


% --- Executes just before vibrationdata_force_frf is made visible.
function vibrationdata_force_frf_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to vibrationdata_force_frf (see VARARGIN)

% Choose default command line output for vibrationdata_force_frf
handles.output = hObject;

set(handles.uipanel_save,'Visible','off');

fn=getappdata(0,'fn');

num=length(fn);

if(length(num)>0)
    num_columns=num;
    ss=sprintf('%d',num_columns);
    set(handles.edit_num_columns,'String',ss);
else
    warndlg('Natural frequency vector not found. ');
    return;
end

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes vibrationdata_force_frf wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = vibrationdata_force_frf_OutputFcn(hObject, eventdata, handles) 
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

delete(vibrationdata_force_frf);


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

      damp=getappdata(0,'damping');
ModeShapes=getappdata(0,'ModeShapes');
        fn=getappdata(0,'fn');
        iu=getappdata(0,'unit');

             
try
   fig_num=getappdata(0,'fig_num');
catch 
   fig_num=1;
end

if( length(fig_num)==0)
    fig_num=1;
end        

%
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
out1=sprintf('\n number of dofs =%d \n',num_modes);
disp(out1);
%
omega2=zeros(nf,1);
%
for i=1:nf
    omega2(i)=(omega(i))^2;
end
%
nrb=0; % leave as zero
%
num_columns=str2num(get(handles.edit_num_columns,'String'));
%
sz=size(QE);
if(num_columns>sz(2))
    num_columns=sz(2);
end
%
i=str2num(get(handles.edit_response_dof,'String'));
k=str2num(get(handles.edit_force_dof,'String'));
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
    d_f_mag_phase=[freq HP_disp];
    d_f_mag_complex=H_disp_force;
      
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
    ymax=max(HM_accel);
    ymin=min(HM_accel);    
    [fig_num]=...
    transfer_from_modes_plots2(iu,iam,i,k,fig_num,minf,maxf,ymin,ymax,freq,HM_accel,HP_accel);
    a_f_mag=[freq HM_accel];
    a_f_mag_phase=[freq HP_accel];
    a_f_mag_complex=H_accel_force;

%%%%%%
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

    setappdata(0,'fig_num',fig_num);
%%%

set(handles.uipanel_save,'Visible','on');


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



function edit_num_columns_Callback(hObject, eventdata, handles)
% hObject    handle to edit_num_columns (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_num_columns as text
%        str2double(get(hObject,'String')) returns contents of edit_num_columns as a double


% --- Executes during object creation, after setting all properties.
function edit_num_columns_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_num_columns (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_force_dof_Callback(hObject, eventdata, handles)
% hObject    handle to edit_force_dof (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_force_dof as text
%        str2double(get(hObject,'String')) returns contents of edit_force_dof as a double


% --- Executes during object creation, after setting all properties.
function edit_force_dof_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_force_dof (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_response_dof_Callback(hObject, eventdata, handles)
% hObject    handle to edit_response_dof (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_response_dof as text
%        str2double(get(hObject,'String')) returns contents of edit_response_dof as a double


% --- Executes during object creation, after setting all properties.
function edit_response_dof_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_response_dof (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function varargout = vibrationdata_two_dof_psd_force(varargin)
% VIBRATIONDATA_TWO_DOF_PSD_FORCE MATLAB code for vibrationdata_two_dof_psd_force.fig
%      VIBRATIONDATA_TWO_DOF_PSD_FORCE, by itself, creates a new VIBRATIONDATA_TWO_DOF_PSD_FORCE or raises the existing
%      singleton*.
%
%      H = VIBRATIONDATA_TWO_DOF_PSD_FORCE returns the handle to a new VIBRATIONDATA_TWO_DOF_PSD_FORCE or the handle to
%      the existing singleton*.
%
%      VIBRATIONDATA_TWO_DOF_PSD_FORCE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in VIBRATIONDATA_TWO_DOF_PSD_FORCE.M with the given input arguments.
%
%      VIBRATIONDATA_TWO_DOF_PSD_FORCE('Property','Value',...) creates a new VIBRATIONDATA_TWO_DOF_PSD_FORCE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before vibrationdata_two_dof_psd_force_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to vibrationdata_two_dof_psd_force_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help vibrationdata_two_dof_psd_force

% Last Modified by GUIDE v2.5 18-Nov-2019 15:49:51

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @vibrationdata_two_dof_psd_force_OpeningFcn, ...
                   'gui_OutputFcn',  @vibrationdata_two_dof_psd_force_OutputFcn, ...
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


% --- Executes just before vibrationdata_two_dof_psd_force is made visible.
function vibrationdata_two_dof_psd_force_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to vibrationdata_two_dof_psd_force (see VARARGIN)

% Choose default command line output for vibrationdata_two_dof_psd_force
handles.output = hObject;


iu=getappdata(0,'unit');

if(iu==1)
    ss='The input array must have two columns:  freq (Hz) & force (lbf^2/Hz)';
else
    ss='The input array must have two columns:  freq (Hz) & force (N^2/Hz)';    
end

set(handles.text_instruction,'String',ss);

set(handles.uipanel_save,'Visible','off');


% Update handles structure
guidata(hObject, handles);

% UIWAIT makes vibrationdata_two_dof_psd_force wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = vibrationdata_two_dof_psd_force_OutputFcn(hObject, eventdata, handles) 
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

delete(vibrationdata_two_dof_psd_force);


% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


disp(' ');
disp(' * * * * * ');
disp(' ');


tpi=2*pi;

      damp=getappdata(0,'damping');
ModeShapes=getappdata(0,'ModeShapes');
        fn=getappdata(0,'fn');
        iu=getappdata(0,'unit');
        

 try
     FS=get(handles.edit_input_array,'String');
     THM=evalin('base',FS);   
 catch
     warndlg('Input array does not exist.');
     return;
 end
 
fig_num=getappdata(0,'fig_num');

if(length(fig_num)==0)
    fig_num=1;
end

num=length(THM(:,1));

fmin=THM(1,1);
fmax=THM(num,1);

N=48;
%
[freq,omega,np]=frequencies_octave_spaced(fmin,fmax,N);

[fpsd]=interp_psd_oct(THM(:,1),THM(:,2),freq);

%%%%%%%%%%%%%%%%

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

%%%%%%
%%%%%%

freq=fix_size(freq);
numf=length(freq);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

h_disp_complex=zeros(nf,2);

num_columns=2;

kd=get(handles.listbox_dof,'Value');

H_disp_force_complex=zeros(numf,2,2);
H_velox_force_complex=zeros(numf,2,2);
H_accel_force_complex=zeros(numf,2,2);


for i=1:2
    
    for k=1:2

%    
        iam=1;
        [H_disp_force]=transfer_core_np(freq,fnv,dampv,QE,omn2,omega,omega2,iam,nf,num_columns,i,k,nrb);

        if(iu==2)
            H_disp_force=H_disp_force*1000;
        end   
    
        H_disp_force_complex(:,i,k)=H_disp_force;
%    
        
        iam=2;
        [H_velox_force]=transfer_core_np(freq,fnv,dampv,QE,omn2,omega,omega2,iam,nf,num_columns,i,k,nrb);
        H_velox_force_complex(:,i,k)=H_velox_force;

        
        iam=3;
        [H_accel_force]=transfer_core_np(freq,fnv,dampv,QE,omn2,omega,omega2,iam,nf,num_columns,i,k,nrb);

        if(iu==1)
            scale=386;
        else
            scale=9.81;
        end
    
        H_accel_force_complex(:,i,k)=H_accel_force/scale;
    
    end
    
end    

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

accel_psd=zeros(numf,2);   
vel_psd=zeros(numf,2);    
disp_psd=zeros(numf,2);    
disp_psd_complex=zeros(numf,2); 
rel_disp_psd=zeros(numf,1);


if(kd==1)
        S=[1 0; 0 0];
end
if(kd==2)
        S=[0 0; 0 1];
end    
if(kd==3)
        S=[1 1; 1 1];
end
if(kd==4)
        S=[1 0; 0 1];
end     


for i=1:numf
  

    
    S=S*fpsd(i);

%    
    H=[H_accel_force_complex(i,1,1)  H_accel_force_complex(i,1,2); H_accel_force_complex(i,2,1)  H_accel_force_complex(i,2,2) ];
    HC=conj(H);
    
    size(H);
    size(S);
    size(HC);
    
    a=H*S*HC';
%
    H=[H_velox_force_complex(i,1,1)  H_velox_force_complex(i,1,2); H_velox_force_complex(i,2,1)  H_velox_force_complex(i,2,2) ];
    HC=conj(H);
    v=H*S*HC';
%
    H=[H_disp_force_complex(i,1,1)  H_disp_force_complex(i,1,2); H_disp_force_complex(i,2,1)  H_disp_force_complex(i,2,2) ];
    HC=conj(H);
    d=H*S*HC';
%
    accel_psd(i,:)=abs(diag(a));
    vel_psd(i,:)=abs(diag(v));
    disp_psd(i,:)=abs(diag(d));

    disp_psd_complex(i,:)=diag(d);
    
end


dr=zeros(2,1);
vr=zeros(2,1);
ar=zeros(2,1);
 
for j=1:2
    
    for i=1:numf
         
         if(j==1)
            rel_disp_psd(i)=disp_psd_complex(i,2)-disp_psd_complex(i,1);      
         end
    end
    
    [s,drms] = calculate_PSD_slopes(freq,disp_psd(:,j));
    [s,vrms] = calculate_PSD_slopes(freq,vel_psd(:,j));
    [s,arms] = calculate_PSD_slopes(freq,accel_psd(:,j));
    
    dr(j)=drms;
    vr(j)=vrms;
    ar(j)=arms;
    
end

rel_disp_psd=abs(rel_disp_psd);

[s,rdr] = calculate_PSD_slopes(freq,rel_disp_psd);


%%%%%%%%%%%%%%%%

x_label='Frequency (Hz)';

if(iu==1)
    y_label_d='Disp (in^2/Hz)';  
    y_label_v='Vel ((in/sec)^2/Hz)'; 
    
    t_string_d='Displacement PSD';
    t_string_v='Velocity PSD';
    
    t_string_rd=sprintf(' Relative Displacement PSD %6.3g inch RMS',rdr);    
    
else
    y_label_d='Disp (mm^2/Hz)'; 
    y_label_v='Vel ((m/sec)^2/Hz)';  
    
    t_string_d='Displacement PSD';
    t_string_v='Velocity PSD';   
    
    t_string_rd=sprintf(' Relative Displacement PSD %6.3g mm RMS',rdr);
    
end

y_label_a='Accel (G^2/Hz)';
t_string_a='Acceleration PSD';

freq=fix_size(freq);

rel_disp_psd=[freq rel_disp_psd];
    disp_psd=[freq disp_psd];
     vel_psd=[freq vel_psd];
   accel_psd=[freq accel_psd];

[fig_num,h2]=plot_PSD_function(fig_num,x_label,y_label_d,t_string_rd,rel_disp_psd,fmin,fmax);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

ppp=[disp_psd(:,1) disp_psd(:,2) ];
qqq=[disp_psd(:,1) disp_psd(:,3) ];

if(iu==1)
    leg_a=sprintf('dof 1 %6.3g in RMS',dr(1));
    leg_b=sprintf('dof 2 %6.3g in RMS',dr(2));
else
    leg_a=sprintf('dof 1 %6.3g mm RMS',dr(1));
    leg_b=sprintf('dof 2 %6.3g mm RMS',dr(2));    
end

[fig_num,h2]=...
      plot_PSD_two_h2(fig_num,x_label,y_label_d,t_string_d,ppp,qqq,leg_a,leg_b);

     

ppp=[vel_psd(:,1) vel_psd(:,2) ];
qqq=[vel_psd(:,1) vel_psd(:,3) ];

if(iu==1)
    leg_a=sprintf('dof 1 %6.3g in/sec RMS',vr(1));
    leg_b=sprintf('dof 2 %6.3g in/sec RMS',vr(2));
else
    leg_a=sprintf('dof 1 %6.3g mm/sec RMS',vr(1));
    leg_b=sprintf('dof 2 %6.3g mm/sec RMS',vr(2));   
end

[fig_num,h2]=...
      plot_PSD_two_h2(fig_num,x_label,y_label_v,t_string_v,ppp,qqq,leg_a,leg_b);     
     
          
ppp=[accel_psd(:,1) accel_psd(:,2) ];
qqq=[accel_psd(:,1) accel_psd(:,3) ];

leg_a=sprintf('dof 1 %6.3g GRMS',ar(1));
leg_b=sprintf('dof 2 %6.3g GRMS',ar(2));


[fig_num,h2]=...
      plot_PSD_two_h2(fig_num,x_label,y_label_a,t_string_a,ppp,qqq,leg_a,leg_b);     
     
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
     
setappdata(0,'rel_disp_psd',rel_disp_psd);
setappdata(0,'disp_psd',disp_psd);
setappdata(0,'vel_psd',vel_psd);
setappdata(0,'accel_psd',accel_psd);

set(handles.uipanel_save,'Visible','on');



% --- Executes on selection change in listbox_dof.
function listbox_dof_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_dof (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_dof contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_dof




% --- Executes during object creation, after setting all properties.
function listbox_dof_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_dof (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_input_array_Callback(hObject, eventdata, handles)
% hObject    handle to edit_input_array (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_input_array as text
%        str2double(get(hObject,'String')) returns contents of edit_input_array as a double


% --- Executes during object creation, after setting all properties.
function edit_input_array_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_input_array (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

n=get(handles.listbox_save,'Value');

if(n==1)
    data=getappdata(0,'rel_disp_psd');
end   
if(n==2)
    data=getappdata(0,'disp_psd');
end    
if(n==3)
    data=getappdata(0,'vel_psd');
end    
if(n==4)
    data=getappdata(0,'accel_psd');
end

output_array=get(handles.edit_output_array,'String');
assignin('base', output_array, data);

h = msgbox('Save Complete'); 


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


% --- Executes on selection change in listbox_save.
function listbox_save_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_save contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_save


% --- Executes during object creation, after setting all properties.
function listbox_save_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_reference.
function pushbutton_reference_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_reference (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

     A = imread('MDOF_force_PSD_response.jpg');
     figure(999) 
     imshow(A,'border','tight','InitialMagnification',100) 


% --- Executes during object creation, after setting all properties.
function pushbutton_reference_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pushbutton_reference (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

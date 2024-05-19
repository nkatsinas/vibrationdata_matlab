function varargout = three_dof_PSD_base(varargin)
% THREE_DOF_PSD_BASE MATLAB code for three_dof_PSD_base.fig
%      THREE_DOF_PSD_BASE, by itself, creates a new THREE_DOF_PSD_BASE or raises the existing
%      singleton*.
%
%      H = THREE_DOF_PSD_BASE returns the handle to a new THREE_DOF_PSD_BASE or the handle to
%      the existing singleton*.
%
%      THREE_DOF_PSD_BASE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in THREE_DOF_PSD_BASE.M with the given input arguments.
%
%      THREE_DOF_PSD_BASE('Property','Value',...) creates a new THREE_DOF_PSD_BASE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before three_dof_PSD_base_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to three_dof_PSD_base_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help three_dof_PSD_base

% Last Modified by GUIDE v2.5 03-Jan-2017 18:23:41

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @three_dof_PSD_base_OpeningFcn, ...
                   'gui_OutputFcn',  @three_dof_PSD_base_OutputFcn, ...
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


% --- Executes just before three_dof_PSD_base is made visible.
function three_dof_PSD_base_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to three_dof_PSD_base (see VARARGIN)

% Choose default command line output for three_dof_PSD_base
handles.output = hObject;


iu=getappdata(0,'unit');

if(iu==1)
    ss='The input array must have two columns:  freq (Hz) & accel (G^2/Hz)';
else
    ss='The input array must have two columns:  freq (Hz) & accel ((m/sec^2)^2/Hz)';    
end

set(handles.text_instruction,'String',ss);

set(handles.uipanel_save,'Visible','off');


% Update handles structure
guidata(hObject, handles);

% UIWAIT makes three_dof_PSD_base wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = three_dof_PSD_base_OutputFcn(hObject, eventdata, handles) 
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

delete(three_dof_PSD_base);


% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


try

    Figures = findobj( 'Type', 'Figure' , '-not' , 'Tag' , get( handles.output , 'Tag' ) );
    NFigures = length( Figures );
    for nFigures = 1 : NFigures
        close( Figures( nFigures ) );
    end
catch
end  

tpi=2*pi;

      damp=getappdata(0,'damp_ratio');
ModeShapes=getappdata(0,'ModeShapes');
        fn=getappdata(0,'fn');
        iu=getappdata(0,'unit');
 base_mass=getappdata(0,'base_mass');        

 try
     FS=get(handles.edit_input_array,'String');
     THM=evalin('base',FS);   
 catch
     warndlg('Input array does not exist.');
     return;
 end
 
fig_num=getappdata(0,'fig_num');

if(isempty(fig_num))
    fig_num=1;
end

num=length(THM(:,1));

fmin=THM(1,1);
fmax=THM(num,1);

N=48;
%
[freq,omega,~]=frequencies_octave_spaced(fmin,fmax,N);

[apsd]=interp_psd_oct(THM(:,1),THM(:,2),freq);


if(iu==1)
   apsd=apsd*386^2; 
else
   apsd=apsd*9.81^2; 
end

fpsd=apsd*base_mass^2;

%%%%%%%%%%%%%%%%


%
QE=ModeShapes;
fnv=fn;
dampv=damp;
nf=length(freq);
num_modes=length(fnv);
ndof=length(fnv);
%
omn=tpi*fnv;
omn2=omn.*omn;
%
fprintf('\n number of dofs =%d \n\n',num_modes);

%
omega2=zeros(nf,1);
%
for i=1:nf
    omega2(i)=(omega(i))^2;
end
%
nrb=0;  % leave as is
%

%%%%%%
%%%%%%

freq=fix_size(freq);
numf=length(freq);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

h_disp_complex=zeros(nf,2);

num_columns=ndof;

k=1; % base excitation

HM_disp=zeros(numf,2);
HM_velox=zeros(numf,2);
HM_accel=zeros(numf,2);

for i=1:ndof

    iam=1;
    [H_disp_force]=...
    transfer_core_np(freq,fnv,dampv,QE,omn2,omega,omega2,iam,nf,num_columns,i,k,nrb);

    if(iu==2)
        H_disp_force=H_disp_force*1000;
    end   
    
    HM_disp(:,i)=abs(H_disp_force);
    h_disp_complex(:,i)=H_disp_force;
      
    iam=2;
    [H_velox_force]=...
    transfer_core_np(freq,fnv,dampv,QE,omn2,omega,omega2,iam,nf,num_columns,i,k,nrb);
    HM_velox(:,i)=abs(H_velox_force);

    iam=3;
    [H_accel_force]=...
    transfer_core_np(freq,fnv,dampv,QE,omn2,omega,omega2,iam,nf,num_columns,i,k,nrb);

    if(iu==1)
        scale=386;
    else
        scale=9.81;
    end
    
    H_accel_force=H_accel_force/scale;
    
    HM_accel(:,i)=abs(H_accel_force);
   
end    

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

accel_psd=zeros(numf,ndof);   
vel_psd=zeros(numf,ndof);    
disp_psd=zeros(numf,ndof);    
rel_disp_psd=zeros(numf,(ndof-1));     

dr=zeros(ndof,1);
vr=zeros(ndof,1);
ar=zeros(ndof,1);
 
for j=1:ndof
    
    for i=1:numf
        accel_psd(i,j)=(HM_accel(i,j)^2)*fpsd(i);
          vel_psd(i,j)=(HM_velox(i,j)^2)*fpsd(i);
         disp_psd(i,j)=(HM_disp(i,j)^2)*fpsd(i);
         
         if(j==2)
            rd21=abs(h_disp_complex(i,2)-h_disp_complex(i,1)); 
            rel_disp_psd(i,j-1)=(rd21^2)*fpsd(i);             
         end
         if(j==3)
            rd32=abs(h_disp_complex(i,3)-h_disp_complex(i,2)); 
            rel_disp_psd(i,j-1)=(rd32^2)*fpsd(i);             
         end         
         
         
    end
    
    rel_disp_psd=abs(rel_disp_psd);
    
    [s,drms] = calculate_PSD_slopes_no(freq,disp_psd(:,j));
    [s,vrms] = calculate_PSD_slopes_no(freq,vel_psd(:,j));
    [s,arms] = calculate_PSD_slopes_no(freq,accel_psd(:,j));
    
    dr(j)=drms;
    vr(j)=vrms;
    ar(j)=arms;
    
end

[~,rdr21] = calculate_PSD_slopes_no(freq,rel_disp_psd(:,1));
[~,rdr32] = calculate_PSD_slopes_no(freq,rel_disp_psd(:,2));

%%%%%%%%%%%%%%%%

x_label='Frequency (Hz)';

if(iu==1)
    y_label_d='Disp (in^2/Hz)';  
    y_label_v='Vel ((in/sec)^2/Hz)'; 
    
    t_string_d='Displacement PSD';
    t_string_v='Velocity PSD';
    
    t_string_rd=sprintf(' Relative Displacement PSD ');    

    leg1=sprintf('Mass 1 - Base Mass %6.3g in rms',rdr21);
    leg2=sprintf('Mass 2 - Mass 1 %6.3g in rms',rdr32);
    
    
else
    y_label_d='Disp (mm^2/Hz)'; 
    y_label_v='Vel ((m/sec)^2/Hz)';  
    
    t_string_d='Displacement PSD';
    t_string_v='Velocity PSD';   
    
    t_string_rd=sprintf(' Relative Displacement PSD ');
    
    leg1=sprintf('Mass 1 - Base Mass %6.3g mm',rd21);
    leg2=sprintf('Mass 2 - Mass 1 %6.3g mm',rd32);   
    
end


freq=fix_size(freq);

ppp1=[freq rel_disp_psd(:,1)];
ppp2=[freq rel_disp_psd(:,2)];


rel_disp_psd=[freq rel_disp_psd];
%    disp_psd=[freq disp_psd];
%     vel_psd=[freq vel_psd];
   accel_psd=[freq accel_psd];
   
md=5;

[fig_num,h2]=plot_loglog_function_md_two_h2(fig_num,x_label,...
               y_label_d,t_string_rd,ppp1,ppp2,leg1,leg2,fmin,fmax,md);
%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
          
ppp1=[accel_psd(:,1) accel_psd(:,2) ];
ppp2=[accel_psd(:,1) accel_psd(:,3) ];
ppp3=[accel_psd(:,1) accel_psd(:,4) ];

leg1=sprintf('Base Mass %6.3g GRMS',ar(1));
leg2=sprintf('Mass 1 %6.3g GRMS',ar(2));
leg3=sprintf('Mass 2 %6.3g GRMS',ar(3));

y_label='Accel (G^2/Hz)';
t_string='Acceleration Power Spectral Density';

md=5;

[fig_num]=plot_loglog_function_md_three(fig_num,x_label,...
               y_label,t_string,ppp1,ppp2,ppp3,leg1,leg2,leg3,fmin,fmax,md);  
  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
     
setappdata(0,'rel_disp_psd',rel_disp_psd);
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

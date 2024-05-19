function varargout = ESA_simple_launcher_spacecraft_model(varargin)
% ESA_SIMPLE_LAUNCHER_SPACECRAFT_MODEL MATLAB code for ESA_simple_launcher_spacecraft_model.fig
%      ESA_SIMPLE_LAUNCHER_SPACECRAFT_MODEL, by itself, creates a new ESA_SIMPLE_LAUNCHER_SPACECRAFT_MODEL or raises the existing
%      singleton*.
%
%      H = ESA_SIMPLE_LAUNCHER_SPACECRAFT_MODEL returns the handle to a new ESA_SIMPLE_LAUNCHER_SPACECRAFT_MODEL or the handle to
%      the existing singleton*.
%
%      ESA_SIMPLE_LAUNCHER_SPACECRAFT_MODEL('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ESA_SIMPLE_LAUNCHER_SPACECRAFT_MODEL.M with the given input arguments.
%
%      ESA_SIMPLE_LAUNCHER_SPACECRAFT_MODEL('Property','Value',...) creates a new ESA_SIMPLE_LAUNCHER_SPACECRAFT_MODEL or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before ESA_simple_launcher_spacecraft_model_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to ESA_simple_launcher_spacecraft_model_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help ESA_simple_launcher_spacecraft_model

% Last Modified by GUIDE v2.5 03-Aug-2017 14:41:17

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ESA_simple_launcher_spacecraft_model_OpeningFcn, ...
                   'gui_OutputFcn',  @ESA_simple_launcher_spacecraft_model_OutputFcn, ...
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


% --- Executes just before ESA_simple_launcher_spacecraft_model is made visible.
function ESA_simple_launcher_spacecraft_model_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to ESA_simple_launcher_spacecraft_model (see VARARGIN)

% Choose default command line output for ESA_simple_launcher_spacecraft_model
handles.output = hObject;

set(handles.units_listbox,'Value',2);
units_listbox_Callback(hObject, eventdata, handles);

fstr='threedof1_sm.jpg';

bg = imread(fstr);
info = imfinfo(fstr);
w = info.Width;  %An integer indicating the width of the image in pixels
h = info.Height; %An integer indicating the height of the image in pixels
 
axes(handles.axes1);
image(bg);

pos1 = getpixelposition(handles.pushbutton_return,true);
pos2 = getpixelposition(handles.uipanel_data,true);
 
set(handles.axes1, ...
    'Visible', 'off', ...
    'Units', 'pixels', ...
    'Position', [pos1(1) pos2(2) w h]);
axis off;
 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% Update handles structure
guidata(hObject, handles);

% UIWAIT makes ESA_simple_launcher_spacecraft_model wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = ESA_simple_launcher_spacecraft_model_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in units_listbox.
function units_listbox_Callback(hObject, eventdata, handles)
% hObject    handle to units_listbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns units_listbox contents as cell array
%        contents{get(hObject,'Value')} returns selected item from units_listbox
n=get(handles.units_listbox,'Value');

if(n==1)
    set(handles.mass_unit_text,'String','Mass Unit: lbm');
    set(handles.stiffness_unit_text,'String','Stiffness Unit: lbf/in');    
else
    set(handles.mass_unit_text,'String','Mass Unit: kg'); 
    set(handles.stiffness_unit_text,'String','Stiffness Unit: N/m');     
end

% --- Executes during object creation, after setting all properties.
function units_listbox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to units_listbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

fig_num=1;

md=5;

x_label='Frequency (Hz)';

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

iu=get(handles.units_listbox,'value');

Q1=str2num( get(handles.edit_Q1,'String' ));
Q2=str2num( get(handles.edit_Q2,'String' ));

Qm=[Q1 Q2];

damp_two=[ 1/(2*Q1)  1/(2*Q2) ];


m1=str2num( get(handles.edit_m1,'String' ));
m2=str2num( get(handles.edit_m2,'String' ));
m3=str2num( get(handles.edit_m3,'String' ));

k1=str2num( get(handles.stiffness1_edit,'String' ));
k2=str2num( get(handles.stiffness2_edit,'String' ));


fmin=str2num( get(handles.edit_fmin,'String' ));
fmax=str2num( get(handles.edit_fmax,'String' ));


i=1;

if(fmin==0)
    fmin=0.1;
end

freq(1)=fmin;
%
while(1)
   i=i+1;
   freq(i)=freq(i-1)*2^(1/96);
   if(freq(i)>fmax)
       freq(i)=fmax;
       break;
   end
end

freq=unique(freq);

freq=fix_size(freq);

nf=length(freq);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

mass=[m1 0 0; 0 m2 0; 0 0 m3];

if(iu==1)
    mass=mass/386;
end

stiff=[k1 -k1 0; -k1 k1+k2 -k2; 0 -k2 k2];


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

disp(' ');
[fn,omegan,ModeShapes,MST]=Generalized_Eigen(stiff,mass,2);
%
disp(' ');
dof=length(fn);
%
disp(' ');
%
v=ones(1,dof);
%
disp('        Natural    Participation    Effective  ');
disp('Mode   Frequency      Factor        Modal Mass ');
%
LM=MST*mass*v';
pf=LM;
sum=0;
%    
mmm=MST*mass*ModeShapes;   
%

pff=zeros(dof,1);
emm=zeros(dof,1);

for i=1:dof
        pff(i)=pf(i)/mmm(i,i);
        emm(i)=pf(i)^2/mmm(i,i);
        out1 = sprintf('%d  %10.4g Hz   %10.4g   %10.4g',i,fn(i),pff(i),emm(i) );
        disp(out1)
        sum=sum+emm(i);
end
out1=sprintf('\n modal mass sum = %8.4g \n',sum);
disp(out1);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

QE=ModeShapes;

fnv=fn;
dampv=[mean(damp_two) damp_two];

omega=2*pi*freq;
omega2=omega.^2;

omn2=omegan.^2;

iam=3;

num_columns=3;
max_num=3;

nrb=0;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


k=1;  % excitation_dof;

i=1;  % response_dof;

[H_response_force_1_1]=...
transfer_core_n(freq,fnv,dampv,QE,omn2,omega,omega2,iam,nf,num_columns,i,k,nrb,max_num);

i=2;  % response_dof;

[H_response_force_2_1]=...
transfer_core_n(freq,fnv,dampv,QE,omn2,omega,omega2,iam,nf,num_columns,i,k,nrb,max_num);

i=3;  % response_dof;

[H_response_force_3_1]=...
transfer_core_n(freq,fnv,dampv,QE,omn2,omega,omega2,iam,nf,num_columns,i,k,nrb,max_num);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

k=2;  % excitation_dof;

i=1;  % response_dof;

[H_response_force_1_2]=...
transfer_core_n(freq,fnv,dampv,QE,omn2,omega,omega2,iam,nf,num_columns,i,k,nrb,max_num);

i=2;  % response_dof;

[H_response_force_2_2]=...
transfer_core_n(freq,fnv,dampv,QE,omn2,omega,omega2,iam,nf,num_columns,i,k,nrb,max_num);

i=3;  % response_dof;

[H_response_force_3_2]=...
transfer_core_n(freq,fnv,dampv,QE,omn2,omega,omega2,iam,nf,num_columns,i,k,nrb,max_num);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

force_trans_1_2=zeros(nf,1);
force_trans_2_1=zeros(nf,1);

for i=1:nf
    force_trans_1_2(i)=H_response_force_1_2(i)/H_response_force_2_2(i);    
    force_trans_2_1(i)=H_response_force_2_1(i)/H_response_force_1_1(i);
end

force_trans_1_2=abs(force_trans_1_2);
force_trans_2_1=abs(force_trans_2_1);


if(iu==1)
    y_label='Trans (lbf/lbf)';
else
    y_label='Trans (N/N)';
end

%%%%%%

ppp=[freq force_trans_1_2];

t_string='Force Transmissibility 1 2';

[fig_num]=plot_linlog_function_md(fig_num,x_label,...
               y_label,t_string,ppp,fmin,fmax,md);

%%%%%%

ppp=[freq force_trans_2_1];

t_string='Force Transmissibility 2 1';

[fig_num]=plot_linlog_function_md(fig_num,x_label,...
               y_label,t_string,ppp,fmin,fmax,md);
           
           
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

force_trans_2_2=zeros(nf,1);
force_trans_3_2=zeros(nf,1);

for i=1:nf
    force_trans_2_2(i)=H_response_force_2_2(i)/H_response_force_2_2(i);
    force_trans_3_2(i)=H_response_force_3_2(i)/H_response_force_2_2(i);    
end

force_trans_2_2=abs(force_trans_2_2);
force_trans_3_2=abs(force_trans_3_2);

t_string='Blocking Force Transmissibility';

ppp1=[ freq  force_trans_2_2  ];
ppp2=[ freq  force_trans_3_2  ];

leg1='FT 2 2';
leg2='FT 3 2';


[fig_num,h2]=plot_linlog_function_md_two_h2(fig_num,x_label,...
               y_label,t_string,ppp1,ppp2,leg1,leg2,fmin,fmax,md);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

t_string='Acceleration Transmissibility \n Mass 3 relative to Mass 2';

y_label='Trans (G/G)';

ppp2=[ freq  force_trans_3_2  ];


[fig_num]=plot_linlog_function_md(fig_num,x_label,...
               y_label,t_string,ppp2,fmin,fmax,md);
           
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


if(iu==1)
    H_response_force_1_1=H_response_force_1_1/386;    
    H_response_force_2_1=H_response_force_2_1/386;
    H_response_force_3_1=H_response_force_3_1/386;
    y_label='Accel/Force (G/lbf)';
else
    H_response_force_1_1=H_response_force_1_1/9.81;    
    H_response_force_2_1=H_response_force_2_1/9.81;
    H_response_force_3_1=H_response_force_3_1/9.81;  
    y_label='Accel/Force (G/N)';
end


HM_11=abs(H_response_force_1_1);
HM_21=abs(H_response_force_2_1);
HM_31=abs(H_response_force_3_1);


t_string='Accelerance Magnitude FRF';

ppp1=[ freq  HM_11  ];
ppp2=[ freq  HM_21  ];
ppp3=[ freq  HM_31  ];

leg1='HM 11';
leg2='HM 21'; 
leg3='HM 31'; 

[fig_num,h2]=plot_linlog_function_md_three_h2(fig_num,x_label,...
               y_label,t_string,ppp1,ppp2,ppp3,leg1,leg2,leg3,fmin,fmax,md);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


disp(' ');
disp(' mass matrix ');
mass
disp(' ');
disp(' stiffness matrix ');
stiff
disp(' ');
ModeShapes
%


setappdata(0,'unit',iu);
setappdata(0,'mass',mass);
setappdata(0,'stiff',stiff);
setappdata(0,'fn',fn);
setappdata(0,'ModeShapes',ModeShapes);

assignin('base','three_dof_mass',mass);
assignin('base','three_dof_stiffness',stiff);
    
disp(' ');
disp('  mass & stiffness matrices saved in workspace as: ');
disp('        ');
disp('     three_dof_mass');
disp('     three_dof_stiffness');

setappdata(0,'pf',pf);
setappdata(0,'pff',pff);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

msgbox('Calculation complete.  Output written to Matlab Command Window.');




function edit_m3_Callback(hObject, eventdata, handles)
% hObject    handle to edit_m3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_m3 as text
%        str2double(get(hObject,'String')) returns contents of edit_m3 as a double


% --- Executes during object creation, after setting all properties.
function edit_m3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_m3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function stiffness2_edit_Callback(hObject, eventdata, handles)
% hObject    handle to stiffness2_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of stiffness2_edit as text
%        str2double(get(hObject,'String')) returns contents of stiffness2_edit as a double


% --- Executes during object creation, after setting all properties.
function stiffness2_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to stiffness2_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_m2_Callback(hObject, eventdata, handles)
% hObject    handle to edit_m2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_m2 as text
%        str2double(get(hObject,'String')) returns contents of edit_m2 as a double


% --- Executes during object creation, after setting all properties.
function edit_m2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_m2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function stiffness1_edit_Callback(hObject, eventdata, handles)
% hObject    handle to stiffness1_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of stiffness1_edit as text
%        str2double(get(hObject,'String')) returns contents of stiffness1_edit as a double


% --- Executes during object creation, after setting all properties.
function stiffness1_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to stiffness1_edit (see GCBO)
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
close(ESA_simple_launcher_spacecraft_model);



function edit_m1_Callback(hObject, eventdata, handles)
% hObject    handle to edit_m1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_m1 as text
%        str2double(get(hObject,'String')) returns contents of edit_m1 as a double


% --- Executes during object creation, after setting all properties.
function edit_m1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_m1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_Q1_Callback(hObject, eventdata, handles)
% hObject    handle to edit_Q1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_Q1 as text
%        str2double(get(hObject,'String')) returns contents of edit_Q1 as a double


% --- Executes during object creation, after setting all properties.
function edit_Q1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_Q1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_Q2_Callback(hObject, eventdata, handles)
% hObject    handle to edit_Q2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_Q2 as text
%        str2double(get(hObject,'String')) returns contents of edit_Q2 as a double


% --- Executes during object creation, after setting all properties.
function edit_Q2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_Q2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_fmin_Callback(hObject, eventdata, handles)
% hObject    handle to edit_fmin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_fmin as text
%        str2double(get(hObject,'String')) returns contents of edit_fmin as a double


% --- Executes during object creation, after setting all properties.
function edit_fmin_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_fmin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_fmax_Callback(hObject, eventdata, handles)
% hObject    handle to edit_fmax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_fmax as text
%        str2double(get(hObject,'String')) returns contents of edit_fmax as a double


% --- Executes during object creation, after setting all properties.
function edit_fmax_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_fmax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

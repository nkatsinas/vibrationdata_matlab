function varargout = nm_mdof_acceleration_force(varargin)
% NM_MDOF_ACCELERATION_FORCE MATLAB code for nm_mdof_acceleration_force.fig
%      NM_MDOF_ACCELERATION_FORCE, by itself, creates a new NM_MDOF_ACCELERATION_FORCE or raises the existing
%      singleton*.
%
%      H = NM_MDOF_ACCELERATION_FORCE returns the handle to a new NM_MDOF_ACCELERATION_FORCE or the handle to
%      the existing singleton*.
%
%      NM_MDOF_ACCELERATION_FORCE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in NM_MDOF_ACCELERATION_FORCE.M with the given input arguments.
%
%      NM_MDOF_ACCELERATION_FORCE('Property','Value',...) creates a new NM_MDOF_ACCELERATION_FORCE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before nm_mdof_acceleration_force_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to nm_mdof_acceleration_force_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help nm_mdof_acceleration_force

% Last Modified by GUIDE v2.5 10-Nov-2016 09:46:46

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @nm_mdof_acceleration_force_OpeningFcn, ...
                   'gui_OutputFcn',  @nm_mdof_acceleration_force_OutputFcn, ...
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


% --- Executes just before nm_mdof_acceleration_force is made visible.
function nm_mdof_acceleration_force_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to nm_mdof_acceleration_force (see VARARGIN)

% Choose default command line output for nm_mdof_acceleration_force
handles.output = hObject;


for i = 1:6
   for j=1:1
      data_s{i,j} = '';     
   end 
end
set(handles.uitable_dof,'Data',data_s); 


listbox_num_dof_Callback(hObject, eventdata, handles)

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes nm_mdof_acceleration_force wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = nm_mdof_acceleration_force_OutputFcn(hObject, eventdata, handles) 
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

iu=get(handles.listbox_units,'value');


num_ea=get(handles.listbox_num_dof,'Value');

A=char(get(handles.uitable_dof,'Data'));
B=str2num(A);

B=sort(B);

enforced_dof=B(1:num_ea);

damp=str2num(get(handles.edit_damping,'String'));

FS=get(handles.edit_mass,'String');
M=evalin('base',FS); 

FS=get(handles.edit_stiffness,'String');
K=evalin('base',FS); 

FS=get(handles.edit_input_array,'String');
EAF=evalin('base',FS); 



if(isempty(M))
   warndlg('enter mass array'); 
   return; 
end  
if(isempty(K))
   warndlg('enter stiffness array'); 
   return; 
end 
if(isempty(EAF))
   warndlg('enter input array'); 
   return; 
end 

t=EAF(:,1);
EAF(:,1)=[];

FFI=EAF;

if(iu==2)
    M=M/386;
end

szM=size(M);

NT=length(t);
nt=NT;

EAI=zeros(nt,num_ea);

for i=1:num_ea

    EAI(:,i)=EAF(:,enforced_dof(i));
  
end

if(iu<=2)
    EAI=EAI*386;   % convert to in/sec^2
else
    EAI=EAI*9.81;  % convert to m/sec^2
end

for i=num_ea:-1:1
    
   FFI(:,enforced_dof(i))=[];
    
end

ndof=szM(1);
num=ndof;

dur=t(NT)-t(1);

dt=dur/(NT-1);

out1=sprintf(' NT=%d  dur=%8.4g sec  dt=%8.4g sec',NT,dur,dt);
disp(out1);

%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

disp(' ');
[fn,omegan,ModeShapes,MST]=Generalized_Eigen(K,M,1);

%
dampv=ones(ndof,1)*damp;

C=zeros(ndof,ndof);

%
for i=1:ndof
    C(i,i)=2*dampv(i)*omegan(i);
end
%

C=M*ModeShapes*C*MST*M;

mass=M;
cdamping=C;
stiff=K;


accel_dof=zeros(ndof,1);

for i=1:num_ea
    accel_dof(enforced_dof(i))=1;
end


forig=zeros(nt,num_ea);
%
k=1;
for i=1:num
    nfi=accel_dof(i);
    if(nfi>0)
        forig(:,k)=EAI(:,nfi);
        k=k+1;
    end    
end


j=1;
k=1;
for i=1:ndof
    if(accel_dof(i)>0)
        enforced_dof(k)=i;
        k=k+1;
    else
        free_dof(j)=i;
        j=j+1;
    end
end

nem=length(enforced_dof);
nfree=length(free_dof);


dispm=1;


[fn,omega,ModeShapes,MST,Mwd,Cwd,Kwd,Mww,Cww,Kww,TT,T1,T2,KT,CT,MT]=...
   partition_matrices_mck(mass,cdamping,stiff,num,nfree,nem,free_dof,...
                                               enforced_dof,'accel',dispm);
%

ngw=zeros(ndof,1);

for i=1:nem
    ngw(i)=enforced_dof(i);
end
for i=1:nfree
    ngw(i+nem)=free_dof(i);
end
%

%%%%%%%%%%%%%%%%%%%%%%%

clear r;
clear part;
clear ModalMass;
%
sz=size(Mww);
%
n_free_dof=sz(1);
%
num_modes=n_free_dof;
%
clear temp;
temp=ModeShapes(:,1:num_modes);
clear ModeShapes;
ModeShapes=temp;
MST=ModeShapes';
%
r=ones(num_modes,1);
%
part = MST*Mww*r;
%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  displacement
%
%  d
%  v
%  acc
%
%%
n=num_modes;
%
%
%%

[a0,a1,a2,a3,a4,a5,a6,a7]=Newmark_coefficients(dt);
%
KH=Kww+a0*Mww+a1*Cww;
%
inv_KH=pinv(KH); 

%
t=zeros(nt,1);
d=zeros(nt,nfree);
v=zeros(nt,nfree);
acc=zeros(nt,nfree);
%
U=zeros(n,1);
Ud=zeros(n,1);
Udd=zeros(n,1);
%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
ns=size(U);
if(ns(2)>ns(1))
    U=U';
end
ns=size(Ud);
if(ns(2)>ns(1))
    Ud=Ud';
end
ns=size(Udd);
if(ns(2)>ns(1))
    Udd=Udd';
end
%%


for i=1:(nt-1)
%   
    FP=FFI(i,:)'-Mwd*(EAI(i,:))';
%    
    FH=FP+Mww*(a0*U+a2*Ud+a3*Udd)+Cww*(a1*U+a4*Ud+a5*Udd);
%
%%    Un=KH\FH;
%
    Un=inv_KH*FH;
%
    Uddn=a0*(Un-U)-a2*Ud-a3*Udd;
    Udn=Ud+a6*Udd+a7*Uddn;
    U=Un;
    Ud=Udn;
    Udd=Uddn;
%
    d(i+1,:)=U';
    v(i+1,:)=Ud';
    acc(i+1,:)=Udd';
    t(i+1)=i*dt;   
%
end


%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%
%    Transformation back to xd xf
%
%%    dT=TT*d';
%%    vT=TT*v';
%%    accT=TT*acc';
%
%% dT=(T1*ddisp' + T2*d')';
%% vT=(T1*dvelox' + T2*v')';
accT=(T1*EAI' + T2*acc')';




%
%  Put in original order
%
%% ZdT=[ ddisp  dT ];
%% ZvT=[ dvelox  vT ];
ZaccT=[ forig  accT ];
%
clear d;   
clear v;
clear acc;

%% d=zeros(nt,num);
%% v=zeros(nt,num);
acc=zeros(nt,num);

%
for i=1:num
   for j=1:nt
%%        d(j,ngw(i))=  (ZdT(j,i));        
%%        v(j,ngw(i))=  (ZvT(j,i));     
      acc(j,ngw(i))=(ZaccT(j,i));
   end
end
%% x=d;
%


%%% leave after mdof_plot

clear acceleration;
clear velocity;
clear displacement;
%

if(iu<=2)
    acc=acc/386;
else
    acc=acc/9.81;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[colororder,color_rows]=line_colors();

    try
       close 1
    end
    figure(1);
%
%%
    hold('all');
%
    j=1;
    for i = 1:num
        if(j>color_rows)
            j=j-color_rows;
        end
        out1=sprintf('dof %d',i);
        plot(t,acc(:,i),'Color', colororder(j,:),'DisplayName',out1);
        legend('-DynamicLegend');
        j=j+1;
    end
    hold off;
%%
    xlabel('Time(sec)');
    title('Acceleration');
    
    ylabel('Accel(G)');
   
    grid on;
    hold off;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%
acceleration=[t acc];
%% velocity=[t v];
%% displacement=[t x];

setappdata(0,'acceleration',acceleration);
%% setappdata(0,'velocity',velocity);
%% setappdata(0,'displacement',displacement);



% --- Executes on button press in pushbutton_return.
function pushbutton_return_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_return (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

delete(nm_mdof_acceleration_force);


% --- Executes on selection change in listbox_units.
function listbox_units_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_units (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_units contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_units


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



function edit_damping_Callback(hObject, eventdata, handles)
% hObject    handle to edit_damping (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_damping as text
%        str2double(get(hObject,'String')) returns contents of edit_damping as a double


% --- Executes during object creation, after setting all properties.
function edit_damping_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_damping (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_mass_Callback(hObject, eventdata, handles)
% hObject    handle to edit_mass (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_mass as text
%        str2double(get(hObject,'String')) returns contents of edit_mass as a double


% --- Executes during object creation, after setting all properties.
function edit_mass_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_mass (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_stiffness_Callback(hObject, eventdata, handles)
% hObject    handle to edit_stiffness (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_stiffness as text
%        str2double(get(hObject,'String')) returns contents of edit_stiffness as a double


% --- Executes during object creation, after setting all properties.
function edit_stiffness_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_stiffness (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_num_modes_Callback(hObject, eventdata, handles)
% hObject    handle to edit_num_modes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_num_modes as text
%        str2double(get(hObject,'String')) returns contents of edit_num_modes as a double


% --- Executes during object creation, after setting all properties.
function edit_num_modes_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_num_modes (see GCBO)
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


% --- Executes on button press in pushbutton_save.
function pushbutton_save_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

n=get(handles.listbox_output,'Value');

if(n==1)
    data=getappdata(0,'acceleration');
end
if(n==2)
    data=getappdata(0,'velocity');
end
if(n==3)
    data=getappdata(0,'displacement');
end

output_array=get(handles.edit_output_array,'String');
assignin('base', output_array, data);

h = msgbox('Save Complete'); 


% --- Executes on selection change in listbox_output.
function listbox_output_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_output (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_output contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_output


% --- Executes during object creation, after setting all properties.
function listbox_output_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_output (see GCBO)
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


% --- Executes on selection change in listbox_num_dof.
function listbox_num_dof_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_num_dof (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_num_dof contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_num_dof

n=get(handles.listbox_num_dof,'Value');

for i = 1:n
   for j=1:1
      data_s{i,j} = '';     
   end 
end
set(handles.uitable_dof,'Data',data_s);



% --- Executes during object creation, after setting all properties.
function listbox_num_dof_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_num_dof (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox4.
function listbox4_Callback(hObject, eventdata, handles)
% hObject    handle to listbox4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox4 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox4


% --- Executes during object creation, after setting all properties.
function listbox4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox4 (see GCBO)
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

function varargout = two_dof_system_base_excitation_mt(varargin)
% TWO_DOF_SYSTEM_BASE_EXCITATION_MT MATLAB code for two_dof_system_base_excitation_mt.fig
%      TWO_DOF_SYSTEM_BASE_EXCITATION_MT, by itself, creates a new TWO_DOF_SYSTEM_BASE_EXCITATION_MT or raises the existing
%      singleton*.
%
%      H = TWO_DOF_SYSTEM_BASE_EXCITATION_MT returns the handle to a new TWO_DOF_SYSTEM_BASE_EXCITATION_MT or the handle to
%      the existing singleton*.
%
%      TWO_DOF_SYSTEM_BASE_EXCITATION_MT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TWO_DOF_SYSTEM_BASE_EXCITATION_MT.M with the given input arguments.
%
%      TWO_DOF_SYSTEM_BASE_EXCITATION_MT('Property','Value',...) creates a new TWO_DOF_SYSTEM_BASE_EXCITATION_MT or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before two_dof_system_base_excitation_mt_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to two_dof_system_base_excitation_mt_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help two_dof_system_base_excitation_mt

% Last Modified by GUIDE v2.5 19-Aug-2014 14:36:16

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @two_dof_system_base_excitation_mt_OpeningFcn, ...
                   'gui_OutputFcn',  @two_dof_system_base_excitation_mt_OutputFcn, ...
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


% --- Executes just before two_dof_system_base_excitation_mt is made visible.
function two_dof_system_base_excitation_mt_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to two_dof_system_base_excitation_mt (see VARARGIN)

% Choose default command line output for two_dof_system_base_excitation_mt
handles.output = hObject;


fstr='two_dof_base.jpg';

posu= getpixelposition(handles.uipanel_data,true);

ux=posu(1);
uy=posu(2);

bg = imread(fstr);
info = imfinfo(fstr);
w = info.Width;  %An integer indicating the width of the image in pixels
h = info.Height; %An integer indicating the height of the image in pixels
 
axes(handles.axes1);
image(bg);
pos1 = getpixelposition(handles.axes1,true);
 
set(handles.axes1, ...
    'Visible', 'off', ...
    'Units', 'pixels', ...
    'Position', [pos1(1)-ux pos1(2)-uy w h]);
axis off; 




listbox_units_Callback(hObject, eventdata, handles);

set(handles.pushbutton_Calculate_Modal_Transient,'Enable','off');

set(handles.uipanel_save,'Visible','off');

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes two_dof_system_base_excitation_mt wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = two_dof_system_base_excitation_mt_OutputFcn(hObject, eventdata, handles) 
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
delete(two_dof_system_base_excitation_mt);


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on selection change in listbox_units.
function listbox_units_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_units (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_units contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_units

n=get(handles.listbox_units,'Value');

if(n==1)
    set(handles.mass_unit_text,'String','Mass Unit: lbm');
    set(handles.stiffness_unit_text,'String','Stiffness Unit: lbf/in');    
else
    set(handles.mass_unit_text,'String','Mass Unit: kg'); 
    set(handles.stiffness_unit_text,'String','Stiffness Unit: N/m');     
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


% --- Executes on button press in pushbutton_calculate_normal_modes.
function pushbutton_calculate_normal_modes_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate_normal_modes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.pushbutton_Calculate_Modal_Transient,'Enable','on');

m1=str2num( get(handles.edit_mass_1,'String' ));
m2=str2num( get(handles.edit_mass_2,'String' ));
k1=str2num( get(handles.edit_stiffness_1,'String' ));
k2=str2num( get(handles.edit_stiffness_2,'String' ));

iu=get(handles.listbox_units,'Value');

mass=zeros(2,2);

mass(1,1)=m1;
mass(2,2)=m2;

stiffness=[(k1+k2) -k2; -k2 k2];

%
if(iu==1)
   mass=mass/386.;
end
%
disp(' ');
[fn,omega,ModeShapes,MST]=Generalized_Eigen(stiffness,mass,2);
%
disp(' ');
dof=2;
%
disp(' ');
%
for i=1:dof
  v(i)=1.;
end
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
for i=1:dof
        pff(i)=pf(i)/mmm(i,i);
        emm(i)=pf(i)^2/mmm(i,i);
        out1 = sprintf('%d  %10.4g Hz   %10.4g   %10.4g',i,fn(i),pff(i),emm(i) );
        disp(out1)
        sum=sum+emm(i);
end
out1=sprintf('\n modal mass sum = %8.4g \n',sum);
disp(out1);

disp(' ');
disp(' mass matrix ');
mass
disp(' ');
disp(' stiffness matrix ');
stiffness
disp(' ');
ModeShapes
%

setappdata(0,'fn',fn);
setappdata(0,'pff',pff);
setappdata(0,'ModeShapes',ModeShapes);
setappdata(0,'mass',mass);
setappdata(0,'stiffness',stiffness);

msgbox('Calculation complete.  Output written to Matlab Command Window.');





% --- Executes on button press in pushbutton_Calculate_Modal_Transient.
function pushbutton_Calculate_Modal_Transient_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_Calculate_Modal_Transient (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

iu=get(handles.listbox_units,'Value');

fn=getappdata(0,'fn');
pff=getappdata(0,'pff');
ModeShapes=getappdata(0,'ModeShapes');
mass=getappdata(0,'mass');
stiffness=getappdata(0,'stiffness');

damp(1)=str2num(get(handles.edit_modal_damping_1,'String'));
damp(2)=str2num(get(handles.edit_modal_damping_2,'String'));

set(handles.uipanel_save,'Visible','on');


FS=get(handles.edit_input_array,'String');
THM=evalin('base',FS);   

T=THM(:,1);
y=double(THM(:,2));

if(iu==1)
    y=y*386;
else
    y=y*9.81*1000;    
end

n=length(y);

dur=THM(n,1)-THM(1,1);

dt=dur/(n-1);

out1=sprintf(' dt=%8.4g sec ',dt);
disp(out1);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

ND=zeros(n,2);
NV=zeros(n,2);
NA=zeros(n,2);

for i=1:2
%
    omegan=2.*pi*fn(i);
    omegad=omegan*sqrt(1.-(damp(i)^2));
%    
    cosd=cos(omegad*dt);
    sind=sin(omegad*dt);
%
    domegadt=damp(i)*omegan*dt;
%    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
    eee1=exp(-domegadt);
    eee2=exp(-2.*domegadt);
%
    ecosd=eee1*cosd;
    esind=eee1*sind; 
%
    a1= 2.*ecosd;
    a2=-eee2;    
%
    omeganT=omegan*dt;
%
    phi=2*(damp(i))^2-1;
    DD1=(omegan/omegad)*phi;
    DD2=2*DD1;
%    
    df1=2*damp(i)*(ecosd-1) +DD1*esind +omeganT;
    df2=-2*omeganT*ecosd +2*damp(i)*(1-eee2) -DD2*esind;
    df3=(2*damp(i)+omeganT)*eee2 +(DD1*esind-2*damp(i)*ecosd);
%     
    VV1=-(damp(i)*omegan/omegad);
%    
    vf1=(-ecosd+VV1*esind)+1;
    vf2=eee2-2*VV1*esind-1;
    vf3=ecosd+VV1*esind-eee2;
%
    MD=(omegan^3*dt);
    df1=df1/MD;
    df2=df2/MD;
    df3=df3/MD;
%
    VD=(omegan^2*dt);
    vf1=vf1/VD;
    vf2=vf2/VD;
    vf3=vf3/VD;
%
    af1=esind/(omegad*dt);
    af2=-2*af1;
    af3=af1;
%
    f=-pff(i)*y;
    
    max(abs(f));
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  SRS engine
%
%  displacement
%
    d_forward=[   df1,  df2, df3 ];
    d_back   =[     1, -a1, -a2 ];
    nd_resp=filter(d_forward,d_back,f);
%    
%  velocity
%
    v_forward=[   vf1,  vf2, vf3 ];
    v_back   =[     1, -a1, -a2 ];
    nv_resp=filter(v_forward,v_back,f);
%    
%  acceleration
%   
    a_forward=[   af1,  af2, af3 ];
    a_back   =[     1, -a1, -a2 ];
    na_resp=filter(a_forward,a_back,f);
%
    nd_resp=fix_size(nd_resp);
    nv_resp=fix_size(nv_resp);
    na_resp=fix_size(na_resp);    
%
    ND(:,i)=nd_resp;
    NV(:,i)=nv_resp;
    NA(:,i)=na_resp;
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
end

A=zeros(2,n);
Z=zeros(2,n);

for j=1:n
    A(:,j)=ModeShapes*NA(j,:)';
    Z(:,j)=ModeShapes*ND(j,:)';
end

if(iu==1)
    A=A/386;
else
    A=A/(9.81*1000);    
end

A=A';
Z=Z';

RZ=Z(:,2)-Z(:,1);

out1=sprintf('Mass 1: %7.4g  %7.4g ',max(A(:,1)),min(A(:,1)));
out2=sprintf('Mass 2: %7.4g  %7.4g ',max(A(:,2)),min(A(:,2)));

disp(' ');
disp('          Peak Accel (G) ');
disp('          Max     Min ');
disp(out1);
disp(out2);

out3=sprintf('Mass 2-1: %7.4g  %7.4g ',max(RZ),min(RZ));

disp(' ');
if(iu==1)
    disp('            Peak Rel Disp (in) ');
else
    disp('            Peak Rel Disp (mm) ');    
end    
disp('            Max     Min ');
disp(out3);




fig_num=1;

figure(fig_num)
fig_num=fig_num+1;
plot(THM(:,1),THM(:,2));
grid on;
xlabel('Time (sec)');
ylabel('Accel (G)');
title('Base Input');

figure(fig_num)
fig_num=fig_num+1;
plot(T,A(:,1));
grid on;
xlabel('Time (sec)');
ylabel('Accel (G)');
title('Response Acceleration Mass 1');

figure(fig_num)
fig_num=fig_num+1;
plot(T,A(:,2));
grid on;
xlabel('Time (sec)');
ylabel('Accel (G)');
title('Response Acceleration Mass 2');

figure(fig_num)
fig_num=fig_num+1;
plot(T,Z(:,1));
grid on;
xlabel('Time (sec)');
if(iu==1)
    ylabel('Rel Disp (in)');
else
    ylabel('Rel Disp (mm)');    
end    
title('Relative Displacement Mass 1 - Base');


figure(fig_num)
fig_num=fig_num+1;
plot(T,Z(:,2));
grid on;
xlabel('Time (sec)');
if(iu==1)
    ylabel('Rel Disp (in)');
else
    ylabel('Rel Disp (mm)');    
end    
title('Relative Displacement Mass 2 - Base');


figure(fig_num)
fig_num=fig_num+1;
plot(T,RZ);
grid on;
xlabel('Time (sec)');
if(iu==1)
    ylabel('Rel Disp (in)');
else
    ylabel('Rel Disp (mm)');    
end    
title('Relative Displacement Mass 2 - Mass 1');

A1=[T A(:,1)];
A2=[T A(:,2)];
Z1=[T Z(:,1)];
Z2=[T Z(:,2)];
Z21=[T RZ];

setappdata(0,'accel_1',A1);
setappdata(0,'accel_2',A2);

setappdata(0,'rd_1',Z1);
setappdata(0,'rd_2',Z2);
setappdata(0,'rd_21',Z21);


function edit_mass_2_Callback(hObject, eventdata, handles)
% hObject    handle to edit_mass_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_mass_2 as text
%        str2double(get(hObject,'String')) returns contents of edit_mass_2 as a double


% --- Executes during object creation, after setting all properties.
function edit_mass_2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_mass_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_stiffness_2_Callback(hObject, eventdata, handles)
% hObject    handle to edit_stiffness_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_stiffness_2 as text
%        str2double(get(hObject,'String')) returns contents of edit_stiffness_2 as a double


% --- Executes during object creation, after setting all properties.
function edit_stiffness_2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_stiffness_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_mass_1_Callback(hObject, eventdata, handles)
% hObject    handle to edit_mass_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_mass_1 as text
%        str2double(get(hObject,'String')) returns contents of edit_mass_1 as a double


% --- Executes during object creation, after setting all properties.
function edit_mass_1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_mass_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_stiffness_1_Callback(hObject, eventdata, handles)
% hObject    handle to edit_stiffness_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_stiffness_1 as text
%        str2double(get(hObject,'String')) returns contents of edit_stiffness_1 as a double


% --- Executes during object creation, after setting all properties.
function edit_stiffness_1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_stiffness_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_modal_damping_1_Callback(hObject, eventdata, handles)
% hObject    handle to edit_modal_damping_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_modal_damping_1 as text
%        str2double(get(hObject,'String')) returns contents of edit_modal_damping_1 as a double


% --- Executes during object creation, after setting all properties.
function edit_modal_damping_1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_modal_damping_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_modal_damping_2_Callback(hObject, eventdata, handles)
% hObject    handle to edit_modal_damping_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_modal_damping_2 as text
%        str2double(get(hObject,'String')) returns contents of edit_modal_damping_2 as a double


% --- Executes during object creation, after setting all properties.
function edit_modal_damping_2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_modal_damping_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
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


% --- Executes on button press in pushbutton_save.
function pushbutton_save_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

n=get(handles.listbox_output,'Value');

if(n==1)
    data=getappdata(0,'accel_1');
end
if(n==2)
    data=getappdata(0,'accel_2');
end
if(n==3)
    data=getappdata(0,'rd_1');
end
if(n==4)
    data=getappdata(0,'rd_2');
end
if(n==5)
    data=getappdata(0,'rd_21');
end
  



output_name=get(handles.edit_output_array,'String');
assignin('base', output_name, data);

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

function varargout = rotating_beam_applied_force(varargin)
% ROTATING_BEAM_APPLIED_FORCE MATLAB code for rotating_beam_applied_force.fig
%      ROTATING_BEAM_APPLIED_FORCE, by itself, creates a new ROTATING_BEAM_APPLIED_FORCE or raises the existing
%      singleton*.
%
%      H = ROTATING_BEAM_APPLIED_FORCE returns the handle to a new ROTATING_BEAM_APPLIED_FORCE or the handle to
%      the existing singleton*.
%
%      ROTATING_BEAM_APPLIED_FORCE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ROTATING_BEAM_APPLIED_FORCE.M with the given input arguments.
%
%      ROTATING_BEAM_APPLIED_FORCE('Property','Value',...) creates a new ROTATING_BEAM_APPLIED_FORCE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before rotating_beam_applied_force_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to rotating_beam_applied_force_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help rotating_beam_applied_force

% Last Modified by GUIDE v2.5 04-Aug-2015 11:43:31

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @rotating_beam_applied_force_OpeningFcn, ...
                   'gui_OutputFcn',  @rotating_beam_applied_force_OutputFcn, ...
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


% --- Executes just before rotating_beam_applied_force is made visible.
function rotating_beam_applied_force_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to rotating_beam_applied_force (see VARARGIN)

% Choose default command line output for rotating_beam_applied_force
handles.output = hObject;

iu=getappdata(0,'unit');

if(iu==1)
    ss='Force/Length unit:  lbf/in';  
else
    ss='Force/Length unit:  N/m';    
end

set(handles.text_FL_unit,'String',ss); 


% Update handles structure
guidata(hObject, handles);

% UIWAIT makes rotating_beam_applied_force wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = rotating_beam_applied_force_OutputFcn(hObject, eventdata, handles) 
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

delete(rotating_beam_applied_force);


% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

iu=getappdata(0,'unit');

try  
    FS=get(handles.edit_input_array,'String');
    THM=evalin('base',FS);  
catch
    warndlg('Input array not found');
    return;
end    

nmodes=get(handles.listbox_nmodes,'Value');

sz=size(THM);

nt=sz(1);
NT=nt;

t=THM(:,1);

dt=(t(nt)-t(1))/(nt-1);

force_th=THM(:,2);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

fn=getappdata(0,'fn');
ModeShapes=getappdata(0,'ModeShapes');
MST=ModeShapes';

damp=getappdata(0,'damp_ratio');

L=getappdata(0,'L');
ne=getappdata(0,'ne');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% apply force only translational dof

sz=size(ModeShapes);

ndof=sz(1);

if(ndof>nmodes)
    ndof=nmodes;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

sr=1/dt;

out1=sprintf('\n sr=%8.4g samples/sec',sr);
  out2=sprintf(' fn=%8.4g Hz  for mode %d',fn(ndof),ndof);
disp(out1);
disp(out2);


if( fn(ndof) > sr/10 )
    warndlg(' Increase sample rate or reduce number of included modes');
    return;
end    

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

tndof=2*ne;

ff=zeros(tndof,1);

for i=1:2:tndof 
    ff(i)=1;
end


ff=ff*L/ne;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

tpi=2*pi;

omegan=tpi*fn;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%

nodal_force=zeros(ndof,nt);

for i=1:nt
    nodal_force(:,i)=(MST(1:ndof,:)*ff)*force_th(i);
end 

%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  Calculate Filter Coefficients
%
mass=1;
%
a1=zeros(ndof,1);
a2=zeros(ndof,1);
%
df1=zeros(ndof,1);
df2=zeros(ndof,1);
df3=zeros(ndof,1);
%
vf1=zeros(ndof,1);
vf2=zeros(ndof,1);
vf3=zeros(ndof,1);
%
af1=zeros(ndof,1);
af2=zeros(ndof,1);
af3=zeros(ndof,1);
%
for j=1:ndof
%
    omegad=omegan(j)*sqrt(1.-(damp(j)^2));
    domegan=damp(j)*omegan(j);
%    
    cosd=cos(omegad*dt);
    sind=sin(omegad*dt); 
%
    domegadt=domegan*dt;
%
    eee1=exp(-domegadt);
    eee2=exp(-2.*domegadt);
%
    ecosd=eee1*cosd;
    esind=eee1*sind; 
%
    a1(j)=2.*ecosd;
    a2(j)=-eee2;
%
    omeganT=omegan(j)*dt;
    phi=(2*damp(j))^2-1;
    DD1=(omegan(j)/omegad)*phi;
    DD2=2*DD1;
%    
    df1(j)=2*damp(j)*(ecosd-1) +DD1*esind +omeganT;
    df2(j)=-2*omeganT*ecosd +2*damp(j)*(1-eee2) -DD2*esind;
    df3(j)=(2*damp(j)+omeganT)*eee2 +(DD1*esind-2*damp(j)*ecosd);
%     
    VV1=(damp(j)*omegan(j)/omegad);
%    
    vf1(j)=(-ecosd+VV1*esind)+1;
    vf2(j)=eee2-2*VV1*esind-1;
    vf3(j)=ecosd+VV1*esind-eee2;
%
    MD=(mass*omegan(j)^3*dt);
    df1(j)=df1(j)/MD;
    df2(j)=df2(j)/MD;
    df3(j)=df3(j)/MD;
%
    VD=(mass*omegan(j)^2*dt);
    vf1(j)=vf1(j)/VD;
    vf2(j)=vf2(j)/VD;
    vf3(j)=vf3(j)/VD;
%
    af1(j)=esind/(mass*omegad*dt);
    af2(j)=-2*af1(j);
    af3(j)=af1(j);
%   
end    
%
%  Numerical Engine
%
disp(' ')
disp(' Calculating response...');
%
nx=zeros(NT,ndof);
nv=zeros(NT,ndof);
na=zeros(NT,ndof);
%
progressbar;
for j=1:ndof
    progressbar(j/ndof);
%
%  displacement
%
    d_forward=[   df1(j),  df2(j), df3(j) ];
    d_back   =[     1, -a1(j), -a2(j) ];
    d_resp=filter(d_forward,d_back,nodal_force(j,:));
%    
%  velocity
%
    v_forward=[   vf1(j),  vf2(j), vf3(j) ];
    v_back   =[     1, -a1(j), -a2(j) ];
    v_resp=filter(v_forward,v_back,nodal_force(j,:));
%    
%  acceleration
%   
    a_forward=[   af1(j),  af2(j), af3(j) ];
    a_back   =[     1, -a1(j), -a2(j) ]; 
    a_resp=filter(a_forward,a_back,nodal_force(j,:));
%
    nx(:,j)=d_resp;  % displacement
    nv(:,j)=v_resp;  % velocity
    na(:,j)=a_resp;  % acceleration  
%
end
pause(0.3);
progressbar(1);
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
clear x;
clear v;
clear a;
%
sys_dof=tndof;

x=zeros(NT,sys_dof);
v=zeros(NT,sys_dof);
a=zeros(NT,sys_dof);
%
for i=1:NT
    x(i,:)=(ModeShapes(:,1:ndof)*((nx(i,:))'))';
    v(i,:)=(ModeShapes(:,1:ndof)*((nv(i,:))'))';
    a(i,:)=(ModeShapes(:,1:ndof)*((na(i,:))'))';    
end
%
%
t=fix_size(t);
%
clear acceleration;
clear velocity;
clear displacement;
%


if(iu==1)
    a=a/386;
else
    x=x*1000;
    a=a/9.81;    
end
%
acceleration=[t a];
velocity=[t v];
displacement=[t x];
%

figure(100);
plot(t,x(:,tndof-1));
grid on;
xlabel('Time (sec)');
if(iu==1)
    ylabel('Disp (in)');
else
    ylabel('Disp (mm)');    
end
title('Displacement at x=L');

figure(101);
plot(t,v(:,tndof-1));
grid on;
xlabel('Time (sec)');
if(iu==1)
    ylabel('Vel (in/sec)');
else
    ylabel('Vel (m/sec)');    
end
title('Velocity at x=L');


figure(102);
plot(t,a(:,tndof-1));
grid on;
xlabel('Time (sec)');
ylabel('Accel (G)');
title('Acceleration at x=L');


%
assignin('base','acceleration',acceleration);
assignin('base','velocity',velocity);
assignin('base','displacement',displacement);

disp(' ');
disp(' Output arrays:  ');
disp('  ');

if(iu==1)
    disp('   displacement (in)');    
    disp('   velocity (in/sec)');    
    disp('   acceleration (G)');
else
    disp('   displacement (mm)');    
    disp('   velocity (m/sec)');    
    disp('   acceleration (G)');    
end


disp(' ');
disp(' The first column is time(sec) in each array.');
disp(' The next column is translation at the right end of element 1,');
disp(' followed by rotation at the same location.');
disp(' The pattern then repeats.');




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


% --- Executes on selection change in listbox_unit.
function listbox_unit_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_unit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_unit contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_unit


% --- Executes during object creation, after setting all properties.
function listbox_unit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_unit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_CL_Callback(hObject, eventdata, handles)
% hObject    handle to edit_CL (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_CL as text
%        str2double(get(hObject,'String')) returns contents of edit_CL as a double


% --- Executes during object creation, after setting all properties.
function edit_CL_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_CL (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_chord_Callback(hObject, eventdata, handles)
% hObject    handle to edit_chord (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_chord as text
%        str2double(get(hObject,'String')) returns contents of edit_chord as a double


% --- Executes during object creation, after setting all properties.
function edit_chord_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_chord (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_nmodes.
function listbox_nmodes_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_nmodes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_nmodes contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_nmodes


% --- Executes during object creation, after setting all properties.
function listbox_nmodes_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_nmodes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

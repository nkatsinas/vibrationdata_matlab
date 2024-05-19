function varargout = vibrationdata_long_force_modal_transient(varargin)
% VIBRATIONDATA_LONG_FORCE_MODAL_TRANSIENT MATLAB code for vibrationdata_long_force_modal_transient.fig
%      VIBRATIONDATA_LONG_FORCE_MODAL_TRANSIENT, by itself, creates a new VIBRATIONDATA_LONG_FORCE_MODAL_TRANSIENT or raises the existing
%      singleton*.
%
%      H = VIBRATIONDATA_LONG_FORCE_MODAL_TRANSIENT returns the handle to a new VIBRATIONDATA_LONG_FORCE_MODAL_TRANSIENT or the handle to
%      the existing singleton*.
%
%      VIBRATIONDATA_LONG_FORCE_MODAL_TRANSIENT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in VIBRATIONDATA_LONG_FORCE_MODAL_TRANSIENT.M with the given input arguments.
%
%      VIBRATIONDATA_LONG_FORCE_MODAL_TRANSIENT('Property','Value',...) creates a new VIBRATIONDATA_LONG_FORCE_MODAL_TRANSIENT or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before vibrationdata_long_force_modal_transient_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to vibrationdata_long_force_modal_transient_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help vibrationdata_long_force_modal_transient

% Last Modified by GUIDE v2.5 29-Jul-2014 16:08:14

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @vibrationdata_long_force_modal_transient_OpeningFcn, ...
                   'gui_OutputFcn',  @vibrationdata_long_force_modal_transient_OutputFcn, ...
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


% --- Executes just before vibrationdata_long_force_modal_transient is made visible.
function vibrationdata_long_force_modal_transient_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to vibrationdata_long_force_modal_transient (see VARARGIN)

% Choose default command line output for vibrationdata_long_force_modal_transient
handles.output = hObject;

change_unit_mat(hObject, eventdata, handles);
listbox_num_modes_Callback(hObject, eventdata, handles);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes vibrationdata_long_force_modal_transient wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = vibrationdata_long_force_modal_transient_OutputFcn(hObject, eventdata, handles) 
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

delete(vibrationdata_long_force_modal_transient);


% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% edit_input_array

fig_num=1;

   nmodes=get(handles.listbox_num_modes,'value');
 n_unit=get(handles.listbox_unit,'value');
n_cross=get(handles.listbox_cross,'Value');

iu=n_unit;

     L=str2num(get(handles.edit_length,'String'));

  E=str2num(get(handles.edit_elastic_modulus,'String'));
rho=str2num(get(handles.edit_mass_density,'String'));

Q(1)=str2num(get(handles.edit_Q1,'String'));
Q(2)=str2num(get(handles.edit_Q2,'String'));
Q(3)=str2num(get(handles.edit_Q3,'String'));
Q(4)=str2num(get(handles.edit_Q4,'String'));


for i=1:nmodes
    damp(i)=1/(2*Q(i));
end

damp


 if(n_cross==1) % circular
     
    d=str2num(get(handles.edit_d_or_a,'String')); 
     
    area=pi*d^2/4; 
    
 else           % other 
    area=str2num(get(handles.edit_d_or_a,'Value')); 
 end

 if(n_unit==1)
    rho=rho/386;
 else    
   area=area/100^2; 
 end     

 A=area;
 
FS=get(handles.edit_input_array,'String');
THM=evalin('base',FS);  
 
%
t=THM(:,1);
f=THM(:,2);
%
tmx=max(t);
tmi=min(t);
n = length(f);
dt=(tmx-tmi)/(n-1);
sr=1./dt;
nt=n;
%
disp(' ')
disp(' Time Step ');
dtmin=min(diff(t));
dtmax=max(diff(t));
%
out4 = sprintf(' dtmin  = %8.4g sec  ',dtmin);
out5 = sprintf(' dt     = %8.4g sec  ',dt);
out6 = sprintf(' dtmax  = %8.4g sec  ',dtmax);
disp(out4)
disp(out5)
disp(out6)
%
disp(' ')
disp(' Sample Rate ');
out4 = sprintf(' srmin  = %8.4g samples/sec  ',1/dtmax);
out5 = sprintf(' sr     = %8.4g samples/sec  ',1/dt);
out6 = sprintf(' srmax  = %8.4g samples/sec  \n',1/dtmin);
disp(out4)
disp(out5)
disp(out6)
%
%%
%
c=sqrt(E/rho);
%
rod_mass=rho*A*L;
QM=2/(rho*A*L);
QM
%
clear fn;
clear omegan;
%
omegan=zeros(nmodes,1);
%
for k=1:nmodes
    i=2*k-1;
    omegan(k)=i*pi*c/(2*L);
end
fn=omegan/(2*pi);
%
%%
%
%
%  Initialize coefficients
%
disp(' ')
disp(' Initialize coefficients')
for j=1:nmodes
%    
%%    out1=sprintf('\n  mode=%d \n',j);
%%    disp(out1);
%    
    omegad=omegan(j)*sqrt(1.-(damp(j)^2));
%
    out5 = sprintf(' omegan=%g   omegad=%g ',omegan(j),omegad);
%%    disp(out5);    
%    
    cosd=cos(omegad*dt);
    sind=sin(omegad*dt);
%
    out5 = sprintf(' cosd=%g   sind=%g ',cosd,sind);
%%    disp(out5);    
%
    domegadt=damp(j)*omegan(j)*dt;
    a1(j)=2.*exp(-domegadt)*cosd;
    a2(j)=-exp(-2.*domegadt);
%
    out5 = sprintf(' a1=%g  a2=%g ',a1(j),a2(j));
%%    disp(out5);  
%
    b1(j)=2.*domegadt;
    b2(j)=omegan(j)*dt*exp(-domegadt);    
    b2(j)=b2(j)*( (omegan(j)/omegad)*(1.-2.*(damp(j)^2))*sind -2.*damp(j)*cosd );
 %
    out5 = sprintf(' b1=%g   b2=%g ',b1(j),b2(j));
%%    disp(out5);  
%
    c2(j)=-(dt/omegad)*exp(-domegadt)*sind;
 %
    out5 = sprintf(' c2=%g  ',c2(j));
%%    disp(out5);  
%
    vc1(j)=dt;
    vc2(j)=dt*exp(-domegadt)*((-damp(j)*omegan(j)/omegad)*sind-cosd);
% 
end
%

clear ff;
ff=zeros(1,n);
for i=1:length(f)
        ff(i)=f(i);        
end    
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  Important step
%
   ff=ff*QM;
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  SRS engine
%
clear phi_d;
clear phi_v;
%
phi_d=zeros(nt,nmodes);
phi_v=zeros(nt,nmodes);
%
d_pos=zeros(nmodes,1);
d_neg=zeros(nmodes,1);
v_pos=zeros(nmodes,1);
v_neg=zeros(nmodes,1);
%
disp(' ')
disp(' Calculating modal displacement');
for j=1:nmodes
%
    clear ffi;
    ffi=ff*sin(omegan(j)*L/c);
%
    d_forward=[     0,  c2(j),      0 ];
    d_back   =[     1, -a1(j), -a2(j) ];
%    
    d_resp=filter(d_forward,d_back,ffi);
%
    phi_d(:,j)=d_resp;
%
    d_pos(j)= max(d_resp);
    d_neg(j)= min(d_resp);
end
%
disp(' ')
disp(' Calculating modal velocity');
for j=1:nmodes
%
    v_forward=[    vc1(j),  vc2(j),      0 ];
    v_back   =[     1, -a1(j), -a2(j) ];
%    
    v_resp=filter(v_forward,v_back,ff);
%
    phi_v(:,j)=v_resp;    
%
    v_pos(j)= max(v_resp);
    v_neg(j)= min(v_resp);
end
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
disp(' ')
disp(' Calculating responses in physical coordinates');
%
x=L;
xc=x/c;
%
nt=max(size(phi_d));
clear uL;
clear vL;
clear strainZ;
uL=zeros(nt,1);
vL=zeros(nt,1);
strainZ=zeros(nt,1);
%
tt=linspace(0,nt*dt,nt); 
%
for i=1:nmodes
    uL(:,1)=uL(:,1)+phi_d(:,i)*sin(omegan(i)*xc);
    vL(:,1)=vL(:,1)+phi_v(:,i)*sin(omegan(i)*xc);
    strainZ(:,1)=strainZ(:,1)+phi_d(:,i)*(omegan(i)/c);
end
%
sz=size(tt);
if(sz(2)>sz(1))
    tt=tt';
end
%
sz=size(uL);
if(sz(2)>sz(1))
    uL=uL';
end
%
sz=size(uL);
if(sz(2)>sz(1))
    uL=uL';
end
%
sz=size(strainZ);
if(sz(2)>sz(1))
    strainZ=strainZ';
end
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
disp(' ');
disp(' Natural Frequency (Hz) ');
for(k=1:nmodes)
    out1=sprintf(' %8.4g ',fn(k));
    disp(out1);
end
disp(' ');
%
figure(fig_num);
fig_num=fig_num+1;
dispTH=[tt uL];
setappdata(0,'dispTH',dispTH); 

plot(tt,uL);
grid on;
title('Displacement at x=L');
xlabel('Time(sec)');
%
if(iu==1)
    ylabel('Disp(in)');
    disp(' ');
    disp(' Displacement (inch) at x=L ');    
else
    ylabel('Disp(mm)');    
    disp(' ');
    disp(' Displacement (mm) at x=L ');    
end
%
mu=mean(uL);
sd=std(uL);
mx=max(uL);
mi=min(uL);
rms=sqrt(sd^2+mu^2);
%
out1 = sprintf('   mean = %8.4g    std = %8.4g    rms = %8.4g ',mu,sd,rms);
out2 = sprintf('   max  = %9.4g    min = %9.4g             \n',mx,mi);
disp(out1);
disp(out2);
%
%
figure(fig_num);
fig_num=fig_num+1;
plot(tt,vL);
grid on;
title('Velocity at x=L');
xlabel('Time(sec)');
%
if(iu==1)
    ylabel('Vel(in/sec)');
    disp(' ');
    disp(' Velocity (in/sec) at x=L');    
else
    ylabel('Vel(m/sec)');
    disp(' ');
    disp(' Velocity (m/sec) at x=L');    
end
%
mu=mean(vL);
sd=std(vL);
mx=max(vL);
mi=min(vL);
rms=sqrt(sd^2+mu^2);
%
out1 = sprintf('   mean = %8.4g    std = %8.4g    rms = %8.4g ',mu,sd,rms);
out2 = sprintf('   max  = %9.4g    min = %9.4g             \n',mx,mi);
disp(out1);
disp(out2);
%
%
figure(fig_num);
fig_num=fig_num+1;
%
stressZ=strainZ*E;
%
strainZ=strainZ*1.0e+06;
%
plot(tt,strainZ);
grid on;
title('Micro Strain at x=0');
xlabel('Time(sec)');
ylabel('Micro Strain');
%   
mu=mean(strainZ);
sd=std(strainZ);
mx=max(strainZ);
mi=min(strainZ);
rms=sqrt(sd^2+mu^2);
%
disp(' ');
disp(' Micro Strain at x=0 ');
%
out1 = sprintf('   mean = %8.4g    std = %8.4g    rms = %8.4g ',mu,sd,rms);
out2 = sprintf('   max  = %9.4g    min = %9.4g             \n',mx,mi);
disp(out1);
disp(out2);

%%%%%%%%%%%%%%%%%%%%%%

figure(fig_num);
fig_num=fig_num+1;
%
%
plot(tt,stressZ);
stressTH=[tt stressZ];
setappdata(0,'stressTH',stressTH); 

grid on;
title('Axial Stress at x=0');
xlabel('Time(sec)');
%
if(n_unit==1)
      disp(' Stress (psi) at x=0 ');    
    ylabel(' Stress (psi)');
else
      disp(' Stress (Pa) at x=0 ');       
    ylabel(' Stress (Pa)');    
end    
%   
mu=mean(stressZ);
sd=std(stressZ);
mx=max(stressZ);
mi=min(stressZ);
rms=sqrt(sd^2+mu^2);
%
disp(' ');
%
out1 = sprintf('   mean = %8.4g    std = %8.4g    rms = %8.4g ',mu,sd,rms);
out2 = sprintf('   max  = %9.4g    min = %9.4g             \n',mx,mi);
disp(out1);
disp(out2);



% --- Executes on button press in pushbutton_save.
function pushbutton_save_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

n=get(handles.listbox_save,'Value');


if(n==1)
    data=getappdata(0,'dispTH');    
end
if(n==2)
    data=getappdata(0,'stressTH');     
end



sz=size(data);

if(max(sz)==0)
    h = msgbox('Data size is zero ');    
else
    output_name=get(handles.edit_output_filename,'String');
    assignin('base', output_name,data);
    h = msgbox('Export Complete.  Press Return. ');
end




function edit_output_filename_Callback(hObject, eventdata, handles)
% hObject    handle to edit_output_filename (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_output_filename as text
%        str2double(get(hObject,'String')) returns contents of edit_output_filename as a double


% --- Executes during object creation, after setting all properties.
function edit_output_filename_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_output_filename (see GCBO)
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



function edit_d_or_a_Callback(hObject, eventdata, handles)
% hObject    handle to edit_d_or_a (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_d_or_a as text
%        str2double(get(hObject,'String')) returns contents of edit_d_or_a as a double


% --- Executes during object creation, after setting all properties.
function edit_d_or_a_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_d_or_a (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_cross.
function listbox_cross_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_cross (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_cross contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_cross
change_unit_mat(hObject, eventdata, handles);

% --- Executes during object creation, after setting all properties.
function listbox_cross_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_cross (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_num_modes.
function listbox_num_modes_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_num_modes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_num_modes contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_num_modes

n=get(handles.listbox_num_modes,'Value');

set(handles.edit_Q1,'Visible','on');
set(handles.edit_Q2,'Visible','off');
set(handles.edit_Q3,'Visible','off');
set(handles.edit_Q4,'Visible','off');

set(handles.text_Q1,'Visible','on');
set(handles.text_Q2,'Visible','off');
set(handles.text_Q3,'Visible','off');
set(handles.text_Q4,'Visible','off');


if(n>=2)
    set(handles.edit_Q2,'Visible','on');
    set(handles.text_Q2,'Visible','on');    
end
if(n>=3)
    set(handles.edit_Q3,'Visible','on'); 
    set(handles.text_Q3,'Visible','on');      
end
if(n==4)
    set(handles.edit_Q4,'Visible','on'); 
    set(handles.text_Q4,'Visible','on');    
end


% --- Executes during object creation, after setting all properties.
function listbox_num_modes_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_num_modes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
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



function edit_Q3_Callback(hObject, eventdata, handles)
% hObject    handle to edit_Q3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_Q3 as text
%        str2double(get(hObject,'String')) returns contents of edit_Q3 as a double


% --- Executes during object creation, after setting all properties.
function edit_Q3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_Q3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_Q4_Callback(hObject, eventdata, handles)
% hObject    handle to edit_Q4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_Q4 as text
%        str2double(get(hObject,'String')) returns contents of edit_Q4 as a double


% --- Executes during object creation, after setting all properties.
function edit_Q4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_Q4 (see GCBO)
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



function edit_elastic_modulus_Callback(hObject, eventdata, handles)
% hObject    handle to edit_elastic_modulus (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_elastic_modulus as text
%        str2double(get(hObject,'String')) returns contents of edit_elastic_modulus as a double


% --- Executes during object creation, after setting all properties.
function edit_elastic_modulus_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_elastic_modulus (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_mat.
function listbox_mat_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_mat (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_mat contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_mat
change_unit_mat(hObject, eventdata, handles);

% --- Executes during object creation, after setting all properties.
function listbox_mat_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_mat (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_mass_density_Callback(hObject, eventdata, handles)
% hObject    handle to edit_mass_density (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_mass_density as text
%        str2double(get(hObject,'String')) returns contents of edit_mass_density as a double


% --- Executes during object creation, after setting all properties.
function edit_mass_density_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_mass_density (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_length_Callback(hObject, eventdata, handles)
% hObject    handle to edit_length (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_length as text
%        str2double(get(hObject,'String')) returns contents of edit_length as a double


% --- Executes during object creation, after setting all properties.
function edit_length_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_length (see GCBO)
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
change_unit_mat(hObject, eventdata, handles);

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

function change_unit_mat(hObject, eventdata, handles)
%

  n_mat=get(handles.listbox_mat,'Value');
 n_unit=get(handles.listbox_unit,'Value');
n_cross=get(handles.listbox_cross,'Value');
 
 if(n_unit==1)
    set(handles.text_elastic_modulus,'String','Elastic Modulus (psi)');
    set(handles.text_mass_density,'String','Mass Density (lbm/in^3)');
    set(handles.text_length_unit,'String','inch');
    set(handles.text_force,'String','Time (sec) & Force (lbf)');
 else
    set(handles.text_elastic_modulus,'String','Elastic Modulus (GPa)');
    set(handles.text_mass_density,'String','Mass Density (kg/m^3)');
    set(handles.text_length_unit,'String','meters'); 
    set(handles.text_force,'String','Time (sec) & Force (N)');    
 end
 
%

 if(n_cross==1) % circular
    set(handles.text_area,'String','Diameter');
    if(n_unit==1)
        set(handles.text_area_unit,'String','inch');
    else
        set(handles.text_area_unit,'String','cm');   
    end
 else           % other 
    set(handles.text_area,'String','Area'); 
    if(n_unit==1)
        set(handles.text_area_unit,'String','in^2');
    else
        set(handles.text_area_unit,'String','cm^2');   
    end   
 end

% 
 
 if(n_unit==1)  % English
    if(n_mat==1) % aluminum
        E=1e+007;
        rho=0.1;  
    end  
    if(n_mat==2)  % steel
        E=3e+007;
        rho= 0.28;         
    end
    if(n_mat==3)  % copper
        E=1.6e+007;
        rho=  0.322;
    end
else                 % metric
    if(n_mat==1)  % aluminum
        E=70;
        rho=  2700;
    end
    if(n_mat==2)  % steel
        E=205;
        rho=  7700;        
    end
    if(n_mat==3)   % copper
        E=110;
        rho=  8900;
    end
end
 
if(n_mat<=3)
    ss1=sprintf('%8.4g',E);
    ss2=sprintf('%8.4g',rho);
 
    set(handles.edit_elastic_modulus,'String',ss1);
    set(handles.edit_mass_density,'String',ss2); 
else
    set(handles.edit_elastic_modulus,'String',' ');
    set(handles.edit_mass_density,'String',' ');    
end

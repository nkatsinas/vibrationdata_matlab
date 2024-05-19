function varargout = vibrationdata_srs_force(varargin)
% VIBRATIONDATA_SRS_FORCE MATLAB code for vibrationdata_srs_force.fig
%      VIBRATIONDATA_SRS_FORCE, by itself, creates a new VIBRATIONDATA_SRS_FORCE or raises the existing
%      singleton*.
%
%      H = VIBRATIONDATA_SRS_FORCE returns the handle to a new VIBRATIONDATA_SRS_FORCE or the handle to
%      the existing singleton*.
%
%      VIBRATIONDATA_SRS_FORCE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in VIBRATIONDATA_SRS_FORCE.M with the given input arguments.
%
%      VIBRATIONDATA_SRS_FORCE('Property','Value',...) creates a new VIBRATIONDATA_SRS_FORCE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before vibrationdata_srs_force_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to vibrationdata_srs_force_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help vibrationdata_srs_force

% Last Modified by GUIDE v2.5 20-Dec-2013 09:26:13

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @vibrationdata_srs_force_OpeningFcn, ...
                   'gui_OutputFcn',  @vibrationdata_srs_force_OutputFcn, ...
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


% --- Executes just before vibrationdata_srs_force is made visible.
function vibrationdata_srs_force_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to vibrationdata_srs_force (see VARARGIN)

% Choose default command line output for vibrationdata_srs_force
handles.output = hObject;

set(handles.text_mass,'String','Enter Mass (lbm)');
set(handles.listbox_force_unit,'Value',1);
set(handles.listbox_method,'Value',1);

set(handles.edit_Q,'String','10');

set(handles.pushbutton_save,'Enable','off');
set(handles.edit_output_array,'Enable','off');


% Update handles structure
guidata(hObject, handles);

% UIWAIT makes vibrationdata_srs_force wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = vibrationdata_srs_force_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton_save.
function pushbutton_save_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

n=get(handles.listbox_output_type,'Value');

data=getappdata(0,'accel_srs');   
data=getappdata(0,'velox_srs'); 
data=getappdata(0,'displ_srs');   
data=getappdata(0,'trans_force_srs'); 

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


% --- Executes on selection change in listbox_output_type.
function listbox_output_type_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_output_type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_output_type contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_output_type


% --- Executes during object creation, after setting all properties.
function listbox_output_type_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_output_type (see GCBO)
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


% --- Executes on selection change in listbox_method.
function listbox_method_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_method (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_method contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_method

n=get(hObject,'Value');

set(handles.pushbutton_save,'Enable','off');
set(handles.edit_input_array,'String',' ');

set(handles.text_input_array_name,'Visible','on');
set(handles.edit_input_array,'Visible','on');

if(n==1)
   set(handles.edit_input_array,'enable','on') 
else
    
   set(handles.text_input_array_name,'Visible','off');
   set(handles.edit_input_array,'Visible','off');

   set(handles.edit_input_array,'enable','off')
   
   [filename, pathname] = uigetfile('*.*');
   filename = fullfile(pathname, filename);
   fid = fopen(filename,'r');
   THM = fscanf(fid,'%g %g',[2 inf]);
   THM=THM';
    
   setappdata(0,'THM',THM);
end


% --- Executes during object creation, after setting all properties.
function listbox_method_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_method (see GCBO)
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


% --- Executes on button press in pushbutton_return.
function pushbutton_return_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_return (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
delete(vibrationdata_srs_force);

% --- Executes on selection change in listbox_force_unit.
function listbox_force_unit_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_force_unit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_force_unit contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_force_unit

n=get(hObject,'Value');

if(n==1)
    set(handles.text_mass,'String','Enter Mass (lbm)');
else
    set(handles.text_mass,'String','Enter Mass (kg)');    
end




% --- Executes during object creation, after setting all properties.
function listbox_force_unit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_force_unit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_fn_Callback(hObject, eventdata, handles)
% hObject    handle to edit_fn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_fn as text
%        str2double(get(hObject,'String')) returns contents of edit_fn as a double


% --- Executes during object creation, after setting all properties.
function edit_fn_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_fn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_Q_Callback(hObject, eventdata, handles)
% hObject    handle to edit_Q (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_Q as text
%        str2double(get(hObject,'String')) returns contents of edit_Q as a double


% --- Executes during object creation, after setting all properties.
function edit_Q_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_Q (see GCBO)
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


% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

fig_num=1;

plot_fmax=str2num(get(handles.edit_fend,'String'));

n_force_mass_unit=get(handles.listbox_force_unit,'Value');

k=get(handles.listbox_method,'Value');

 
if(k==1)
  FS=get(handles.edit_input_array,'String');
  THM=evalin('base',FS);   
else
  THM=getappdata(0,'THM');
end

t=THM(:,1);
f=double(THM(:,2));

n=length(f);

dur=THM(n,1)-THM(1,1);

dt=dur/(n-1);
sr=1/dt;

mass=str2num(get(handles.edit_mass,'String'));
Q=str2num(get(handles.edit_Q,'String'));

damp=1/(2*Q);

fstart=str2num(get(handles.edit_start_frequency,'String'));

fn(1)=fstart;

fmax=sr/8;

oct=2^(1/12);

num=1;

while(1)
    
  num=num+1;
  
  fn(num)=fn(num-1)*oct;
  
  if(fn(num)>fmax)
      break;
  end
    
end

if(n_force_mass_unit==1)
    mass=mass/386;
end
%
out1=sprintf('mass=%g',mass);
disp(out1);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  Initialize coefficients
%
disp(' ')
disp(' Initialize coefficients')
%
    df1=zeros(num,1);
    df2=zeros(num,1);
    df3=zeros(num,1);
%    
    vf1=zeros(num,1);
    vf2=zeros(num,1);
    vf3=zeros(num,1);
%
    df1=zeros(num,1);
    df2=zeros(num,1);
    df3=zeros(num,1);
%
    af1=zeros(num,1);
    af2=zeros(num,1);
    af3=zeros(num,1);
%    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
    for i=1:num
%
        omegan=2.*pi*fn(i);
        omegad=omegan*sqrt(1.-(damp^2));
%    
        cosd=cos(omegad*dt);
        sind=sin(omegad*dt); 
%
        domegadt=damp*omegan*dt;
%
        eee1=exp(-domegadt);
        eee2=exp(-2.*domegadt);
%
        ecosd=eee1*cosd;
        esind=eee1*sind; 
%
        a1(i)= 2.*ecosd;
        a2(i)=-eee2;     
%
        omeganT=omegan*dt;
%
        phi=2*(damp)^2-1;
        DD1=(omegan/omegad)*phi;
        DD2=2*DD1;
%
        df1(i)=2*damp*(ecosd-1) +DD1*esind +omeganT;
        df2(i)=-2*omeganT*ecosd +2*damp*(1-eee2) -DD2*esind;
        df3(i)=(2*damp+omeganT)*eee2 +(DD1*esind-2*damp*ecosd);
%     
        VV1=-(damp*omegan/omegad);
%    
        vf1(i)=(-ecosd+VV1*esind)+1;
        vf2(i)=eee2-2*VV1*esind-1;
        vf3(i)=ecosd+VV1*esind-eee2;
%
        MD=(mass*omegan^3*dt);
        df1(i)=df1(i)/MD;
        df2(i)=df2(i)/MD;
        df3(i)=df3(i)/MD;
%
        VD=(mass*omegan^2*dt);
        vf1(i)=vf1(i)/VD;
        vf2(i)=vf2(i)/VD;
        vf3(i)=vf3(i)/VD;
%
        af1(i)=esind/(mass*omegad*dt);
        af2(i)=-2*af1(i);
        af3(i)=af1(i);
%    
    end

%   
clear fdm;
fdm=f/mass;
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

for i=1:num
%    
%  displacement
%    
    d_forward=[   df1(i),  df2(i), df3(i) ];
    d_back   =[     1, -a1(i), -a2(i) ];
    d_resp=filter(d_forward,d_back,f);
%    
%  velocity
%
    v_forward=[   vf1(i),  vf2(i), vf3(i) ];
    v_back   =[     1, -a1(i), -a2(i) ];
    v_resp=filter(v_forward,v_back,f);
%    
%  acceleration
%   
    a_forward=[   af1(i),  af2(i), af3(i) ];
    a_back   =[     1, -a1(i), -a2(i) ]; 
    a_resp=filter(a_forward,a_back,f);
%
%  transmitted foree
%
    [a1,a2,b1,b2,b3,~,~,~,~,~]=srs_coefficients(fn,damp,dt);
%                               
    forward=[ b1(i),  b2(i),  b3(i) ];
    back   =[  1, -a1(i), -a2(i) ];
%    
    ft_resp=filter(forward,back,f);
%
    if(n_force_mass_unit==2)
        d_resp=d_resp*1000;
    end
%
    accel_srs(i,2)=max(a_resp);
    accel_srs(i,3)=abs(min(a_resp));   
%
    velox_srs(i,2)=max(v_resp);
    velox_srs(i,3)=abs(min(v_resp));   
%
    displ_srs(i,2)=max(d_resp);
    displ_srs(i,3)=abs(min(d_resp));
%
    trans_force_srs(i,2)=max(ft_resp);
    trans_force_srs(i,3)=abs(min(ft_resp));
%
    accel_srs(i,1)=fn(i);
    velox_srs(i,1)=fn(i);
    displ_srs(i,1)=fn(i);
    trans_force_srs(i,1)=fn(i);
%
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(n_force_mass_unit==1)
    accel_srs(:,2)=accel_srs(:,2)/386;
    accel_srs(:,3)=accel_srs(:,3)/386;    
else
    accel_srs(:,2)=accel_srs(:,2)/9.81;
    accel_srs(:,3)=accel_srs(:,3)/9.81;    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

figure(fig_num);
fig_num=fig_num+1;
plot(t,f); 
xlabel('Time (sec)');
%
if(n_force_mass_unit==1)
    ylabel('Force (lbf)');
else
    ylabel('Force (N)');
end
title('Applied Force');
%
grid;
zoom on;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure(fig_num);
fig_num=fig_num+1;
plot(fn,accel_srs(:,2),fn,accel_srs(:,3));
xlabel('Natural Frequency(Hz)');
grid on;
set(gca,'MinorGridLineStyle',':','GridLineStyle',':','XScale','log','YScale','log');
xlim([fn(1) plot_fmax]);
grid on;
ylabel('Peak Accel (G)');
if(n_force_mass_unit==1)
    out5 = sprintf(' Acceleration SRS: mass=%g lbm Q=%g ',mass*386,Q);
else
    out5 = sprintf(' Acceleration SRS: mass=%g kg  Q=%g ',mass,Q);    
end
title(out5);
legend('positive','negative');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

figure(fig_num);
fig_num=fig_num+1;
plot(fn,velox_srs(:,2),fn,velox_srs(:,3));
xlabel('Natural Frequency(Hz)');
grid on;
set(gca,'MinorGridLineStyle',':','GridLineStyle',':','XScale','log','YScale','log');
xlim([fn(1) plot_fmax]);
grid on;
if(n_force_mass_unit==1)
    ylabel('Peak Vel (in/sec)');
else
    ylabel('Peak Vel (m/sec)');
end
if(n_force_mass_unit==1)
    out5 = sprintf(' Velocity SRS: mass=%g lbm Q=%g ',mass*386,Q);
else
    out5 = sprintf(' Velocity SRS: mass=%g kg  Q=%g ',mass,Q);    
end
title(out5);
legend('positive','negative');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

figure(fig_num);
fig_num=fig_num+1;
plot(fn,displ_srs(:,2),fn,displ_srs(:,3));
xlabel('Natural Frequency(Hz)');
grid on;
set(gca,'MinorGridLineStyle',':','GridLineStyle',':','XScale','log','YScale','log');
xlim([fn(1) plot_fmax]);
grid on;
if(n_force_mass_unit==1)
    ylabel('Peak Disp (in)');
else
    ylabel('Peak Disp (mm)');
end
if(n_force_mass_unit==1)
    out5 = sprintf(' Displacement SRS: mass=%g lbm Q=%g ',mass*386,Q);
else
    out5 = sprintf(' Displacement SRS: mass=%g kg  Q=%g ',mass,Q);    
end
title(out5);
legend('positive','negative');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

figure(fig_num);
fig_num=fig_num+1;
plot(fn,trans_force_srs(:,2),fn,trans_force_srs(:,3));
xlabel('Natural Frequency(Hz)');
grid on;
set(gca,'MinorGridLineStyle',':','GridLineStyle',':','XScale','log','YScale','log');
xlim([fn(1) plot_fmax]);
grid on;
if(n_force_mass_unit==1)
    ylabel('Force (lbf)');
else
    ylabel('Force (N)');
end
if(n_force_mass_unit==1)
    out5 = sprintf('Transmitted Force SRS: mass=%g lbm Q=%g ',mass*386,Q);
else
    out5 = sprintf('Transmitted Force SRS: mass=%g kg  Q=%g ',mass,Q);    
end
title(out5);
legend('positive','negative');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

setappdata(0,'accel_srs',accel_srs);   
setappdata(0,'velox_srs',velox_srs); 
setappdata(0,'displ_srs',displ_srs);   
setappdata(0,'trans_force_srs',trans_force_srs); 

set(handles.pushbutton_save,'Enable','on');
set(handles.edit_output_array,'Enable','on');



function edit_start_frequency_Callback(hObject, eventdata, handles)
% hObject    handle to edit_start_frequency (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_start_frequency as text
%        str2double(get(hObject,'String')) returns contents of edit_start_frequency as a double


% --- Executes during object creation, after setting all properties.
function edit_start_frequency_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_start_frequency (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_fend_Callback(hObject, eventdata, handles)
% hObject    handle to edit_fend (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_fend as text
%        str2double(get(hObject,'String')) returns contents of edit_fend as a double


% --- Executes during object creation, after setting all properties.
function edit_fend_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_fend (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over pushbutton_calculate.
function pushbutton_calculate_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

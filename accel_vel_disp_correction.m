function varargout = accel_vel_disp_correction(varargin)
% ACCEL_VEL_DISP_CORRECTION MATLAB code for accel_vel_disp_correction.fig
%      ACCEL_VEL_DISP_CORRECTION, by itself, creates a new ACCEL_VEL_DISP_CORRECTION or raises the existing
%      singleton*.
%
%      H = ACCEL_VEL_DISP_CORRECTION returns the handle to a new ACCEL_VEL_DISP_CORRECTION or the handle to
%      the existing singleton*.
%
%      ACCEL_VEL_DISP_CORRECTION('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ACCEL_VEL_DISP_CORRECTION.M with the given input arguments.
%
%      ACCEL_VEL_DISP_CORRECTION('Property','Value',...) creates a new ACCEL_VEL_DISP_CORRECTION or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before accel_vel_disp_correction_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to accel_vel_disp_correction_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help accel_vel_disp_correction

% Last Modified by GUIDE v2.5 23-Apr-2015 09:33:13

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @accel_vel_disp_correction_OpeningFcn, ...
                   'gui_OutputFcn',  @accel_vel_disp_correction_OutputFcn, ...
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


% --- Executes just before accel_vel_disp_correction is made visible.
function accel_vel_disp_correction_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to accel_vel_disp_correction (see VARARGIN)

% Choose default command line output for accel_vel_disp_correction
handles.output = hObject;

set(handles.listbox_method,'Value',1);
listbox_integration_1_Callback(hObject, eventdata, handles)


set(handles.edit_input_array_name,'Visible','on');
set(handles.text_input_array_name,'Visible','on');
set(handles.edit_input_array_name,'Enable','on');
set(handles.text_input_array_name,'Enable','on');


set(handles.listbox_integration_1,'Value',1);
set(handles.listbox_integration_2,'Value',1);
set(handles.listbox_integration_3,'Value',1);

set(handles.uipanel_save,'Visible','off');

set(handles.listbox_psave,'Value',2);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes accel_vel_disp_correction wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = accel_vel_disp_correction_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function edit_fc_Callback(hObject, eventdata, handles)
% hObject    handle to edit_fc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_fc as text
%        str2double(get(hObject,'String')) returns contents of edit_fc as a double


% --- Executes during object creation, after setting all properties.
function edit_fc_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_fc (see GCBO)
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



try

    Figures = findobj( 'Type', 'Figure' , '-not' , 'Tag' , get( handles.output , 'Tag' ) );
    NFigures = length( Figures );
    for nFigures = 1 : NFigures
        close( Figures( nFigures ) );
    end
catch
end   



iunit=get(handles.listbox_units,'Value');
setappdata(0,'iunit',iunit);

k=get(handles.listbox_method,'Value');

try
 
if(k==1)
  FS=get(handles.edit_input_array_name,'String');
  THM=evalin('base',FS);   
else
  THM=getappdata(0,'THM');
end

catch
    warndlg('Input Array not found');
    return;
end

tt=THM(:,1);

y=double(THM(:,2));

num=length(y);

dur=THM(num,1)-THM(1,1);

dt=dur/(num-1);

%%%

I1=get(handles.listbox_integration_1,'Value');
I2=get(handles.listbox_integration_2,'Value');
I3=get(handles.listbox_integration_3,'Value');

%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Integration 1

if(I1==2)
    y=y-mean(y);
end
if(I1==3)
    y=detrend(y);    
end
if(I1==4)
    fc=str2num(get(handles.edit_fc,'String'));
    y=detrend(y);      
    [y]=Butterworth_filter_highpass_function(y,fc,dt);    
end

ntap=get(handles.listbox_taper_a,'Value');

if(ntap>1)
    if(ntap==2)
        npe=0.1;
    end    
    if(ntap==3)
        npe=0.5;
    end
    if(ntap==4)
        npe=1;
    end
    if(ntap==5)
        npe=2;
    end
    if(ntap==6)
        npe=3;
    end
    if(ntap==7)
        npe=4;
    end    
    if(ntap==8)
        npe=5;
    end
    if(ntap==9)
        npe=6;
    end
    if(ntap==10)
        npe=7;
    end
    if(ntap==11)
        npe=8;
    end
    if(ntap==12)
        npe=9;
    end    
    if(ntap==13)
        npe=10;
    end    
%
    [y]=half_cosine_fade_perc(y,npe);

end

a=y;

v=zeros(num,1);
v(1)=y(1)*dt/2;

for i=2:(num-1)
    v(i)=v(i-1)+y(i)*dt;
end
v(num)=v(num-1)+y(num)*dt/2;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% In Between

if(I2==2)
    v=v-mean(v);    
end    
if(I2==3)
    v=detrend(v);        
end 
if(I2==4)
    n = 2;
    p = polyfit(tt,v,n);
    v= v - (  p(1)*tt.^2 + p(2)*tt + p(3));
end 
if(I2==5)
    n = 3;
    p = polyfit(tt,v,n);
    v= v - (  p(1)*tt.^3 + p(2)*tt.^2 + p(3)*tt + p(4));
end


ntap=get(handles.listbox_taper_v,'Value');

if(ntap>1)
    if(ntap==2)
        npe=0.1;
    end    
    if(ntap==3)
        npe=0.5;
    end
    if(ntap==4)
        npe=1;
    end
    if(ntap==5)
        npe=2;
    end
    if(ntap==6)
        npe=3;
    end
    if(ntap==7)
        npe=4;
    end    
    if(ntap==8)
        npe=5;
    end
    if(ntap==9)
        npe=6;
    end
    if(ntap==10)
        npe=7;
    end
    if(ntap==11)
        npe=8;
    end
    if(ntap==12)
        npe=9;
    end    
    if(ntap==13)
        npe=10;
    end    
%
    [v]=half_cosine_fade_perc(v,npe);

end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Integration 2

d=zeros(num,1);
d(1)=v(1)*dt/2;

for i=2:(num-1)
    d(i)=d(i-1)+v(i)*dt;
end
d(num)=d(num-1)+v(num)*dt/2;

d=fix_size(d);

if(I3==2)
    d=d-mean(d);    
end    
if(I3==3)
    d=detrend(d);        
end 
if(I3==4)
    n = 2;
    p = polyfit(tt,d,n);
    d= d - (  p(1)*tt.^2 + p(2)*tt + p(3));
end 
if(I3==5)
    n = 3;
    p = polyfit(tt,d,n);
    d= d - (  p(1)*tt.^3 + p(2)*tt.^2 + p(3)*tt + p(4));
end

ntap=get(handles.listbox_taper_d,'Value');

if(ntap>1)
    if(ntap==2)
        npe=0.1;
    end    
    if(ntap==3)
        npe=0.5;
    end
    if(ntap==4)
        npe=1;
    end
    if(ntap==5)
        npe=2;
    end
    if(ntap==6)
        npe=3;
    end
    if(ntap==7)
        npe=4;
    end    
    if(ntap==8)
        npe=5;
    end
    if(ntap==9)
        npe=6;
    end
    if(ntap==10)
        npe=7;
    end
    if(ntap==11)
        npe=8;
    end
    if(ntap==12)
        npe=9;
    end    
    if(ntap==13)
        npe=10;
    end    
%
    [d]=half_cosine_fade_perc(d,npe);
%
end    
        
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

a=fix_size(a);
v=fix_size(v);
d=fix_size(d);

if(iunit==1)
    v=v*386;
    d=d*386;
    ay='Accel (G)';
    vy='Vel (ips)';
    dy='Disp (in)';
end
if(iunit==2)
    v=v*9.81*100;
    d=d*9.81*1000;
    ay='Accel (G)';
    vy='Vel (cm/s)';
    dy='Disp (mm)';
end
if(iunit==3)
    v=v*100;
    d=d*1000;
    ay='Accel (m/s^2)';
    vy='Vel (cm/s)';
    dy='Disp (mm)';
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


[vv]=differentiate_function(d,dt);
[aa]=differentiate_function(vv,dt);

if(iunit==1) % G, in/sec, in
    aa=aa/386;
end
if(iunit==2) % G, cm/sec, mm
    vv=vv/10;
    aa=aa/(9.81*1000);
end
if(iunit==3) % m/sec^2, cm/sec, mm
    vv=vv/10;
    aa=aa/1000;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

vvv=zeros(num,1);
vvv(1)=aa(1)*dt/2;

for i=2:(num-1)
    vvv(i)=vvv(i-1)+aa(i)*dt;
end
vvv(num)=vvv(num-1)+aa(num)*dt/2;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

ddd=zeros(num,1);
ddd(1)=vvv(1)*dt/2;

for i=2:(num-1)
    ddd(i)=ddd(i-1)+vvv(i)*dt;
end
ddd(num)=ddd(num-1)+vvv(num)*dt/2;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(iunit==1) % G, in/sec, in
    vvv=vvv*386;
    ddd=ddd*386;
end
if(iunit==2) % G, cm/sec, mm
    vvv=vvv*9.81*100;
    ddd=ddd*9.81*1000;
end
if(iunit==3) % m/sec^2, cm/sec, mm
    vvv=vvv*10;
    ddd=ddd*1000;
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

a1=max(abs(a));
a2=max(abs(a));
amax=max([a1 a2 ]);

[ya]=ytick_linear_altp(amax);

v1=max(abs(v));
v2=max(abs(vv));
v3=max(abs(vvv));
vmax=max([v1 v2 v3]);
[yv]=ytick_linear_altp(vmax);

d1=max(abs(d));
d3=max(abs(ddd));
dmax=max([d1  d3]);
[yd]=ytick_linear_altp(dmax);


fig_num=1;

tstart=tt(1);
tend=1.001*tt(num);


hp=figure(fig_num);
fig_num=fig_num+1;
subplot(3,3,1);
plot(tt,a);
ylabel(ay);
xlim([tstart tend]);
ylim([-ya(1) ya(1)]);
grid on;

subplot(3,3,2);
plot(tt,aa);
xlim([tstart tend]);
ylim([-ya(1) ya(1)]);
grid on;

subplot(3,3,3);
plot(tt,aa);
xlim([tstart tend]);
ylim([-ya(1) ya(1)]);
grid on;

subplot(3,3,4);
plot(tt,v);
ylabel(vy);
xlim([tstart tend]);
ylim([-yv(1) yv(1)]);
grid on;

subplot(3,3,5);
plot(tt,vv);
ylim([-yv(1) yv(1)]);
xlim([tstart tend]);
grid on;

subplot(3,3,6);
plot(tt,vvv);
xlim([tstart tend]);
ylim([-yv(1) yv(1)]);
grid on;

subplot(3,3,7);
plot(tt,d);
xlim([tstart tend]);
ylabel(dy);
ylim([-yd(1) yd(1)]);
grid on;
xlabel('Time(sec)');

subplot(3,3,8);
plot(tt,d);
ylim([-yd(1) yd(1)]);
xlim([tstart tend]);
grid on;
xlabel('Time(sec)');

subplot(3,3,9);
plot(tt,ddd);
ylim([-yd(1) yd(1)]);
xlim([tstart tend]);
grid on;
xlabel('Time(sec)');


set(hp, 'Position', [0 0 850 650]);



%%%

psave=get(handles.listbox_psave,'Value');


if(psave==1)
    
    pname='integrated_data';
    
    
    set(gca,'Fontsize',12);
    print(hp,pname,'-dpng','-r300');
    
    out1=sprintf('\n Plot File:  %s.png',pname);
    disp(out1);
    
    msgbox('Plot file exported to hard drive: integrated_data.png');
   
end


%%%

set(handles.uipanel_save,'Visible','on');

tt=fix_size(tt);
aa=fix_size(aa);
vvv=fix_size(vvv);
ddd=fix_size(ddd);

aaa=[tt aa];
vvv=[tt vvv];
ddd=[tt ddd];

setappdata(0,'acceleration',aaa);
setappdata(0,'velocity',vvv);
setappdata(0,'displacement',ddd);
setappdata(0,'dt',dt);
setappdata(0,'ay',ay);
setappdata(0,'vy',vy);
setappdata(0,'dy',dy);

disp(' ');
        disp('                 max     min     std ')

out1=sprintf(' acceleration: %8.4g %8.4g %8.4g ',max(a),min(a),std(a));
out2=sprintf('     velocity: %8.4g %8.4g %8.4g ',max(v),min(v),std(v));
out3=sprintf(' displacement: %8.4g %8.4g %8.4g  ',max(d),min(d),std(d));

disp(out1);
disp(out2);
disp(out3);

setappdata(0,'fig_num',fig_num);



% --- Executes on button press in pushbutton_return.
function pushbutton_return_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_return (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on selection change in listbox_taper_d.
function listbox_taper_d_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_taper_d (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_taper_d contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_taper_d


% --- Executes during object creation, after setting all properties.
function listbox_taper_d_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_taper_d (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_taper_v.
function listbox_taper_v_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_taper_v (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_taper_v contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_taper_v


% --- Executes during object creation, after setting all properties.
function listbox_taper_v_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_taper_v (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_psave.
function listbox_psave_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_psave (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_psave contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_psave


% --- Executes during object creation, after setting all properties.
function listbox_psave_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_psave (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
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

set(handles.uipanel_save,'Visible','off');

n=get(handles.listbox_method,'Value');

set(handles.text_input_array_name,'Visible','on');
set(handles.edit_input_array_name,'Visible','on');

if(n==1)
   set(handles.edit_input_array_name,'enable','on') 
else
    
   set(handles.text_input_array_name,'Visible','off');
   set(handles.edit_input_array_name,'Visible','off');

   set(handles.edit_input_array_name,'enable','off')
   
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



function edit_input_array_name_Callback(hObject, eventdata, handles)
% hObject    handle to edit_input_array_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_input_array_name as text
%        str2double(get(hObject,'String')) returns contents of edit_input_array_name as a double


% --- Executes during object creation, after setting all properties.
function edit_input_array_name_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_input_array_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


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


% --- Executes on selection change in listbox_integration_1.
function listbox_integration_1_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_integration_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_integration_1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_integration_1

set(handles.uipanel_save,'Visible','off');

n=get(handles.listbox_integration_1,'Value');

if(n==4)
    set(handles.edit_fc,'Visible','on');
    set(handles.text_fc,'Visible','on');    
else
    set(handles.edit_fc,'Visible','off');
    set(handles.text_fc,'Visible','off');      
end



% --- Executes during object creation, after setting all properties.
function listbox_integration_1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_integration_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_integration_2.
function listbox_integration_2_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_integration_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_integration_2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_integration_2


% --- Executes during object creation, after setting all properties.
function listbox_integration_2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_integration_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_integration_3.
function listbox_integration_3_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_integration_3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_integration_3 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_integration_3


% --- Executes during object creation, after setting all properties.
function listbox_integration_3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_integration_3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_taper_a.
function listbox_taper_a_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_taper_a (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_taper_a contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_taper_a


% --- Executes during object creation, after setting all properties.
function listbox_taper_a_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_taper_a (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
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

output_name=get(handles.edit_output_array_name,'String');

assignin('base', output_name, data);

h = msgbox('Save Complete'); 


function edit_output_array_name_Callback(hObject, eventdata, handles)
% hObject    handle to edit_output_array_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_output_array_name as text
%        str2double(get(hObject,'String')) returns contents of edit_output_array_name as a double


% --- Executes during object creation, after setting all properties.
function edit_output_array_name_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_output_array_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton_info.
function pushbutton_info_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_info (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

msgbox(' Description written to Matlab Command Window ');

disp(' ');
disp(' ');
disp(' The goal of this script is to correct an acceleration signal so ');
disp(' that its integrated velocity and double integrated displacement ');
disp(' each oscillates about its respective zero baseline. ');
disp(' ');
disp(' The user must use trial-and-error to determine the best ');
disp(' combination of filtering, trend removal and tapering to ');
disp(' to achieve this goal.');
disp(' ');
disp(' Nine subplots appear as follows: ');
disp(' ');
disp(' Row 1, Col 1 - processed acceleration prior to integration ');
disp(' Row 2, Col 1 - integrated velocity ');
disp(' Row 3, Col 1 - double integrated displacement ');
disp(' ');
disp(' Row 3, Col 2 - double integrated displacement (repeated) ');
disp(' Row 2, Col 2 - differentiated velocity from double integrated displacement');
disp(' Row 1, Col 2 - double differentiated acceleration from double integrated displacement');
disp(' ');
disp(' Row 1, Col 3 - double differentiated acceleration (repeated) ');
disp(' Row 2, Col 3 - integrated velocity from double differentiated acceleration');
disp(' Row 3, Col 3 - double integrated displacement from double differentiated acceleration');
disp(' ');
disp(' The goal is that the curves in all nine plots oscillate about the');
disp(' respective zero baseline. ');

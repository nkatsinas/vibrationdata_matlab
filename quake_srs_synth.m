function varargout = quake_srs_synth(varargin)
% QUAKE_SRS_SYNTH MATLAB code for quake_srs_synth.fig
%      QUAKE_SRS_SYNTH, by itself, creates a new QUAKE_SRS_SYNTH or raises the existing
%      singleton*.
%
%      H = QUAKE_SRS_SYNTH returns the handle to a new QUAKE_SRS_SYNTH or the handle to
%      the existing singleton*.
%
%      QUAKE_SRS_SYNTH('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in QUAKE_SRS_SYNTH.M with the given input arguments.
%
%      QUAKE_SRS_SYNTH('Property','Value',...) creates a new QUAKE_SRS_SYNTH or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before quake_srs_synth_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to quake_srs_synth_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help quake_srs_synth

% Last Modified by GUIDE v2.5 03-Apr-2024 13:32:48

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @quake_srs_synth_OpeningFcn, ...
                   'gui_OutputFcn',  @quake_srs_synth_OutputFcn, ...
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


% --- Executes just before quake_srs_synth is made visible.
function quake_srs_synth_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to quake_srs_synth (see VARARGIN)

% Choose default command line output for quake_srs_synth
handles.output = hObject;


n=get(handles.listbox_units,'Value');




listbox_units_Callback(hObject, eventdata, handles);

set(handles.uipanel_png,'Visible','off');

set(handles.uipanel_save,'Visible','off');
set(handles.uipanel_nastran,'Visible','off');

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes quake_srs_synth wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = quake_srs_synth_OutputFcn(hObject, eventdata, handles) 
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

delete(quake_srs_synth);

handles.s=vibrationdata;    

set(handles.s,'Visible','on'); 




% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

tic

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

delete( setdiff( findall(0, 'type', 'figure'), quake_srs_synth ) );

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

fig_num=1;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

try
    FS1=strtrim(get(handles.edit_srs_name,'String'));
    THS=evalin('base',FS1);
catch
    warndlg('SRS array does not exist','Warning');
    return;
end

fr=THS(:,1);
r=THS(:,2);

error_limit=str2num(get(handles.edit_error_limit,'String'));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

iu=get(handles.listbox_units,'Value');

%% uewf=str2num(get(handles.edit_uewf,'String'));

uewf=1.25;


Q=str2num(get(handles.edit_Q,'String'));
iter=str2num(get(handles.edit_iter,'String'));

thu=get(handles.edit_time_history,'String');

if isempty(thu)
    warndlg('Time history does not exist');
    return;
else
    THM=evalin('base',thu);    
end

THM(:,1)=THM(:,1)-THM(1,1);

reference_accel=THM;

t=THM(:,1);
accel=THM(:,2);



num=length(t);
duration=t(num)-t(1);
dt=duration/(num-1);
sr=1/dt;



du=get(handles.edit_duration,'String');
dur=str2num(du);

if isempty(du)
    dur=duration;
    out1=sprintf('%8.4g',duration);
    set(handles.edit_duration,'String',out1);     
end


au=get(handles.edit_sr,'String');
ssr=str2num(au);   

if isempty(au)
    ssr=sr;
    out1=sprintf('%8.4g',sr);
    set(handles.edit_sr,'String',out1);     
end

%%

maxf=max(fr);

if(ssr<10*maxf)
    warndlg('Sample rate is too low ');
end

if(ssr>60*maxf)
    warndlg('Sample rate is higher than needed ');
end

%%
   
    
ffmax=sr/10;

nfr=str2num(get(handles.edit_primary,'String'));
nsec=str2num(get(handles.edit_secondary,'String'));


start_time=t(1);
first=t(1);

nt=2000;


[acceleration,velocity,displacement,wavelet_table,wavelet_low,...
                                                 wavelet_up,alpha,beta]=...
  vibrationdata_wavelet_decomposition_engine_q(t,accel,dt,first,...
                                                  ffmax,nt,nfr,start_time);
                                            

wavelet_table_add=wavelet_table;

acceleration(:,1)

ta=min([t(1) acceleration(1,1)]);
tb=max([max(t) max(acceleration(:,1))]);

figure(fig_num);
fig_num=fig_num+1;
subplot(2,1,1);
plot(t,accel);
title('Reference');
ylabel('Accel (G)');
grid on;
xlim([ta tb]);

subplot(2,1,2);
plot(acceleration(:,1),acceleration(:,2));
title('Wavelet Decomposition');
xlabel('Time (sec)');
ylabel('Accel (G)');
grid on;
xlim([ta tb]);

decomposition=acceleration;
setappdata(0,'decomposition',decomposition);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

sz=size(wavelet_table);

last_wavelet=sz(1);

f=zeros(last_wavelet,1);
amp=zeros(last_wavelet,1);
NHS=zeros(last_wavelet,1);
td=zeros(last_wavelet,1);
%
%
for i=1:last_wavelet
    f(i)=wavelet_table_add(i,2);
    amp(i)=wavelet_table_add(i,3);
    NHS(i)=wavelet_table_add(i,4); 
    td(i)=wavelet_table_add(i,5);  
end

dur_ref=0;

for i=1:last_wavelet
    d=td(i)+(NHS(i)/2*f(i));
    if(d>dur_ref)
        dur_ref=d;
    end
end
%

if(dur_ref<dur)
    dur=dur_ref;
    disp(' ');
    disp(' Duration increased ');
end

%
dt=1./ssr;
%
nt=ceil(dur/dt);
%
damp=1/(2*Q);
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear t;

t=linspace(0,nt*dt,nt+1); 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%

ioct=3;

dlimit=str2num(get(handles.edit_dlimit,'String'));

if(iu==1)
    dlimit=dlimit/386;
else
    dlimit=dlimit/(9.81*1000);
end



[fn,srs_spec]=SRS_specification_interpolation(fr,r,ioct);

[a1,a2,b1,b2,b3,rd_a1,rd_a2,rd_b1,rd_b2,rd_b3]=...
                                      srs_coefficients(fn,damp,dt);  



%%%

dur=str2num(get(handles.edit_duration,'String'));
                                  
[amp,error_i,wavelet_low,wavelet_up,alpha,beta,t]=...
    quake_srs_synth_phase_1(f,dt,damp,amp,NHS,td,last_wavelet,iter,...
                              fn,srs_spec,dlimit,error_limit,iu,uewf,dur);

% f, NHS, & td remain unchanged

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%

[raccel]=generate_time_history_wavelet_table_q(f,amp,NHS,td,t,...
                                        wavelet_low,wavelet_up,alpha,beta);

ta=min([reference_accel(1,1) acceleration(1,1) t(1,1)]);
tb=max([max(reference_accel(:,1)) max(acceleration(:,1)) max(t(:,1))]);

figure(fig_num);
fig_num=fig_num+1;

subplot(3,1,1);
plot(reference_accel(:,1),reference_accel(:,2));
title('Reference');
ylabel('Accel (G)');
set(gca,'XTickLabel',[]);
grid on;
xlim([ta tb]);
 
subplot(3,1,2);
plot(acceleration(:,1),acceleration(:,2));
title('Wavelet Decomposition');
ylabel('Accel (G)');
set(gca,'XTickLabel',[]);
grid on;
xlim([ta tb]);

subplot(3,1,3);
plot(t,raccel);
title('Intermediate');
xlabel('Time (sec)');
ylabel('Accel (G)');
grid on;
xlim([ta tb]);


t=fix_size(t);
raccel=fix_size(raccel);

intermediate=[t raccel];
setappdata(0,'intermediate',intermediate);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
[raccel,ramp,last_wavelet,f,amp,NHS,td,wavelet_low,wavelet_up,alpha,beta]=...
       quake_srs_synth_phase_3(f,dt,amp,NHS,td,t,last_wavelet,...
                srs_spec,dlimit,fn,raccel,a1,a2,b1,b2,b3,nsec,...
                            error_limit,wavelet_low,wavelet_up,alpha,beta);
                        
[dispx,vel,acc]=wavelet_integrate_q(f,ramp,NHS,td,dt,dur,t,...
                                        wavelet_low,wavelet_up,alpha,beta);

raccel=acc;                                    
                        
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%

num=length(fn);     

rxmax=zeros(num,1);
rxmin=zeros(num,1);
                               
for j=1:num
       
        forward=[ b1(j),  b2(j),  b3(j) ];    
        back   =[     1, -a1(j), -a2(j) ];    
%    
        resp=filter(forward,back,raccel);
%
        rxmax(j)=max(resp);
        rxmin(j)=abs(min(resp));
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



f=fix_size(f);
amp=fix_size(amp);
NHS=fix_size(NHS);
td=fix_size(td);

wtable=[f amp NHS td];

if(iu==1)
    vel=vel*386;
    dispx=dispx*386;
    vy='Vel (in/sec)';
    dy='Disp (in)';
else
    vel=vel*9.81*100;
    dispx=dispx*9.81*1000;   
    vy='Vel (cm/sec)';
    dy='Disp (mm)';    
end

t=fix_size(t);
dispx=fix_size(dispx);
vel=fix_size(vel);
acc=fix_size(acc);

accel_array=[t acc];

setappdata(0,'dispx_array',[t dispx]);
setappdata(0,'vel_array',[t vel]);
setappdata(0,'accel_array',accel_array);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

ta=min([reference_accel(1,1) acceleration(1,1) accel_array(1,1)]);
tb=max([max(reference_accel(:,1)) max(acceleration(:,1)) max(accel_array(:,1))]);

figure(fig_num);
fig_num=fig_num+1;
 
subplot(3,1,1);
plot(reference_accel(:,1),reference_accel(:,2));
title('Reference');
ylabel('Accel (G)');
set(gca,'XTickLabel',[]);
grid on;
xlim([ta tb]);
 
subplot(3,1,2);
plot(acceleration(:,1),acceleration(:,2));
title('Wavelet Decomposition');
ylabel('Accel (G)');
set(gca,'XTickLabel',[]);
grid on;
xlim([ta tb]);

subplot(3,1,3);
plot(accel_array(:,1),accel_array(:,2));
title('Modifed');
xlabel('Time (sec)');
ylabel('Accel (G)');
grid on;
xlim([ta tb]);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

figure(fig_num);
fig_num=fig_num+1;
subplot(3,1,1);
plot(accel_array(:,1),accel_array(:,2));
title('Modified Set');
ylabel('Accel (G)');
set(gca,'XTickLabel',[]);
grid on;

subplot(3,1,2);
plot(t,vel);
ylabel(vy);
set(gca,'XTickLabel',[]);
grid on;

subplot(3,1,3);
plot(t,dispx);
ylabel(dy);
xlabel('Time(sec)');
grid on;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

figure(fig_num);
fig_num=fig_num+1;
t1=r/sqrt(2);
t2=r*sqrt(2);
plot(fn,rxmax,fn,rxmin,fr,t2,fr,r,fr,t1);
set(gca,'MinorGridLineStyle','none','GridLineStyle',':','XScale','log','YScale','log');
legend('Synth Pos','Synth Neg','+3 dB','Spec','-3 dB','location','northwest');
grid on;
out1=sprintf('Shock Response Spectrum Q=%g',Q);
title(out1);
xlabel('Natural Frequency (Hz)');
ylabel('Accel (G)');

fn=fix_size(fn);
rxmax=fix_size(rxmax);
rxmin=fix_size(rxmin);

[aay]=get(gca,'ylim');

ylim([aay(1) 10*aay(2)]);


setappdata(0,'srs',[fn rxmax rxmin]);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

set(handles.uipanel_save,'Visible','on');
set(handles.uipanel_nastran,'Visible','on');
set(handles.uipanel_png,'Visible','on');

setappdata(0,'reference_accel',reference_accel);
setappdata(0,'fig_num',fig_num);
setappdata(0,'t',t);
setappdata(0,'raccel',raccel);
setappdata(0,'dy',dy);
setappdata(0,'vy',vy);
setappdata(0,'fn',fn);
setappdata(0,'rxmax',rxmax);
setappdata(0,'rxmin',rxmin);
setappdata(0,'r',r);
setappdata(0,'fr',fr);
setappdata(0,'Q',Q);
setappdata(0,'wtable',wtable);
setappdata(0,'acceleration',acceleration);

t=toc;

minutes=round(t/60);

out1=sprintf('\n Elapsed Time = %g min ',minutes);
disp(out1);



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



function edit_srs_Callback(hObject, eventdata, handles)
% hObject    handle to edit_srs (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_srs as text
%        str2double(get(hObject,'String')) returns contents of edit_srs as a double


% --- Executes during object creation, after setting all properties.
function edit_srs_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_srs (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_th.
function listbox_th_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_th (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_th contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_th


% --- Executes during object creation, after setting all properties.
function listbox_th_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_th (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_srs_name_Callback(hObject, eventdata, handles)
% hObject    handle to edit_srs_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_srs_name as text
%        str2double(get(hObject,'String')) returns contents of edit_srs_name as a double


% --- Executes during object creation, after setting all properties.
function edit_srs_name_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_srs_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_sr_Callback(hObject, eventdata, handles)
% hObject    handle to edit_sr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_sr as text
%        str2double(get(hObject,'String')) returns contents of edit_sr as a double


% --- Executes during object creation, after setting all properties.
function edit_sr_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_sr (see GCBO)
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

n=get(handles.listbox_units,'Value');

if(n==1)
    set(handles.text_dlimit,'String','inch');  
else
    set(handles.text_dlimit,'String','mm');       
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



function edit_iter_Callback(hObject, eventdata, handles)
% hObject    handle to edit_iter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_iter as text
%        str2double(get(hObject,'String')) returns contents of edit_iter as a double


% --- Executes during object creation, after setting all properties.
function edit_iter_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_iter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_duration_Callback(hObject, eventdata, handles)
% hObject    handle to edit_duration (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_duration as text
%        str2double(get(hObject,'String')) returns contents of edit_duration as a double


% --- Executes during object creation, after setting all properties.
function edit_duration_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_duration (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_dlimit_Callback(hObject, eventdata, handles)
% hObject    handle to edit_dlimit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_dlimit as text
%        str2double(get(hObject,'String')) returns contents of edit_dlimit as a double


% --- Executes during object creation, after setting all properties.
function edit_dlimit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_dlimit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_time_history_Callback(hObject, eventdata, handles)
% hObject    handle to edit_time_history (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_time_history as text
%        str2double(get(hObject,'String')) returns contents of edit_time_history as a double


% --- Executes during object creation, after setting all properties.
function edit_time_history_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_time_history (see GCBO)
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

n=get(handles.listbox_save,'Value');

output_name=get(handles.edit_output_array_name,'String');


if(n==1)
    data=getappdata(0,'accel_array');
end
if(n==2)
    data=getappdata(0,'vel_array');    
end
if(n==3)
    data=getappdata(0,'dispx_array'); 
end
if(n==4)
    data=getappdata(0,'srs'); 
end
if(n==5)
    data=getappdata(0,'wtable'); 
end
if(n==6)
    data=getappdata(0,'decomposition'); 
end
if(n==7)
    data=getappdata(0,'intermediate'); 
end

assignin('base', output_name, data);

msgbox('Array saved');


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


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

data=getappdata(0,'accel_array');
assignin('base','export_signal_nastran',data);

handles.s=Vibrationdata_export_to_Nastran;    
set(handles.s,'Visible','on'); 



function edit_primary_Callback(hObject, eventdata, handles)
% hObject    handle to edit_primary (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_primary as text
%        str2double(get(hObject,'String')) returns contents of edit_primary as a double


% --- Executes during object creation, after setting all properties.
function edit_primary_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_primary (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_secondary_Callback(hObject, eventdata, handles)
% hObject    handle to edit_secondary (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_secondary as text
%        str2double(get(hObject,'String')) returns contents of edit_secondary as a double


% --- Executes during object creation, after setting all properties.
function edit_secondary_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_secondary (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_png.
function pushbutton_png_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_png (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

prefix=get(handles.edit_png,'String');

fig_num=getappdata(0,'fig_num');

reference_accel=getappdata(0,'reference_accel');

t=getappdata(0,'t');

dispx_array=getappdata(0,'dispx_array');
vel_array=getappdata(0,'vel_array');
accel_array=getappdata(0,'accel_array');

dy=getappdata(0,'dy');
vy=getappdata(0,'vy');
fn=getappdata(0,'fn');
fr=getappdata(0,'fr');
rxmax=getappdata(0,'rxmax');
rxmin=getappdata(0,'rxmin');
r=getappdata(0,'r');
acceleration=getappdata(0,'acceleration');
Q=getappdata(0,'Q');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

disp(' ');
disp(' Plot Files: ');

h=figure(fig_num);
fig_num=fig_num+1;
 
subplot(3,1,1);
plot(reference_accel(:,1),reference_accel(:,2));
title('Reference');
ylabel('Accel (G)');
grid on;
set(gca,'Fontsize',11);
 
subplot(3,1,2);
plot(acceleration(:,1),acceleration(:,2));
title('Wavelet Decomposition');
ylabel('Accel (G)');
grid on;
set(gca,'Fontsize',11);

subplot(3,1,3);
plot(accel_array(:,1),accel_array(:,2));
title('Modifed');
xlabel('Time (sec)');
ylabel('Accel (G)');
grid on;
set(gca,'Fontsize',11);


    
pname=sprintf('%s_accel_ref',prefix);    

out1=sprintf('   %s.png',pname);
disp(out1);
    
print(h,pname,'-dpng','-r300');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

h=figure(fig_num);
fig_num=fig_num+1;
subplot(3,1,1);
plot(accel_array(:,1),accel_array(:,2));
title('Modified Set');
ylabel('Accel (G)');
grid on;
set(gca,'Fontsize',11);
 
subplot(3,1,2);
plot(vel_array(:,1),vel_array(:,2));
ylabel(vy);
grid on;
set(gca,'Fontsize',11);
 
subplot(3,1,3);
plot(dispx_array(:,1),dispx_array(:,2));
ylabel(dy);
xlabel('Time(sec)');
grid on;
set(gca,'Fontsize',11);
    
pname=sprintf('%s_accel_vel_disp',prefix);

out1=sprintf('   %s.png',pname);
disp(out1);
    
print(h,pname,'-dpng','-r300');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
h=figure(fig_num);
fig_num=fig_num+1;
t1=r/sqrt(2);
t2=r*sqrt(2);
plot(fn,rxmax,fn,rxmin,fr,t2,fr,r,fr,t1);
set(gca,'MinorGridLineStyle','none','GridLineStyle',':','XScale','log','YScale','log');
legend('Synth Pos','Synth Neg','+3 dB','Spec','-3 dB');
grid on;
out1=sprintf('Shock Response Spectrum Q=%g',Q);
title(out1);
xlabel('Natural Frequency (Hz)');
ylabel('Accel (G)');
[aay]=get(gca,'ylim');
ylim([aay(1) 10*aay(2)]);

pname=sprintf('%s_srs',prefix);
    
out1=sprintf('   %s.png',pname);
disp(out1);
    
set(gca,'Fontsize',12);
print(h,pname,'-dpng','-r300');



function edit_png_Callback(hObject, eventdata, handles)
% hObject    handle to edit_png (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_png as text
%        str2double(get(hObject,'String')) returns contents of edit_png as a double


% --- Executes during object creation, after setting all properties.
function edit_png_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_png (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_error_limit_Callback(hObject, eventdata, handles)
% hObject    handle to edit_error_limit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_error_limit as text
%        str2double(get(hObject,'String')) returns contents of edit_error_limit as a double


% --- Executes during object creation, after setting all properties.
function edit_error_limit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_error_limit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_uewf_Callback(hObject, eventdata, handles)
% hObject    handle to edit_uewf (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_uewf as text
%        str2double(get(hObject,'String')) returns contents of edit_uewf as a double


% --- Executes during object creation, after setting all properties.
function edit_uewf_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_uewf (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function pushbutton_calculate_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

function varargout = plate_fea_arbitrary(varargin)
% PLATE_FEA_ARBITRARY MATLAB code for plate_fea_arbitrary.fig
%      PLATE_FEA_ARBITRARY, by itself, creates a new PLATE_FEA_ARBITRARY or raises the existing
%      singleton*.
%
%      H = PLATE_FEA_ARBITRARY returns the handle to a new PLATE_FEA_ARBITRARY or the handle to
%      the existing singleton*.
%
%      PLATE_FEA_ARBITRARY('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PLATE_FEA_ARBITRARY.M with the given input arguments.
%
%      PLATE_FEA_ARBITRARY('Property','Value',...) creates a new PLATE_FEA_ARBITRARY or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before plate_fea_arbitrary_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to plate_fea_arbitrary_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help plate_fea_arbitrary

% Last Modified by GUIDE v2.5 25-May-2015 14:12:25

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @plate_fea_arbitrary_OpeningFcn, ...
                   'gui_OutputFcn',  @plate_fea_arbitrary_OutputFcn, ...
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


% --- Executes just before plate_fea_arbitrary is made visible.
function plate_fea_arbitrary_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to plate_fea_arbitrary (see VARARGIN)

% Choose default command line output for plate_fea_arbitrary
handles.output = hObject;

set(handles.uipanel_save,'Visible','off');
set(handles.pushbutton_rainflow,'Visible','off');
set(handles.pushbutton_stats,'Visible','off');

fig_num=400;
setappdata(0,'afig',fig_num);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes plate_fea_arbitrary wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = plate_fea_arbitrary_OutputFcn(hObject, eventdata, handles) 
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

delete(plate_fea_arbitrary)


% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

disp(' Reading data');

try
     FS=get(handles.edit_input_array,'String');
     THM=evalin('base',FS);   
catch
     warndlg('Input array does not exist.');
     return;
end


nt=length(THM(:,1));

dt=(THM(nt,1)-THM(1,1))/(nt-1);
sr=1/dt;

fig_num=getappdata(0,'afig');

node=str2num(get(handles.edit_node,'String'));


damp=getappdata(0,'damp_ratio');

iu=getappdata(0,'iu');

afig=getappdata(0,'afig');


%% fn=getappdata(0,'part_fn');

fn=getappdata(0,'part_fn');

omega=getappdata(0,'part_omega');
ModeShapes=getappdata(0,'part_ModeShapes');

MST=ModeShapes';

TT=getappdata(0,'TT');
T1=getappdata(0,'T1');
T2=getappdata(0,'T2');

Mwd=getappdata(0,'Mwd');
Mww=getappdata(0,'Mww');

ngw=getappdata(0,'ngw');
nem=getappdata(0,'nem');

TZ_tracking_array=getappdata(0,'TZ_tracking_array');

ij=TZ_tracking_array(node);
for j=1:length(ngw)
   
    if(ngw(j)==ij)
        nidof=j;
        break;
    end
      
end

retdof=nidof-nem;


sz=size(Mww);
nff=sz(1);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

omegan=omega;
%

%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

disp(' Integrating acceleration ');

f=THM(:,2);


[dvelox]=integrate_function(f,dt);
 [ddisp]=integrate_function(dvelox,dt);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  Modal Transient
%
clear omegad;
omegad=zeros(nff,1);


for i=1:length(damp)
    omegad(i)=omegan(i)*sqrt(1-damp(i)^2);
end
%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%%

num_modes=length(fn);



if(num_modes==0)
   out1=sprintf(' Increase input data sample rate >= %8.3g',10*fn(1));
   warndlg(out1); 
   return; 
end

nmx=get(handles.listbox_nmx,'Value');

if(num_modes>nmx)
    num_modes=nmx;
end

if(num_modes>length(damp))
    num_modes=length(damp);
end



noo=num_modes;

for i=1:noo
    
    if(sr<10*fn(i))
       num_modes=i-1;
       out1=sprintf('\n Number of included modes = %d due to input data sample rate limitation. ',num_modes);   
       disp(out1);        
       break; 
    end
    
end


disp(' ');
out1=sprintf(' sample rate = %8.4g samples/sec ',sr);
disp(out1);

disp(' ');
disp('  n     fn(Hz)   damp ratio');

for i=1:num_modes 
   out1=sprintf(' %d.  %8.3g  %6.3g ',i,fn(i),damp(i)); 
   disp(out1); 
end


Q=ModeShapes(:,1:num_modes);
QT=Q';



ff=zeros(nem,1);

QTMwd=QT*Mwd;

for i=1:length(f)
    ff(1:nem,i)=f(i);
end

disp(' ');
disp(' Calculating FP ');

FP=-QTMwd*ff;

disp(' Completed FP ')    

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

out1=sprintf('\n num_modes=%d \n',num_modes);
disp(out1);

%
[a1,a2,df1,df2,df3,vf1,vf2,vf3,af1,af2,af3]=...
              ramp_invariant_filter_coefficients(num_modes,omegan,damp,dt);
%
tic
[aa,dd]=enforced_motion_modal_transient_engine_fea_plate(FP,a1,a2,df1,df2,df3,...
                                     vf1,vf2,vf3,af1,af2,af3,nt,num_modes,Q,retdof);
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%
%    Transformation back to xd xf
%
clear dT;
clear vT;
clear accT;
%
%

   accel(:,1)=THM(:,1);
rel_disp(:,1)=THM(:,1);


LD=length(ddisp);

yddisp=zeros(nem,LD);
forig=zeros(nem,LD);


for j=1:nem
   
        yddisp(j,:)=ddisp(:);

        forig(j,:)=THM(:,2);                
end

%  T2 = identity matix

disp(' Put in original order ');

sz=size(T1);

MM=zeros(sz(1),1);
dT=zeros(sz(1),1);
accT=zeros(sz(1),1);

for i=1:sz(1)
    MM(i)=sum(T1(i,:));
end

       accel(:,2)=MM(retdof)*THM(:,2)+aa(:);
    rel_disp(:,2)=MM(retdof)*ddisp(:)+dd(:)-ddisp(:);


if(iu==1)
    rel_disp(:,2)=rel_disp(:,2)*386;
else
    rel_disp(:,2)=rel_disp(:,2)*9.81*1000;    
end

toc     
    
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(afig==400)

    figure(afig);
    afig=afig+1;
    plot(THM(:,1),THM(:,2));
    grid on;
    xlabel('Time (sec)');
    ylabel('Accel (G)');
    title('Base Input');

end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

figure(afig);
afig=afig+1;
plot(accel(:,1),accel(:,2));
grid on;
xlabel('Time (sec)');
ylabel('Accel (G)');
out1=sprintf('Acceleration at node %d ',node);
title(out1);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[vv]=integrate_function(accel(:,2),dt);

vv=fix_size(vv);

if(iu==1)
    vv=vv*386;
else
    vv=vv*9.81*100;
end

vel(:,1)=THM(:,1);
vel(:,2)=vv;

figure(afig);
afig=afig+1;
plot(vel(:,1),vel(:,2));
grid on;
xlabel('Time (sec)');

if(iu==1)
    ylabel('Vel (in/sec)');
else
    ylabel('Vel (cm/sec)');    
end
out1=sprintf('Velocity at node %d ',node);
title(out1);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

figure(afig);
afig=afig+1;
plot(rel_disp(:,1),rel_disp(:,2));
grid on;
xlabel('Time (sec)');

if(iu==1)
    ylabel('Rel Disp (in)');
else
    ylabel('Rel Disp (mm)');    
end
out1=sprintf('Relative Displacement at node %d ',node);
title(out1);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

disp(' ');
out1=sprintf(' Response Results at node %d ',node);
disp(out1);

    out1=sprintf('\n  Acceleration (G): \n            max=%8.4g  min=%8.4g  std dev=%8.4g',max(accel(:,2)),min(accel(:,2)),std(accel(:,2)));
disp(out1);

if(iu==1)
    out2=sprintf('\n  Velocity (in): \n            max=%8.4g  min=%8.4g  std dev=%8.4g',max(vel(:,2)),min(vel(:,2)),std(vel(:,2)));    
    out3=sprintf('\n  Relative Displacement (in): \n            max=%8.4g  min=%8.4g  std dev=%8.4g',max(rel_disp(:,2)),min(rel_disp(:,2)),std(rel_disp(:,2)));
else
    out2=sprintf('\n  Velocity (cm/sec): \n            max=%8.4g  min=%8.4g  std dev=%8.4g',max(vel(:,2)),min(vel(:,2)),std(vel(:,2)));      
    out3=sprintf('\n  Relative Displacement (mm): \n            max=%8.4g  min=%8.4g  std dev=%8.4g',max(rel_disp(:,2)),min(rel_disp(:,2)),std(rel_disp(:,2)));    
end  
disp(out2);
disp(out3);
disp(' ');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

setappdata(0,'afig',afig);

setappdata(0,'accel',accel);
setappdata(0,'rel_disp',rel_disp);

set(handles.uipanel_save,'Visible','on');



% --- Executes on button press in pushbutton_save.
function pushbutton_save_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

n=get(handles.listbox_type,'Value');

if(n==1)
    data=getappdata(0,'accel');
end
if(n==2)
    data=getappdata(0,'rel_disp');
end

output_name=get(handles.edit_output_array_name,'String');
assignin('base', output_name, data);

set(handles.pushbutton_rainflow,'Visible','on');
set(handles.pushbutton_stats,'Visible','on');

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


% --- Executes on selection change in listbox_type.
function listbox_type_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_type contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_type


% --- Executes during object creation, after setting all properties.
function listbox_type_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_type (see GCBO)
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



function edit_node_Callback(hObject, eventdata, handles)
% hObject    handle to edit_node (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_node as text
%        str2double(get(hObject,'String')) returns contents of edit_node as a double


% --- Executes during object creation, after setting all properties.
function edit_node_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_node (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit4_Callback(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit4 as text
%        str2double(get(hObject,'String')) returns contents of edit4 as a double


% --- Executes during object creation, after setting all properties.
function edit4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_rainflow.
function pushbutton_rainflow_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_rainflow (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.s=vibrationdata_rainflow;
set(handles.s,'Visible','on')


% --- Executes on button press in pushbutton_stats.
function pushbutton_stats_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_stats (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.s=vibrationdata_statistics
set(handles.s,'Visible','on')


% --- Executes on selection change in listbox_nmx.
function listbox_nmx_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_nmx (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_nmx contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_nmx


% --- Executes during object creation, after setting all properties.
function listbox_nmx_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_nmx (see GCBO)
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

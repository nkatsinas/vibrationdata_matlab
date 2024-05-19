function varargout = vibrationdata_two_dof_Dirac_force(varargin)
% VIBRATIONDATA_TWO_DOF_DIRAC_FORCE MATLAB code for vibrationdata_two_dof_Dirac_force.fig
%      VIBRATIONDATA_TWO_DOF_DIRAC_FORCE, by itself, creates a new VIBRATIONDATA_TWO_DOF_DIRAC_FORCE or raises the existing
%      singleton*.
%
%      H = VIBRATIONDATA_TWO_DOF_DIRAC_FORCE returns the handle to a new VIBRATIONDATA_TWO_DOF_DIRAC_FORCE or the handle to
%      the existing singleton*.
%
%      VIBRATIONDATA_TWO_DOF_DIRAC_FORCE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in VIBRATIONDATA_TWO_DOF_DIRAC_FORCE.M with the given input arguments.
%
%      VIBRATIONDATA_TWO_DOF_DIRAC_FORCE('Property','Value',...) creates a new VIBRATIONDATA_TWO_DOF_DIRAC_FORCE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before vibrationdata_two_dof_Dirac_force_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to vibrationdata_two_dof_Dirac_force_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help vibrationdata_two_dof_Dirac_force

% Last Modified by GUIDE v2.5 24-Jul-2017 09:58:37

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @vibrationdata_two_dof_Dirac_force_OpeningFcn, ...
                   'gui_OutputFcn',  @vibrationdata_two_dof_Dirac_force_OutputFcn, ...
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


% --- Executes just before vibrationdata_two_dof_Dirac_force is made visible.
function vibrationdata_two_dof_Dirac_force_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to vibrationdata_two_dof_Dirac_force (see VARARGIN)

% Choose default command line output for vibrationdata_two_dof_Dirac_force
handles.output = hObject;

set(handles.uipanel_save,'Visible','off');

iu=getappdata(0,'unit');

if(iu==1)
    sss='Total Impulse (lbf sec)';
else
    sss='Total Impulse (N sec)';    
end

set(handles.text_total_impulse,'String',sss);


% Update handles structure
guidata(hObject, handles);

% UIWAIT makes vibrationdata_two_dof_Dirac_force wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = vibrationdata_two_dof_Dirac_force_OutputFcn(hObject, eventdata, handles) 
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

delete(vibrationdata_two_dof_Dirac_force);


% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

tpi=2*pi;

fig_num=1;

      mass=getappdata(0,'m2');
      stiffness=getappdata(0,'k2');

      damp=getappdata(0,'damping');
ModeShapes=getappdata(0,'ModeShapes');
        fn=getappdata(0,'fn');
        iu=getappdata(0,'unit');
        
dur=str2num(get(handles.edit_dur,'String'));        
sr=str2num(get(handles.edit_sr,'String'));   

dt=1/sr;

nt=round(dur/dt);

Q=ModeShapes;

nd=zeros(2,nt);
d=zeros(2,nt);

nv=zeros(2,nt);
v=zeros(2,nt);

na=zeros(2,nt);
acc=zeros(2,nt);

t=zeros(nt,1);

%%%

Imp=str2num(get(handles.edit_total_impulse,'String'));

%%%

omegan=tpi*fn;

omegad=zeros(2,1);
domegan=zeros(2,1);

for i=1:2
    omegad(i)=omegan(i)*sqrt(1-damp(i)^2);
   domegan(i)=damp(i)*omegan(i);
end

if(max(abs(damp))>1)
   warndlg('Damping Error'); 
   return; 
end

for i=1:nt
    
   t(i)=(i-1)*dt;   
      
   a1=-domegan(1)*t(i);
   b1=  omegad(1)*t(i);
   
   a2=-domegan(2)*t(i);
   b2=  omegad(2)*t(i);
   
   sinb1=sin(b1);   
   sinb2=sin(b2);   
   
   cosb1=cos(b1);
   cosb2=cos(b2);   
   
%    
   n1= Q(2,1)*exp(a1)*sinb1/omegad(1); 
   n2= Q(2,2)*exp(a2)*sinb2/omegad(2);    

   nd(1,i)=Imp*n1;
   nd(2,i)=Imp*n2;
   d(:,i)=Q*nd(:,i);
   
%%%   

   n1= Q(2,1)*( -domegan(1)*sinb1+omegad(1)*cosb1 )*exp(a1)/omegad(1); 
   n2= Q(2,2)*( -domegan(2)*sinb2+omegad(2)*cosb2 )*exp(a2)/omegad(2);   

   nv(1,i)=Imp*n1;
   nv(2,i)=Imp*n2;
   v(:,i)=Q*nv(:,i);

%%%

   n11=  -domegan(1)*( -domegan(1)*sinb1+omegad(1)*cosb1 );
   n12=    omegad(1)*( -domegan(1)*cosb1-omegad(1)*sinb1 );

   n21=  -domegan(2)*( -domegan(2)*sinb2+omegad(2)*cosb2 );
   n22=    omegad(2)*( -domegan(2)*cosb2-omegad(2)*sinb2 );  


   na(1,i)=Imp*Q(2,1)*(n11+n12)*exp(a1)/omegad(1);
   na(2,i)=Imp*Q(2,2)*(n21+n22)*exp(a2)/omegad(2);
   
   acc(:,i)=Q*na(:,i);   
   
%%%
end
%

data1=[t nd(1,:)'];
data2=[t nd(2,:)'];

t_string1='Modal Displacements';
t_string2=' ';

xlabel2='Time (sec)';

ylabel1=' mode 1 ';
ylabel2=' mode 2 ';


[fig_num]=subplots_two_linlin_two_titles_scale(fig_num,xlabel2,ylabel1,ylabel2,data1,data2,t_string1,t_string2);

%
figure(fig_num);
fig_num=fig_num+1;

dd=d;
if(iu==2)
    dd=dd*1000;
end

plot(t,dd(1,:),t,dd(2,:));

    
legend ('dof 1','dof 2');   
xlabel('Time(sec)');
title('Displacement');
grid on;
disp(' ');
if(iu==1)
    ylabel(' Displacement(in) ');
    disp(' Peak Displacement (in) ')
else
    ylabel(' Displacement(mm) ');
    disp(' Peak Displacement (mm)')
end

out1=sprintf('dof 1  %8.4g  %8.4g  ',max(dd(1,:)),min(dd(1,:)));
out2=sprintf('dof 2  %8.4g  %8.4g  ',max(dd(2,:)),min(dd(2,:)));

disp(out1);
disp(out2);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

dd=dd';

rd=zeros(nt,1);

for i=1:nt
    rd(i)=dd(i,2)-dd(i,1);
end
    
figure(fig_num);
fig_num=fig_num+1;
plot(t,rd);
xlabel('Time(sec)');
title('Relative Displacement (dof 2 - dof 1)');
grid on;
disp(' ');
if(iu==1)
    ylabel(' Disp (in) ');
    disp(' Peak Relative Displacement (in) ')
else
    ylabel(' Disp(mm) ');
    disp(' Peak Relative Displacement (mm)')
end

out1=sprintf('dof 1  %8.4g  %8.4g  ',max(rd),min(rd));
disp(out1);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
figure(fig_num);
fig_num=fig_num+1;
plot(t,v(1,:),t,v(2,:));
legend ('dof 1','dof 2');   
xlabel('Time(sec)');
title('Velocity');

grid on;
%

disp(' ');
if(iu==1)
    ylabel(' Velocity(in/sec) ');
    disp(' Peak Velocity (in/sec) ')
else
    ylabel(' Velocity(mm/sec) ');
    disp(' Peak Velocity (mm/sec)')
end
 
out1=sprintf('dof 1  %8.4g  %8.4g  ',max(v(1,:)),min(v(1,:)));
out2=sprintf('dof 2  %8.4g  %8.4g  ',max(v(2,:)),min(v(2,:)));
 
disp(out1);
disp(out2);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
figure(fig_num);
fig_num=fig_num+1;
if(iu==1)
    acc=acc/386;
else
    acc=acc/9.81;
end
plot(t,acc(1,:),t,acc(2,:));
legend ('dof 1','dof 2');   
xlabel('Time(sec)');
title('Acceleration');
ylabel(' Accel(G) ');
grid on;
disp(' ');
disp(' Peak Acceleration (G) ');
        
out1=sprintf('dof 1  %8.4g  %8.4g  ',max(acc(1,:)),min(acc(1,:)));
out2=sprintf('dof 2  %8.4g  %8.4g  ',max(acc(2,:)),min(acc(2,:)));
 
disp(out1);
disp(out2);
        
disp(' ');

v=v';
acc=acc';


setappdata(0,'rd',[t rd]);
setappdata(0,'acc',[t acc]);
setappdata(0,'v',[t v]);
setappdata(0,'dd',[t dd]);

set(handles.uipanel_save,'Visible','on');





function edit_dur_Callback(hObject, eventdata, handles)
% hObject    handle to edit_dur (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_dur as text
%        str2double(get(hObject,'String')) returns contents of edit_dur as a double


% --- Executes during object creation, after setting all properties.
function edit_dur_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_dur (see GCBO)
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


% --- Executes on button press in pushbutton_save.
function pushbutton_save_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

n=get(handles.listbox_output,'Value');

if(n==1)
    data=getappdata(0,'rd');
end
if(n==2)
    data=getappdata(0,'dd');
end
if(n==3)
    data=getappdata(0,'v');
end
if(n==4)
    data=getappdata(0,'acc');
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



function edit_total_impulse_Callback(hObject, eventdata, handles)
% hObject    handle to edit_total_impulse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_total_impulse as text
%        str2double(get(hObject,'String')) returns contents of edit_total_impulse as a double


% --- Executes during object creation, after setting all properties.
function edit_total_impulse_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_total_impulse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

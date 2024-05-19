function varargout = vibrationdata_remove_damped_sine(varargin)
% VIBRATIONDATA_REMOVE_DAMPED_SINE MATLAB code for vibrationdata_remove_damped_sine.fig
%      VIBRATIONDATA_REMOVE_DAMPED_SINE, by itself, creates a new VIBRATIONDATA_REMOVE_DAMPED_SINE or raises the existing
%      singleton*.
%
%      H = VIBRATIONDATA_REMOVE_DAMPED_SINE returns the handle to a new VIBRATIONDATA_REMOVE_DAMPED_SINE or the handle to
%      the existing singleton*.
%
%      VIBRATIONDATA_REMOVE_DAMPED_SINE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in VIBRATIONDATA_REMOVE_DAMPED_SINE.M with the given input arguments.
%
%      VIBRATIONDATA_REMOVE_DAMPED_SINE('Property','Value',...) creates a new VIBRATIONDATA_REMOVE_DAMPED_SINE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before vibrationdata_remove_damped_sine_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to vibrationdata_remove_damped_sine_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help vibrationdata_remove_damped_sine

% Last Modified by GUIDE v2.5 30-Jan-2015 10:24:32

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @vibrationdata_remove_damped_sine_OpeningFcn, ...
                   'gui_OutputFcn',  @vibrationdata_remove_damped_sine_OutputFcn, ...
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


% --- Executes just before vibrationdata_remove_damped_sine is made visible.
function vibrationdata_remove_damped_sine_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to vibrationdata_remove_damped_sine (see VARARGIN)

% Choose default command line output for vibrationdata_remove_damped_sine
handles.output = hObject;


set(handles.pushbutton_calculate,'Visible','off');
set(handles.uipanel_save,'Visible','off');

set(handles.text_t1,'Visible','off');
set(handles.text_t2,'Visible','off');
set(handles.edit_t1,'Visible','off');
set(handles.edit_t2,'Visible','off');

listbox_num_tones_Callback(hObject, eventdata, handles);


% Update handles structure
guidata(hObject, handles);

% UIWAIT makes vibrationdata_remove_damped_sine wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = vibrationdata_remove_damped_sine_OutputFcn(hObject, eventdata, handles) 
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

delete(vibrationdata_remove_damped_sine);


% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


nt=str2num(get(handles.edit_nt,'String'));

THM=getappdata(0,'THM');

%%%%%%

m=get(handles.listbox_num_tones,'Value');
    
N=m;
    
A=char(get(handles.uitable_coordinates,'Data'));
    
B=str2num(A);
    
freq=B(1:N);
bw=B((N+1):(2*N)); 
npf=B((2*N+1):(3*N)); 
    

%%%%%%

nfr=sum(npf);

fl=zeros(nfr,1);
fu=zeros(nfr,1);

k=1;

for i=1:N
   for j=1:npf(i)
       fl(k)=freq(i)-bw(i)/2;
       fu(k)=freq(i)+bw(i)/2;
       k=k+1;
   end 
end   

%%%%%%

amp=double(THM(:,2));
 
n=length(amp);
dur=THM(n,1)-THM(1,1);
dt=dur/(n-1);
sr=1/dt;

s_amp=THM(:,2);
s_tim=THM(:,1);

tmi=min(THM(:,1));
tmx=max(THM(:,1));

try
    ts=str2num(get(handles.edit_t1,'String'));
catch
    ts=tmi;
end

try
    te=str2num(get(handles.edit_t2,'String'));
catch
    te=tmx;
end

%%%%%%

out1=sprintf(' ts=%8.4g  te=%8.4g  tmi=%8.4g  dt=%8.4g  ',ts,te,tmi,dt);
disp(out1);

n1=fix((ts-tmi)/dt);
n2=fix((te-tmi)/dt);
%
if(n1<1)
    n1=1;
end
%
if(n2>n)
    n2=n;
end
%
if(n1>n2)
    n2=n1;
end
%

out1=sprintf(' n1=%d  n2=%d  ',n1,n2);
disp(out1);
%

if(n1==n2)
    warndlg(' n1=n2 ');
    return;
end

%
tim=s_tim(n1:n2)';
t=tim;
%
amp=s_amp(n1:n2)';
a=amp;
a1=a;
%
np=length(tim);


if(np<=0)
    warndlg(' Number of points is zero ');
    return;
end


n=np;
original=amp;
running_sum=amp*0;
%
out1 = sprintf(' np  = %d  \n',np);
disp(out1)
%
fmax=0.;
%
istr=1;  % manual frequencies 
%
dur=max(t)-min(t);

out1=sprintf('\n dur = %8.4g sec \n',dur);
disp(out1);

if(dur<=1.0e-20)
    warndlg(' Duration = 0 ');
    return;
end

num2=length(t);

%
drate=fix(sr/(fmax*16.));
%
if(drate <2)
    drate=1;
end    
if(drate > 10)
    drate=10;
end    
%
x1r=zeros(nfr,1);
x2r=zeros(nfr,1);
x3r=zeros(nfr,1);
x4r=zeros(nfr,1);
x5r=zeros(nfr,1);
%
for ie=1:nfr
%
    out4 = sprintf('\n frequency case %d \n',ie);
    disp(out4)    
%
    flow=fl(ie);
     fup=fu(ie);
%                 
	 [a,x1r,x2r,x3r,x4r,x5r,running_sum]=...
        sf_engine2(a,t,num2,flow,fup,ie,nt,dur,x1r,x2r,x3r,x4r,...
                                            x5r,running_sum,original,istr);                 
%
end
%
%%
%%

tp=2*pi;

disp(' ');
disp(' Results');
disp(' ');
disp(' Case   Amplitude   fn(Hz)       damp      Phase(rad)  Delay(sec) ');
%
for ie=1:nfr
    out4 = sprintf('  %d  %10.4f  %10.4f  %10.4f  %10.4f  %10.4f ',...
                            ie,x1r(ie),x2r(ie)/tp,x4r(ie),x3r(ie),x5r(ie));
    disp(out4)      
end    
%
syn=zeros(1,n);
%    
for ie=1:nfr
    domegan=x4r(ie)*x2r(ie);
    omegad=x2r(ie)*sqrt(1.-x4r(ie)^2);
%	
    for i=1:n
%
		tt=t(i)-t(1);
%
		if( tt > x5r(ie) )
            ta=tt-x5r(ie);
			syn(i)=syn(i)+x1r(ie)*exp(-domegan*ta)*sin(omegad*ta+x3r(ie));
        end
%				
    end
%
end

a1=fix_size(a1);
running_sum=fix_size(running_sum);

residual=(a1-running_sum);
%
figure(2)
plot(t,residual);
title('Residual');
xlabel('Time (sec)');
grid on;
%
figure(3)
plot(s_tim,s_amp,'b',t,running_sum,'r');
%
% plot(t,syn,'-.');
%
xlabel(' Time (sec) ');
legend ('Input Data','Synthesis');
tmin=tmi;
tmax=tmx;
%
ymax=1.5*max(s_amp);
ymin=1.5*min(s_amp);
axis([tmin,tmax,ymin,ymax]);
zoom on;

t=fix_size(t);
residual=fix_size(residual);

running_sum=fix_size(running_sum);

synth_th=[t running_sum ];
residual_th=[t residual];

setappdata(0,'synth_th',synth_th);
setappdata(0,'residual_th',residual_th);

set(handles.uipanel_save,'Visible','on');

disp(' ');
disp(' Standard Deviations ');
disp(' ');

out0=sprintf('  original: %8.4g  ',std(THM(:,2)));
out1=sprintf(' synthesis: %8.4g  ',std(running_sum));
out2=sprintf('  residual: %8.4g  ',std(residual));

disp(out0);
disp(out1);
disp(out2);

h = msgbox('Results Written to Matlab Command Window'); 


%%%%%%

set(handles.uipanel_save,'Visible','on');




% --- Executes on button press in pushbutton_plot_input.
function pushbutton_plot_input_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_plot_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

try
      FS=get(handles.edit_input_array,'String');
      THM=evalin('base',FS);
%      disp('ref 2')
catch
      warndlg('Unable to read input file','Warning');
      return;
end    

THM=fix_size(THM);
setappdata(0,'THM',THM);

sz=size(THM);
num=sz(1);

t1=THM(1,1);
t2=THM(num,1);

s1=sprintf('%8.4g',t1);
s2=sprintf('%8.4g',t2);

set(handles.edit_t1,'String',s1);
set(handles.edit_t2,'String',s2);

set(handles.text_t1,'Visible','on');
set(handles.text_t2,'Visible','on');
set(handles.edit_t1,'Visible','on');
set(handles.edit_t2,'Visible','on');


figure(1);
plot(THM(:,1),THM(:,2));
xlabel('Time (sec)');
ylabel('Amplitude');
grid on;

set(handles.pushbutton_calculate,'Enable','on');

set(handles.pushbutton_calculate,'Visible','on');


% --- Executes on button press in pushbutton_save.
function pushbutton_save_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

n=get(handles.listbox_save,'Value');

if(n==1)
    data=getappdata(0,'synth_th');
else
    data=getappdata(0,'residual_th');    
end    
    
output_name=get(handles.edit_output_array,'String');
assignin('base', output_name, data);

h = msgbox('Save Complete'); 




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


% --- Executes on selection change in listbox_num_tones.
function listbox_num_tones_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_num_tones (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_num_tones contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_num_tones

n=get(handles.listbox_num_tones,'Value');

for i = 1:n
   for j=1:3
      data_s{i,j} = '';     
   end     
end
set(handles.uitable_coordinates,'Data',data_s);   


% --- Executes during object creation, after setting all properties.
function listbox_num_tones_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_num_tones (see GCBO)
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



function edit_t1_Callback(hObject, eventdata, handles)
% hObject    handle to edit_t1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_t1 as text
%        str2double(get(hObject,'String')) returns contents of edit_t1 as a double


% --- Executes during object creation, after setting all properties.
function edit_t1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_t1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_t2_Callback(hObject, eventdata, handles)
% hObject    handle to edit_t2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_t2 as text
%        str2double(get(hObject,'String')) returns contents of edit_t2 as a double


% --- Executes during object creation, after setting all properties.
function edit_t2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_t2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_nt_Callback(hObject, eventdata, handles)
% hObject    handle to edit_nt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_nt as text
%        str2double(get(hObject,'String')) returns contents of edit_nt as a double


% --- Executes during object creation, after setting all properties.
function edit_nt_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_nt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function varargout = extract_transient(varargin)
% EXTRACT_TRANSIENT MATLAB code for extract_transient.fig
%      EXTRACT_TRANSIENT, by itself, creates a new EXTRACT_TRANSIENT or raises the existing
%      singleton*.
%
%      H = EXTRACT_TRANSIENT returns the handle to a new EXTRACT_TRANSIENT or the handle to
%      the existing singleton*.
%
%      EXTRACT_TRANSIENT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in EXTRACT_TRANSIENT.M with the given input arguments.
%
%      EXTRACT_TRANSIENT('Property','Value',...) creates a new EXTRACT_TRANSIENT or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before extract_transient_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to extract_transient_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help extract_transient

% Last Modified by GUIDE v2.5 06-Sep-2016 18:02:25

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @extract_transient_OpeningFcn, ...
                   'gui_OutputFcn',  @extract_transient_OutputFcn, ...
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


% --- Executes just before extract_transient is made visible.
function extract_transient_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to extract_transient (see VARARGIN)

% Choose default command line output for extract_transient
handles.output = hObject;

set(handles.pushbutton_plot_TH,'Enable','on');
set(handles.pushbutton_calculate,'Enable','off');

set(handles.text_start_time,'Enable','off');
set(handles.text_end_time,'Enable','off');
set(handles.edit_start_time,'Enable','off');
set(handles.edit_end_time,'Enable','off');

set(handles.uipanel_save,'Visible','off');

listbox_lpf_Callback(hObject, eventdata, handles);

% Find all windows of type figure, which have an empty FileName attribute.
allPlots = findall(0, 'Type', 'figure', 'FileName', []);
delete(allPlots);


% Update handles structure
guidata(hObject, handles);

% UIWAIT makes extract_transient wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = extract_transient_OutputFcn(hObject, eventdata, handles) 
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

% Find all windows of type figure, which have an empty FileName attribute.
allPlots = findall(0, 'Type', 'figure', 'FileName', []);
delete(allPlots);

try
    close(handles.fig10);
catch
end

n=get(handles.listbox_lpf,'Value');

if(n==1)
    et_mean_lpf(hObject, eventdata, handles);
end

sinefdam(hObject, eventdata, handles);


function et_mean_lpf(hObject, eventdata, handles)

fc=str2num(get(handles.edit_lpf,'String'));

THM=getappdata(0,'THM');
t=THM(:,1);
y=THM(:,2);

a=y;

%
tmx=max(t);
tmi=min(t);
n = length(y);
dt=(tmx-tmi)/(n-1);
sr=1/dt;

%
maxw=round(double(n)/2);
%
q=0.400*(sr/fc);  % primary goal lpf
            
w= 2*floor(q/2)+1;

if(w>maxw)
    w= 2*floor(q/2)-1; 
end
if(w<3)
    w=3;
end            

out1=sprintf('\n  window size=%d \n',w);
disp(out1);

%
k=fix(double(w-1)/2.);
%

last=n;

%  np=1;  % number of passes

    for i=1:last
%
        ave=0.;
        n=0;
%
        for j=(i-k):(i+k)
%
            if(j>=1 && j<=last )
%
                ave=ave+a(j);
                n=n+1;
            end	
        end
        if(n>1)
            a(i)=ave/double(n);
        end
    end
  

%
t=fix_size(t);
a=fix_size(a);

lpf_data=[t a];   
%
setappdata(0,'lpf_data',lpf_data);


function et_mean_hpf(hObject, eventdata, handles)

THM=getappdata(0,'amp_i');

t=THM(:,1);
y=THM(:,2);

a=y;

%
n = length(y);

maxw=floor(double(n)/2);

tmx=max(t);
tmi=min(t);
n = length(y);
dt=(tmx-tmi)/(n-1);
sr=1/dt;

fcross=str2num(get(handles.edit_fcross,'String'));

q=0.728*(sr/fcross);

w= 2*floor(q/2)+1;

if(w>maxw)
    w= 2*floor(q/2)-1; 
end

out1=sprintf('\n  window size=%d \n',w);
disp(out1);

%
k=fix(double(w-1)/2.);
%

last=n;

%  np=1;  % number of passes

    for i=1:last
%
        ave=0.;
        n=0;
%
        for j=(i-k):(i+k)
%
            if(j>=1 && j<=last )
%
                ave=ave+a(j);
                n=n+1;
            end	
        end
        if(n>1)
            a(i)=ave/double(n);
        end
    end
  
    a=y-a;
%
t=fix_size(t);
a=fix_size(a);

hpf_data=[t a];   
%
setappdata(0,'hpf_data',hpf_data);



function sinefdam(hObject, eventdata, handles)

tic

fig_num=2;

tp=2*pi;

fmin=str2num(get(handles.edit_fmin,'String'));

ts=str2num(get(handles.edit_start_time,'String'));
te=str2num(get(handles.edit_end_time,'String'));

nfr=str2num(get(handles.edit_number,'String'));
nt=str2num(get(handles.edit_trials,'String'));

md1=str2num(get(handles.edit_max_damp,'String'));
md2=str2num(get(handles.edit_min_damp,'String'));

max_damp=max([md1 md2]);
min_damp=min([md1 md2]);

THM=getappdata(0,'THM');
amp=double(THM(:,2));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

s_tim=THM(:,1);
s_amp=THM(:,2);

n = length(s_tim); 
%
tmx=max(s_tim);
tmi=min(s_tim);
%
out1 = sprintf('\n  %d samples \n',n);
disp(out1)
%
dt=(tmx-tmi)/(n-1);
sr=1./dt;
%
out1 = sprintf(' SR  = %g samples/sec    dt = %g sec \n',sr,dt);
out3 = sprintf(' start  = %g sec    end = %g sec            ',tmi,tmx);
disp(out1)
disp(out3)
%
if(ts>tmx)
    ts=tmx;
end
if(te<tmi)
    ts=tmi;
end
%
n1=fix((ts-tmi)/dt);
n2=fix((te-tmi)/dt);
%
if(n1<1)
    n1=1;
end
if(n2>n)
    n2=n;
end    
%
if(n1>n2)
    temp=n1;
    n1=n2;
    n2=temp;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

nf=get(handles.listbox_lpf,'Value');

if(nf==1)
    lpf_data=getappdata(0,'lpf_data');
    
    amp=amp-lpf_data(:,2);  % subtract rigid body

    amp=fix_size(amp);
    
    s_amp=amp;  % leave here
    
    original_minus_rigid_th=[THM(:,1) amp];
    
    amp_i=[THM(:,1) amp];
    
    setappdata(0,'amp_i',amp_i);
    
    et_mean_hpf(hObject, eventdata, handles);
    
    hpf_data=getappdata(0,'hpf_data');
    
    amp(n1:n2)=amp(n1:n2)-hpf_data(n1:n2,2);

    hpf_data_sh=hpf_data(n1:n2,2);

    a=amp(n1:n2); 
else
    a=amp(n1:n2);
    a=fix_size(a);
end

av=a;
amp_orig=a;

tim=s_tim(n1:n2)';
t=tim;
%

np=length(tim);
num2=np;

%
out1 = sprintf(' np  = %d  \n',np);
disp(out1)
%
%;
%
dur=t(num2)-t(1);
%
% dt=dur/(num2-1);
% sr=1./dt;  
%



md1=max_damp;
md2=min_damp;


[syn,residual,Ar,Br,omeganr,dampr,delayr]=damped_sine_find_function_delay(dur,av,amp_orig,t,dt,nfr,md1,md2); 


x2r=omeganr;
x4r=dampr;
x5r=delayr;

for ie=1:nfr    
    x1r(ie)=norm([Ar(ie) Br(ie)]);
    x3r(ie)=atan2(Ar(ie),Br(ie));
end     


%

if(nfr>=1)

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
%%%%
%

x1r=fix_size(x1r);
x2r=fix_size(x2r);
x3r=fix_size(x3r);
x4r=fix_size(x4r);
x5r=fix_size(x5r);

aaa=[x1r x2r x3r x4r x5r];

bbb=sortrows(aaa,2);

sx1r=bbb(:,1);
sx2r=bbb(:,2);
sx3r=bbb(:,3);
sx4r=bbb(:,4);
sx5r=bbb(:,5);

bbb(:,2)=bbb(:,2)/tp;

setappdata(0,'curve_fit_table',bbb);

ccc=sortrows(aaa,-1);

ax1r=ccc(:,1);
ax2r=ccc(:,2);
ax3r=ccc(:,3);
ax4r=ccc(:,4);
ax5r=ccc(:,5);

% % % % % %

disp(' ');
disp(' Results, sorted by frequency');
disp(' ');
disp(' Case   Amplitude   fn(Hz)       damp      Phase(rad)  Delay(sec) ');
%
for ie=1:nfr
    out4 = sprintf('  %d  %10.4f  %10.4f  %10.4f  %10.4f  %10.4f ',...
                            ie,sx1r(ie),sx2r(ie)/tp,sx4r(ie),sx3r(ie),sx5r(ie));
    disp(out4)      
end    

% % % % % %

disp(' ');
disp(' Results, sorted by Amplitude');
disp(' ');
disp(' Case   Amplitude   fn(Hz)       damp      Phase(rad)  Delay(sec) ');
%
for ie=1:nfr
    out4 = sprintf('  %d  %10.4f  %10.4f  %10.4f  %10.4f  %10.4f ',...
                            ie,ax1r(ie),ax2r(ie)/tp,ax4r(ie),ax3r(ie),ax5r(ie));
    disp(out4)      
end    

% % % % % %

fx=sx2r/tp;

clear xx;
clear yy;
    
handles.fig10=figure(10);

for i=1:nfr
    
    xx=[fx(i) fx(i)];
    yy=[0  sx1r(i)];
    
    line(xx,yy,'Color','b');
end

xlabel('Frequency(Hz)');
ylabel('Amplitude');
grid on;
title('Damped Sine Curve-fit Spectra');

guidata(hObject, handles);

end

%
%

tmax=1.0e+90;

LM=length(s_tim);

for i=1:LM
    terr=abs(s_tim(i)-t(1));
    if(terr<tmax)
        tmax=terr;
    end
end

% s_tim=fix_size(s_tim);
% s_amp=fix_size(s_amp);

t=fix_size(t);
syn=fix_size(syn);

if(nf==1)
    hpf_data_sh=fix_size(hpf_data_sh);
    syn=syn+hpf_data_sh;
end

iu=get(handles.listbox_units,'Value');

if(iu==1)
   ystring='Accel (G)'; 
else
   ystring='Accel (m/sec^2)'; 
end


transient_th=[t syn];
residual_th=[t residual];

setappdata(0,'transient_th',transient_th);
setappdata(0,'residual_th',residual_th);

%%%%%%

figure(fig_num);
fig_num=fig_num+1;
plot(s_tim,s_amp,'b');
xlabel('Time (sec)');
hold on
plot(t,syn,'r');
xlabel(' Time (sec) ');
ylabel(ystring);
legend ('Input Data','Transient Synthesis');
title('Transient Curve-fit');
tmin=tmi;
tmax=tmx;
xlim([tmin,tmax]);
zoom on;
hold off;

%%%%%%

figure(fig_num);
fig_num=fig_num+1;

plot(residual_th(:,1),residual_th(:,2),'b');


title('Residual');
xlabel('Time (sec)');
xlabel(' Time (sec) ');
ylabel(ystring);
tmin=tmi;
tmax=tmx;
xlim([tmin,tmax]);
zoom on;


%%%%%%

if(nf==1)
    figure(fig_num);
    fig_num=fig_num+1;
    hold on
    
    plot(THM(:,1),THM(:,2),'b');    
    plot(lpf_data(:,1),lpf_data(:,2),'r');
    legend ('Input Data','Rigid Body Est');    
    
    title('Rigid Body Acceleration Estimate');
    xlabel('Time (sec)');
    xlabel(' Time (sec) ');
    ylabel(ystring);
    tmin=tmi;
    tmax=tmx;
    xlim([tmin,tmax]);
    zoom on;
    hold off;    
%

    rpt=lpf_data;
    
    rpt(n1:n2,2)=rpt(n1:n2,2)+syn;
    
    rigid_plus_transient_th=rpt;
    
    rigid_plus_residual_th=[s_tim lpf_data(:,2)+residual_th(:,2)];

    

    figure(fig_num);
    fig_num=fig_num+1;
    plot(rigid_plus_transient_th(:,1),rigid_plus_transient_th(:,2),'b');
    title('Rigid Body Acceleration + Transient Estimate');
    xlabel('Time (sec)');
    xlabel(' Time (sec) ');
    ylabel(ystring);
    tmin=tmi;
    tmax=tmx;
    xlim([tmin,tmax]);
    zoom on;
    
    
 
    figure(fig_num);
    fig_num=fig_num+1;
    
    plot(original_minus_rigid_th(:,1),original_minus_rigid_th(:,2),'b');
    title('Original - Rigid Body Acceleration');
    xlabel('Time (sec)');
    xlabel(' Time (sec) ');
    ylabel(ystring);
    tmin=tmi;
    tmax=tmx;
    xlim([tmin,tmax]);
    zoom on;   
    
%%   

    hp=figure(fig_num);
    fig_num=fig_num+1;

    subplot(4,1,1);
    plot(THM(:,1),THM(:,2));
    ylabel(ystring);
    xlim([tmin,tmax]);
    title('Input Data');
    qqq=get(gca,'ylim');
    qmax=max(abs(qqq));
    ylim([-qmax,qmax]);
    grid on;
    grid minor;
    
    subplot(4,1,2);
    plot(lpf_data(:,1),lpf_data(:,2));
    ylabel(ystring);
    xlim([tmin,tmax]);
    title('Rigid Body Estimate');
    ylim([-qmax,qmax]);
    grid on;    
    grid minor;   
 
    subplot(4,1,3);
    plot(t,syn);
    ylabel(ystring);
    xlim([tmin,tmax]);
    title('Transient Curve-fit');
    ylim([-qmax,qmax]);
    grid on;  
    grid minor;      
    
    subplot(4,1,4);
    plot(residual_th(:,1),residual_th(:,2));
    xlabel('Time (sec)');
    ylabel(ystring);
    xlim([tmin,tmax]);
    title('Residual');
    ylim([-qmax,qmax]);
    grid on;
    grid minor;     
    
    set(hp, 'Position', [50 50 650 700]);

%%

    setappdata(0,'rigid_th',lpf_data);    
    setappdata(0,'rigid_plus_transient_th',rigid_plus_transient_th);
    setappdata(0,'rigid_plus_residual_th',rigid_plus_residual_th);
    setappdata(0,'original_minus_rigid_th',original_minus_rigid_th);   
    
end





set(handles.uipanel_save,'Visible','on');
set(handles.listbox_save, 'String','');

string_th{1}=sprintf('Transient Synthesis');   
string_th{2}=sprintf('Residual');  

if(nf==1)
  
    string_th{3}=sprintf('Rigid Body');   
    string_th{4}=sprintf('Rigid Body + Transient');     
    string_th{5}=sprintf('Rigid Body + Residual');     
    string_th{6}=sprintf('Original - Rigid Body'); 
end

set(handles.listbox_save,'String',string_th)  

disp(' ');
toc

h = msgbox('Results Written to Matlab Command Window'); 


% --- Executes on button press in pushbutton_return.
function pushbutton_return_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_return (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

delete(extract_transient)

% --- Executes on selection change in listbox_method.
function listbox_method_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_method (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_method contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_method
n=get(handles.listbox_method,'Value');


set(handles.text_input_array_name,'Visible','on');
set(handles.edit_input_array,'Visible','on');

set(handles.edit_input_array,'String',' ');

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


% --- Executes on selection change in listbox_type.
function listbox_type_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_type contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_type


n=get(handles.listbox_type,'Value');

set(handles.text_max_damp,'Visible','off');
set(handles.edit_max_damp,'Visible','off');


if(n==1)
    set(handles.text_number,'String','Enter Number of Sines');
    set(handles.edit_trials,'String','2000');
else
    set(handles.text_number,'String','Enter Number of Damped Sines'); 
    set(handles.edit_trials,'String','2000');
    set(handles.text_max_damp,'Visible','on');
    set(handles.edit_max_damp,'Visible','on');    
end



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


% --- Executes on button press in pushbutton_plot_TH.
function pushbutton_plot_TH_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_plot_TH (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

try

    FS=get(handles.edit_input_array,'String');
    THM=evalin('base',FS);
catch
    warndlg('Input array not found '); 
end
    

setappdata(0,'THM',THM);

iu=get(handles.listbox_units,'Value');

figure(1);
plot(THM(:,1),THM(:,2));
title('Time History');
xlabel('Time (sec)');

if(iu==1)
    ylabel('Accel (G)');    
else
    ylabel('Accel (m/sec^2)');       
end
grid on;


set(handles.pushbutton_calculate,'Enable','on');

set(handles.text_start_time,'Enable','on');
set(handles.text_end_time,'Enable','on');
set(handles.edit_start_time,'Enable','on');
set(handles.edit_end_time,'Enable','on');


tmi=min(THM(:,1));
tmx=max(THM(:,1));

s1=sprintf(' %8.4g ',tmi);
s2=sprintf(' %8.4g ',tmx);

n=length(THM(:,1));

dt=(tmx-tmi)/(n-1);

sr=1/dt;

setappdata(0,'sr',sr);

set(handles.edit_start_time,'String',s1);
set(handles.edit_end_time,'String',s2);



function edit_number_Callback(hObject, eventdata, handles)
% hObject    handle to edit_number (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_number as text
%        str2double(get(hObject,'String')) returns contents of edit_number as a double


% --- Executes during object creation, after setting all properties.
function edit_number_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_number (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_trials_Callback(hObject, eventdata, handles)
% hObject    handle to edit_trials (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_trials as text
%        str2double(get(hObject,'String')) returns contents of edit_trials as a double


% --- Executes during object creation, after setting all properties.
function edit_trials_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_trials (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_start_time_Callback(hObject, eventdata, handles)
% hObject    handle to edit_start_time (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_start_time as text
%        str2double(get(hObject,'String')) returns contents of edit_start_time as a double


% --- Executes during object creation, after setting all properties.
function edit_start_time_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_start_time (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_end_time_Callback(hObject, eventdata, handles)
% hObject    handle to edit_end_time (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_end_time as text
%        str2double(get(hObject,'String')) returns contents of edit_end_time as a double


% --- Executes during object creation, after setting all properties.
function edit_end_time_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_end_time (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_export.
function pushbutton_export_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_export (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

n=get(handles.listbox_save,'Value');

if(n==1)
    data=getappdata(0,'transient_th');
end    
if(n==2)
    data=getappdata(0,'residual_th');    
end  
if(n==3)
    data=getappdata(0,'rigid_th');    
end  
if(n==4)
    data=getappdata(0,'rigid_plus_transient_th');    
end 
if(n==5)
    data=getappdata(0,'rigid_plus_residual_th');    
end 
if(n==6)
    data=getappdata(0,'original_minus_rigid_th');
end
    
    
output_name=get(handles.edit_output_array,'String');
assignin('base', output_name, data);

msgbox('Save Complete');


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



function edit_max_damp_Callback(hObject, eventdata, handles)
% hObject    handle to edit_max_damp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_max_damp as text
%        str2double(get(hObject,'String')) returns contents of edit_max_damp as a double


% --- Executes during object creation, after setting all properties.
function edit_max_damp_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_max_damp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function pushbutton_export_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pushbutton_export (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on key press with focus on edit_input_array and none of its controls.
function edit_input_array_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_input_array (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)

set(handles.pushbutton_calculate,'Enable','off');


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over edit_input_array.
function edit_input_array_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to edit_input_array (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.pushbutton_calculate,'Enable','on');



function edit_min_damp_Callback(hObject, eventdata, handles)
% hObject    handle to edit_min_damp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_min_damp as text
%        str2double(get(hObject,'String')) returns contents of edit_min_damp as a double


% --- Executes during object creation, after setting all properties.
function edit_min_damp_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_min_damp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_lpf.
function listbox_lpf_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_lpf (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_lpf contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_lpf

n=get(handles.listbox_lpf,'Value');

if(n==1)
    set(handles.text_lpf,'Visible','on');
    set(handles.edit_lpf,'Visible','on');    
else
    set(handles.text_lpf,'Visible','off');    
    set(handles.edit_lpf,'Visible','off');       
end    


% --- Executes during object creation, after setting all properties.
function listbox_lpf_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_lpf (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
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



function edit_lpf_Callback(hObject, eventdata, handles)
% hObject    handle to edit_lpf (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_lpf as text
%        str2double(get(hObject,'String')) returns contents of edit_lpf as a double


% --- Executes during object creation, after setting all properties.
function edit_lpf_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_lpf (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox5.
function listbox5_Callback(hObject, eventdata, handles)
% hObject    handle to listbox5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox5 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox5


% --- Executes during object creation, after setting all properties.
function listbox5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_fmin_Callback(hObject, eventdata, handles)
% hObject    handle to edit_fmin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_fmin as text
%        str2double(get(hObject,'String')) returns contents of edit_fmin as a double


% --- Executes during object creation, after setting all properties.
function edit_fmin_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_fmin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_fcross_Callback(hObject, eventdata, handles)
% hObject    handle to edit_fcross (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_fcross as text
%        str2double(get(hObject,'String')) returns contents of edit_fcross as a double


% --- Executes during object creation, after setting all properties.
function edit_fcross_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_fcross (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

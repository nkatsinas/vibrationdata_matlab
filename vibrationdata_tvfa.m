function varargout = vibrationdata_tvfa(varargin)
% VIBRATIONDATA_TVFA MATLAB code for vibrationdata_tvfa.fig
%      VIBRATIONDATA_TVFA, by itself, creates a new VIBRATIONDATA_TVFA or raises the existing
%      singleton*.
%
%      H = VIBRATIONDATA_TVFA returns the handle to a new VIBRATIONDATA_TVFA or the handle to
%      the existing singleton*.
%
%      VIBRATIONDATA_TVFA('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in VIBRATIONDATA_TVFA.M with the given input arguments.
%
%      VIBRATIONDATA_TVFA('Property','Value',...) creates a new VIBRATIONDATA_TVFA or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before vibrationdata_tvfa_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to vibrationdata_tvfa_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help vibrationdata_tvfa

% Last Modified by GUIDE v2.5 28-May-2019 10:42:11

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @vibrationdata_tvfa_OpeningFcn, ...
                   'gui_OutputFcn',  @vibrationdata_tvfa_OutputFcn, ...
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


% --- Executes just before vibrationdata_tvfa is made visible.
function vibrationdata_tvfa_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to vibrationdata_tvfa (see VARARGIN)

% Choose default command line output for vibrationdata_tvfa
handles.output = hObject;

set(handles.uipanel_save,'Visible','off');

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes vibrationdata_tvfa wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = vibrationdata_tvfa_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



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

set(handles.uipanel_save,'Visible','off');

n=get(hObject,'Value');

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


% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%%%

Figures = findobj( 'Type', 'Figure' , '-not' , 'Tag' , get( handles.output , 'Tag' ) );
NFigures = length( Figures );
for nFigures = 1 : NFigures
  close( Figures( nFigures ) );
end

fig_num=1;

%%%

k=get(handles.listbox_method,'Value');

YS=get(handles.edit_yaxis_label,'String');


p=get(handles.listbox_overlap,'Value');

po=(p-1)*0.1;


if(k==1)
  FS=get(handles.edit_input_array,'String');
  THM=evalin('base',FS);   
else
  THM=getappdata(0,'THM');
end


tstart=str2num(get(handles.edit_tstart,'String'));
tend=str2num(get(handles.edit_tend,'String'));

[~,i]=min(abs(tstart-THM(:,1)));
[~,j]=min(abs(tend-THM(:,1)));

THM=THM(i:j,:);


seg=str2num(get(handles.edit_segment_duration,'String'));

if(seg<1.0e-05)
    warndlg('Segment Duration is too low');
    return;
end

amp=THM(:,2);
tim=THM(:,1);
nn = size(amp);
n = nn(1);
%disp(' mean values ')
mu=mean(amp);
sd=std(amp);
mx=max(amp);
mi=min(amp);
rms=sqrt(sd^2+mu^2);
kta=0.;
tt_max=0.;
tt_min=0.;
%1
    for i=1:n
        if( amp(i)==mx)
            tt_max=tim(i);
        end
        if( amp(i)==mi)
            tt_min=tim(i);
        end
        kta=kta+amp(i)^4;
    end      
    kta=kta/(n*sd^4);
%1
disp(' ')
disp(' time stats ')
disp(' ')
tmx=max(tim);
tmi=min(tim);
% disp(out0)
out3 = sprintf(' start  = %g sec    end = %g sec            ',tmi,tmx);
dt=(tmx-tmi)/n;
sr=1./dt;
out4 = sprintf(' SR  = %8.4g samples/sec    dt = %8.4g sec            ',sr,dt);
out5 = sprintf('\n number of samples = %d  ',n);
disp(out3)
disp(out4)
disp(out5)
disp(' ')
disp(' amplitude stats ')
disp(' ')
out0 = sprintf(' number of points = %d ',n);
out1 = sprintf(' mean = %8.4g    std = %8.4g    rms = %8.4g ',mu,sd,rms);
out2a = sprintf(' max  = %9.4g  at  = %8.4g sec            ',mx,tt_max);
out2b = sprintf(' min  = %9.4g  at  = %8.4g sec            ',mi,tt_min);
out5  = sprintf('\n kurtosis  = %8.4g ',kta);
%
disp(out1)
disp(out2a)
disp(out2b)
disp(out5)
%
dur=tmx-tmi;
%
if(seg>dur/4)
    seg=dur/4;
    string=sprintf('%8.3g',seg);
    set(handles.edit_segment_duration,'String',string);
end
%

ns=fix(sr*seg);
%
out1=sprintf(' ns=%d ',ns);
disp(out1);

step=floor(ns*(1-po));


i=1;
j1=1;
j2=1+ns;

maxn=1.0e+06;

while(1)

    if((j2)>n)
        break;
    end
    
    j1=j1+step;
    j2=j2+step;
    
    i=i+1;
    
    if(i>maxn)
        break;
    end    
    
end 

nnn=i;


disp(' ');
out1=sprintf('\n nnn=%d  step=%d\n',nnn,step);
disp(out1);



if(nnn==0)
    warndlg('nnn=0');
    return;
end
if(step==0)
    warndlg('step=0');
    return;
end



%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
tpi=2*pi;

zc=zeros(nnn,1);
sds=zeros(nnn,1);
rms=zeros(nnn,1);
av=zeros(nnn,1);
peak=zeros(nnn,1);
tt=zeros(nnn,1);
freq=zeros(nnn,1);
kt=zeros(nnn,1);

%
j1=1;
j2=1+ns;

for i=1:nnn
    if(j2>n)
        break;
    end
%
    clear x;
    zc(i)=0;
    x=amp(j1:j2);
      
    if(isempty(x))
        break;
    end
        
%    peak(i)=max(abs(x));
    
    [mu,sd,xrms,~,xkt]=kurtosis_stats(x);
    
    av(i)=mu;
    sds(i)=sd;
    rms(i)=xrms;
    kt(i)=xkt;
    
    tt(i)=(tim(j1)+tim(j2))/2.;
%
    for k=2:max(size(x))
        if(x(k)*x(k-1)<0)
            zc(i)=zc(i)+1;
        end
    end

%%%%    

    nfr=1;
    a=x;
    amp_orig=x;
    t=tim(j1:j2);
    dur=t(end)-t(1);
    tt(i)=mean(t);
    
    [~,~,Ar,Br,omeganr]=sine_find_function(dur,a,amp_orig,t,dt,nfr);    
%    peak(i)=norm([Ar Br]);
    
    peak(i)=max(abs(x));  
    
    freq(i)=omeganr/tpi;
    
%%%%

    j1=j1+step;
    j2=j2+step;
% 
end
%

freq=fix_size(freq);
%
clear length;
n=length(tt);
if(tt(n)<tt(n-1))
    tt(n)=[];
    sds(n)=[];
    av(n)=[];
    peak(n)=[];
    rms(n)=[];
    zc(n)=[];
    freq(n)=[];
    kt(n)=[];
end
%

for i=1:length(kt)
    if(isnan(kt(i)))
        kt(i)=0;
    end
end

%
figure(fig_num);
fig_num=fig_num+1;
plot(tim,amp)
xlabel(' Time (sec)');
ylabel(YS);
grid on;
title('Time History');
%
tt
kt
%
figure(fig_num);
fig_num=fig_num+1;
plot(tt,kt)
xlabel(' Time (sec)');
ylabel('Kurtosis');
grid on;
title('Kurtosis Time History');
%



figure(fig_num);
fig_num=fig_num+1;

plot(tt,peak,tt,rms,tt,sds,'-.',tt,av);

setappdata(0,'peak',[tt peak]);
setappdata(0,'RMS',[tt rms]);
setappdata(0,'stddev',[tt sds]);
setappdata(0,'mean',[tt av]);
setappdata(0,'kurtosis',[tt kt]);

legend ('peak','rms','std dev','average');    
xlabel(' Time (sec)');
ylabel(YS);
title('Segmented Time History');
grid;
%% ymax=max(av);
%% if( max(av) < max(peak))
%%     ymax=max(peak);
%% end
%% ymax=ymax*1.2;
%% ymin=min(av);
%% axis([tmi tmx ymin ymax]);  
%


figure(fig_num);
fig_num=fig_num+1;
plot(tt,freq);  
setappdata(0,'frequency',[tt freq]);
title('Frequency vs. Time');
xlabel(' Time (sec)');
ylabel(' Freq (Hz)');
grid;
% ymax=max(freq)*1.2;
% ymin=min(freq)*0.7;
% axis([tmi tmx ymin ymax]);  
%



figure(fig_num);
fig_num=fig_num+1;
plot(tt,freq,'.');  
setappdata(0,'frequency',[tt freq]);
title('Frequency vs. Time');
xlabel(' Time (sec)');
ylabel(' Freq (Hz)');
grid;
% ymax=max(freq)*1.2;
% ymin=min(freq)*0.7;
% axis([tmi tmx ymin ymax]);  
%


figure(fig_num);
plot(freq,peak,'.');  
title('Peak vs. Frequency');
string=sprintf('Peak %s',YS);
ylabel(string);
xlabel(' Freq (Hz)');
grid;
% ymax=max(peak)*1.2;
% ymin=0;
% fmi=min(freq);
% fmx=max(freq);
% axis([fmi fmx ymin ymax]);  

set(handles.uipanel_save,'Visible','on');


% --- Executes on button press in pushbutton_return.
function pushbutton_return_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_return (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

delete(vibrationdata_tvfa)


function edit_segment_duration_Callback(hObject, eventdata, handles)
% hObject    handle to edit_segment_duration (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_segment_duration as text
%        str2double(get(hObject,'String')) returns contents of edit_segment_duration as a double


% --- Executes during object creation, after setting all properties.
function edit_segment_duration_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_segment_duration (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_yaxis_label_Callback(hObject, eventdata, handles)
% hObject    handle to edit_yaxis_label (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_yaxis_label as text
%        str2double(get(hObject,'String')) returns contents of edit_yaxis_label as a double


% --- Executes during object creation, after setting all properties.
function edit_yaxis_label_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_yaxis_label (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_overlap.
function listbox_overlap_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_overlap (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_overlap contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_overlap
set(handles.uipanel_save,'Visible','off');

% --- Executes during object creation, after setting all properties.
function listbox_overlap_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_overlap (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on key press with focus on edit_segment_duration and none of its controls.
function edit_segment_duration_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_segment_duration (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.uipanel_save,'Visible','off');


% --- Executes on key press with focus on edit_input_array and none of its controls.
function edit_input_array_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_input_array (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.uipanel_save,'Visible','off');


% --- Executes on key press with focus on edit_yaxis_label and none of its controls.
function edit_yaxis_label_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_yaxis_label (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.uipanel_save,'Visible','off');


% --- Executes on button press in pushbutton_save.
function pushbutton_save_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

n=get(handles.listbox_function,'Value');
n

if(n==1)
    data=getappdata(0,'peak');    
end
if(n==2)
    data=getappdata(0,'RMS');    
end
if(n==3)
    data=getappdata(0,'stddev');    
end
if(n==4)
    data=getappdata(0,'mean');    
end
if(n==5)
    data=getappdata(0,'frequency');    
end
if(n==6)
    data=getappdata(0,'kurtosis');    
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


% --- Executes on selection change in listbox_function.
function listbox_function_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_function (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_function contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_function


% --- Executes during object creation, after setting all properties.
function listbox_function_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_function (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_tstart_Callback(hObject, eventdata, handles)
% hObject    handle to edit_tstart (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_tstart as text
%        str2double(get(hObject,'String')) returns contents of edit_tstart as a double


% --- Executes during object creation, after setting all properties.
function edit_tstart_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_tstart (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_tend_Callback(hObject, eventdata, handles)
% hObject    handle to edit_tend (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_tend as text
%        str2double(get(hObject,'String')) returns contents of edit_tend as a double


% --- Executes during object creation, after setting all properties.
function edit_tend_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_tend (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function varargout = vibrationdata_shock_effective_duration(varargin)
% VIBRATIONDATA_SHOCK_EFFECTIVE_DURATION MATLAB code for vibrationdata_shock_effective_duration.fig
%      VIBRATIONDATA_SHOCK_EFFECTIVE_DURATION, by itself, creates a new VIBRATIONDATA_SHOCK_EFFECTIVE_DURATION or raises the existing
%      singleton*.
%
%      H = VIBRATIONDATA_SHOCK_EFFECTIVE_DURATION returns the handle to a new VIBRATIONDATA_SHOCK_EFFECTIVE_DURATION or the handle to
%      the existing singleton*.
%
%      VIBRATIONDATA_SHOCK_EFFECTIVE_DURATION('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in VIBRATIONDATA_SHOCK_EFFECTIVE_DURATION.M with the given input arguments.
%
%      VIBRATIONDATA_SHOCK_EFFECTIVE_DURATION('Property','Value',...) creates a new VIBRATIONDATA_SHOCK_EFFECTIVE_DURATION or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before vibrationdata_shock_effective_duration_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to vibrationdata_shock_effective_duration_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help vibrationdata_shock_effective_duration

% Last Modified by GUIDE v2.5 17-Apr-2015 13:53:40

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @vibrationdata_shock_effective_duration_OpeningFcn, ...
                   'gui_OutputFcn',  @vibrationdata_shock_effective_duration_OutputFcn, ...
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


% --- Executes just before vibrationdata_shock_effective_duration is made visible.
function vibrationdata_shock_effective_duration_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to vibrationdata_shock_effective_duration (see VARARGIN)

% Choose default command line output for vibrationdata_shock_effective_duration
handles.output = hObject;

set(handles.pushbutton_calculate,'Visible','off');

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes vibrationdata_shock_effective_duration wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = vibrationdata_shock_effective_duration_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

delete(vibrationdata_shock_effective_duration);


% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


t=getappdata(0,'t');
a=getappdata(0,'a');
fig_num=getappdata(0,'fig_num');

ref=str2num(get(handles.edit_reference,'String'));
ns=str2num(get(handles.edit_nseg,'String'));

amp=a;
tim=t;

nn = size(amp);
n = nn(1);
%disp(' mean values ')

[mu,sd,rms,sk,kt]=kurtosis_stats(amp);
[tt_max,tt_min,mx,mi]=max_min_times(tim,amp);

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
out5  = sprintf('\n kurtosis  = %8.4g ',kt);
%
disp(out1)
disp(out2a)
disp(out2b)
disp(out5)
%
amax=abs(mx);
if( amax < abs(mi))
    amax=abs(mi);
end
%
TE=0;
for(i=1:nn)
    if(amp(i)>(amax/3))
        TE=tim(i);
    end
end
%
%%% seg=((tmx-tmi)/nseg);  % This parameter can be varied according to the desired resolution.
%
%%% ns=fix(sr*seg);
%
%%% nnn=fix((tmx-tmi)/seg);
%
progressbar % Create figure and set starting time
%
for(i=1:n-ns)
%
    progressbar(i/(n-ns)) % Update figure    
%
    clear x;
    x=amp(i:i+ns);   
    sds(i)=std(x);
    av(i)=mean(x);
    rms(i)=sqrt(sds(i)^2+av(i)^2);
    tt(i)=(tim(i)+tim(i+ns))/2.;
end
%
rms_max=max(rms);
%
Te=0;   % fix here
for(i=1:n-ns)
    if(rms(i)>(rms_max/10))
        Te=tt(i);
    end
end

TE=TE-ref;
Te=Te-ref;


out1 = sprintf('\n Effective Duration TE = %8.5g sec ',TE);
out2 =   sprintf('                       = %8.5g msec',TE*1000);
disp(out1);
disp(out2);
disp(' ');
out1 = sprintf('\n Effective Duration Te = %8.5g sec ',Te);
out2 =   sprintf('                       = %8.5g msec\n',Te*1000);
disp(out1);
disp(out2);
%
figure(fig_num);
plot(tt,sds,tt,av)
legend ('RMS','average');    
xlabel(' Time (sec)');
grid;
ymax=max(rms);
ymax=ymax*1.3;
ymin=0;
axis([tmi tmx ymin ymax]);  
%    ylabel(' Std Dev ');  

msgbox('Results written to Command Window');





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



function edit_reference_Callback(hObject, eventdata, handles)
% hObject    handle to edit_reference (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_reference as text
%        str2double(get(hObject,'String')) returns contents of edit_reference as a double


% --- Executes during object creation, after setting all properties.
function edit_reference_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_reference (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_read.
function pushbutton_read_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_read (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

fig_num=1;

thu=get(handles.edit_time_history,'String');

if isempty(thu)
    warndlg('Time history does not exist');
    return;
else
    THM=evalin('base',thu);    
end



t=THM(:,1);
a=THM(:,2);

figure(fig_num);
fig_num=fig_num+1;
plot(t,a);
grid on;
xlabel('Time (sec)');
ylabel('Accel (G)');
title('Input Time History');

%%%

setappdata(0,'t',t);
setappdata(0,'a',a);
setappdata(0,'fig_num',fig_num);

set(handles.pushbutton_calculate,'Visible','on');


% --- Executes on key press with focus on edit_time_history and none of its controls.
function edit_time_history_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_time_history (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)

set(handles.pushbutton_calculate,'Visible','off');



function edit_nseg_Callback(hObject, eventdata, handles)
% hObject    handle to edit_nseg (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_nseg as text
%        str2double(get(hObject,'String')) returns contents of edit_nseg as a double


% --- Executes during object creation, after setting all properties.
function edit_nseg_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_nseg (see GCBO)
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

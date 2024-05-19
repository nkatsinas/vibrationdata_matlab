function varargout = vibrationdata_temporal_moments(varargin)
% VIBRATIONDATA_TEMPORAL_MOMENTS MATLAB code for vibrationdata_temporal_moments.fig
%      VIBRATIONDATA_TEMPORAL_MOMENTS, by itself, creates a new VIBRATIONDATA_TEMPORAL_MOMENTS or raises the existing
%      singleton*.
%
%      H = VIBRATIONDATA_TEMPORAL_MOMENTS returns the handle to a new VIBRATIONDATA_TEMPORAL_MOMENTS or the handle to
%      the existing singleton*.
%
%      VIBRATIONDATA_TEMPORAL_MOMENTS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in VIBRATIONDATA_TEMPORAL_MOMENTS.M with the given input arguments.
%
%      VIBRATIONDATA_TEMPORAL_MOMENTS('Property','Value',...) creates a new VIBRATIONDATA_TEMPORAL_MOMENTS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before vibrationdata_temporal_moments_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to vibrationdata_temporal_moments_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help vibrationdata_temporal_moments

% Last Modified by GUIDE v2.5 07-Mar-2015 08:23:46

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @vibrationdata_temporal_moments_OpeningFcn, ...
                   'gui_OutputFcn',  @vibrationdata_temporal_moments_OutputFcn, ...
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


% --- Executes just before vibrationdata_temporal_moments is made visible.
function vibrationdata_temporal_moments_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to vibrationdata_temporal_moments (see VARARGIN)

% Choose default command line output for vibrationdata_temporal_moments
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes vibrationdata_temporal_moments wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = vibrationdata_temporal_moments_OutputFcn(hObject, eventdata, handles) 
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

delete(vibrationdata_temporal_moments);



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


% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
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

ref=str2num(get(handles.edit_delay,'String'));


figure(fig_num);
plot(t,a);
grid on;
xlabel('Time (sec)');
ylabel('Accel (G)');
title('Input Time History');

%%%%%

  amp=double(THM(:,2));
    tim=double(THM(:,1));
    n = length(amp);
%disp(' mean values ')
   
    mx=max(amp);
    mi=min(amp);
    TT=t;
    
    [mu,sd,rms,sk,kt]=kurtosis_stats(amp);
    [tt_max,tt_min,mx,mi]=max_min_times(TT,amp);
    
    

%1
    disp(' ')
    disp(' Time Stats ')
    tmx=max(tim);
    tmi=min(tim);
    duration=(tmx-tmi);
% 
    out3 = sprintf('   start  = %g sec    end = %g sec   duration = %g sec  ',tmi,tmx,duration);
    disp(out3)
%
    dt=duration/(n-1);
    out5 = sprintf('\n number of samples = %d  ',n);
    disp(out5)
%
    clear t;
    t=tim;
    disp(' ')
    disp(' Time Step ');
    clear difft;
    difft=diff(t);
    dtmin=min(difft);
    dtmax=max(difft);
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
    out6 = sprintf(' srmax  = %8.4g samples/sec  ',1/dtmin);
    disp(out4)
    disp(out5)
    disp(out6)
    clear t;
%
    disp(' ')
    disp(' Amplitude Stats ')
     out0 = sprintf(' number of points = %d ',n);
    out1 = sprintf(' mean = %8.4g    std = %8.4g    rms = %8.4g ',mu,sd,rms);
    out2a = sprintf(' max  = %9.4g  at  = %8.4g sec             ',mx,tt_max);
    out2b = sprintf(' min  = %9.4g  at  = %8.4g sec            \n',mi,tt_min);
    disp(out0);
    disp(out1);
    disp(out2a);
    disp(out2b);

%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
a2=zeros(n,1);
%
for i=1:n
    a2(i)=amp(i)^2;
end
%
m0=0;
m1=0;
m2=0;
m3=0;
m4=0;
%
for i=1:n
        ta=(tim(i)-ref);
        
        a2i=a2(i);
        
        m0=m0+a2i;        
        m1=m1+ta*a2i;
        m2=m2+ta^2*a2i;
        m3=m3+ta^3*a2i; 
        m4=m4+ta^4*a2i;          
end    
%
m0=m0*dt;
m1=m1*dt;
m2=m2*dt;
m3=m3*dt;
m4=m4*dt;
%
E=m0;
D=sqrt( (m2/m0) - (m1/m0)^2 );
%
Ae=sqrt(E/D);
T=m1/m0;

ss=(m3/m0)-3*(m1*m2/m0^2)+2*(m1/m0)^3;
St=(ss)^(1/3);

S=St/D;

kk=(m4/m0)-4*(m1*m3/m0^2)+6*(m1^2*m2/m0^3)-3*(m1/m0)^4;
Kt=(kk)^(1/4);

K=Kt/D;
%
disp(' ');
disp('               Central Moments ');
disp('  ');
%
out1=sprintf('                Energy E  = %8.4g G^2 sec',E);
out2=sprintf(' Root energy amplitude Ae = %8.4g ',Ae);
out3=sprintf('          Central time T  = %8.4g sec',T);
out4=sprintf('          RMS duration D  = %8.4g sec',D);
out5=sprintf('      Central skewness St = %8.4g sec',St);
out6=sprintf('   Normalized skewness S  = %8.4g ',S);
out7=sprintf('      Central kurtosis Kt = %8.4g sec',Kt);
out8=sprintf('   Normalized kurtosis K  = %8.4g ',K);

%
disp(out1);
disp(out2);
disp(out3);
disp(out4);
disp(out5);
disp(out6);
disp(out7);
disp(out8);

msgbox('Results written to Command Window');



function edit_delay_Callback(hObject, eventdata, handles)
% hObject    handle to edit_delay (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_delay as text
%        str2double(get(hObject,'String')) returns contents of edit_delay as a double


% --- Executes during object creation, after setting all properties.
function edit_delay_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_delay (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function varargout = generate_sound(varargin)
% GENERATE_SOUND MATLAB code for generate_sound.fig
%      GENERATE_SOUND, by itself, creates a new GENERATE_SOUND or raises the existing
%      singleton*.
%
%      H = GENERATE_SOUND returns the handle to a new GENERATE_SOUND or the handle to
%      the existing singleton*.
%
%      GENERATE_SOUND('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GENERATE_SOUND.M with the given input arguments.
%
%      GENERATE_SOUND('Property','Value',...) creates a new GENERATE_SOUND or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before generate_sound_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to generate_sound_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help generate_sound

% Last Modified by GUIDE v2.5 01-Oct-2022 14:31:43

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @generate_sound_OpeningFcn, ...
                   'gui_OutputFcn',  @generate_sound_OutputFcn, ...
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


% --- Executes just before generate_sound is made visible.
function generate_sound_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to generate_sound (see VARARGIN)

% Choose default command line output for generate_sound
handles.output = hObject;

setappdata(0,'Fs',1);
setappdata(0,'signal',1);
setappdata(0,'stitle','1');
set(handles.pushbutton_Play_Sound,'enable','off');
set(handles.pushbutton_Save_File,'enable','off');

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes generate_sound wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = generate_sound_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton_Return.
function pushbutton_Return_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_Return (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close(generate_sound);


% --- Executes on button press in pushbutton_Sine_Tone.
function pushbutton_Sine_Tone_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_Sine_Tone (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

set(handles.pushbutton_Play_Sound,'enable','off');
set(handles.pushbutton_Save_File,'enable','off');

x = inputdlg({'Freq (Hz)','Duration (sec)'}, 'Input data');

iflag=1;

try
    f=str2num(x{1});
catch
    iflag=0;
end

try
    dur=str2num(x{2});
catch
    iflag=0;
end    
    
if(iflag==1)    
    FS=44100;
    dt=1/FS;

    N=ceil(dur/dt);

    omega=2*pi*f;

    t=linspace(0,(N-1)*dt,N);

    signal(1:N)=sin(omega*t);

    setappdata(0,'Fs',FS);
    setappdata(0,'signal',signal);
    setappdata(0,'stitle','Pure Sine Tone');

    set(handles.pushbutton_Play_Sound,'enable','on');
    set(handles.pushbutton_Save_File,'enable','on');
    
    msgbox('Sine tone generated');

end

% --- Executes on button press in pushbutton_Play_Sound.
function pushbutton_Play_Sound_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_Play_Sound (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

Fs=getappdata(0,'Fs');
signal=getappdata(0,'signal');
stitle=getappdata(0,'stitle');

figure(1);
dt=1/Fs;
N=length(signal);
t=linspace(0,(N-1)*dt,N);
plot(t,signal);
xlabel('Time (sec)');
ylabel('Amplitude');
title(stitle,'interpreter','none');
grid on;


player = audioplayer(signal, Fs);
play(player)
pause(max(size(signal))/Fs);


% --- Executes on button press in pushbutton_Save_File.
function pushbutton_Save_File_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_Save_File (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Fs=getappdata(0,'Fs');
signal=getappdata(0,'signal');

filename = uiputfile('*.wav');

try
    wavwrite(signal,Fs,filename);
catch
    audiowrite(filename,signal,Fs);
end

% --- Executes on button press in pushbutton_Beat_Effect.
function pushbutton_Beat_Effect_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_Beat_Effect (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


set(handles.pushbutton_Play_Sound,'enable','off');
set(handles.pushbutton_Save_File,'enable','off');

x = inputdlg({'Tone 1: Amplitude ','Tone 1: Freq (Hz)',...
              'Tone 2: Amplitude ','Tone 2: Freq (Hz)',...
                                        'Duration (sec)'}, 'Input Data ');

iflag=1;

try
    A1=str2num(x{1});
catch
    iflag=0;
end    

try
    f1=str2num(x{2});
catch
    iflag=0;
end    
  
try
    A2=str2num(x{3});
catch
    iflag=0;
end
   
try
    f2=str2num(x{4});
catch
    iflag=0;
end

try
    dur=str2num(x{5});
catch
    iflag=0;
end    
    
if(iflag==1)

    FS=44100;
    dt=1/FS;

    N=ceil(dur/dt);

    omega1=2*pi*f1;
    omega2=2*pi*f2;

    t=linspace(0,(N-1)*dt,N);

    signal(1:N)=A1*sin(omega1*t)+A2*sin(omega2*t);

    setappdata(0,'Fs',FS);
    setappdata(0,'signal',signal);

    set(handles.pushbutton_Play_Sound,'enable','on');
    set(handles.pushbutton_Save_File,'enable','on');
    setappdata(0,'stitle','Beat Frequency Effect');

    msgbox('Beat signal generated');
end


% --- Executes on button press in pushbutton_shepard_tone.
function pushbutton_shepard_tone_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_shepard_tone (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.s=vibrationdata_shepard_tone;    
set(handles.s,'Visible','on'); 

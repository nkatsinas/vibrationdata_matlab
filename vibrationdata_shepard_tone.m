function varargout = vibrationdata_shepard_tone(varargin)
% VIBRATIONDATA_SHEPARD_TONE MATLAB code for vibrationdata_shepard_tone.fig
%      VIBRATIONDATA_SHEPARD_TONE, by itself, creates a new VIBRATIONDATA_SHEPARD_TONE or raises the existing
%      singleton*.
%
%      H = VIBRATIONDATA_SHEPARD_TONE returns the handle to a new VIBRATIONDATA_SHEPARD_TONE or the handle to
%      the existing singleton*.
%
%      VIBRATIONDATA_SHEPARD_TONE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in VIBRATIONDATA_SHEPARD_TONE.M with the given input arguments.
%
%      VIBRATIONDATA_SHEPARD_TONE('Property','Value',...) creates a new VIBRATIONDATA_SHEPARD_TONE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before vibrationdata_shepard_tone_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to vibrationdata_shepard_tone_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help vibrationdata_shepard_tone

% Last Modified by GUIDE v2.5 14-Mar-2014 10:34:17

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @vibrationdata_shepard_tone_OpeningFcn, ...
                   'gui_OutputFcn',  @vibrationdata_shepard_tone_OutputFcn, ...
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


% --- Executes just before vibrationdata_shepard_tone is made visible.
function vibrationdata_shepard_tone_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to vibrationdata_shepard_tone (see VARARGIN)

% Choose default command line output for vibrationdata_shepard_tone
handles.output = hObject;

set(handles.listbox_sr,'Value',1);
set(handles.listbox_tones,'Value',3);
set(handles.edit_duration,'String','60');

set(handles.pushbutton_play_sound,'Visible','off');

set(handles.pushbutton_save,'Enable','off');

set(handles.pushbutton_export_wav_file,'Enable','off');

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes vibrationdata_shepard_tone wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = vibrationdata_shepard_tone_OutputFcn(hObject, eventdata, handles) 
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

delete(vibrationdata_shepard_tone);


% --- Executes on selection change in listbox_sr.
function listbox_sr_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_sr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_sr contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_sr


% --- Executes during object creation, after setting all properties.
function listbox_sr_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_sr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_tones.
function listbox_tones_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_tones (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_tones contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_tones


% --- Executes during object creation, after setting all properties.
function listbox_tones_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_tones (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
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


% --- Executes on button press in pushbutton_generate.
function pushbutton_generate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_generate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

tn=get(handles.listbox_tones,'Value');

number_tones = 1+tn;

srn=get(handles.listbox_sr,'Value');

sr=22050*srn;

tmax=str2num(get(handles.edit_duration,'String'));

f1 = 27.5;                % starting freq (Hz)
f2 = (2^number_tones)*f1; % ending freq (Hz)
%
%
%   log sweep rate
%
dt=1./sr;    % time step
ns=tmax*sr;  % number of sample/cycles
cycles=1;    % number of cycles
%  
oct=log(f2/f1)/log(2.);   % number of octaves
%
out1 = sprintf('\n Number of octaves = %8.2f  ',oct);    
disp(out1);       
%
ntimes = ns*cycles;
%
t2=tmax;
dur=tmax;
%
tpi=2.*pi;
%
rate=oct/dur;
%
out1 = sprintf('\n Sweep rate = %8.2f oct/sec ',rate);    
disp(out1);  
out1 = sprintf('\n            = %8.2f  oct/min \n',60.*rate);    
disp(out1);     
%
disp(' Calculating time vector... ')
TT=linspace(dt,(ntimes+1)*dt,ntimes); 
%
a = zeros(1,ntimes);
arg = zeros(1,ntimes);
freq = zeros(1,ntimes);
%
disp(' ')
disp(' Calculating log sweep....')
disp(' ')    
%  
%			fspectral = f1*pow(2.,rate*t);
%
a=zeros(1,ntimes);
theta=zeros(number_tones,1);
arg=zeros(number_tones,1);
key=zeros(number_tones,1);
noc=zeros(number_tones,1);
amp=zeros(number_tones,1);
%
for i=1:number_tones
    noc(i)=2^(i-1);
end
%
fspan=f2-f1;
theta_coefficient=tpi/(rate*log(2));
%
sd=150;
%
progressbar % Create figure and set starting time
for i=1:ntimes
%
    progressbar(i/ntimes); % Update figure  
%
    W=-1.+2^(rate*TT(i));
%
    arg(1)=f1*W;
%
    for j=1:number_tones
        if(key(j)==0)
            arg(j)=arg(1)*noc(j);       
        else
            W=-1.+2^(rate*TT(i-key(j)));
            arg(j)=f1*W;    
         end
    end
%
    for j=1:number_tones
        fspectral=noc(j)*f1*(2^(rate*TT(i-key(j))));
        delta=(fspectral-f1)/fspan;
        amp(j)=(1-cos(tpi*delta));
%
        if(fspectral>f2)
             key(j)=i;
             noc(j)=1;
        end
    end
%
    theta=theta_coefficient*arg;
%
    a(i)=sum(amp.*sin(theta));
%
end
%
a(1)=0.;
TT=TT-dt;
%
% disp(' ')
% disp(' End of sweep ')
% disp(' ')
%
clear aa;
aa=detrend(a);
sine_sweep=[TT;aa]'; 


setappdata(0,'sine_sweep',sine_sweep);
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
np=ntimes;
%
disp(' ')
disp(' End of sweep ')
disp(' ')
clear signal;
signal=aa';
signal = signal/max(abs(signal));
%
setappdata(0,'signal',signal);
setappdata(0,'sr',sr);

set(handles.pushbutton_play_sound,'Visible','on');
set(handles.pushbutton_save,'Enable','on');
set(handles.pushbutton_export_wav_file,'Enable','on');


% --- Executes on button press in pushbutton_play_sound.
function pushbutton_play_sound_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_play_sound (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

signal=getappdata(0,'signal');

sr=getappdata(0,'sr');

player = audioplayer(signal, sr);
play(player);
pause(max(size(signal))/sr);

% --- Executes on button press in pushbutton_save.
function pushbutton_save_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

data=getappdata(0,'sine_sweep');

sr=getappdata(0,'sr');

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


% --- Executes on button press in pushbutton_export_wav_file.
function pushbutton_export_wav_file_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_export_wav_file (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

signal=getappdata(0,'signal');
sr=getappdata(0,'sr');

out_file = uiputfile('*.wav');

filename=out_file;
Fs=sr;

try
    wavwrite(signal,Fs,filename);
catch
    audiowrite(filename,signal,Fs);
end

function varargout = read_wave_file(varargin)
% READ_WAVE_FILE MATLAB code for read_wave_file.fig
%      READ_WAVE_FILE, by itself, creates a new READ_WAVE_FILE or raises the existing
%      singleton*.
%
%      H = READ_WAVE_FILE returns the handle to a new READ_WAVE_FILE or the handle to
%      the existing singleton*.
%
%      READ_WAVE_FILE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in READ_WAVE_FILE.M with the given input arguments.
%
%      READ_WAVE_FILE('Property','Value',...) creates a new READ_WAVE_FILE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before read_wave_file_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to read_wave_file_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help read_wave_file

% Last Modified by GUIDE v2.5 17-Jul-2014 10:26:28

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @read_wave_file_OpeningFcn, ...
                   'gui_OutputFcn',  @read_wave_file_OutputFcn, ...
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


% --- Executes just before read_wave_file is made visible.
function read_wave_file_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to read_wave_file (see VARARGIN)

% Choose default command line output for read_wave_file
handles.output = hObject;

setappdata(0,'Fs',1);
setappdata(0,'Signal',1);
set(handles.pushbutton_play,'enable','off');
set(handles.pushbutton_save_matlab,'enable','off');
set(handles.edit_channel_one,'enable','off');
set(handles.edit_channel_two,'enable','off');
set(handles.text_ch_one,'visible','off');
set(handles.text_ch_two,'visible','off');
set(handles.pushbutton_FFT,'enable','off');

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes read_wave_file wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = read_wave_file_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton_Select_wav_File.
function pushbutton_Select_wav_File_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_Select_wav_File (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

set(handles.pushbutton_play,'enable','off');
set(handles.pushbutton_save_ascii,'enable','off');
set(handles.pushbutton_save_matlab,'enable','off');
set(handles.edit_channel_one,'enable','off');
set(handles.edit_channel_two,'enable','off');
set(handles.text_ch_one,'visible','off');
set(handles.text_ch_two,'visible','off');

%% [filename, pathname] = uigetfile({'*.wav';'*.ogg';'*.flac';'*.au';...
%%   '*.aif';'*.aifc';'*.aiff';'*.mp3';'*.m4a';'*.mp4','All Audio Files';...
%%          '*.*','All Files' },'File Selector');

[filename, pathname]=...
 uigetfile({'*.wav;*.aifc;*.aiff;*.mp3;*.m4a;*.mp4;*.ogg;*.flac;*.au;*.aif',...
                         'All Image Files';'*.*','All Files'},'File Selector');      
      

filename = fullfile(pathname, filename);


[signal, Fs] = audioread(filename);

    
out1=sprintf(' Fs = %10.5g samples/sec ',Fs);
disp(out1);

signal=fix_size(signal);

sz=size(signal);

N=length(signal(:,1));
dt=1/Fs;
t=linspace(0,(N-1)*dt,N);
t=fix_size(t);

stitle=sprintf('%s',filename);

figure(1);
if(sz(2)==1)
    plot(t,signal(:,1)); 
else
    plot(t,signal(:,1),t,signal(:,2));    
end    
xlabel('Time (sec)');
ylabel('Amplitude');
title(stitle,'interpreter','none');
grid on;

set(handles.pushbutton_play,'enable','on');
set(handles.pushbutton_save_ascii,'enable','on');
set(handles.pushbutton_save_matlab,'enable','on');




set(handles.edit_channel_one,'enable','on');
set(handles.text_ch_one,'visible','on');

if(sz(2)==2)
    set(handles.edit_channel_two,'enable','on');
    set(handles.text_ch_two,'visible','on');
end


setappdata(0,'Fs',Fs);          % keep
setappdata(0,'signal',signal);  % keep

setappdata(0,'channel_one',[t signal(:,1)]); 

if(sz(2)==1)
    setappdata(0,'channel_num',1);    
else   
    setappdata(0,'channel_num',2);      
    setappdata(0,'channel_two',[t signal(:,2)]); 
end


% --- Executes on button press in pushbutton_play.
function pushbutton_play_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_play (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

Fs=getappdata(0,'Fs');
signal=getappdata(0,'signal');

player = audioplayer(signal, Fs);
play(player)
pause(max(size(signal))/Fs);


function edit_status_Callback(hObject, eventdata, handles)
% hObject    handle to edit_status (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_status as text
%        str2double(get(hObject,'String')) returns contents of edit_status as a double


% --- Executes during object creation, after setting all properties.
function edit_status_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_status (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_Return.
function pushbutton_Return_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_Return (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close(read_wave_file);


% --- Executes on button press in pushbutton_save_ascii.
function pushbutton_save_ascii_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_save_ascii (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

N=getappdata(0,'channel_num');
ch1=getappdata(0,'channel_one');

filename1 = uiputfile('*.txt','Save Channel 1');
save(filename1,'ch1','-ASCII') 

if(N==2)
    ch2=getappdata(0,'channel_two');
    filename2 = uiputfile('*.txt','Save Channel 2');
    save(filename2,'ch2','-ASCII')     
end

set(handles.pushbutton_FFT,'enable','on')

% --- Executes on button press in pushbutton_save_matlab.
function pushbutton_save_matlab_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_save_matlab (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

N=getappdata(0,'channel_num');
ch1=getappdata(0,'channel_one');

name1=get(handles.edit_channel_one,'string');
assignin('base',name1,ch1);

if(N==2)
    ch2=getappdata(0,'channel_two');
    name2=get(handles.edit_channel_two,'string');   
    assignin('base',name2,ch2);    
end

h = msgbox('Save Complete'); 

set(handles.pushbutton_FFT,'enable','on');



function edit_channel_one_Callback(hObject, eventdata, handles)
% hObject    handle to edit_channel_one (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_channel_one as text
%        str2double(get(hObject,'String')) returns contents of edit_channel_one as a double


% --- Executes during object creation, after setting all properties.
function edit_channel_one_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_channel_one (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_channel_two_Callback(hObject, eventdata, handles)
% hObject    handle to edit_channel_two (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_channel_two as text
%        str2double(get(hObject,'String')) returns contents of edit_channel_two as a double


% --- Executes during object creation, after setting all properties.
function edit_channel_two_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_channel_two (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_FFT.
function pushbutton_FFT_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_FFT (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.s= vibrationdata_fft; 
set(handles.s,'Visible','on');  

function varargout = read_convert_text(varargin)
% READ_CONVERT_TEXT MATLAB code for read_convert_text.fig
%      READ_CONVERT_TEXT, by itself, creates a new READ_CONVERT_TEXT or raises the existing
%      singleton*.
%
%      H = READ_CONVERT_TEXT returns the handle to a new READ_CONVERT_TEXT or the handle to
%      the existing singleton*.
%
%      READ_CONVERT_TEXT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in READ_CONVERT_TEXT.M with the given input arguments.
%
%      READ_CONVERT_TEXT('Property','Value',...) creates a new READ_CONVERT_TEXT or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before read_convert_text_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to read_convert_text_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help read_convert_text

% Last Modified by GUIDE v2.5 03-May-2013 16:18:01

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @read_convert_text_OpeningFcn, ...
                   'gui_OutputFcn',  @read_convert_text_OutputFcn, ...
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


% --- Executes just before read_convert_text is made visible.
function read_convert_text_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to read_convert_text (see VARARGIN)

% Choose default command line output for read_convert_text
handles.output = hObject;

set(handles.pushbutton_Play_Sound,'enable','off');
set(handles.pushbutton_Save,'enable','off');
set(handles.input_edit,'enable','off');
set(handles.input_Array_Name,'enable','off');

setappdata(0,'Fs',1);
setappdata(0,'Signal',1);
setappdata(0,'THM',1);
setappdata(0,'filename','1');


% Update handles structure
guidata(hObject, handles);

% UIWAIT makes read_convert_text wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = read_convert_text_OutputFcn(hObject, eventdata, handles) 
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
close(read_convert_text);



function data_entry_processing(hObject, eventdata, handles)

THM=getappdata(0,'THM');
filename=getappdata(0,'filename');

sz=size(THM);

if(sz(2)>sz(1))
    THM=THM';
end

amplitude=detrend(THM(:,2));

maxa=max(abs(amplitude));

signal=amplitude/maxa;

N=length(signal);

dur=(THM(N,1)-THM(1,1));

Fs=round((N-1)/dur);

if(Fs==44100)
    xi=THM(:,1);
else
    Fs=44100;
    dt=1/Fs;
    N=round(dur/dt);
%
%  This method assumes that the sample rate is already uniform
%
%  Linear interpolation
%
    xi =linspace(0,(N-1)*dt,N)+THM(1,1);  
    signal = interp1(THM(:,1),signal,xi);    
%
end

setappdata(0,'Fs',Fs);
setappdata(0,'signal',signal);  

stitle=sprintf('%s',filename);

figure(1);
plot(xi,signal);
xlabel('Time (sec)');
ylabel('Amplitude');
title(stitle,'interpreter','none');
grid on;

set(handles.pushbutton_Play_Sound,'enable','on');
set(handles.pushbutton_Save,'enable','on');


% --- Executes on button press in pushbutton_Read_External_File.
function pushbutton_Read_External_File_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_Read_External_File (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

set(handles.input_edit,'enable','off');
set(handles.input_edit,'String',' ');
set(handles.input_Array_Name,'enable','off');

[filename, pathname] = uigetfile({'*.txt';'*.dat'});
filename = fullfile(pathname, filename);

fid = fopen(filename,'r');
THM = fscanf(fid,'%g %g',[2 inf]);

setappdata(0,'THM',THM);
setappdata(0,'filename',filename);

data_entry_processing(hObject, eventdata, handles);




% --- Executes on button press in pushbutton_Play_Sound.
function pushbutton_Play_Sound_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_Play_Sound (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Fs=getappdata(0,'Fs');
signal=getappdata(0,'signal');

player = audioplayer(signal, Fs);
play(player)
pause(max(size(signal))/Fs);


% --- Executes on button press in pushbutton_Save.
function pushbutton_Save_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_Save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Fs=getappdata(0,'Fs');
signal=getappdata(0,'signal');

filename = uiputfile('*.wav');


audiowrite(filename,signal,Fs)    


% --- Executes on button press in pushbutton_Read_Matlab.
function pushbutton_Read_Matlab_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_Read_Matlab (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

set(handles.input_edit,'enable','on');
set(handles.input_Array_Name,'enable','on');


function input_edit_Callback(hObject, eventdata, handles)
% hObject    handle to input_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of input_edit as text
%        str2double(get(hObject,'String')) returns contents of input_edit as a double

FS=get(handles.input_edit,'String');

THM=evalin('base',FS);
         
setappdata(0,'THM',THM);

setappdata(0,'filename',FS);

data_entry_processing(hObject, eventdata, handles);


% --- Executes during object creation, after setting all properties.
function input_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to input_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function varargout = Sarkani_random(varargin)
% SARKANI_RANDOM MATLAB code for Sarkani_random.fig
%      SARKANI_RANDOM, by itself, creates a new SARKANI_RANDOM or raises the existing
%      singleton*.
%
%      H = SARKANI_RANDOM returns the handle to a new SARKANI_RANDOM or the handle to
%      the existing singleton*.
%
%      SARKANI_RANDOM('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SARKANI_RANDOM.M with the given input arguments.
%
%      SARKANI_RANDOM('Property','Value',...) creates a new SARKANI_RANDOM or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Sarkani_random_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Sarkani_random_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Sarkani_random

% Last Modified by GUIDE v2.5 27-Aug-2015 18:04:39

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Sarkani_random_OpeningFcn, ...
                   'gui_OutputFcn',  @Sarkani_random_OutputFcn, ...
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


% --- Executes just before Sarkani_random is made visible.
function Sarkani_random_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Sarkani_random (see VARARGIN)

% Choose default command line output for Sarkani_random
handles.output = hObject;

listbox_method_Callback(hObject, eventdata, handles);

listbox_lpf_Callback(hObject, eventdata, handles);

set(handles.uipanel_save,'Visible','off');

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Sarkani_random wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Sarkani_random_OutputFcn(hObject, eventdata, handles) 
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

delete(Sarkani_random);


% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

nmeth=get(handles.listbox_method,'Value');

if(nmeth==1)
    kt=str2num(get(handles.edit_kurtosis,'String'));  
    [beta,n,ktr]=Sarkani_table(kt);
else
    beta=str2num(get(handles.edit_beta,'String'));
    n=str2num(get(handles.edit_n,'String'));
end

sigma=str2num(get(handles.edit_sigma,'String'));
duration=str2num(get(handles.edit_duration,'String'));
sr=str2num(get(handles.edit_sr,'String'));

dt=1/sr;

nt=floor(duration/dt);

t=zeros(nt,1);
for i=1:nt
   t(i)=(i-1)*dt; 
end

mu=0;

[X]=simple_white_noise(mu,sigma,nt);

nf=get(handles.listbox_lpf,'Value');

if(nf==1)
    fl=str2num(get(handles.edit_lpf,'String'));      

    if(fl>sr/2.)
        fl=0.49*sr;
        msgbox('Note: lowpass filter frequency decreased ','Warning','warn');
        out1=sprintf('%8.4g',fl);
        set(handles.edit_lpf,'String',out1);         
    end
    fh=0;
    iband=1;
    iphase=2;
    [X,~,~,~]=Butterworth_filter_function_alt(X,dt,iband,fl,fh,iphase);    

end

for i=1:nt
    Y(i)=X(i)+beta*sign(X(i))*(abs(X(i))^n);
end
%        
Y=sigma*Y/std(Y);
%
[amean,amax,amin,aabs,astd,arms,askew,akurt]=dstats(Y);

Y=fix_size(Y);
t=fix_size(t);

%
figure(10)
plot(t,Y);
grid on;
ylabel('Amplitude');
xlabel('Time (sec)');
out1=sprintf('Time History   std dev=%g  kurtosis=%6.3g',astd,akurt);
title(out1);

fig_num=11;

nbars=31;
figure(fig_num);
xx=max(abs(Y));
x=linspace(-xx,xx,nbars);       
hist(Y,x)
ylabel('Counts');
title('Histogram');
xlabel('Amplitude'); 

signal=[t Y];

setappdata(0,'signal',signal);

set(handles.uipanel_save,'Visible','on');

function edit_sigma_Callback(hObject, eventdata, handles)
% hObject    handle to edit_sigma (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_sigma as text
%        str2double(get(hObject,'String')) returns contents of edit_sigma as a double


% --- Executes during object creation, after setting all properties.
function edit_sigma_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_sigma (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
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


% --- Executes on selection change in listbox_lpf.
function listbox_lpf_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_lpf (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_lpf contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_lpf
set(handles.uipanel_save,'Visible','off');

n=get(handles.listbox_lpf,'Value');

set(handles.text_lpf,'Visible','off');
set(handles.edit_lpf,'Visible','off');

if(n==1)
    set(handles.text_lpf,'Visible','on');
    set(handles.edit_lpf,'Visible','on');    
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


% --- Executes on selection change in listbox_method.
function listbox_method_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_method (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_method contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_method
set(handles.uipanel_save,'Visible','off');

n=get(handles.listbox_method,'Value');

set(handles.text_kurtosis,'Visible','off');
set(handles.edit_kurtosis,'Visible','off');

set(handles.text_beta,'Visible','off');
set(handles.edit_beta,'Visible','off');

set(handles.text_n,'Visible','off');
set(handles.edit_n,'Visible','off');

if(n==1)
    set(handles.text_kurtosis,'Visible','on');
    set(handles.edit_kurtosis,'Visible','on');    
else
    set(handles.text_beta,'Visible','on');
    set(handles.edit_beta,'Visible','on');
 
    set(handles.text_n,'Visible','on');
    set(handles.edit_n,'Visible','on');
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



function edit_kurtosis_Callback(hObject, eventdata, handles)
% hObject    handle to edit_kurtosis (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_kurtosis as text
%        str2double(get(hObject,'String')) returns contents of edit_kurtosis as a double


% --- Executes during object creation, after setting all properties.
function edit_kurtosis_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_kurtosis (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_beta_Callback(hObject, eventdata, handles)
% hObject    handle to edit_beta (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_beta as text
%        str2double(get(hObject,'String')) returns contents of edit_beta as a double


% --- Executes during object creation, after setting all properties.
function edit_beta_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_beta (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_n_Callback(hObject, eventdata, handles)
% hObject    handle to edit_n (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_n as text
%        str2double(get(hObject,'String')) returns contents of edit_n as a double


% --- Executes during object creation, after setting all properties.
function edit_n_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_n (see GCBO)
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


data=getappdata(0,'signal');

output_name=strtrim(get(handles.edit_output_array,'String'));
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


% --- Executes on key press with focus on edit_beta and none of its controls.
function edit_beta_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_beta (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.uipanel_save,'Visible','off');


% --- Executes on key press with focus on edit_n and none of its controls.
function edit_n_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_n (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.uipanel_save,'Visible','off');


% --- Executes on key press with focus on edit_lpf and none of its controls.
function edit_lpf_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_lpf (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.uipanel_save,'Visible','off');


% --- Executes on key press with focus on edit_kurtosis and none of its controls.
function edit_kurtosis_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_kurtosis (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.uipanel_save,'Visible','off');


% --- Executes on key press with focus on edit_sigma and none of its controls.
function edit_sigma_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_sigma (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.uipanel_save,'Visible','off');


% --- Executes on key press with focus on edit_sr and none of its controls.
function edit_sr_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_sr (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.uipanel_save,'Visible','off');


% --- Executes on key press with focus on edit_duration and none of its controls.
function edit_duration_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_duration (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.uipanel_save,'Visible','off');

function varargout = Lomb_Scargle_Periodogram(varargin)
% LOMB_SCARGLE_PERIODOGRAM MATLAB code for Lomb_Scargle_Periodogram.fig
%      LOMB_SCARGLE_PERIODOGRAM, by itself, creates a new LOMB_SCARGLE_PERIODOGRAM or raises the existing
%      singleton*.
%
%      H = LOMB_SCARGLE_PERIODOGRAM returns the handle to a new LOMB_SCARGLE_PERIODOGRAM or the handle to
%      the existing singleton*.
%
%      LOMB_SCARGLE_PERIODOGRAM('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in LOMB_SCARGLE_PERIODOGRAM.M with the given input arguments.
%
%      LOMB_SCARGLE_PERIODOGRAM('Property','Value',...) creates a new LOMB_SCARGLE_PERIODOGRAM or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Lomb_Scargle_Periodogram_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Lomb_Scargle_Periodogram_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Lomb_Scargle_Periodogram

% Last Modified by GUIDE v2.5 28-Jun-2017 16:44:59

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Lomb_Scargle_Periodogram_OpeningFcn, ...
                   'gui_OutputFcn',  @Lomb_Scargle_Periodogram_OutputFcn, ...
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


% --- Executes just before Lomb_Scargle_Periodogram is made visible.
function Lomb_Scargle_Periodogram_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Lomb_Scargle_Periodogram (see VARARGIN)

% Choose default command line output for Lomb_Scargle_Periodogram
handles.output = hObject;

listbox_synth_Callback(hObject, eventdata, handles);

set(handles.uipanel_save,'Visible','off');


% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Lomb_Scargle_Periodogram wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Lomb_Scargle_Periodogram_OutputFcn(hObject, eventdata, handles) 
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

delete(Lomb_Scargle_Periodogram);


% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

disp('  ');
disp(' * * * * * ');
disp('  ');

fig_num=1;

tpi=2*pi;

try
  FS=get(handles.edit_input_array,'String');
  THM=evalin('base',FS);   
catch
  warndlg('Input array not found');
  return;    
end      

YS=get(handles.edit_ylabel,'String');

t=THM(:,1);
a=THM(:,2);

a=a-mean(a);

aorig=a;

n=length(t);

dur=t(n)-t(1);

out1=sprintf(' %d input points ',n);
disp(out1);


df=str2num(get(handles.edit_df,'String'));
fmax=str2num(get(handles.edit_max_freq,'String'));

i=1;

while(1)
    freq(i)=df*i;
    if(freq(i)>fmax);
        freq(i)=[];
        break;
    end
    i=i+1;
end

num=length(freq);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Y=a;

synth=zeros(n,1);

progressbar;

for i=1:num
    progressbar(i/num);
    
    omega=tpi*freq(i);
    
    [a(i),b(i),c(i),y,tau(i),PP(i),AFT(i)]=sine_cosine_lsf_function(Y,t,omega);
    
    as1=std(Y);
    
    as2=std(Y-y);
    
    if(as2<as1)
        synth=synth+y;
        Y=Y-y;
    else
        a(i)=0;
        b(i)=0;
        c(i)=0;
        tau(i)=0;
        PP(i)=0;
        AFT(i)=0;
    end


end
pause(0.3);
progressbar(1);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

nres=get(handles.listbox_synth,'Value');

if(nres==1)
    SR=str2num(get(handles.edit_SR,'String')); 

    dt=1/SR;

    m=floor(dur/dt);

    tt=linspace(0,dur,m+1);
    tt=fix_size(tt);
    re_syn=zeros(m+1,1);

    progressbar;
    
    for i=1:num
        progressbar(i/num);
    
        omt=tpi*freq(i)*tt;
    
        re_syn=re_syn+a(i)+b(i)*sin(omt) +c(i)*cos(omt);
    
    end
    pause(0.3);
    progressbar(1);
    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


xlabel3='Time (sec)';

ylabel1=YS;
ylabel2=YS;
ylabel3=YS;

data1=[t,aorig];
data2=[t,synth];
data3=[t,aorig-synth];

t_string1='Input Time History, Mean Removed';
t_string2='Synthesized Time History';
t_string3='Residual Time History';

[fig_num]=subplots_three_linlin_three_titles_ss(fig_num,xlabel3,ylabel1,ylabel2,ylabel3,data1,data2,data3,t_string1,t_string2,t_string3);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

figure(fig_num);
fig_num=fig_num+1;
plot(freq,AFT);
xlabel('Frequency (Hz)');
ylabel(YS);
title('Lomb-Scargle Periodgram');
grid on;

freq=fix_size(freq);

AFT=fix_size(AFT);

LSP=[freq,AFT];

setappdata(0,'LSP',LSP);

set(handles.uipanel_save,'Visible','on');

[~,fmaxp]=find_max(LSP);


out1=sprintf('\n Max peak at %8.4g Hz \n',fmaxp);
disp(out1);


if(nres==1)
    
    xlabel3='Time (sec)';
    
    ylabel1=YS;
    ylabel2=YS;
    ylabel3=YS;

    data1=[t,aorig];
    data2=[t,synth];
    data3=[tt,re_syn];

    t_string1='Input Time History, Mean Removed';
    t_string2='Synthesized Time History';
    t_string3='Resampled Time History';    
    
    [fig_num]=subplots_three_linlin_three_titles_ss(fig_num,xlabel3,ylabel1,ylabel2,ylabel3,data1,data2,data3,t_string1,t_string2,t_string3);

    setappdata(0,'resampled_synthesis',data3);
    
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



function edit_ylabel_Callback(hObject, eventdata, handles)
% hObject    handle to edit_ylabel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_ylabel as text
%        str2double(get(hObject,'String')) returns contents of edit_ylabel as a double


% --- Executes during object creation, after setting all properties.
function edit_ylabel_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_ylabel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_df_Callback(hObject, eventdata, handles)
% hObject    handle to edit_df (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_df as text
%        str2double(get(hObject,'String')) returns contents of edit_df as a double


% --- Executes during object creation, after setting all properties.
function edit_df_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_df (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_max_freq_Callback(hObject, eventdata, handles)
% hObject    handle to edit_max_freq (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_max_freq as text
%        str2double(get(hObject,'String')) returns contents of edit_max_freq as a double


% --- Executes during object creation, after setting all properties.
function edit_max_freq_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_max_freq (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on key press with focus on edit_df and none of its controls.
function edit_df_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_df (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)

set(handles.uipanel_save,'Visible','off');


% --- Executes on key press with focus on edit_max_freq and none of its controls.
function edit_max_freq_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_max_freq (see GCBO)
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


% --- Executes on button press in pushbutton_save.
function pushbutton_save_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


n=get(handles.listbox_function,'Value');

if(n==1)
    data=getappdata(0,'LSP');
else
    data=getappdata(0,'resampled_synthesis');    
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


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on selection change in listbox_synth.
function listbox_synth_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_synth (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_synth contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_synth
set(handles.uipanel_save,'Visible','off');
n=get(handles.listbox_synth,'Value');

if(n==1)
    set(handles.text_SR,'Visible','on');
    set(handles.edit_SR,'Visible','on');
else
    set(handles.text_SR,'Visible','off');
    set(handles.edit_SR,'Visible','off'); 
end

set(handles.listbox_function, 'String', '');
string_th{1}=sprintf('Periodgram');

if(n==1)
    string_th{2}=sprintf('Resampled Synthesis');    
end
    
set(handles.listbox_function,'String',string_th);



% --- Executes during object creation, after setting all properties.
function listbox_synth_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_synth (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_SR_Callback(hObject, eventdata, handles)
% hObject    handle to edit_SR (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_SR as text
%        str2double(get(hObject,'String')) returns contents of edit_SR as a double


% --- Executes during object creation, after setting all properties.
function edit_SR_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_SR (see GCBO)
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


% --- Executes on key press with focus on edit_SR and none of its controls.
function edit_SR_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_SR (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.uipanel_save,'Visible','off');

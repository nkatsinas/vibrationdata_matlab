function varargout = series_half_sine_pulses(varargin)
% SERIES_HALF_SINE_PULSES MATLAB code for series_half_sine_pulses.fig
%      SERIES_HALF_SINE_PULSES, by itself, creates a new SERIES_HALF_SINE_PULSES or raises the existing
%      singleton*.
%
%      H = SERIES_HALF_SINE_PULSES returns the handle to a new SERIES_HALF_SINE_PULSES or the handle to
%      the existing singleton*.
%
%      SERIES_HALF_SINE_PULSES('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SERIES_HALF_SINE_PULSES.M with the given input arguments.
%
%      SERIES_HALF_SINE_PULSES('Property','Value',...) creates a new SERIES_HALF_SINE_PULSES or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before series_half_sine_pulses_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to series_half_sine_pulses_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help series_half_sine_pulses

% Last Modified by GUIDE v2.5 12-Sep-2020 09:31:40

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @series_half_sine_pulses_OpeningFcn, ...
                   'gui_OutputFcn',  @series_half_sine_pulses_OutputFcn, ...
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


% --- Executes just before series_half_sine_pulses is made visible.
function series_half_sine_pulses_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to series_half_sine_pulses (see VARARGIN)

% Choose default command line output for series_half_sine_pulses
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes series_half_sine_pulses wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = series_half_sine_pulses_OutputFcn(hObject, eventdata, handles) 
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

try

    Figures = findobj( 'Type', 'Figure' , '-not' , 'Tag' , get( handles.output , 'Tag' ) );
    NFigures = length( Figures );
    for nFigures = 1 : NFigures
        close( Figures( nFigures ) );
    end
catch
end    


disp(' ');
disp(' * * * * * * * * ');
disp(' ');

fig_num=1;


num=floor(str2double(get(handles.edit_num,'String')));
amp=str2double(get(handles.edit_amp,'String'));
dur_min=(1/1000)*str2double(get(handles.edit_dur_min,'String'));
dur_max=(1/1000)*str2double(get(handles.edit_dur_max,'String'));

time_between_min=str2double(get(handles.edit_time_between_min,'String'));
time_between_max=str2double(get(handles.edit_time_between_max,'String'));

if(time_between_min > time_between_max)
    warndlg('Fix time between so that min < max');
    return;
end

pre_time=str2double(get(handles.edit_pre_time,'String'));
sr=str2double(get(handles.edit_sr,'String'));


tmax=time_between_max;
tmin=time_between_min;


dt=1/sr;   

np2=num*floor(tmax/dt);
np1=num*floor(tmin/dt);

TT=linspace(0,(np2-1)*dt,np2); 

[~,ii]=min(abs(TT-pre_time));
if(ii<1)
    ii=1;
end

jj2=np2/num;
jj1=np1/num;

a=zeros(np2,1);

i1=ii;

for ijk=1:num
    
    A=amp*(0.9+0.2*rand());
    
    pulse_duration=(dur_max-dur_min)*rand()+dur_min;
    
    i=0;
    while(1)
        ttt=i*dt;
        if(ttt>pulse_duration)
            break;
        end
        a(i1+i)=A*sin(pi*ttt/pulse_duration);
        i=i+1;
    end
    
    i1=i1+round((jj2-jj1)*rand()+jj1);
end

TT=fix_size(TT);


    
YS=get(handles.edit_ylabel,'String');  
    
h=figure(fig_num);
plot(TT,a);
grid on;
xlabel('Time (sec)');
ylabel(YS);
ylim([0,amp*1.2]);
ZoomHandle = zoom(h);
set(ZoomHandle,'Motion','horizontal');


data1=[TT a];

prefix=get(handles.edit_prefix,'String');    
    
s1=sprintf('%s',prefix);
   
assignin('base', s1,data1);   

out1=sprintf(' Calculation Complete. Output array:   %s',s1);    
msgbox(out1);

    
    

% --- Executes on button press in pushbutton_return.
function pushbutton_return_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_return (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

delete(series_half_sine_pulses);


% --- Executes on selection change in listbox_1.
function listbox_1_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_1

n=get(handles.listbox_1,'Value');


set(handles.text_s8,'Visible','off');
set(handles.edit8,'Visible','off'); 
set(handles.text_s9,'Visible','off');
set(handles.edit9,'Visible','off'); 


if(n<=2)
    set(handles.text_s8,'Visible','on');
    set(handles.edit8,'Visible','on');  
end


if(n==1)
   sss='Low Pass Frequency (Hz)'; 
   set(handles.text_s8,'String',sss);
end
if(n==2)
   sss1='Lower Frequency (Hz)'; 
   sss2='Upper Frequency (Hz)'; 
   set(handles.text_s8,'String',sss1); 
   set(handles.text_s9,'String',sss2);
   set(handles.text_s9,'Visible','on');
   set(handles.edit9,'Visible','on');       
end





% --- Executes during object creation, after setting all properties.
function listbox_1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit8_Callback(hObject, eventdata, handles)
% hObject    handle to edit8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit8 as text
%        str2double(get(hObject,'String')) returns contents of edit8 as a double


% --- Executes during object creation, after setting all properties.
function edit8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit9_Callback(hObject, eventdata, handles)
% hObject    handle to edit9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit9 as text
%        str2double(get(hObject,'String')) returns contents of edit9 as a double


% --- Executes during object creation, after setting all properties.
function edit9_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_time_between_min_Callback(hObject, eventdata, handles)
% hObject    handle to edit_time_between_min (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_time_between_min as text
%        str2double(get(hObject,'String')) returns contents of edit_time_between_min as a double


% --- Executes during object creation, after setting all properties.
function edit_time_between_min_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_time_between_min (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_amp_Callback(hObject, eventdata, handles)
% hObject    handle to edit_amp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_amp as text
%        str2double(get(hObject,'String')) returns contents of edit_amp as a double


% --- Executes during object creation, after setting all properties.
function edit_amp_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_amp (see GCBO)
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



function edit_dur_min_Callback(hObject, eventdata, handles)
% hObject    handle to edit_dur_min (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_dur_min as text
%        str2double(get(hObject,'String')) returns contents of edit_dur_min as a double


% --- Executes during object creation, after setting all properties.
function edit_dur_min_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_dur_min (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_rho_Callback(hObject, eventdata, handles)
% hObject    handle to edit_rho (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_rho as text
%        str2double(get(hObject,'String')) returns contents of edit_rho as a double


% --- Executes during object creation, after setting all properties.
function edit_rho_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_rho (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_prefix_Callback(hObject, eventdata, handles)
% hObject    handle to edit_prefix (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_prefix as text
%        str2double(get(hObject,'String')) returns contents of edit_prefix as a double


% --- Executes during object creation, after setting all properties.
function edit_prefix_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_prefix (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_dur_max_Callback(hObject, eventdata, handles)
% hObject    handle to edit_dur_max (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_dur_max as text
%        str2double(get(hObject,'String')) returns contents of edit_dur_max as a double


% --- Executes during object creation, after setting all properties.
function edit_dur_max_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_dur_max (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_num_Callback(hObject, eventdata, handles)
% hObject    handle to edit_num (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_num as text
%        str2double(get(hObject,'String')) returns contents of edit_num as a double


% --- Executes during object creation, after setting all properties.
function edit_num_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_num (see GCBO)
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



function edit_pre_time_Callback(hObject, eventdata, handles)
% hObject    handle to edit_pre_time (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_pre_time as text
%        str2double(get(hObject,'String')) returns contents of edit_pre_time as a double


% --- Executes during object creation, after setting all properties.
function edit_pre_time_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_pre_time (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_time_between_max_Callback(hObject, eventdata, handles)
% hObject    handle to edit_time_between_max (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_time_between_max as text
%        str2double(get(hObject,'String')) returns contents of edit_time_between_max as a double


% --- Executes during object creation, after setting all properties.
function edit_time_between_max_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_time_between_max (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

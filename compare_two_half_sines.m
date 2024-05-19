function varargout = compare_two_half_sines(varargin)
% COMPARE_TWO_HALF_SINES MATLAB code for compare_two_half_sines.fig
%      COMPARE_TWO_HALF_SINES, by itself, creates a new COMPARE_TWO_HALF_SINES or raises the existing
%      singleton*.
%
%      H = COMPARE_TWO_HALF_SINES returns the handle to a new COMPARE_TWO_HALF_SINES or the handle to
%      the existing singleton*.
%
%      COMPARE_TWO_HALF_SINES('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in COMPARE_TWO_HALF_SINES.M with the given input arguments.
%
%      COMPARE_TWO_HALF_SINES('Property','Value',...) creates a new COMPARE_TWO_HALF_SINES or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before compare_two_half_sines_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to compare_two_half_sines_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help compare_two_half_sines

% Last Modified by GUIDE v2.5 24-Mar-2014 09:36:06

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @compare_two_half_sines_OpeningFcn, ...
                   'gui_OutputFcn',  @compare_two_half_sines_OutputFcn, ...
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


% --- Executes just before compare_two_half_sines is made visible.
function compare_two_half_sines_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to compare_two_half_sines (see VARARGIN)

% Choose default command line output for compare_two_half_sines
handles.output = hObject;

listbox_amplitude_unit_Callback(hObject, eventdata, handles)
listbox_time_unit_Callback(hObject, eventdata, handles);


% Update handles structure
guidata(hObject, handles);

% UIWAIT makes compare_two_half_sines wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = compare_two_half_sines_OutputFcn(hObject, eventdata, handles) 
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

delete(compare_two_half_sines);



function edit_amplitude_1_Callback(hObject, eventdata, handles)
% hObject    handle to edit_amplitude_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_amplitude_1 as text
%        str2double(get(hObject,'String')) returns contents of edit_amplitude_1 as a double


% --- Executes during object creation, after setting all properties.
function edit_amplitude_1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_amplitude_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_amplitude_unit.
function listbox_amplitude_unit_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_amplitude_unit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_amplitude_unit contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_amplitude_unit

n=get(handles.listbox_amplitude_unit,'Value');

if(n==1)
    set(handles.text_amplitude_1,'String','Accel (G)');
    set(handles.text_amplitude_2,'String','Accel (G)');    
else
    set(handles.text_amplitude_1,'String','Accel (m/sec^2)');
    set(handles.text_amplitude_2,'String','Accel (m/sec^2)');  
end


% --- Executes during object creation, after setting all properties.
function listbox_amplitude_unit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_amplitude_unit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_Q_Callback(hObject, eventdata, handles)
% hObject    handle to edit_Q (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_Q as text
%        str2double(get(hObject,'String')) returns contents of edit_Q as a double


% --- Executes during object creation, after setting all properties.
function edit_Q_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_Q (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_f1_Callback(hObject, eventdata, handles)
% hObject    handle to edit_f1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_f1 as text
%        str2double(get(hObject,'String')) returns contents of edit_f1 as a double


% --- Executes during object creation, after setting all properties.
function edit_f1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_f1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_f2_Callback(hObject, eventdata, handles)
% hObject    handle to edit_f2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_f2 as text
%        str2double(get(hObject,'String')) returns contents of edit_f2 as a double


% --- Executes during object creation, after setting all properties.
function edit_f2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_f2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_duration_1_Callback(hObject, eventdata, handles)
% hObject    handle to edit_duration_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_duration_1 as text
%        str2double(get(hObject,'String')) returns contents of edit_duration_1 as a double


% --- Executes during object creation, after setting all properties.
function edit_duration_1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_duration_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_duration_2_Callback(hObject, eventdata, handles)
% hObject    handle to edit_duration_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_duration_2 as text
%        str2double(get(hObject,'String')) returns contents of edit_duration_2 as a double


% --- Executes during object creation, after setting all properties.
function edit_duration_2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_duration_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_amplitude_2_Callback(hObject, eventdata, handles)
% hObject    handle to edit_amplitude_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_amplitude_2 as text
%        str2double(get(hObject,'String')) returns contents of edit_amplitude_2 as a double


% --- Executes during object creation, after setting all properties.
function edit_amplitude_2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_amplitude_2 (see GCBO)
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

Q=str2num(get(handles.edit_Q,'String'));

n_amp_unit=get(handles.listbox_amplitude_unit,'Value');
n_dur_unit=get(handles.listbox_time_unit,'Value');

amp_1=str2num(get(handles.edit_amplitude_1,'String'));
amp_2=str2num(get(handles.edit_amplitude_2,'String'));

dur_1=str2num(get(handles.edit_duration_1,'String'));
dur_2=str2num(get(handles.edit_duration_2,'String'));

do1=dur_1;
do2=dur_2;

if(n_dur_unit==1)
    dur_1=dur_1/1000;
    dur_2=dur_2/1000;
end

f1=str2num(get(handles.edit_f1,'String'));
f2=str2num(get(handles.edit_f2,'String'));

if(f1<=0)
    f1=0.1;
end
%
fn(1)=f1;
i=1;
while(1)
    fn(i+1)=fn(i)*2^(1/24);
    if(fn(i+1)>f2)
        fn(i+1)=f2;
        break;
    end
    i=i+1;
end

resp_dur=0;
nat=1;
iunit=1;

[a1_srs,pv1_srs,rd1_srs,base1_th,a1_th,rd1_th]=...
        vibrationdata_half_sine_pulse(nat,amp_1,dur_1,fn,Q,resp_dur,iunit);

[a2_srs,pv2_srs,rd2_srs,base2_th,a2_th,rd2_th]=...
        vibrationdata_half_sine_pulse(nat,amp_2,dur_2,fn,Q,resp_dur,iunit);

 
sz=size(a1_srs);
a1_m=zeros(sz(1),1);
for i=1:sz(1)
    a1_m(i,1)=a1_srs(i,1);
    a1_m(i,2)=max([a1_srs(i,2) abs(a1_srs(i,3)) ]);    
end

sz=size(a2_srs);
a2_m=zeros(sz(1),1);
for i=1:sz(1)
    a2_m(i,1)=a2_srs(i,1);
    a2_m(i,2)=max([a2_srs(i,2) abs(a2_srs(i,3)) ]);    
end
    
    
figure(1);
plot(a1_m(:,1),a1_m(:,2),a2_m(:,1),a2_m(:,2));
xlabel('Natural Frequency (Hz)');

out1=sprintf('Half-Sine Pulse, Acceleration SRS Q=%g',Q);
title(out1); 

if(n_amp_unit==1)
    ylabel('Peak Accel (G)');
    if(n_dur_unit==1)
        out1=sprintf(' %g G, %g msec',amp_1,do1);
        out2=sprintf(' %g G, %g msec',amp_2,do2);        
    else
        out1=sprintf(' %g G, %g sec',amp_1,do1); 
        out2=sprintf(' %g G, %g sec',amp_2,do2);         
    end   
else
    ylabel('Peak Accel (m/s^2)');   
    if(n_dur_unit==1)
        out1=sprintf(' %g m/s^2, %g msec',amp_1,do1);
        out2=sprintf(' %g m/s^2, %g msec',amp_2,do2);        
    else
        out1=sprintf(' %g m/s^2, %g sec',amp_1,do1);  
        out2=sprintf(' %g m/s^2, %g sec',amp_2,do2);         
    end       
end    
    

legend(out1,out2);

maxA1=max(a1_m(:,2));
maxA2=max(a2_m(:,2));

minA1=min(a1_m(:,2));
minA2=min(a2_m(:,2));

maxA=max([maxA1 maxA2]);
minA=max([minA1 minA2]);

set(gca,'MinorGridLineStyle',':','GridLineStyle',':','XScale','log','YScale','log'); 
xlim([f1 f2]);
ymax=10^(ceil(0.2+log10(maxA)));
ymin=10^(floor(log10(minA)));
if(ymin<ymax/1000)
    ymin=ymax/1000;
end
ylim([ymin ymax])
grid on;


% --- Executes on selection change in listbox_time_unit.
function listbox_time_unit_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_time_unit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_time_unit contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_time_unit

n=get(handles.listbox_time_unit,'Value');

if(n==1)
    set(handles.text_duration_1,'String','Duration (msec)');
    set(handles.text_duration_2,'String','Duration (msec)');    
else
    set(handles.text_duration_1,'String','Duration (sec)');
    set(handles.text_duration_2,'String','Duration (sec)');  
end


% --- Executes during object creation, after setting all properties.
function listbox_time_unit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_time_unit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

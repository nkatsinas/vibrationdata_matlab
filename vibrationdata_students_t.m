function varargout = vibrationdata_students_t(varargin)
% VIBRATIONDATA_STUDENTS_T MATLAB code for vibrationdata_students_t.fig
%      VIBRATIONDATA_STUDENTS_T, by itself, creates a new VIBRATIONDATA_STUDENTS_T or raises the existing
%      singleton*.
%
%      H = VIBRATIONDATA_STUDENTS_T returns the handle to a new VIBRATIONDATA_STUDENTS_T or the handle to
%      the existing singleton*.
%
%      VIBRATIONDATA_STUDENTS_T('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in VIBRATIONDATA_STUDENTS_T.M with the given input arguments.
%
%      VIBRATIONDATA_STUDENTS_T('Property','Value',...) creates a new VIBRATIONDATA_STUDENTS_T or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before vibrationdata_students_t_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to vibrationdata_students_t_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help vibrationdata_students_t

% Last Modified by GUIDE v2.5 12-Aug-2014 14:39:01

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @vibrationdata_students_t_OpeningFcn, ...
                   'gui_OutputFcn',  @vibrationdata_students_t_OutputFcn, ...
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


% --- Executes just before vibrationdata_students_t is made visible.
function vibrationdata_students_t_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to vibrationdata_students_t (see VARARGIN)

% Choose default command line output for vibrationdata_students_t
handles.output = hObject;

listbox_method_Callback(hObject, eventdata, handles);
clear_results(hObject, eventdata, handles);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes vibrationdata_students_t wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = vibrationdata_students_t_OutputFcn(hObject, eventdata, handles) 
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
delete(vibrationdata_students_t);


% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

YS=get(handles.edit_YS,'String');

n=get(handles.listbox_method,'Value');



if(n==1)
    v=str2num(get(handles.edit_vk,'String'));
    
    if(v<=4)
        warndlg(' dof must be > 4');
        return;
    end

    k=(3*v-6)/(v-4);
 
    ss=sprintf('%6.2g',k);
    set(handles.edit_alt,'String',ss);
else
    k=str2num(get(handles.edit_vk,'String'));
    
    if(k<=4)
        warndlg(' kurtosis must be > 3');
        return;
    end
    
    v=(4*k-6)/(k-3);
    ss=sprintf('%6.2g',v);
    set(handles.edit_alt,'String',ss);    
end


stda=str2num(get(handles.edit_std,'String'));
dur=str2num(get(handles.edit_duration,'String'));
sr=str2num(get(handles.edit_sr,'String'));
dt=1/sr;

nt=floor(dur*sr);

a=-2/v;

t=zeros(nt,1);
x=zeros(nt,1);

best=zeros(nt,1);

record=1.0e+90;

M=10;

progressbar;

for j=1:M
    progressbar(j/M);

    for i=1:nt
%
        t(i)=(i-1)*dt;
%    
        while(1)
            U=(2*rand-1);
            V=(2*rand-1);
            w=U^2+V^2;
            if(w<1 && abs(w)>1.0e-25)
                break;
            end
        end
%
        x(i)=U*sqrt(v*(w^a-1)/w);
%
    end
%    
    x=stda*x/(std(x));
%
    mu=mean(x);
    sd=std(x);

    ks=0;

    for i=1:nt
        ks=ks+(x(i)-mu)^4;        
    end    
    ks=ks/(nt*sd^4);    
%
    error = abs(1-(ks/k));
%
    if(error<record)
        record=error;
        best=x;
        
        if(record<0.03)
            break;
        end             
    end    
   
%
end
pause(0.4);
progressbar(1);

x=best;    

st=[t x];

setappdata(0,'st',st);

%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


mu=mean(x);
sd=std(x);
mx=max(x);
mi=min(x);
rms=sqrt(sd^2+mu^2);
 
sk=0;
kt=0;
 
for i=1:nt

	kt=kt+(x(i)-mu)^4;
	sk=sk+(x(i)-mu)^3;

end

kt=kt/(nt*sd^4);
sk=sk/(nt*sd^3);
 
string_x=sprintf('\n Amplitude Stats ');
string2=sprintf('\n\n      mean = %8.4g ',mu);
string3=sprintf('\n   std dev = %8.4g ',sd);
string4=sprintf('\n       RMS = %8.4g ',rms);
string5=sprintf('\n\n  skewness = %8.4g ',sk);
string6=sprintf('\n  kurtosis = %8.4g ',kt);

big_string=string_x;
big_string=strcat(big_string,string2);
big_string=strcat(big_string,string3);
big_string=strcat(big_string,string4);
big_string=strcat(big_string,string5);
big_string=strcat(big_string,string6);


mx=max(x);
mi=min(x);

amax=abs(mx);
amin=abs(mi);

if(amax<amin)
   amax=amin;
end
    
crest=amax/rms;

string7=sprintf('\n\n      Maximum = %8.4g ',mx);
string8=sprintf('\n      Minimum = %8.4g ',mi);
string9=sprintf('\n Crest Factor = %8.4g ',crest);    
   
big_string=strcat(big_string,string7);
big_string=strcat(big_string,string8);
big_string=strcat(big_string,string9);
 
    
set(handles.edit_results,'String',big_string);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

fig_num=1;

figure(fig_num);
fig_num=fig_num+1;
plot(t,x);
ylabel(YS);
xlabel('Time (sec)');
grid on;
    

figure(fig_num);
fig_num=fig_num+1;
nbars=61;
xx=max(abs(x));
y=linspace(-xx,xx,nbars);       
hist(x,y)
ylabel('Counts');
title('Histogram');
xlabel(YS);




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



function edit_std_Callback(hObject, eventdata, handles)
% hObject    handle to edit_std (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_std as text
%        str2double(get(hObject,'String')) returns contents of edit_std as a double


% --- Executes during object creation, after setting all properties.
function edit_std_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_std (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_results_Callback(hObject, eventdata, handles)
% hObject    handle to edit_results (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_results as text
%        str2double(get(hObject,'String')) returns contents of edit_results as a double


% --- Executes during object creation, after setting all properties.
function edit_results_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_results (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_alt_Callback(hObject, eventdata, handles)
% hObject    handle to edit_alt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_alt as text
%        str2double(get(hObject,'String')) returns contents of edit_alt as a double


% --- Executes during object creation, after setting all properties.
function edit_alt_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_alt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_dof.
function listbox_dof_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_dof (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_dof contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_dof

n=get(handles.listbox_dof,'Value');

v= 4.5 + 0.1*(n-1);

k=6/(v-4);

ks=sprintf('%g',k);

set(handles.edit_alt,'String',ks);

setappdata(0,'v',v);


% --- Executes during object creation, after setting all properties.
function listbox_dof_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_dof (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_save.
function pushbutton_save_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

data=getappdata(0,'st');

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


% --- Executes on selection change in listbox_method.
function listbox_method_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_method (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_method contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_method

clear_results(hObject, eventdata, handles)

n=get(handles.listbox_method,'Value');

if(n==1)
    set(handles.text_vk,'String','Enter dof, real number > 4');
    set(handles.text_alt,'String','Expected Kurtosis');    
else
    set(handles.text_vk,'String','Enter Kurtosis, real number > 3'); 
    set(handles.text_alt,'String','degrees-of-freedom');     
end

set(handles.edit_alt,'String','');


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



function edit_vk_Callback(hObject, eventdata, handles)
% hObject    handle to edit_vk (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_vk as text
%        str2double(get(hObject,'String')) returns contents of edit_vk as a double


% --- Executes during object creation, after setting all properties.
function edit_vk_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_vk (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_YS_Callback(hObject, eventdata, handles)
% hObject    handle to edit_YS (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_YS as text
%        str2double(get(hObject,'String')) returns contents of edit_YS as a double


% --- Executes during object creation, after setting all properties.
function edit_YS_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_YS (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function clear_results(hObject, eventdata, handles)
%
set(handles.edit_results,'String','');


% --- Executes on key press with focus on edit_std and none of its controls.
function edit_std_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_std (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
clear_results(hObject, eventdata, handles);


% --- Executes on key press with focus on edit_duration and none of its controls.
function edit_duration_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_duration (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
clear_results(hObject, eventdata, handles);


% --- Executes on key press with focus on edit_sr and none of its controls.
function edit_sr_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_sr (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
clear_results(hObject, eventdata, handles);


% --- Executes on key press with focus on edit_YS and none of its controls.
function edit_YS_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_YS (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
clear_results(hObject, eventdata, handles);


% --- Executes on key press with focus on edit_vk and none of its controls.
function edit_vk_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_vk (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
clear_results(hObject, eventdata, handles);
set(handles.edit_alt,'String','');

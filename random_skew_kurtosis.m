function varargout = random_skew_kurtosis(varargin)
% RANDOM_SKEW_KURTOSIS MATLAB code for random_skew_kurtosis.fig
%      RANDOM_SKEW_KURTOSIS, by itself, creates a new RANDOM_SKEW_KURTOSIS or raises the existing
%      singleton*.
%
%      H = RANDOM_SKEW_KURTOSIS returns the handle to a new RANDOM_SKEW_KURTOSIS or the handle to
%      the existing singleton*.
%
%      RANDOM_SKEW_KURTOSIS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in RANDOM_SKEW_KURTOSIS.M with the given input arguments.
%
%      RANDOM_SKEW_KURTOSIS('Property','Value',...) creates a new RANDOM_SKEW_KURTOSIS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before random_skew_kurtosis_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to random_skew_kurtosis_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help random_skew_kurtosis

% Last Modified by GUIDE v2.5 18-Feb-2022 18:18:51

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @random_skew_kurtosis_OpeningFcn, ...
                   'gui_OutputFcn',  @random_skew_kurtosis_OutputFcn, ...
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


% --- Executes just before random_skew_kurtosis is made visible.
function random_skew_kurtosis_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to random_skew_kurtosis (see VARARGIN)

% Choose default command line output for random_skew_kurtosis
handles.output = hObject;

set(handles.pushbutton_save,'Enable','off');

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes random_skew_kurtosis wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = random_skew_kurtosis_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in listbox_skew.
function listbox_skew_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_skew (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_skew contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_skew


% --- Executes during object creation, after setting all properties.
function listbox_skew_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_skew (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

disp(' ');
disp(' * * * * * * * ');
disp(' ');

try

    Figures = findobj( 'Type', 'Figure' , '-not' , 'Tag' , get( handles.output , 'Tag' ) );
    NFigures = length( Figures );
    for nFigures = 1 : NFigures
        close( Figures( nFigures ) );
    end
catch
end    


ns=get(handles.listbox_seed,'Value');
    
if(ns==1)
    rng(1);
end
    

sg=str2num(get(handles.edit_sd,'String'));

m=get(handles.listbox_1,'Value');

k=str2num(get(handles.edit_k,'String'));

n=get(handles.listbox_skew,'Value');


dur=str2num(get(handles.edit_dur,'String'));
sr=str2num(get(handles.edit_sr,'String'));

dt=1/sr;

num=floor(dur/dt);

skgoal=0;

skerror=1.0e+20;

ybest=zeros(num,1);

x=zeros(num,1);

for i=1:num      
    x(i)=(i-1)*dt;
end

if(m==1)
%
%    iband:   1=lowpass  2=highpass  3=bandpass 
%
%    iphase=1  for refiltering for phase correction
%          =2  for no refiltering
      iband=1;
      fl=sr/10;
      fh=0;
      iphase=2;
end    

for nt=1:6

    a=randn(num,1);
    y=zeros(num,1);

    if(m==1)
%    
      [a,~,~,~]=Butterworth_filter_function_alt(a,dt,iband,fl,fh,iphase);
%      
    end      
   
    if(n==1)  % skew = 0
        ex = 0.842*(k-1.36)^0.378;
%
        for i=1:num
            y(i)=sign(a(i))*(abs(a(i))^ex);
        end
    else
        [p1,p2,skgoal]=skewness_kurtosis_coefficients(n,m);       
    end
    
    if(n>=2)  % skew >= 0.1
        LK=log10(k);
        exp= p1(1)*LK^2+p1(2)*LK+p1(3);
        exn= p2(1)*LK^2+p2(2)*LK+p2(3);
    
        for i=1:num
         
            if(a(i)>0)
                y(i)=a(i)^exp;
            else
                y(i)=-(abs(a(i))^exn);            
            end    
        end 
    end    
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    kts=0.;
    sks=0;

    sd=std(y);
    mu=mean(y);

    y=y-mu;

    y=y*sg/sd;

    [mu,sd,rms,sk,kt]=kurtosis_stats(y);
    
    if( abs(sk-skgoal)<skerror)
        skerror=abs(sk-skgoal);
     
        
        ybest=y;
        
        mu_best=mu;
        sd_best=sd;  
        sk_best=sk;
        kt_best=kt;
    end

end   

out1=sprintf('     mean=%8.4g ',mu_best);
out2=sprintf('  std dev=%8.4g ',sd_best);
out3=sprintf(' skewness=%8.4g ',sk_best);
out4=sprintf(' kurtosis=%8.4g \n',kt_best);

out5=sprintf('      max=%8.4g ',max(ybest));
out6=sprintf('      min=%8.4g ',min(ybest));

disp(out1);
disp(out2);
disp(out3);
disp(out4);
disp(out5);
disp(out6);

fig_num=1;

figure(fig_num);
fig_num=fig_num+1;
plot(x,ybest);
xlabel('Time (sec) ');
grid on;
out1=sprintf(' mean=%4.2f  std=%g  skewness=%4.2g  kurtosis=%4.2g',mu_best,sd_best,sk_best,kt_best);
title(out1);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

nbars=31;

figure(fig_num);
fig_num=fig_num+1;
xx=max(abs(y));
xh=linspace(-xx,xx,nbars);       
hist(y,xh)
ylabel('Counts');
title('Histogram');
xlabel('Amplitude Bins');

x=fix_size(x);
ybest=fix_size(ybest);

wsk=[x ybest];

setappdata(0,'wsk',wsk);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

THM=wsk;
t_string=out1;
x_label='Time (sec)';
y_label='Amplitude';

[fig_num]=plot_time_history_histogram(fig_num,THM,t_string,x_label,y_label,nbars);
% [fig_num]=plot_time_history_histogram_alt(fig_num,THM,t_string,x_label,y_label,nbars);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

set(handles.pushbutton_save,'Enable','on');

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


% --- Executes on button press in pushbutton_return.
function pushbutton_return_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_return (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
delete(random_skew_kurtosis);



function edit_sd_Callback(hObject, eventdata, handles)
% hObject    handle to edit_sd (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_sd as text
%        str2double(get(hObject,'String')) returns contents of edit_sd as a double


% --- Executes during object creation, after setting all properties.
function edit_sd_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_sd (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_dur_Callback(hObject, eventdata, handles)
% hObject    handle to edit_dur (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_dur as text
%        str2double(get(hObject,'String')) returns contents of edit_dur as a double


% --- Executes during object creation, after setting all properties.
function edit_dur_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_dur (see GCBO)
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



function edit_k_Callback(hObject, eventdata, handles)
% hObject    handle to edit_k (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_k as text
%        str2double(get(hObject,'String')) returns contents of edit_k as a double


% --- Executes during object creation, after setting all properties.
function edit_k_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_k (see GCBO)
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

data=getappdata(0,'wsk');

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


% --- Executes on selection change in listbox_1.
function listbox_1_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_1


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


% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.s=vibrationdata_sdof_base;
set(handles.s,'Visible','on');


% --- Executes on selection change in listbox_seed.
function listbox_seed_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_seed (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_seed contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_seed


% --- Executes during object creation, after setting all properties.
function listbox_seed_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_seed (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

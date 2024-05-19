function varargout = signal_sine_sweep(varargin)
% SIGNAL_SINE_SWEEP MATLAB code for signal_sine_sweep.fig
%      SIGNAL_SINE_SWEEP, by itself, creates a new SIGNAL_SINE_SWEEP or raises the existing
%      singleton*.
%
%      H = SIGNAL_SINE_SWEEP returns the handle to a new SIGNAL_SINE_SWEEP or the handle to
%      the existing singleton*.
%
%      SIGNAL_SINE_SWEEP('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SIGNAL_SINE_SWEEP.M with the given input arguments.
%
%      SIGNAL_SINE_SWEEP('Property','Value',...) creates a new SIGNAL_SINE_SWEEP or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before signal_sine_sweep_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to signal_sine_sweep_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help signal_sine_sweep

% Last Modified by GUIDE v2.5 22-Oct-2020 09:14:42

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @signal_sine_sweep_OpeningFcn, ...
                   'gui_OutputFcn',  @signal_sine_sweep_OutputFcn, ...
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


% --- Executes just before signal_sine_sweep is made visible.
function signal_sine_sweep_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to signal_sine_sweep (see VARARGIN)

% Choose default command line output for signal_sine_sweep
handles.output = hObject;

set(handles.pushbutton_sdof,'Enable','off');

set(handles.edit_output_array,'Enable','off');
set(handles.pushbutton_save,'Enable','off');

set(handles.listbox_type,'Value',1);
set(handles.listbox_coordinates,'Value',1);
set(handles.listbox_direction,'Value',1);

set(handles.listbox_spectral,'Value',2);


for i = 1:2
   for j=1:2
      data_s{i,j} = '';     
   end 
end
set(handles.uitable_coordinates,'Data',data_s); 

listbox_type_Callback(hObject, eventdata, handles);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes signal_sine_sweep wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = signal_sine_sweep_OutputFcn(hObject, eventdata, handles) 
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

set(handles.pushbutton_sdof,'Enable','off');

nspec=get(handles.listbox_spectral,'Value');


ntime=get(handles.listbox_time,'Value');

ndir=get(handles.listbox_direction,'Value');

ntype=get(handles.listbox_type,'Value');
tmax=str2num(get(handles.edit_duration,'String'));

m=get(handles.listbox_coordinates,'Value');
N=m+1;


A=char(get(handles.uitable_coordinates,'Data'));

B=str2num(A);

freq=B(1:N);
amp=B((N+1):(2*N));

freq=fix_size(freq);
amp=fix_size(amp);

fa=[freq amp];

fa=sortrows(fa,1);


fff=fa(:,1);
aaa=fa(:,2);


clear freq;
clear amp;

%%

sr=str2num(get(handles.edit_sr,'String'));
dt=1/sr;

if(max(fff)>(sr/10))
       sr=max(fff)*10;
       dt=1/sr;
       msgbox('Note: sample rate increased ','Warning','warn');
       out1=sprintf('%8.4g',sr);
       set(handles.edit_sr,'String',out1);
end

%%

num=N;
f1 = fff(1);
f2 = fff(num);


%  
oct=log(f2/f1)/log(2.);

disp(' ');
if(ntime==1)
    dur=tmax;
%%%%    out3=sprintf(' %7.3g octaves/min ',60*(oct/dur));
else    
    dur=(oct/tmax)*60;
    out3=sprintf(' %7.3g octaves/min ',tmax);    
end

string=sprintf('%6.3g',oct);

set(handles.edit_number_octaves,'string',string);

ns=ceil(dur*sr);

if(ndir==3)
    ns=ns*2;
end

ntimes = ns;

out1=sprintf(' %6.3g octaves ',oct);
out2=sprintf(' %7.3g seconds ',dur);
disp(out1);
disp(out2);

if(ntime==2)
    disp(out3);
end
    
cycles=0.;

%
tpi=2.*pi;

if(ntype==1)  % linear
    rate=(f2-f1)/dur;
else          % log
    rate=oct/dur;
end



maxn=90000000;
%
if(ntimes>maxn)
    ntimes=maxn;
%    
    out1=sprintf('Time history truncated to %d points,',maxn);
    out5 = sprintf('or %g sec',maxn*dt);
    sss=strcat(out1,out5);
%  
    msgbox(sss,'Warning','warn');        
end
%

if(ndir==3)
    nt=ntimes/2;
else
    nt=ntimes;     
end


TT=linspace(dt,(ntimes+1)*dt,ntimes); 

%
   a = zeros(1,ntimes);
 arg = zeros(1,nt);
freq = zeros(1,nt);

%
if(ntype==1)  % linear
%
% 0.5 factor is necessary to obtain correct number of cycles for linear case.
%
%			fspectral= (     rate*t ) + f1;
    fmax=0.5*(f2-f1)+f1;
    freq=linspace(f1,fmax,nt);     
%
else  % log
%  
%			fspectral = f1*pow(2.,rate*t);
%
    for i=1:nt
        arg(i)=-1.+2^(rate*TT(i));
    end   
end


%%

freq=fix_size(freq);
TT=fix_size(TT);

if(ntype==1) % linear
   arg=tpi*freq.*TT(1:nt);
else  %log
   arg=tpi*f1*arg/(rate*log(2));  
end

if(ndir==3)
       arg1=arg;
       arg1=fix_size(arg1);
       arg2=flipud(arg1);       
       arg=[arg1; arg2];
end 

%

ntimes=length(a);

%
if(ntype==1) % linear
    spectral=linspace(f1,f2,nt); 
else 
    f1=log10(f1);
    f2=log10(f2);
    spectral=logspace(f1,f2,nt);         
end
%
limit=length(fff)-1;
amplitude=zeros(1,nt);
%

for i=1:nt
   for j=1:limit
       if(fff(j)<=spectral(i) && fff(j+1)>=spectral(i))
            x=spectral(i)-fff(j);
            L=fff(j+1)-fff(j);
            c2=x/L;
            c1=1-x/L;
            amplitude(i)=c1*aaa(j)+c2*aaa(j+1);
            break;
       end
   end
end
%
%% figure(13)
%% plot(spectral,amplitude);
%
if(ndir==3)
    a(1:nt)=sin(arg(1:nt));  
    
     diff_rec=1.0e+90;
 
    
    for i=0:359
        theta=pi*i/180;

        a1=a(nt-1);
        a2=a(nt);
        a3=sin(arg(nt+1)+theta);
        a4=sin(arg(nt+2)+theta);        

        ab=[a1 a2 a3 a4];
        aa=detrend(ab);
        
        diff=norm(aa);
        
        if(diff<diff_rec)
            diff_rec=diff;
            psi=theta;
%            out1=sprintf(' %d %8.4g %8.4g',i,psi,diff);
%            ab
%            disp(out1);
        end
        
        
    end
%    psi

    a((nt+1):ntimes)=sin(arg((nt+1):ntimes)+psi);
else
    a=sin(arg);
end
%

if(ndir==3)
       amp1=amplitude;
       amp1=fix_size(amp1);
       amp2=flipud(amp1);       
       amplitude=[amp1; amp2];    
end



a=fix_size(a);
amplitude=fix_size(amplitude);

a(1)=0.;
a=a.*amplitude;
TT=TT-dt;


%%

TT=fix_size(TT);
a=fix_size(a);

if(ndir==2)
    a=flipud(a);
end


figure(1);
plot(TT,a);
tstring='Sine Sweep';
title(tstring);
grid on;
xlabel('Time (sec)');
ylabel('Amplitude');


signal=[TT a];
setappdata(0,'signal',signal);


fig_num=2;

t=TT;    

num=length(t);

%
%   positive slope zero crossing times for input
%


k=1;
for i=2:num
    if( a(i) > a(i-1) && a(i) > 0 && a(i-1) <=0)
        tindex(k)=i;
        L=a(i)-a(i-1);
        c1=a(i)/L;
        c2=1-c1;
        tz(k)=c1*t(i-1)+c2*t(i);
        k=k+1;
    end
end

nt=k-1;   % number of positive slope zero crossings

%% step=round(str2num(get(handles.edit_step,'String')));   % with sliding window

step=20;

m=1;
for i=(step+1):nt
    m=m+1;
end
m=m-2;  % leave
 
aa=zeros(m,1);
trans=zeros(m,1);
f=zeros(m,1);
phase=zeros(m,1);
    

if(nspec==1)

    progressbar;

    m=1;
    
    for i=(step+1):nt
    
        progressbar(i/nt);
    
        kk=tindex(i);
        jj=tindex(i-step);
        T=(tz(i)-tz(i-step))/step;
        f(m)=1/T;
        aa(m)=std(a(jj:kk));
    
        m=m+1;
    end

    pause(0.2);
    progressbar(1);


    figure(fig_num);
    fig_num=fig_num+1;

    plot(f,aa*sqrt(2));
    title('Sine Sweep Spectral Function');
    xlabel('Frequency (Hz)');

    ylabel('Accel (G)');

    grid on;

    xl = xlim;

end

msgbox('Calculation Complete');

set(handles.edit_output_array,'Enable','on');
set(handles.pushbutton_save,'Enable','on');  




% --- Executes on button press in pushbutton_return.
function pushbutton_return_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_return (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
delete(signal_sine_sweep);


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


% --- Executes on selection change in listbox_type.
function listbox_type_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_type contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_type


n=get(handles.listbox_type,'Value');

set(handles.listbox_time,'Value',1);


if(n==1)  % linear

    set(handles.text_time_option,'Visible','off');
    set(handles.listbox_time,'Visible','off');
    
else
    
    set(handles.text_time_option,'Visible','on');
    set(handles.listbox_time,'Visible','on');
    
end    
    
listbox_time_Callback(hObject, eventdata, handles);

set(handles.edit_output_array,'Enable','off');
set(handles.pushbutton_save,'Enable','off');

% --- Executes during object creation, after setting all properties.
function listbox_type_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_type (see GCBO)
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
data=getappdata(0,'signal');

output_name=get(handles.edit_output_array,'String');
assignin('base', output_name, data);

set(handles.pushbutton_sdof,'Enable','on');

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


% --- Executes on selection change in listbox_coordinates.
function listbox_coordinates_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_coordinates (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_coordinates contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_coordinates

m=get(hObject,'Value');
n=m+1;

Nrows=n;
Ncolumns=2;
 
set(handles.uitable_coordinates,'Data',cell(Nrows,Ncolumns));



set(handles.edit_output_array,'Enable','off');
set(handles.pushbutton_save,'Enable','off');


% --- Executes during object creation, after setting all properties.
function listbox_coordinates_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_coordinates (see GCBO)
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



function edit_number_octaves_Callback(hObject, eventdata, handles)
% hObject    handle to edit_number_octaves (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_number_octaves as text
%        str2double(get(hObject,'String')) returns contents of edit_number_octaves as a double


% --- Executes during object creation, after setting all properties.
function edit_number_octaves_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_number_octaves (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_direction.
function listbox_direction_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_direction (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_direction contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_direction


% --- Executes during object creation, after setting all properties.
function listbox_direction_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_direction (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_time.
function listbox_time_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_time (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_time contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_time

n=get(handles.listbox_time,'Value');

if(n==1)
    set(handles.text_duration_type,'String','Duration (sec)');    
else
    set(handles.text_duration_type,'String','Sweep Rate (oct/min)');        
end


% --- Executes during object creation, after setting all properties.
function listbox_time_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_time (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_spectral.
function listbox_spectral_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_spectral (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_spectral contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_spectral


% --- Executes during object creation, after setting all properties.
function listbox_spectral_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_spectral (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_sdof.
function pushbutton_sdof_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_sdof (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.s=vibrationdata_sdof_base;
set(handles.s,'Visible','on');

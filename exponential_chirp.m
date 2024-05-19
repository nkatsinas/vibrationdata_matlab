function varargout = exponential_chirp(varargin)
% EXPONENTIAL_CHIRP MATLAB code for exponential_chirp.fig
%      EXPONENTIAL_CHIRP, by itself, creates a new EXPONENTIAL_CHIRP or raises the existing
%      singleton*.
%
%      H = EXPONENTIAL_CHIRP returns the handle to a new EXPONENTIAL_CHIRP or the handle to
%      the existing singleton*.
%
%      EXPONENTIAL_CHIRP('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in EXPONENTIAL_CHIRP.M with the given input arguments.
%
%      EXPONENTIAL_CHIRP('Property','Value',...) creates a new EXPONENTIAL_CHIRP or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before exponential_chirp_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to exponential_chirp_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help exponential_chirp

% Last Modified by GUIDE v2.5 01-Apr-2020 18:35:33

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @exponential_chirp_OpeningFcn, ...
                   'gui_OutputFcn',  @exponential_chirp_OutputFcn, ...
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


% --- Executes just before exponential_chirp is made visible.
function exponential_chirp_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to exponential_chirp (see VARARGIN)

% Choose default command line output for exponential_chirp
handles.output = hObject;

set(handles.edit_output_array,'Enable','off');
set(handles.pushbutton_save,'Enable','off');

set(handles.listbox_type,'Value',2);
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

% UIWAIT makes exponential_chirp wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = exponential_chirp_OutputFcn(hObject, eventdata, handles) 
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

disp(' ');
disp(' * * * * * * * * * * ');
disp(' ');


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

Q=str2num(get(handles.edit_Q,'String'));

srs_ref=[freq amp];
fq=freq(1);

fa=[freq amp/Q];


% fa(1,1)=fa(1,1)*0.5;

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


nt = ns;



out1=sprintf(' %6.3g octaves ',oct);
out2=sprintf(' %7.3g seconds ',dur);
disp(out1);
disp(out2);


   
%
tpi=2.*pi;

if(ntype==1)  % linear
    rate=(f2-f1)/dur;
else          % log
    rate=oct/dur;
end



maxn=90000000;
%
if(nt>maxn)
    nt=maxn;
%    
    out1=sprintf('Time history truncated to %d points,',maxn);
    out5 = sprintf('or %g sec',maxn*dt);
    sss=strcat(out1,out5);
%  
    msgbox(sss,'Warning','warn');        
end
%



TT=linspace(dt,(nt+1)*dt,nt); 

%
   a = zeros(1,nt);
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


%
% srs_ref
% interpolate srs  fff,aaa

ioct=3;  % 1/12 octave
[fn,spec]=SRS_specification_interpolation(fff,aaa,ioct);
fn=fix_size(fn);
fn(end)=f2;

spec=fix_size(spec);
srs_int12=[fn spec];

[fn_int,spec_int]=SRS_specification_interpolation(srs_ref(:,1),srs_ref(:,2),ioct);
fn_int=fix_size(fn_int);
spec_int=fix_size(spec_int);
srs_ref_int=[fn_int,spec_int];


ioct=1;  % 1/6 octave
[fn3,spec3]=SRS_specification_interpolation(fff,aaa,ioct);
fn3=fix_size(fn3);
spec3=fix_size(spec3);
srs_int3=[fn3 spec3];



num_fn=length(fn);
num_fn3=length(fn3);

%
if(ntype==1) % linear
    spectral=linspace(f1,f2,nt); 
else 
    f1=log10(f1);
    f2=log10(f2);
    spectral=logspace(f1,f2,nt);  
end

%%%

num=str2num(get(handles.edit_num,'String'));

error_max=1.0e+09;

for ijk=1:num
    
    if(ijk==1)
        fff=srs_int3(:,1);        
        aaa=srs_int3(:,2);
    else    
        if(rand()<0.1)
            for i=1:num_fn3
                aaa(i)=srs_int3(i,2)*(0.99+0.02*rand());
            end
        else
            for i=1:num_fn3
                aaa(i)=aaa_rec(i)*(0.99+0.02*rand());
            end            
        end
    end

% synthesize

    [TT,a]=sine_sweep_ec(fff,aaa,spectral,arg,ndir,TT,dt);

% srs

    accel_input=a; 
    [~,accel_abs_srs]=srs_base_np_ec(Q,accel_input,dt,fn);

% compare

    error=zeros(num_fn,1);
    

    
    for i=1:num_fn
        if(srs_int12(i,1)>=fq)
            error(i)=abs(20*log10(accel_abs_srs(i,2)/(srs_ref_int(i,2))));
        end    
    end    

    err=sum(error);

% check error

    if(err<error_max)
        error_max=err;
        TT_rec=TT;
        a_rec=a;
        aaa_rec=aaa;
        accel_abs_srs_rec=accel_abs_srs;
 
        out1=sprintf('%d  %8.5g',ijk,error_max);
        disp(out1);
    end
    
end

disp(' ');
disp(' * * * * * * * * * * ');
disp(' ');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

TT_rec=TT_rec-TT_rec(1);

figure(1);
plot(TT_rec,a_rec);
tstring='Chirp Pulse';
title(tstring);
grid on;
xlabel('Time (sec)');
ylabel('Amplitude');

signal=[TT_rec a_rec];
setappdata(0,'signal',signal);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

fig_num=2;
md=6;
fmin=srs_ref(1,1);
fmax=srs_ref(end,1);
x_label='Natural Frequency (Hz)';
y_label='Peak Accel (G)';
t_string=sprintf('SRS Q=%g',Q);
ppp1=accel_abs_srs_rec;
ppp2=srs_ref;
leg1='Chirp';
leg2='Spec';


[fig_num,h2]=plot_loglog_function_md_two_h2(fig_num,x_label,...
               y_label,t_string,ppp1,ppp2,leg1,leg2,fmin,fmax,md);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

msgbox('Calculation Complete');

set(handles.edit_output_array,'Enable','on');
set(handles.pushbutton_save,'Enable','on');  



function[TT,a]=sine_sweep_ec(fff,aaa,spectral,arg,ndir,TT,dt)
%

nt=length(spectral);
limit=length(fff);

amplitude=zeros(1,nt);

for i=1:nt
   for j=1:limit-1
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



a=sin(arg);


% amplitude

%
%% figure(13)
%% plot(spectral,amplitude);
%


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




% --- Executes on button press in pushbutton_return.
function pushbutton_return_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_return (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
delete(exponential_chirp);


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

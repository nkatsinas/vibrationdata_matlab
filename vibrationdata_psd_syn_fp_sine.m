function varargout = vibrationdata_psd_syn_fp_sine(varargin)
% VIBRATIONDATA_PSD_SYN_FP_SINE MATLAB code for vibrationdata_psd_syn_fp_sine.fig
%      VIBRATIONDATA_PSD_SYN_FP_SINE, by itself, creates a new VIBRATIONDATA_PSD_SYN_FP_SINE or raises the existing
%      singleton*.
%
%      H = VIBRATIONDATA_PSD_SYN_FP_SINE returns the handle to a new VIBRATIONDATA_PSD_SYN_FP_SINE or the handle to
%      the existing singleton*.
%
%      VIBRATIONDATA_PSD_SYN_FP_SINE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in VIBRATIONDATA_PSD_SYN_FP_SINE.M with the given input arguments.
%
%      VIBRATIONDATA_PSD_SYN_FP_SINE('Property','Value',...) creates a new VIBRATIONDATA_PSD_SYN_FP_SINE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before vibrationdata_psd_syn_fp_sine_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to vibrationdata_psd_syn_fp_sine_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help vibrationdata_psd_syn_fp_sine

% Last Modified by GUIDE v2.5 02-Jan-2015 17:37:43

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @vibrationdata_psd_syn_fp_sine_OpeningFcn, ...
                   'gui_OutputFcn',  @vibrationdata_psd_syn_fp_sine_OutputFcn, ...
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


% --- Executes just before vibrationdata_psd_syn_fp_sine is made visible.
function vibrationdata_psd_syn_fp_sine_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to vibrationdata_psd_syn_fp_sine (see VARARGIN)

% Choose default command line output for vibrationdata_psd_syn_fp_sine
handles.output = hObject;

set(handles.uipanel_save,'Visible','off');

listbox_type_Callback(hObject, eventdata, handles);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes vibrationdata_psd_syn_fp_sine wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = vibrationdata_psd_syn_fp_sine_OutputFcn(hObject, eventdata, handles) 
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

delete(vibrationdata_psd_syn_fp_sine);


% --- Executes on button press in Calculate.
function Calculate_Callback(hObject, eventdata, handles)
% hObject    handle to Calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

fig_num=1;
 
try
   FS=get(handles.edit_input_array_name,'String');
   THM=evalin('base',FS);   
catch
    warndlg('Input Filename Error');
    return;
end

amp=THM(:,2);
freq=THM(:,1);



tpi=2*pi;


ntype=get(handles.listbox_type,'Value');
nunit=get(handles.listbox_unit,'Value');

dur=str2num(get(handles.edit_duration,'String'));
tmax=dur;

df=str2num(get(handles.edit_df,'String'));


[dt,freq,amp,slope,grms] = psd_syn_sine_data_entry(freq,amp,tmax);


out4 = sprintf('\n  Input PSD overall level = %g ',grms);
disp(out4)
%
%  time vector
%
   nL=round(dur/dt);
%   
   TT=linspace(0,nL*dt,nL); 
%
%  frequency vector
%   
   f1=min(freq);
   f2=max(freq);
   nF=round((f2-f1)/df);
%   
   ff=linspace(f1,f1+nF*df,nF+1);
%
   ph=rand(1,nF)*tpi;
%
LS=max(size(freq))-1;
spec=zeros(1,nF);
%

snf=sprintf('%d',nF);
set(handles.edit_ns,'String',snf);
%

for i=1:nF
%
    for j=1:LS
 %            
	    if( ff(i) >= freq(j) && ff(i) < freq(j+1) )
%				
            fr = (ff(i)/freq(j) );
	        spec(i)=amp(j)*( fr^slope(j) );         
%
		    break;
        end
    end
%
    if( ff(i) == freq(j+1))
       spec(i)=amp(LS+1);    
    end
%
%    out1=sprintf(' i=%d  ff=%8.4g  spec=%8.4g  ',i,ff(i),spec(i));
%    disp(out1);
%
end
%
mag=sqrt(spec);
%
psd_th=zeros(1,nL);
%
ff=ff*tpi;
%
progressbar
%
for j=1:nF
    progressbar(j/nF)
    arg=ff(j)*TT+ph(j);
%%    out1=sprintf(' j=%d  ff=%8.4g  mag=%8.4g  ph=%8.4g ',j,ff(j),mag(j),ph(j));
%%    disp(out1);
%
    psd_th=psd_th+mag(j)*sin(arg);
%
end
progressbar(1)
%
out5 = sprintf('\n scale time history ');
disp(out5)   
%
%  scale th
%
    mu=mean(psd_th);
    stddev=std(psd_th);
    grmsout = sqrt(mu^2+stddev^2);
%
    scale=grms/grmsout;
    psd_th=psd_th*scale;
%
%  Output
%
mu=mean(psd_th);
sd=std(psd_th);
mx=max(psd_th);
mi=min(psd_th);
rms=sqrt(sd^2+mu^2);

%
disp(' ')
n=length(psd_th);

kt=0;

for i=1:n
     kt=kt+(psd_th(i)-mu)^4;
end

kurtosis=kt/(n*sd^4);

maxa=max([mx mi]);

cr=maxa/sd;


out0 = sprintf(' number of points = %d ',n);
out1 = sprintf('      mean = %8.4g    std = %8.4g    rms = %8.4g \n',mu,sd,rms);
out2 = sprintf(' kurtosis  = %6.3g  \n',kurtosis);
out3 = sprintf('      max  = %9.4g  ',mx);
out4 = sprintf('      min  = %9.4g  \n',mi);
out5 = sprintf('     crest = %8.4g \n',cr);

%
disp(out0);
disp(out1);
disp(out2);
disp(out3);
disp(out4);
disp(out5);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[aslope,rms] = calculate_PSD_slopes(THM(:,1),THM(:,2));

if(ntype==1)

    out5 = sprintf('Time History   std dev=%8.3g  kurtosis=%4.2g',std(psd_th),kurtosis);
    
    if(nunit==1)
        Alab='Force (lbf)';
        Plab='Force (lbf^2/Hz)';
        t_string=sprintf(' Force PSD   %8.4g lbf RMS ',rms);
    else
        Alab='Force (N)';
        Plab='Force (N^2/Hz)';  
        t_string=sprintf(' Force PSD   %8.4g N RMS ',rms);        
    end

else
    
    if(nunit==1)
        Alab='Pressure (psi)';
        Plab='Pressure (psi^2/Hz)';        
        t_string=sprintf('Pressure PSD   %8.4g psi RMS ',rms);        
    else
        Alab='Pressure (Pa)';   
        Plab='Pressure (Pa^2/Hz)'; 
        t_string=sprintf('Pressure PSD   %8.4g Pa RMS ',rms);           
    end
    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

xlab='Frequency (Hz)';
ylab=Plab;

fmin=min(freq);
fmax=max(freq);

[fig_num]=plot_PSD_function(fig_num,xlab,ylab,t_string,THM,fmin,fmax);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

figure(fig_num);
fig_num=fig_num+1;
plot(TT,psd_th);
%    

title(out5);      
xlabel(' Time (sec)');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

figure(fig_num);
fig_num=fig_num+1;
xx=max(abs(psd_th));
nbars=31;
x=linspace(-xx,xx,nbars);       
hist(psd_th,x)
ylabel('Counts');
title('Histogram');
xlabel(Alab);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

TT=fix_size(TT);
psd_th=fix_size(psd_th);

pp=[TT psd_th];

setappdata(0,'time_history',pp);

set(handles.uipanel_save,'Visible','on');
set(handles.pushbutton_psd,'Visible','off');



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


% --- Executes on selection change in listbox_type.
function listbox_type_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_type contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_type

ntype=get(handles.listbox_type,'Value');

if(ntype==1)
    ss{1}=sprintf('lbf');
    ss{2}=sprintf('N');  
else
    ss{1}=sprintf('psi');
    ss{2}=sprintf('Pa');      
end
    
set(handles.listbox_unit,'String',ss)


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

data=getappdata(0,'time_history');

output_name=get(handles.edit_output_array_name,'String');
assignin('base', output_name, data);

set(handles.pushbutton_psd,'Visible','on');

h = msgbox('Save Complete.'); 



% --- Executes on selection change in listbox_unit.
function listbox_unit_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_unit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_unit contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_unit


% --- Executes during object creation, after setting all properties.
function listbox_unit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_unit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_input_array_name_Callback(hObject, eventdata, handles)
% hObject    handle to edit_input_array_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_input_array_name as text
%        str2double(get(hObject,'String')) returns contents of edit_input_array_name as a double


% --- Executes during object creation, after setting all properties.
function edit_input_array_name_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_input_array_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_output_array_name_Callback(hObject, eventdata, handles)
% hObject    handle to edit_output_array_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_output_array_name as text
%        str2double(get(hObject,'String')) returns contents of edit_output_array_name as a double


% --- Executes during object creation, after setting all properties.
function edit_output_array_name_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_output_array_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_ns_Callback(hObject, eventdata, handles)
% hObject    handle to edit_ns (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_ns as text
%        str2double(get(hObject,'String')) returns contents of edit_ns as a double


% --- Executes during object creation, after setting all properties.
function edit_ns_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_ns (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_psd.
function pushbutton_psd_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_psd (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


handles.s= vibrationdata_psd;

set(handles.s,'Visible','on'); 

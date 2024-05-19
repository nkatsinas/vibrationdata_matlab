function varargout = vibrationdata_gust_psd_syn(varargin)
% VIBRATIONDATA_GUST_PSD_SYN MATLAB code for vibrationdata_gust_psd_syn.fig
%      VIBRATIONDATA_GUST_PSD_SYN, by itself, creates a new VIBRATIONDATA_GUST_PSD_SYN or raises the existing
%      singleton*.
%
%      H = VIBRATIONDATA_GUST_PSD_SYN returns the handle to a new VIBRATIONDATA_GUST_PSD_SYN or the handle to
%      the existing singleton*.
%
%      VIBRATIONDATA_GUST_PSD_SYN('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in VIBRATIONDATA_GUST_PSD_SYN.M with the given input arguments.
%
%      VIBRATIONDATA_GUST_PSD_SYN('Property','Value',...) creates a new VIBRATIONDATA_GUST_PSD_SYN or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before vibrationdata_gust_psd_syn_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to vibrationdata_gust_psd_syn_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help vibrationdata_gust_psd_syn

% Last Modified by GUIDE v2.5 13-Aug-2014 14:01:39

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @vibrationdata_gust_psd_syn_OpeningFcn, ...
                   'gui_OutputFcn',  @vibrationdata_gust_psd_syn_OutputFcn, ...
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


% --- Executes just before vibrationdata_gust_psd_syn is made visible.
function vibrationdata_gust_psd_syn_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to vibrationdata_gust_psd_syn (see VARARGIN)

% Choose default command line output for vibrationdata_gust_psd_syn
handles.output = hObject;

listbox_unit_Callback(hObject, eventdata, handles);


set(handles.pushbutton_calculate,'Visible','off');
set(handles.uipanel_save,'Visible','off');

set(handles.edit_duration,'Visible','off');
set(handles.text_duration,'Visible','off');
set(handles.text_recommend,'Visible','off');
set(handles.text_otherwise,'Visible','off');

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes vibrationdata_gust_psd_syn wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = vibrationdata_gust_psd_syn_OutputFcn(hObject, eventdata, handles) 
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

% THM=getappdata(0,'THM');

fig_num=1;

tmax=str2num(get(handles.edit_duration,'String'));

nsz=getappdata(0,'nsz');

original_spec=getappdata(0,'original_spec');
freq=getappdata(0,'freq');
freq_spec=getappdata(0,'freq_spec');
amp=getappdata(0,'amp');
% min_dur=getappdata(0,'min_dur');

set(handles.uipanel_save,'Visible','on');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% nss=length(freq);
%
freq(nsz+1)=freq(nsz)*2^(1/48);
amp(nsz+1)=amp(nsz);
%
[~,slope,vrms] = psd_syn_data_entry(freq,amp,tmax,nsz);
%
sr=20*max(freq_spec);
dt=1/sr;
spec_vrms=vrms;
%
freq=fix_size(freq);
 amp=fix_size(amp);
%
%  Plot Input PSD
%
[fig_num]=...
velox_PSD_plot(fig_num,original_spec,vrms,'Input Power Spectral Density');
%   
%  Generate White Noise 
%
[np,np2,noct,mmm,m2,N,df,white_noise,tw]=gust_PSD_syn_white_noise(tmax,dt);
%
%  Interpolat PSD spec
%
[fft_freq,spec]=gust_interpolate_PSD_spec(mmm,freq,amp,slope,df,vrms);
%
fmax=max(freq);
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
mag=sqrt(spec);
%
nsegments = 1;
%
sq_spec=sqrt(spec);
%
[Y,psd_th,nL]=PSD_syn_FFT_core(nsegments,m2,N,fmax,df,sq_spec,white_noise);
%
[TT,psd_th]=gust_PSD_syn_scale_time_history(psd_th,vrms,nL,dt,tmax);
%
[freq,amp,NW,df,mr_choice,h_choice,den,mH]=...
                       gust_PSD_syn_verify(TT,psd_th,spec_vrms,dt,freq(1));
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
nnt=3;
%
clear freq_spec;
clear amp_spec;
%
freq_spec=original_spec(:,1);
 amp_spec=original_spec(:,2);
%
[amp,dispx,full,tim]=...
    gust_PSD_syn_velox_correction(nnt,amp,dt,spec_vrms,mH,NW,freq_spec,...
                               amp_spec,df,mr_choice,h_choice,den,freq,TT);  
%
[amp,freq,full]=...
     gust_PSD_final_correction(amp,freq,full,freq_spec,amp_spec,den,...
                                                 NW,mH,mr_choice,h_choice);
%
freq=fix_size(freq);
full=fix_size(full);
[zmax,fmax]=find_max([freq full]);
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
clear sum;
ms=sum(full);
%
rms=sqrt(ms*df);
%
disp(' ');
out4 = sprintf(' Overall RMS = %10.3g ',rms);
out5 = sprintf(' Three Sigma = %10.3g ',3*rms);
disp(out4)
disp(out5)
disp(' ');
%
clear TT;
clear psd_TH;
%
TT=tim;
psd_TH=amp;
%
TT=fix_size(TT);
%
psd_TH=fix_size(psd_TH);
dispx=fix_size(dispx);
%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



% --- Executes on button press in pushbutton_return.
function pushbutton_return_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_return (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

delete(vibrationdata_gust_psd_syn);


% --- Executes on selection change in listbox_unit.
function listbox_unit_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_unit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_unit contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_unit

n=get(handles.listbox_unit,'Value');

if(n==1)
    set(handles.text_unit,'String','The PSD specification must have two columns:  Freq(Hz) & Velocity((ft/sec)^2/Hz)');
else
    set(handles.text_unit,'String','The PSD specification must have two columns:  Freq(Hz) & Velocity((m/sec)^2/Hz)');    
end


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


% --- Executes on button press in pushbutton_read.
function pushbutton_read_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_read (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


FS=get(handles.edit_input_array,'String');
THM=evalin('base',FS);   

if(THM(1,1)<1.0e-09)  % check for zero frequency
    THM(1,1)=10^(floor(-0.1+log10(THM(2,1))));
end
%
if(THM(1,2)<1.0e-30)  % check for zero amplitude
    noct=log(THM(2,1)/THM(1,1))/log(2);
    THM(1,2)=(noct/4)*THM(2,2);         % 6 db/octave 
end

nsz=max(size(THM));

k=1;
for i=1:nsz
    if(THM(i,1)>0)
        amp(k)=THM(i,2);
        freq(k)=THM(i,1);
        k=k+1;
    end
end
freq_spec=freq;
%
original_spec=THM;
%
min_dur=10/freq(1);

setappdata(0,'nsz',nsz);
setappdata(0,'THM',THM);
setappdata(0,'original_spec',original_spec);
setappdata(0,'freq',freq);
setappdata(0,'freq_spec',freq_spec);
setappdata(0,'amp',amp);
setappdata(0,'min_dur',min_dur);

set(handles.pushbutton_calculate,'Visible','on');

set(handles.edit_duration,'Visible','on');
set(handles.text_duration,'Visible','on');
set(handles.text_recommend,'Visible','on');
set(handles.text_otherwise,'Visible','on');

ss=sprintf('Recommended duration > %9.6g sec',min_dur');
set(handles.text_recommend,'String',ss);




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


% --- Executes on button press in pushbutton_save.
function pushbutton_save_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function edit_output_name_Callback(hObject, eventdata, handles)
% hObject    handle to edit_output_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_output_name as text
%        str2double(get(hObject,'String')) returns contents of edit_output_name as a double


% --- Executes during object creation, after setting all properties.
function edit_output_name_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_output_name (see GCBO)
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

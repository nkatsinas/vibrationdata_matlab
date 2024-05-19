function varargout = vibrationdata_PSD_vel_synth(varargin)
% VIBRATIONDATA_PSD_VEL_SYNTH MATLAB code for vibrationdata_PSD_vel_synth.fig
%      VIBRATIONDATA_PSD_VEL_SYNTH, by itself, creates a new VIBRATIONDATA_PSD_VEL_SYNTH or raises the existing
%      singleton*.
%
%      H = VIBRATIONDATA_PSD_VEL_SYNTH returns the handle to a new VIBRATIONDATA_PSD_VEL_SYNTH or the handle to
%      the existing singleton*.
%
%      VIBRATIONDATA_PSD_VEL_SYNTH('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in VIBRATIONDATA_PSD_VEL_SYNTH.M with the given input arguments.
%
%      VIBRATIONDATA_PSD_VEL_SYNTH('Property','Value',...) creates a new VIBRATIONDATA_PSD_VEL_SYNTH or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before vibrationdata_PSD_vel_synth_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to vibrationdata_PSD_vel_synth_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help vibrationdata_PSD_vel_synth

% Last Modified by GUIDE v2.5 14-Aug-2014 10:36:52

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @vibrationdata_PSD_vel_synth_OpeningFcn, ...
                   'gui_OutputFcn',  @vibrationdata_PSD_vel_synth_OutputFcn, ...
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


% --- Executes just before vibrationdata_PSD_vel_synth is made visible.
function vibrationdata_PSD_vel_synth_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to vibrationdata_PSD_vel_synth (see VARARGIN)

% Choose default command line output for vibrationdata_PSD_vel_synth
handles.output = hObject;

set(handles.listbox_method,'Value',1);
set(handles.listbox_numrows,'Value',1);
set(handles.listbox_metric,'Value',1);
set(handles.listbox_units,'Value',1);

set(handles.pushbutton_calculate,'Enable','off');
set(handles.listbox_numrows,'Enable','off');
set(handles.uitable_advise,'Visible','off');
set(handles.listbox_numrows,'Visible','off');
set(handles.text_select_processing_option,'Visible','off');

set(handles.listbox_numrows,'String',' ');

set(handles.edit_output_array,'Enable','off');
set(handles.pushbutton_save,'Enable','off');

YL='Velocity';

setappdata(0,'wnd_label',YL); 

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes vibrationdata_PSD_vel_synth wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = vibrationdata_PSD_vel_synth_OutputFcn(hObject, eventdata, handles) 
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

delete(vibrationdata_PSD_vel_synth);



% --- Executes on button press in pushbutton_view_options.
function pushbutton_view_options_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_view_options (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

set(handles.listbox_numrows,'Enable','on');
set(handles.uitable_advise,'Visible','on');
set(handles.listbox_numrows,'Visible','on');
set(handles.text_select_processing_option,'Visible','on');

set(handles.listbox_numrows,'String',' ');

k=get(handles.listbox_method,'Value');

 
if(k==1)
  FS=get(handles.edit_input_array,'String');
  THM=evalin('base',FS);   
else
  THM=getappdata(0,'THM');
end

maxf=max(THM(:,1));

A=get(handles.edit_duration,'String');

iflag=0;

if isempty(A)
    warndlg(' Enter Duration ');
    return;
else
    dur=str2num(A);
    iflag=1;
end  

if(THM(1,1)<1.0e-08)
    THM(1,1)=1.0e-08;
end    

fmin=THM(1,1);

rd=10/fmin;


if(dur<rd)   
    out1=sprintf(' Recommended Duration >= %8.4g sec.  Otherwise increase specification starting frequency.',rd);
    warndlg(out1);    
end   

if(iflag==1)

    [data,dt,sr,n,max_num_rows]=advise_syn(maxf,dur);
    
    setappdata(0,'dt',dt);    
    setappdata(0,'sr',sr);
    setappdata(0,'n',n);      

    for i=1:max_num_rows
        handles.number(i)=i;
    end

    set(handles.listbox_numrows,'String',handles.number);

    cn={'No. of Segments ','Samples/Segments','Time/Segment (sec)','df (Hz)','dof'};

    set(handles.uitable_advise,'Data',data,'ColumnWidth','auto','ColumnName',cn);

    setappdata(0,'advise_data',data);
    
    set(handles.pushbutton_calculate,'Enable','on');


end


% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

q=get(handles.listbox_numrows,'Value');
advise_data=getappdata(0,'advise_data');
NW=advise_data(q,1);  % Number of Segments
sdf=advise_data(q,4);



fig_num=1;

iu=get(handles.listbox_units,'Value');

if(iu==1)
    unit='ft/sec';
end
if(iu==2)
    unit='in/sec';
end
if(iu==3)
    unit='m/sec';
end



set(handles.pushbutton_save,'Enable','On');    
set(handles.edit_output_array,'Enable','On'); 


k=get(handles.listbox_method,'Value');
 
if(k==1)
  FS=get(handles.edit_input_array,'String');
  THM=evalin('base',FS);   
else
  THM=getappdata(0,'THM');
end

ffmin=THM(1,1);

% 
if(sdf>ffmin)
    warndlg('df>lowest spec frequency. Recommend longer duration or fewer segments or increase starting spec frequency.');
    return;
end

clear progressbar;
progressbar;

progressbar(1/10);

maxf=max(THM(:,1));

dur=str2num(get(handles.edit_duration,'String'));


dt=getappdata(0,'dt');    
sr=getappdata(0,'sr');
n=getappdata(0,'n'); 
np=n;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

progressbar(2/10);


out1=sprintf(' NW= %d ',NW);
disp(out1);

progressbar(3/10);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(THM(1,1)<1.0e-09)  % check for zero frequency
    THM(1,1)=10^(floor(-0.1+log10(THM(2,1))));
end
%
if(THM(1,2)<1.0e-30)  % check for zero amplitude
    noct=log(THM(2,1)/THM(1,1))/log(2);
    THM(1,2)=(noct/4)*THM(2,2);         % 6 db/octave 
end
%
nsz=max(size(THM));
freq=zeros(nsz+1,1);
amp=zeros(nsz+1,1);
%
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

progressbar(4/10);

%
nss=length(freq);
%
freq(nsz+1)=freq(nsz)*2^(1/48);
amp(nsz+1)=amp(nsz);
%

[~,slope,rms] = psd_syn_data_entry(freq,amp,nsz,nsz);

progressbar(5/10);

freq=fix_size(freq);
 amp=fix_size(amp);
 
spec_rms=rms; 
%
%  Plot Input PSD
%
out1=sprintf(' Input Power Spectral Density %7.3g %s rms',rms,unit);

dimension=getappdata(0,'wnd_label');  

tmax=dur;

progressbar(6/10);

%   
%  Generate White Noise 
%
[np,white_noise,tw]=PSD_syn_white_noise(tmax,dt,np);

progressbar(7/10);
%
%  Interpolate PSD spec
%
mmm=round(np/2);
%
df=1/(np*dt);
%

%
[fft_freq,spec]=interpolate_PSD_spec(np,freq,amp,slope,df);
%
fmax=max(freq);

progressbar(8/10);
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
mag=sqrt(spec);
%
nsegments = 1;
%
sq_spec=sqrt(spec);
%
[fig_num]=wnb_PSD_plot(fig_num,original_spec,out1,dimension,unit);
%
mmm;
np;
nsegments;
nsegments*mmm;
size(white_noise);

progressbar(1);
clear progressbar;

[Y,psd_th,nL]=PSD_syn_FFT_core(nsegments,mmm,np,fmax,df,sq_spec,white_noise);
%

disp('r1: size psd_th');
size(psd_th)

[TT,psd_th,dt]=PSD_syn_scale_time_history(psd_th,rms,np,tmax);
%


disp('r2: size psd_th');
size(psd_th);

[amp,mr_choice,h_choice,mH]=...
                       wnb_PSD_syn_verify(TT,psd_th,spec_rms,dt,df,mmm,NW);

 %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
nnt=4;
%
clear freq_spec;
clear amp_spec;
%
freq_spec=original_spec(:,1);
 amp_spec=original_spec(:,2);

%
iunit=get(handles.listbox_units,'Value');

disp(' ');
disp('r3: wnaccel_psd_syn_correction_vel');
%
[velox,dispx,freq,full,tim,df]=...
      wnaccel_psd_syn_correction_vel(nnt,amp,dt,spec_rms,NW,freq_spec,...
                          amp_spec,mr_choice,h_choice,TT,iunit,spec_rms);

scale=std(amp)/spec_rms;
 
amp=amp*scale;
velox=velox*scale;
dispx=dispx*scale;

full=full*scale^2;



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
psd_velox=velox;
psd_dispx=dispx;
%
TT=fix_size(TT);
%
clear length;
na=length(psd_TH);
%
temp=TT(1:na);
clear TT;
TT=temp;

%
psd_velox=fix_size(psd_velox);
psd_dispx=fix_size(psd_dispx);

psd_synthesis_velox=[TT psd_velox];
psd_synthesis_dispx=[TT psd_dispx];


setappdata(0,'psd_synthesis_velox',psd_synthesis_velox); 
setappdata(0,'psd_synthesis_dispx',psd_synthesis_dispx); 


ng=length(TT);
out1=sprintf('\n %d points \n',ng);
disp(out1);

%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                      
%


figure(fig_num);
fig_num=fig_num+1;
plot(TT,psd_velox);

if(iunit==1)
    unit='ft/sec';
    vlabel='Velocity (ft/sec)';
    vpsdlabel='Velocity ((ft/sec)^2/Hz)';
    at = sprintf(' Power Spectral Density  Overall Level = %6.3g ft/sec rms ',rms);     
end
if(iunit==2)
    unit='in/sec';
    vlabel='Velocity (in/sec)';  
    vpsdlabel='Velocity ((in/sec)^2/Hz)';  
    at = sprintf(' Power Spectral Density  Overall Level = %6.3g in/sec rms ',rms);       
end
if(iunit==3)
    unit='m/sec';
    vlabel='Velocity (m/sec)';    
    vpsdlabel='Velocity ((m/sec)^2/Hz)';       
    at = sprintf(' Power Spectral Density  Overall Level = %6.3g m/sec rms ',rms);       
end


xlabel('Time (sec)');
out1=sprintf('Velocity Time History Synthesis  %7.3g %s rms',std(psd_velox),unit);
title(out1);
out_dim_unit=sprintf('Velocity (%s)',unit);
ylabel(out_dim_unit);
grid on;



figure(fig_num);
fig_num=fig_num+1;
plot(TT,psd_dispx);

if(iunit==1)
    unit='ft';
end
if(iunit==2)
    unit='in';
end
if(iunit==3)
    unit='m';
end

xlabel('Time (sec)');
out1=sprintf('Displacement Time History Synthesis  %7.3g %s rms',std(psd_dispx),unit);
title(out1);
out_dim_unit=sprintf('Disp (%s)',unit);
ylabel(out_dim_unit);
grid on;


nbar=31;

xx=max(abs(psd_TH));
x=linspace(-xx,xx,nbar);       
figure(fig_num);
fig_num=fig_num+1;
hist(psd_TH,x)
ylabel(' Counts');

xlabel(vlabel);  

title('Velocity Histogram');

size(freq);
size(full);

min(freq);
max(freq);
min(full);
max(full);

freq=fix_size(freq);
full=fix_size(full);

psd_syn=[freq full];

setappdata(0,'psd_syn',psd_syn);

figure(fig_num);
fig_num=fig_num+1;
plot(freq,full,'b',freq_spec,amp_spec,'r',...
           freq_spec,sqrt(2)*amp_spec,'k',freq_spec,amp_spec/sqrt(2),'k');
legend ('Synthesis','Specification','+/- 1.5 dB tol ');
%   
fmin=freq_spec(1);
fmax=max(freq_spec);
ymax=max(full);
%  
xlabel(' Frequency (Hz)');

ylabel(vpsdlabel);   
title(at);
set(gca,'MinorGridLineStyle','none','GridLineStyle',':','XScale','log','YScale','log'); 
grid;
%
tb=sqrt(sqrt(2));
ymax=10^(ceil(+0.1+log10(ymax)));
ymin = min(amp_spec/tb);
ymin=10^(floor(-0.1+log10(ymin)));
%
fmax=10^(ceil(log10(fmax)));
fmin=10^(floor(log10(fmin)));
%
xlim([fmin,fmax]);
ylim([ymin,ymax]);

set(handles.pushbutton_save,'Enable','on');



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


% --- Executes on button press in pushbutton_save.
function pushbutton_save_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

n=get(handles.listbox_metric,'Value');

output_array=get(handles.edit_output_array,'String');


if(n==1)
    data=getappdata(0,'psd_synthesis_velox'); 
end
if(n==2)
    data=getappdata(0,'psd_synthesis_dispx');    
end
if(n==3)
    data=getappdata(0,'psd_syn');    
end

output_array=get(handles.edit_output_array,'String');
assignin('base', output_array, data);

h = msgbox('Save Complete'); 




% --- Executes on selection change in listbox_metric.
function listbox_metric_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_metric (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_metric contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_metric


% --- Executes during object creation, after setting all properties.
function listbox_metric_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_metric (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_numrows.
function listbox_numrows_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_numrows (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_numrows contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_numrows


% --- Executes during object creation, after setting all properties.
function listbox_numrows_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_numrows (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
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
set(handles.pushbutton_calculate,'Enable','off');

clear_table(hObject, eventdata, handles);

set(handles.uitable_advise,'Visible','off');

n=get(hObject,'Value');

set(handles.pushbutton_view_options,'Enable','on');


set(handles.edit_output_array,'Enable','off');


set(handles.pushbutton_save,'Enable','off');

set(handles.edit_input_array,'String',' ');

set(handles.text_input_array_name,'Visible','on');
set(handles.edit_input_array,'Visible','on');

if(n==1)
   set(handles.edit_input_array,'enable','on') 
else
   set(handles.edit_input_array,'enable','off')
   set(handles.text_input_array_name,'Visible','off');
   set(handles.edit_input_array,'Visible','off');   
   
   [filename, pathname] = uigetfile('*.*');
   filename = fullfile(pathname, filename);
   fid = fopen(filename,'r');
   THM = fscanf(fid,'%g %g',[2 inf]);
   THM=THM';
    
   setappdata(0,'THM',THM);
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


% --- Executes on selection change in listbox_units.
function listbox_units_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_units (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_units contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_units


% --- Executes during object creation, after setting all properties.
function listbox_units_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_units (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on key press with focus on edit_duration and none of its controls.
function edit_duration_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_duration (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)

clear_table(hObject, eventdata, handles);

function clear_table(hObject, eventdata, handles)
%
set(handles.listbox_numrows,'Enable','off');
set(handles.uitable_advise,'Visible','off');
set(handles.listbox_numrows,'Visible','off')
set(handles.text_select_processing_option,'Visible','off');


% --- Executes during object creation, after setting all properties.
function pushbutton_calculate_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on key press with focus on edit_input_array and none of its controls.
function edit_input_array_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_input_array (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
clear_table(hObject, eventdata, handles);

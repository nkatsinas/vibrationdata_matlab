function varargout = vibrationdata_iso_generic(varargin)
% VIBRATIONDATA_ISO_GENERIC MATLAB code for vibrationdata_iso_generic.fig
%      VIBRATIONDATA_ISO_GENERIC, by itself, creates a new VIBRATIONDATA_ISO_GENERIC or raises the existing
%      singleton*.
%
%      H = VIBRATIONDATA_ISO_GENERIC returns the handle to a new VIBRATIONDATA_ISO_GENERIC or the handle to
%      the existing singleton*.
%
%      VIBRATIONDATA_ISO_GENERIC('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in VIBRATIONDATA_ISO_GENERIC.M with the given input arguments.
%
%      VIBRATIONDATA_ISO_GENERIC('Property','Value',...) creates a new VIBRATIONDATA_ISO_GENERIC or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before vibrationdata_iso_generic_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to vibrationdata_iso_generic_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help vibrationdata_iso_generic

% Last Modified by GUIDE v2.5 29-May-2013 10:08:52

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @vibrationdata_iso_generic_OpeningFcn, ...
                   'gui_OutputFcn',  @vibrationdata_iso_generic_OutputFcn, ...
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


% --- Executes just before vibrationdata_iso_generic is made visible.
function vibrationdata_iso_generic_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to vibrationdata_iso_generic (see VARARGIN)

% Choose default command line output for vibrationdata_iso_generic
handles.output = hObject;

set(handles.listbox_dimension,'Value',1);

set(handles.listbox_unit,'Value',1);

set(handles.listbox_method,'Value',1);

set(handles.pushbutton_save,'Enable','off');
set(handles.edit_output_array,'Enable','off');
% set(handles.edit_results,'Enable','off');



% Update handles structure
guidata(hObject, handles);

% UIWAIT makes vibrationdata_iso_generic wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = vibrationdata_iso_generic_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton_save.
function pushbutton_save_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

spectral_velocity=getappdata(0,'spectral_velocity'); 

output_name=get(handles.edit_output_array,'String');
assignin('base', output_name, spectral_velocity);

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


% --- Executes on selection change in listbox_method.
function listbox_method_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_method (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_method contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_method
n=get(hObject,'Value');

set(handles.pushbutton_save,'Enable','off');
set(handles.edit_input_array,'String',' ');

set(handles.text_input_array_name,'Visible','on');
set(handles.edit_input_array,'Visible','on');

if(n==1)
   set(handles.edit_input_array,'enable','on') 
else
    
   set(handles.text_input_array_name,'Visible','off');
   set(handles.edit_input_array,'Visible','off');

   set(handles.edit_input_array,'enable','off')
   
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


% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% set(handles.edit_results,'Enable','on');


k=get(handles.listbox_method,'Value');

iu=get(handles.listbox_unit,'Value');
 
if(k==1)
  FS=get(handles.edit_input_array,'String');
  THM=evalin('base',FS);   
else
  THM=getappdata(0,'THM');
end

iat=get(handles.listbox_dimension,'Value');
iau=get(handles.listbox_unit,'Value');

set(handles.pushbutton_save,'Enable','off');
set(handles.edit_output_array,'Enable','off');

t=THM(:,1);
amp=THM(:,2);

n=length(t);
dur=THM(n,1)-THM(1,1);

dt=dur/(n-1);

%%%%%%%%%%%%%%%%%%%

%
disp(' ')
disp(' vc_velox.m   ver 1.0  October 22, 2012 ')
disp(' by Tom Irvine  Email: tomirvine@aol.com ')
disp(' ')
disp(' This program calculates the one-third velocity spectrum ')
disp(' of a time history for comparison with ISO Generic Vibration ');
disp(' Criteria for Vibration-Sensitive Equipment.')
disp(' ')
disp(' The input time history may be either acceleration or velocity. ');
disp(' ');
%
%
fig_num=1;
%
% disp(' ');
% disp(' Enter input amplitude type ');
% disp('  1=acceleration  2=velocity ');
% iat=input(' ');
%
amp=detrend(amp,'linear');
%
if(iat==1)
%    disp(' ');
%    disp(' Enter input acceleration unit ');
%    disp('  1=G  2=m/sec^2 ');
%    iau=input(' ');
    if(iau==1)
        amp=amp*9.81;  % convert to G to m/sec^2   
    end
%
    iband=2;  % highpass filter 
    iphase=1; % refiltering for phase correction
    fl=2;
    fh=2;
    [amp,~,~,~]=...
                Butterworth_filter_function_alt(amp,dt,iband,fl,fh,iphase);
    [amp]=integrate_function(amp,dt);
    amp=detrend(amp,'linear');  
%
else
%    disp(' ');
%    disp(' Enter input velocity unit ');
%    disp('  1=in/sec  2=m/sec ');
%    iau=input(' ');
    if(iau==1)
        amp=amp*0.0254; % convert in/sec to m/sec
    end    
end
%
amp=amp*1.0e+06;  % convert to micro meters/sec
%
THM=[t amp];
%
p_unit=sprintf('micro meters/sec');
x_label=sprintf('Time(sec)');
y_label=sprintf('Velocity(%s)',p_unit);
t_string=sprintf('Time History');
[fig_num]=plot_TH(fig_num,x_label,y_label,t_string,THM);
%
% disp(' ');
% st=input(' Enter starting time (sec) ');
%
% disp(' ');
% te=input(' Enter ending time (sec) ');
%
st=THM(1,1);
te=THM(n,1);
%
j=1;
jfirst=1;
jlast=max(size(THM));
for i=1:max(size(THM))
    if(THM(i,1)<st)
        jfirst=i;
    end
    if(THM(i,1)>te)
        jlast=i;
        break;
    end
end
%
tim=double(THM(jfirst:jlast,1));
amp=double(THM(jfirst:jlast,2));    
%
n = max(size(amp));
%
N=2^(floor(log(n)/log(2)));
%
out4 = sprintf(' time history length = %d ',n);
disp(out4)
disp(' ');
%
mu=mean(amp);
amp=amp-mu;
%
%
    [dt,df,mmm,NW,io]=FFT_advise_limit_vc(tim,amp);
%
    tmi=THM(1,1);
    [mk,freq,time_a,dt,NW]=FFT_time_freq_set(mmm,NW,dt,df,tmi,io);
%
    [store,store_p,freq_p,max_a,max_f]=FFT_core_seg(NW,mmm,mk,freq,amp,io);                               
%
    store=store';
%
    sz=size(store);
    imax=sz(1);
    jmax=sz(2);
    full=zeros(imax,1);
    for i=1:imax
 %
        ms=0;  
        for j=1:jmax
            ms=ms+0.5*store(i,j)^2;
        end
 %
        full(i)=sqrt(ms/jmax);   % rms
    end
%
    full=sqrt(2)*full;  % peak
%
    [fl,fc,fu,imax]=one_third_octave_frequencies();
%
    [sv]=convert_FFT_to_one_third(freq,fl,fu,full);                   
%
    fstart=4;
    fend=80;
    [pf,pv]=trim_frequency_function(fc,sv,fstart,fend);  
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
    figure(fig_num);
    fig_num=fig_num+1;
    fs=[4 8 80]';
    ws=[1600 800 800]';
    of=0.5*ws;
    res=0.5*of;
    th=0.5*res;
    vca=0.5*th;
    vcb=0.5*vca;
    vcc=0.5*vcb;
    vcd=0.5*vcc;
    vce=0.5*vcd;

    
    n=size(pf);

    for i=n:-1:1
        if(pv(i)<1.0e-20)
            pv(i)=[];
            pf(i)=[];
        end
    end  
    
    plot(pf,pv,fs,ws,'k',fs,of,'k',fs,res,'k',fs,th,'k',fs,vca,'k',...
                              fs,vcb,'k',fs,vcc,'k',fs,vcd,'k',fs,vce,'k');
    title('One Third Octave Band Spectral Velocity'); 
    ylabel('Velocity (micro meters/sec)');
    xlabel('Center Frequency (Hz)');
%
    grid on;
    set(gca,'MinorGridLineStyle','none','GridLineStyle','none','XScale',...
                                                     'log','YScale','log');
    fmin=4;
    fmax=80;
%    
    yyy=max(pv);
    if(yyy<1600)
        yyy=1600;
    end
%    
    yss=min(pv);
    if(yss>min(vce))
        yss=min(vce);
    end
%
%%    ymax=10^ceil(log10(max(yyy)));
    ymax=3200;
%%    ymin=10^floor(log10(min(yss)));
    ymin=3.125;
    axis([fmin,fmax,ymin,ymax]);
%
    set(gca,'ytick',[3.125 6.25 12.5 25 50 100 200 400 800 1600 3200])
    set(gca,'YTickLabel',{'3.125';'6.25';'12.5';'25';'50';'100';'200';'400';'800';'1600';'3200'}) 
%
    set(gca,'xtick',[4 5 6.3 8 10 12.5 16 20 25 31.5 40 50 63 80])
    set(gca,'XTickLabel',{'4';'5';'6.3';'8';'10';'12.5';'16';'20';'25';'31.5';'40';'50';'63';'80';})    
%
    text('Position',[81 800],'String','Workshop','color','k','FontWeight','normal','FontSize',9) 
    text('Position',[81 400],'String','Office','color','k','FontWeight','normal','FontSize',9)
    text('Position',[81 200],'String','Residential','color','k','FontWeight','normal','FontSize',9)
    text('Position',[81 100],'String','Theater','color','k','FontWeight','normal','FontSize',9) 
    text('Position',[81 50],'String','VC-A','color','k','FontWeight','normal','FontSize',9) 
    text('Position',[81 25],'String','VC-B','color','k','FontWeight','normal','FontSize',9)
    text('Position',[81 12.5],'String','VC-C','color','k','FontWeight','normal','FontSize',9)     
    text('Position',[81 6.25],'String','VC-D','color','k','FontWeight','normal','FontSize',9) 
    text('Position',[81 3.125],'String','VC-E','color','k','FontWeight','normal','FontSize',9)   
%
    pos = get(gca,'position'); % This is in normalized coordinates 
    pos(3:4)=pos(3:4)*.92; % Shrink the axis by a factor of .92 
    pos(1:2)=pos(1:2)+pos(3:4)*.05; % Center it in the figure window 
    set(gca,'position',pos);
%
    [pf]=fix_size(pf);
    [pv]=fix_size(pv);
%
    spectral_velocity=[pf pv];
%    
    [xmax,ymax]=find_max(spectral_velocity);    
%
    out1=sprintf(' maximum: \n\n %8.5g micro meters/sec \n at %6.2g Hz ',xmax,ymax);
    disp(out1);  

set(handles.edit_results,'String',out1);    


setappdata(0,'spectral_velocity',spectral_velocity);   


set(handles.pushbutton_save,'Enable','on');
set(handles.edit_output_array,'Enable','on');

    
%%%%%%%%%%%%%%%%%%%



% --- Executes on button press in pushbutton_return.
function pushbutton_return_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_return (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
delete(vibrationdata_iso_generic);


% --- Executes on selection change in listbox2.
function listbox2_Callback(hObject, eventdata, handles)
% hObject    handle to listbox2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox2


% --- Executes during object creation, after setting all properties.
function listbox2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_dimension.
function listbox_dimension_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_dimension (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_dimension contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_dimension

n=get(handles.listbox_dimension,'Value');
  
if(n==1)
    string{1}=sprintf('G'); 
    string{2}=sprintf('m/sec^2'); 
else
    string{1}=sprintf('in/sec'); 
    string{2}=sprintf('m/sec'); 
end

set(handles.listbox_unit,'String',string)  


% --- Executes during object creation, after setting all properties.
function listbox_dimension_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_dimension (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


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



function edit_output_Callback(hObject, eventdata, handles)
% hObject    handle to edit_results (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_results as text
%        str2double(get(hObject,'String')) returns contents of edit_results as a double


% --- Executes during object creation, after setting all properties.
function edit_output_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_results (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function varargout = vibrationdata_damped_sine_synth(varargin)
% VIBRATIONDATA_DAMPED_SINE_SYNTH MATLAB code for vibrationdata_damped_sine_synth.fig
%      VIBRATIONDATA_DAMPED_SINE_SYNTH, by itself, creates a new VIBRATIONDATA_DAMPED_SINE_SYNTH or raises the existing
%      singleton*.
%
%      H = VIBRATIONDATA_DAMPED_SINE_SYNTH returns the handle to a new VIBRATIONDATA_DAMPED_SINE_SYNTH or the handle to
%      the existing singleton*.
%
%      VIBRATIONDATA_DAMPED_SINE_SYNTH('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in VIBRATIONDATA_DAMPED_SINE_SYNTH.M with the given input arguments.
%
%      VIBRATIONDATA_DAMPED_SINE_SYNTH('Property','Value',...) creates a new VIBRATIONDATA_DAMPED_SINE_SYNTH or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before vibrationdata_damped_sine_synth_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to vibrationdata_damped_sine_synth_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help vibrationdata_damped_sine_synth

% Last Modified by GUIDE v2.5 16-Mar-2018 11:21:17

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @vibrationdata_damped_sine_synth_OpeningFcn, ...
                   'gui_OutputFcn',  @vibrationdata_damped_sine_synth_OutputFcn, ...
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


% --- Executes just before vibrationdata_damped_sine_synth is made visible.
function vibrationdata_damped_sine_synth_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to vibrationdata_damped_sine_synth (see VARARGIN)

% Choose default command line output for vibrationdata_damped_sine_synth
handles.output = hObject;

set(handles.listbox_units,'Value',1);
set(handles.listbox_method,'Value',1);
set(handles.edit_Q,'String','10');


set(handles.uipanel_sample_rate,'Visible','off');
set(handles.text_suggest_sample_rate,'Visible','off');
set(handles.edit_sample_rate,'Visible','off');
set(handles.uipanel_condition_type,'Visible','off');
set(handles.text_condition_suggestion,'Visible','off');
set(handles.edit_condition,'Visible','off');


set(handles.uipanel_save,'Visible','off');
set(handles.uipanel_export_Nastran,'Visible','off');
set(handles.listbox_output_array,'Visible','off');
set(handles.edit_output_array,'Visible','off');
set(handles.text_output_array,'Visible','off'); 

set(handles.edit_trials_per_frequency,'String','5000');
set(handles.edit_number_of_frequencies,'String','500');

set(handles.edit_Q,'String','10');

set(handles.pushbutton_calculate,'Visible','off');


% Update handles structure
guidata(hObject, handles);

% UIWAIT makes vibrationdata_damped_sine_synth wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = vibrationdata_damped_sine_synth_OutputFcn(hObject, eventdata, handles) 
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

tic;

%%%%%%%%%%%%%%%

Figures = findobj( 'Type', 'Figure' , '-not' , 'Tag' , get( handles.output , 'Tag' ) );
NFigures = length( Figures );

if(NFigures>4)
    NFigures=4;
end
    
for nFigures = 1 : NFigures
  close( Figures( nFigures ) );
end


%%%%%%%%%%%%%%%


h = msgbox('Intermediate Results are written in Command Window');

k=get(handles.listbox_method,'Value');

if(k==1)
  FS=get(handles.edit_input_array,'String');
  srs_spec_input=evalin('base',FS);   
else
  srs_spec_input=getappdata(0,'srs_spec_input');
end

Q=str2num(get(handles.edit_Q,'String'));
damp = (1/(2*Q));
ntrials=str2num(get(handles.edit_trials,'String'));

sr=str2num(get(handles.edit_sample_rate,'String'));
dt=1/sr;

dur=str2num(get(handles.edit_condition,'String'));
nt=round(dur/dt); 

residual=str2num(get(handles.edit_residual,'String'));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

fig_num=1;

tpi=2*pi;

FMAX=400;

octave=(2^(1/12));
%
errlit=1.0e+90;
syn_error = 1.0e+91;  
%

%% disp(' Select units ');
%% disp('  1=English: accel(G), vel(in/sec),  disp(in)  ');
%% disp('  2=metric : accel(G), vel(m/sec),  disp(mm)  '); 
%
iunit=get(handles.listbox_units,'Value');

sz=size(srs_spec_input(:,1));

n=sz(1);

f=srs_spec_input(:,1);
a=srs_spec_input(:,2);

srs_spec=[f a];

ffirst=f(1);
flast=f(n);
last_f=f(n);
last_a=a(n);
%
ffmin=ffirst;
ffmax=flast;
%

slope=zeros(n-1,1);

%
for i=1:(n-1)
    slope(i)=log(a(i+1)/a(i))/log(f(i+1)/f(i));
end

dre=4/f(1);

first=0;

ns=nt;

iamax=ntrials;

ntt=80;  % number of iterations for inner loop

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

disp(' ');
disp('  Interpolating reference. ');
%
rf=zeros(FMAX,1);
ra=zeros(FMAX,1);
%
rf(1)=f(1);
ra(1)=a(1);
%
for i=2:FMAX
%
    rf(i)=rf(i-1)*octave;
%
    if( rf(i) == max(f) )
    break;
    end
    if( rf(i) > max(f) )
        rf(i)=max(f);
        break;
    end
end
last=i;
%
out1=sprintf(' \n last = %ld   flast = %12.4g\n',last,rf(last));
disp(out1);
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
for i=1:last
%
    for j=1:n
%
        if( rf(i) > f(j) && rf(i) <f(j+1))
            ra(i)=a(j)*( (rf(i)/f(j))^slope(j) );
            break;
        end
%
        if( rf(i)==f(j))
            ra(i)=a(j);
            break;
        end
%
        if( rf(i)==f(j+1))   
            ra(i)=a(j+1);
            break;
        end
    end
end
%
rf(last)=last_f;
ra(last)=last_a;
%
out1=sprintf(' \n last=%ld ',last);
disp(out1);
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%

jkj=1;
%
best_amp=zeros(last,1);
best_phase=zeros(last,1);
best_delay=zeros(last,1);
best_dampt=zeros(last,1);
%
freq=rf;
clear omega;
omega=tpi*rf;
%
progressbar;
for ia=1:iamax
    progressbar(ia/iamax);
    iflag=0;
%
% disp('  Calculating damped sine parameters.');
    [amp,phase,delay,dampt,sss,first]=...
    DSS_sintime(ns,dt,dur,tpi,ia,iamax,ra,omega,last,syn_error,...
                          best_amp,best_phase,best_delay,best_dampt,first);
%
%disp('  Synthesizing initial time history. ');
    [sum,sym]=DSS_th_syn(ns,amp,sss,last);
%
    [xmin,xmax]=DSS_srs(FMAX,last,ns,freq,damp,dt,sum);
%
    for ijk=1:ntt
%
        for i=1:last
            xx = (xmax(i) + abs(xmin(i)))/2.; 
            if(xx <1.0e-90)
                iflag=1;
            end
            amp(i)=amp(i)*((ra(i)/xx)^0.25);
        end
 %   
        if(iflag==1)
            disp(' ref 1 ');
            break;
        end
%
        [sym,sum]=DSS_scale_th(ns,last,sum,amp,sss);
%
        nk=round(0.9*ns);
        LLL=ns-nk;
        for i=nk:ns
            x=(i-nk);
            sum(i)=sum(i)*(1-(x/LLL));
        end
%
        fper=3;
        fper=fper/100;
%
%        n=length(y);
        n=ns;
%
        na=round(fper*n);
        nb=n-na;
        delta=n-nb;
%
        for i=1:na
            arg=pi*(( (i-1)/(na-1) )+1); 
            sum(i)=sum(i)*0.5*(1+(cos(arg)));
        end
%
        [xmin,xmax]=DSS_srs(FMAX,last,ns,freq,damp,dt,sum);
%
        [syn_error,iflag]=DSS_srs_error(last,xmax,xmin,ra,iflag);
%
        if(iflag==1)
            disp(' ref 2 ');
            break;
        end
%
        sym= 20*log10(abs(max(sum)/min(sum)));
        sym=abs(sym);
        if( (syn_error < errlit) && (sym < 2.5) || ia==1)
%
            iacase =ia;
            icase = ijk;
%
            errlit = syn_error;
%
            out1=sprintf(' \n %ld %ld  best= %12.4g  sym= %12.4g',ia,...
                                                        ijk,syn_error,sym);
            disp(out1)
            for k=1:last
                best_amp(k)=amp(k);
                best_phase(k)=phase(k);
                best_dampt(k)= dampt(k);
                best_delay(k)=delay(k);
            end
            store=sum;
%
        end
%
        out1=sprintf(' %ld %ld  error= %12.4g   best= %12.4g  ',ia,ijk,...
                                                         syn_error,errlit);
        disp(out1);
%
        if(ijk>8 && syn_error > error_before)  
            break;
        end
        if(ijk>8 && sym>3.0)  
            break;
        end   
        if(ijk>1 && syn_error > 1.0e+90)
            break;
        end
%
        error_before=syn_error;
    end
    disp(' ');
%
    if(jkj==1)
        jkj=2;
    else
        jkj=1;
    end
end
pause(0.5);
progressbar(1); 
%
out1=sprintf(' \n\n Best case is %ld %ld ',iacase,icase);
disp(out1);
%
store;
%
[xmin,xmax]=DSS_srs(FMAX,last,ns,freq,damp,dt,store);
%
freq=fix_size(freq);
xmin=fix_size(xmin);
xmax=fix_size(xmax);
%
sz=size(xmax);
nnn=sz(1);

ff=freq(1:nnn);
clear freq;
freq=ff;
%
srs_syn=[freq xmin xmax];
%
clear tr;
clear store_recon;
%
tr=linspace(0,(ns-1)*dt,ns);
store_recon=store;
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%

nt=str2num(get(handles.edit_trials_per_frequency,'String'));
nfr=str2num(get(handles.edit_number_of_frequencies,'String'));


[acceleration,velocity,displacement,srs_syn,wavelet_table]=...
    vibrationdata_DSS_waveform_reconstruction(tr,store_recon,dt,first,...
                                       freq,ffmin,ffmax,damp,iunit,nt,nfr);
%



[acceleration]=add_pre_post_shock(acceleration(:,2),residual,dt);
[velocity]    =add_pre_post_shock(velocity(:,2),residual,dt);
[displacement]=add_pre_post_shock(displacement(:,2),residual,dt);

toc
%
[fig_num]=...
plot_avd_srs_damped_sine(acceleration,velocity,displacement,srs_syn,...
                                              srs_spec,damp,fig_num,iunit);
%
clear shock_response_spectrum;
%
shock_response_spectrum=srs_syn;

%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%

setappdata(0,'displacement',displacement); 
setappdata(0,'velocity',velocity); 
setappdata(0,'acceleration',acceleration); 
setappdata(0,'shock_response_spectrum',shock_response_spectrum); 
setappdata(0,'wavelet_table',wavelet_table);



%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
set(handles.uipanel_save,'Visible','on');
set(handles.uipanel_export_Nastran,'Visible','on');
set(handles.listbox_output_array,'Visible','on');
set(handles.edit_output_array,'Visible','on');
set(handles.text_output_array,'Visible','on'); 



% --- Executes on button press in pushbutton_return.
function pushbutton_return_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_return (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

delete(vibrationdata_damped_sine_synth);


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

set(handles.text_input_array_name,'Visible','on');
set(handles.edit_input_array,'Visible','on');

n=get(hObject,'Value');

if(n==1)
   set(handles.pushbutton_read_data,'Visible','off');     
    
   set(handles.edit_input_array,'enable','on') 
else
   set(handles.pushbutton_read_data,'Visible','off');
   
   set(handles.edit_input_array,'enable','off')
   
   set(handles.text_input_array_name,'Visible','off');
   set(handles.edit_input_array,'Visible','off');   
   
   [filename, pathname] = uigetfile('*.*');
   filename = fullfile(pathname, filename);
   fid = fopen(filename,'r');
   srs_spec_input = fscanf(fid,'%g %g',[2 inf]);
   srs_spec_input=srs_spec_input';
    
   setappdata(0,'srs_spec_input',srs_spec_input);
   
   activate_sample_rate(hObject, eventdata, handles)
   
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


% --- Executes on button press in pushbutton_read_data.
function pushbutton_read_data_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_read_data (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

FS=get(handles.edit_input_array,'String');
srs_spec_input=evalin('base',FS);  

setappdata(0,'srs_spec_input',srs_spec_input);

activate_sample_rate(hObject, eventdata, handles);




function activate_sample_rate(hObject, eventdata, handles)
%

srs_spec_input=getappdata(0,'srs_spec_input');

set(handles.uipanel_sample_rate,'visible','on');
set(handles.text_suggest_sample_rate,'visible','on');
set(handles.edit_sample_rate,'visible','on');

set(handles.uipanel_condition_type,'visible','on');
set(handles.text_condition_suggestion,'visible','on');
set(handles.edit_condition,'visible','on');


   
flast=srs_spec_input(end,1);
sr_suggest=10*flast;
s1=sprintf('(suggest >= %9.6g)',sr_suggest);
set(handles.text_suggest_sample_rate,'String',s1);


srs_spec_input=getappdata(0,'srs_spec_input');

fmin=srs_spec_input(1,1);

T=1/fmin;

s1=sprintf('(suggest >= %g)',2.0*T);

set(handles.text_condition_suggestion,'String',s1); 

ss=sprintf('%9.6g',sr_suggest);
set(handles.edit_sample_rate,'String',ss);


function edit_trials_Callback(hObject, eventdata, handles)
% hObject    handle to edit_trials (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_trials as text
%        str2double(get(hObject,'String')) returns contents of edit_trials as a double


% --- Executes during object creation, after setting all properties.
function edit_trials_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_trials (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_sample_rate_Callback(hObject, eventdata, handles)
% hObject    handle to edit_sample_rate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_sample_rate as text
%        str2double(get(hObject,'String')) returns contents of edit_sample_rate as a double


% --- Executes during object creation, after setting all properties.
function edit_sample_rate_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_sample_rate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_condition_Callback(hObject, eventdata, handles)
% hObject    handle to edit_condition (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_condition as text
%        str2double(get(hObject,'String')) returns contents of edit_condition as a double


% --- Executes during object creation, after setting all properties.
function edit_condition_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_condition (see GCBO)
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

n=get(handles.listbox_output_array,'value');

if(n==1)
    data=getappdata(0,'acceleration');
end
if(n==2)
    data=getappdata(0,'velocity');
end
if(n==3)
    data=getappdata(0,'displacement');
end
if(n==4)
    data=getappdata(0,'shock_response_spectrum');
end
if(n==5)
    data=getappdata(0,'wavelet_table');
end


output_name=get(handles.edit_output_array,'String');
assignin('base', output_name, data);

h = msgbox('Save Complete'); 





% --- Executes on selection change in listbox_output_array.
function listbox_output_array_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_output_array (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_output_array contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_output_array


% --- Executes during object creation, after setting all properties.
function listbox_output_array_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_output_array (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



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



function edit_trials_per_frequency_Callback(hObject, eventdata, handles)
% hObject    handle to edit_trials_per_frequency (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_trials_per_frequency as text
%        str2double(get(hObject,'String')) returns contents of edit_trials_per_frequency as a double


% --- Executes during object creation, after setting all properties.
function edit_trials_per_frequency_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_trials_per_frequency (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_number_of_frequencies_Callback(hObject, eventdata, handles)
% hObject    handle to edit_number_of_frequencies (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_number_of_frequencies as text
%        str2double(get(hObject,'String')) returns contents of edit_number_of_frequencies as a double


% --- Executes during object creation, after setting all properties.
function edit_number_of_frequencies_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_number_of_frequencies (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on key press with focus on edit_condition and none of its controls.
function edit_condition_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_condition (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)

set(handles.pushbutton_calculate,'Visible','on');


% --- Executes on button press in pushbutton_export.
function pushbutton_export_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_export (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

data=getappdata(0,'acceleration');
assignin('base','export_signal_nastran',data);
 
handles.s=Vibrationdata_export_to_Nastran;    
set(handles.s,'Visible','on'); 



function edit_residual_Callback(hObject, eventdata, handles)
% hObject    handle to edit_residual (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_residual as text
%        str2double(get(hObject,'String')) returns contents of edit_residual as a double


% --- Executes during object creation, after setting all properties.
function edit_residual_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_residual (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

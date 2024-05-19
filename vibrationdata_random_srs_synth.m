function varargout = vibrationdata_random_srs_synth(varargin)
% VIBRATIONDATA_RANDOM_SRS_SYNTH MATLAB code for vibrationdata_random_srs_synth.fig
%      VIBRATIONDATA_RANDOM_SRS_SYNTH, by itself, creates a new VIBRATIONDATA_RANDOM_SRS_SYNTH or raises the existing
%      singleton*.
%
%      H = VIBRATIONDATA_RANDOM_SRS_SYNTH returns the handle to a new VIBRATIONDATA_RANDOM_SRS_SYNTH or the handle to
%      the existing singleton*.
%
%      VIBRATIONDATA_RANDOM_SRS_SYNTH('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in VIBRATIONDATA_RANDOM_SRS_SYNTH.M with the given input arguments.
%
%      VIBRATIONDATA_RANDOM_SRS_SYNTH('Property','Value',...) creates a new VIBRATIONDATA_RANDOM_SRS_SYNTH or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before vibrationdata_random_srs_synth_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to vibrationdata_random_srs_synth_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help vibrationdata_random_srs_synth

% Last Modified by GUIDE v2.5 16-Dec-2016 12:13:47

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @vibrationdata_random_srs_synth_OpeningFcn, ...
                   'gui_OutputFcn',  @vibrationdata_random_srs_synth_OutputFcn, ...
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


% --- Executes just before vibrationdata_random_srs_synth is made visible.
function vibrationdata_random_srs_synth_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to vibrationdata_random_srs_synth (see VARARGIN)

% Choose default command line output for vibrationdata_random_srs_synth
handles.output = hObject;

set(handles.pushbutton_plot,'Visible','off');

set(handles.pushbutton_read_data,'Visible','on'); 

set(handles.listbox_method,'Value',1);

set(handles.listbox_units,'Value',1);

set(handles.listbox_output_array,'Value',1);


set(handles.text_condition_suggestion,'String',' ');

set(handles.pushbutton_calculate,'visible','off');

set(handles.uipanel_conditon_type,'visible','off');
set(handles.text_condition_suggestion,'visible','off');
set(handles.edit_duration,'visible','off');

set(handles.uipanel_save,'Visible','off');
set(handles.uipanel_export,'Visible','off'); 

%% set(handles.uipanel_select_condition,'Visible','off'); 
%% set(handles.listbox_condition,'Visible','off'); 
listbox_strategy_Callback(hObject, eventdata, handles);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes vibrationdata_random_srs_synth wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = vibrationdata_random_srs_synth_OutputFcn(hObject, eventdata, handles) 
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

%% h = msgbox('Intermediate Results are written in Command Window');

clear length;
fig_num=1;



fper=str2num(get(handles.edit_taper,'String'));

k=get(handles.listbox_method,'Value');

if(k==1)
  FS=get(handles.edit_input_array,'String');
  srs_spec_input=evalin('base',FS);   
else
  srs_spec_input=getappdata(0,'srs_spec_input');
end

   f=srs_spec_input(:,1);
asrs=srs_spec_input(:,2);

  fr=f;
   r=asrs;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

n=length(f);

flast=f(n);
alast=asrs(n);

%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%%  Calculate slopes between input points
%
%%  Interpolate
%

ioct = 3;

[f,spec]=SRS_specification_interpolation(fr,r,ioct);


if(f(1)<1.0e-10)
      f(1)=[];
   spec(1)=[];
end

f=fix_size(f);
spec=fix_size(spec);

nspec=length(f);
if(f(nspec)< flast);
  
   temp_f=f;
   temp_r=spec;
   
   clear f;
   clear spec;
   
   nspec=nspec+1;
   
   f=[temp_f; flast];
   spec=[temp_r; alast];
    
end


fn=f;


nhh=nspec-1;

s=zeros(nhh,1);
%
for i=1:nhh
    a=(log(spec(i+1))-log(spec(i)));
    b=(log(fn(i+1))-log(fn(i)));
    s(i)=a/b;
    
%%    out1=sprintf(' %d %8.4g %8.4g %8.4g  %8.4g %8.4g  ',i,fn(i),spec(i),a,b,s(i));
%%    disp(out1);
    
end

%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%

damp=str2num(get(handles.edit_damping,'String'));

damp=damp/100;

Q = (1./(2.*damp));

ntrials=str2num(get(handles.edit_ntrials,'String'));
tol=str2num(get(handles.edit_tol,'String'));

iunit=get(handles.listbox_units,'Value');
iu=iunit;

dunit='mm';
vunit='m/sec';
aunit='G';
%
if(iunit==1)
		  dunit='inch';
		  vunit='in/sec';
end
if(iunit==3)
		  aunit='m/sec^2';
end


srmin=10*flast;

ssdd=get(handles.edit_duration,'String');

if(isempty(ssdd))
    warndlg('Enter Duration');
    return; 
else
    dur=str2num(get(handles.edit_duration,'String'));    
end

nt=round(dur*srmin); 

ne=ceil( log(nt)/log(2) );

nt=2^ne;

dt=dur/(nt-1);
sr=1/dt;
ssr=sr;

out1=sprintf('\n dt=%9.4g sec   dur=%8.4f sec \n sr=%9.4g sample/sec  nt=%ld \n',dt,dur,sr,nt);
disp(out1);
%
if(dur < 1.5/f(1))
%
        dur=1.6/f(1);
		out1=sprintf('\n\n Warning: duration is too short.\n\n Duration is reset to %f ',dur);
        disp(out1);
        
        ss=sprintf('%8.4g',dur);
        set(handles.edit_duration,'String',ss);
        
%%%        warndlg(out1,'Warning');
        
%
end
%        
tic
disp(' ');
%
[a1,a2,b1,b2,b3,~,~,~,~,~]=srs_coefficients(f,damp,dt);
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% nt = number of points
%

lpf=max(f);
mu=0;
sigma=max(spec)/4;
res=1;

exponent = 0.5;

m_choice=0;
h_choice=0;

error_max=1.0e+50;
dmax=error_max;

error_b=0;

progressbar;

for i=1:ntrials  % outer loop

    progressbar(i/ntrials);
    
%
%   synthesize white
%

    [y]=simple_white_noise_LPF(mu,sigma,nt,dt,lpf);
   
    
     N=nt;
%
%   srs
%
    [~,xmax,xmin]=simple_srs_engine_function(y,fn,dt,res,a1,a2,b1,b2,b3);

    for j=1:100  % inner loop 

%     scale factor

        ss=zeros(nspec,1);

        for k=1:nspec
            ave = (( abs(xmax(k)) + abs(xmin(k)) )/2.);
            if(j<5)
                ss(k)= ( spec(k)/ave )^exponent;                
            else
                ss(k)= ( spec(k)/ave )^(exponent*(0.98+0.04*rand()));
            end    
        end

%     fft

       [freq,~,~,complex_FFT]=full_FFT_core_c(m_choice,h_choice,y,N,dt);

%     apply scale to fft

        for k=1:length(freq)
            
            scale=0.1;
            
            if( freq(k)<= flast )
            
                for ijk=1:(nspec-1)
                
                    if(freq(k)>=fn(ijk) && freq(k)<=fn(ijk+1))
                    
                        scale=ss(ijk)*(freq(k)/fn(ijk))^s(ijk);
                        
%%                        out1=sprintf(' scale=%8.4g %8.4g  %8.4g  %8.4g  %8.4g  ',scale,ss(ijk),freq(k),fn(ijk),s(ijk));
%%                        disp(out1);
                        
                        break;
                    
                    end
                
                end            
            
            end
            
            complex_FFT(k,2)=scale*complex_FFT(k,2);
            
        end

%     invfft

       yinv = N*ifft(complex_FFT,N,'symmetric');
       
       y=yinv(:,2);
      
%     srs

       [~,xmax,xmin]=simple_srs_engine_function(y,fn,dt,res,a1,a2,b1,b2,b3);

%     error comparison

       [error,irror]=random_srs_error(spec,xmax,xmin);
      
%       determine whether record

        if(irror<error_max)
           
            error_max=irror;
            
            yrec=y;
      
            out1=sprintf(' %d %d  %8.4g  %8.4g  std(y)=%8.4g',i,j,error,irror,max(xmax));
            disp(out1);            
            
        end  
        
        if(j>10 && error_b<error)
            break;
        end
      
        error_b=error;
            
    end
    
%
end  %% end nt loop
%     
pause(0.2);
progressbar(1);


nnn=length(yrec);


t=zeros(nnn,1);

for i=1:nnn
    t(i)=(i-1)*dt;  
end    

[y]=half_cosine_fade_perc(y,fper);

accel=y;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

ffmax=sr/10;

nfr=str2num(get(handles.edit_primary,'String'));
nsec=str2num(get(handles.edit_secondary,'String'));
error_limit=str2num(get(handles.edit_error_limit,'String'));
iter=str2num(get(handles.edit_scale_iter,'String'));


nt=1000;
uewf=1.25;
reference_accel=[t accel];

start_time=t(1);
first=t(1);



[acceleration,velocity,displacement,wavelet_table,wavelet_low,...
                                                 wavelet_up,alpha,beta]=...
  vibrationdata_wavelet_decomposition_engine_q(t,accel,dt,first,...
                                                  ffmax,nt,nfr,start_time);
                                            

wavelet_table_add=wavelet_table;



ta=min([t(1) acceleration(1,1)]);
tb=max([max(t) max(acceleration(:,1))]);

figure(fig_num);
fig_num=fig_num+1;
subplot(2,1,1);
plot(t,accel);
title('Reference');
ylabel('Accel (G)');
grid on;
xlim([ta tb]);

subplot(2,1,2);
plot(acceleration(:,1),acceleration(:,2));
title('Wavelet Decomposition');
xlabel('Time (sec)');
ylabel('Accel (G)');
grid on;
xlim([ta tb]);

decomposition=acceleration;
setappdata(0,'decomposition',decomposition);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

sz=size(wavelet_table);

last_wavelet=sz(1);

f=zeros(last_wavelet,1);
amp=zeros(last_wavelet,1);
NHS=zeros(last_wavelet,1);
td=zeros(last_wavelet,1);
%
%
for i=1:last_wavelet
    f(i)=wavelet_table_add(i,2);
    amp(i)=wavelet_table_add(i,3);
    NHS(i)=wavelet_table_add(i,4); 
    td(i)=wavelet_table_add(i,5);  
end

dur_ref=0;

for i=1:last_wavelet
    d=td(i)+(NHS(i)/2*f(i));
    if(d>dur_ref)
        dur_ref=d;
    end
end
%

if(dur_ref<dur)
    dur=dur_ref;
    disp(' ');
    disp(' Duration increased ');
end

%
dt=1./ssr;
%
nt=ceil(dur/dt);
%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear t;

t=linspace(0,nt*dt,nt+1); 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%

ioct=3;

%% dlimit=str2num(get(handles.edit_dlimit,'String'));

%% if(iu==1)
%%    dlimit=dlimit/386;
%% else
%%    dlimit=dlimit/(9.81*1000);
%% end


dlimit=1.0e+20;

srs_spec=spec;

%%%%  [fn,srs_spec]=SRS_specification_interpolation(fr,r,ioct);

[a1,a2,b1,b2,b3,rd_a1,rd_a2,rd_b1,rd_b2,rd_b3]=...
                                      srs_coefficients(fn,damp,dt);  



%%%

%% dur=str2num(get(handles.edit_duration,'String'));
                                  
[amp,error_i,wavelet_low,wavelet_up,alpha,beta,t]=...
    quake_srs_synth_phase_1(f,dt,damp,amp,NHS,td,last_wavelet,iter,...
                              fn,srs_spec,dlimit,error_limit,iu,uewf,dur);

% f, NHS, & td remain unchanged

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%

[raccel]=generate_time_history_wavelet_table_q(f,amp,NHS,td,t,...
                                        wavelet_low,wavelet_up,alpha,beta);

ta=min([reference_accel(1,1) acceleration(1,1) t(1,1)]);
tb=max([max(reference_accel(:,1)) max(acceleration(:,1)) max(t(:,1))]);

figure(fig_num);
fig_num=fig_num+1;

subplot(3,1,1);
plot(reference_accel(:,1),reference_accel(:,2));
title('Reference');
ylabel('Accel (G)');
set(gca,'XTickLabel',[]);
grid on;
xlim([ta tb]);
 
subplot(3,1,2);
plot(acceleration(:,1),acceleration(:,2));
title('Wavelet Decomposition');
ylabel('Accel (G)');
set(gca,'XTickLabel',[]);
grid on;
xlim([ta tb]);

subplot(3,1,3);
plot(t,raccel);
title('Intermediate');
xlabel('Time (sec)');
ylabel('Accel (G)');
grid on;
xlim([ta tb]);


t=fix_size(t);
raccel=fix_size(raccel);

intermediate=[t raccel];
setappdata(0,'intermediate',intermediate);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
[raccel,ramp,last_wavelet,f,amp,NHS,td,wavelet_low,wavelet_up,alpha,beta]=...
       quake_srs_synth_phase_3(f,dt,amp,NHS,td,t,last_wavelet,...
                srs_spec,dlimit,fn,raccel,a1,a2,b1,b2,b3,nsec,...
                            error_limit,wavelet_low,wavelet_up,alpha,beta);
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%

num=length(fn);     

rxmax=zeros(num,1);
rxmin=zeros(num,1);
                               
for j=1:num
       
        forward=[ b1(j),  b2(j),  b3(j) ];    
        back   =[     1, -a1(j), -a2(j) ];    
%    
        resp=filter(forward,back,raccel);
%
        rxmax(j)=max(resp);
        rxmin(j)=abs(min(resp));
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[dispx,vel,acc]=wavelet_integrate_q(f,ramp,NHS,td,dt,dur,t,...
                                        wavelet_low,wavelet_up,alpha,beta);


f=fix_size(f);
amp=fix_size(amp);
NHS=fix_size(NHS);
td=fix_size(td);

wtable=[f amp NHS td];


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

yrec=acc;
vv=vel;
dd=dispx;



figure(fig_num);
fig_num=fig_num+1;
plot(t,yrec);
grid on;
y_lab=sprintf('Accel (%s)',aunit);
ylabel(y_lab);
xlabel('Time (sec)');
title('Acceleration');


[~,xmax,xmin]=simple_srs_engine_function(yrec,fn,dt,res,a1,a2,b1,b2,b3);


if(iu==1)
    vv=vv*386;
    dd=dd*386;        
end
if(iu==2)
    vv=vv*9.81;
    dd=dd*9.81*1000;    
end
if(iu==3)
    dd=dd*1000;
end

t=fix_size(t);
yy=fix_size(yrec);
vv=fix_size(vv);
dd=fix_size(dd);


acceleration=[t yy];
    velocity=[t vv];
displacement=[t dd];



[fig_num]=...
  plot_avd_time_histories_subplots(acceleration,velocity,displacement,iunit,fig_num);




a_pos=xmax;
a_neg=xmin;
t_string=sprintf('SRS  Damping=%g%%',damp*100);

y_lab=sprintf('Peak Accel (%s)',aunit);

fmin=min(fn);
fmax=max(fn);

srs_spec=[ fr r ];

[fig_num,h]=...
       srs_plot_function_spec_h(fig_num,fn,a_pos,a_neg,t_string,y_lab,fmin,fmax,srs_spec,tol);
   
shock_response_spectrum=[fn a_pos a_neg];   
   
set(handles.pushbutton_plot,'Visible','on');


setappdata(0,'acceleration',acceleration);
setappdata(0,'velocity',velocity);
setappdata(0,'displacement',displacement);
setappdata(0,'shock_response_spectrum',shock_response_spectrum);
setappdata(0,'wtable',wtable);

set(handles.uipanel_save,'Visible','on');

disp(' '); 
toc



% --- Executes on button press in pushbutton_return.
function pushbutton_return_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_return (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
delete(vibrationdata_random_srs_synth);


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


% --- Executes on selection change in listbox_octave_spacing.
function listbox_octave_spacing_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_octave_spacing (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_octave_spacing contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_octave_spacing


% --- Executes during object creation, after setting all properties.
function listbox_octave_spacing_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_octave_spacing (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_damping_Callback(hObject, eventdata, handles)
% hObject    handle to edit_damping (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_damping as text
%        str2double(get(hObject,'String')) returns contents of edit_damping as a double


% --- Executes during object creation, after setting all properties.
function edit_damping_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_damping (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_strategy.
function listbox_strategy_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_strategy (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_strategy contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_strategy




% --- Executes during object creation, after setting all properties.
function listbox_strategy_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_strategy (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



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



function edit5_Callback(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit5 as text
%        str2double(get(hObject,'String')) returns contents of edit5 as a double


% --- Executes during object creation, after setting all properties.
function edit5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
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



function edit_iw_Callback(hObject, eventdata, handles)
% hObject    handle to edit_iw (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_iw as text
%        str2double(get(hObject,'String')) returns contents of edit_iw as a double


% --- Executes during object creation, after setting all properties.
function edit_iw_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_iw (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_ew_Callback(hObject, eventdata, handles)
% hObject    handle to edit_ew (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_ew as text
%        str2double(get(hObject,'String')) returns contents of edit_ew as a double


% --- Executes during object creation, after setting all properties.
function edit_ew_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_ew (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_dw_Callback(hObject, eventdata, handles)
% hObject    handle to edit_dw (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_dw as text
%        str2double(get(hObject,'String')) returns contents of edit_dw as a double


% --- Executes during object creation, after setting all properties.
function edit_dw_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_dw (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_vw_Callback(hObject, eventdata, handles)
% hObject    handle to edit_vw (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_vw as text
%        str2double(get(hObject,'String')) returns contents of edit_vw as a double


% --- Executes during object creation, after setting all properties.
function edit_vw_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_vw (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_aw_Callback(hObject, eventdata, handles)
% hObject    handle to edit_aw (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_aw as text
%        str2double(get(hObject,'String')) returns contents of edit_aw as a double


% --- Executes during object creation, after setting all properties.
function edit_aw_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_aw (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_condition.
function listbox_condition_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_condition (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_condition contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_condition

n=get(handles.listbox_condition,'Value');

if(n==2)
    set(handles.uipanel_conditon_type,'Title','Enter Duration (sec)');
else
    set(handles.uipanel_conditon_type,'Title','Enter Number of Points');    
end

activate_duration(hObject, eventdata, handles);


% --- Executes during object creation, after setting all properties.
function listbox_condition_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_condition (see GCBO)
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


% --- Executes on button press in pushbutton_sample_rate.
function pushbutton_sample_rate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_sample_rate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton_duration.
function pushbutton_duration_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_duration (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton_read_data.
function pushbutton_read_data_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_read_data (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

try

    FS=get(handles.edit_input_array,'String');
    srs_spec_input=evalin('base',FS);  

    setappdata(0,'srs_spec_input',srs_spec_input);

catch
   warndlg('Input array not found'); 
   return; 
end

set(handles.pushbutton_calculate,'visible','on');

activate_duration(hObject, eventdata, handles);



function activate_sample_rate(hObject, eventdata, handles)
%
disp('activate');

try
    srs_spec_input=getappdata(0,'srs_spec_input');
catch
    warndlg('Input SRS not found');
    return;
end       
   
set(handles.uipanel_select_condition,'Visible','on'); 




% --- Executes on key press with focus on edit_duration and none of its controls.
function edit_duration_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_duration (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)

set(handles.pushbutton_calculate,'visible','on');


% --- Executes on key press with focus on edit_sample_rate and none of its controls.
function edit_sample_rate_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_sample_rate (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)

set(handles.uipanel_select_condition,'Visible','on'); 
set(handles.listbox_condition,'Visible','on'); 

activate_duration(hObject, eventdata, handles);

function activate_duration(hObject, eventdata, handles)

set(handles.uipanel_conditon_type,'visible','on');
set(handles.text_condition_suggestion,'visible','on');
set(handles.edit_duration,'visible','on');


srs_spec_input=getappdata(0,'srs_spec_input');

fmin=srs_spec_input(1,1);

T=1/fmin;




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
    data=getappdata(0,'wtabel');
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


% --- Executes on button press in pushbutton_export.
function pushbutton_export_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_export (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

data=getappdata(0,'acceleration');
assignin('base','export_signal_nastran',data);
 
handles.s=Vibrationdata_export_to_Nastran;    
set(handles.s,'Visible','on'); 


% --- Executes on button press in pushbutton_plot.
function pushbutton_plot_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_plot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

fig_num=getappdata(0,'fig_num');
acceleration=getappdata(0,'acceleration');
velocity=getappdata(0,'velocity');
displacement=getappdata(0,'displacement');
iunit=getappdata(0,'iunit');

[fig_num,ha,hv,hd]=plot_avd_time_histories_h(acceleration,velocity,displacement,iunit,fig_num);


%    

f=getappdata(0,'f'); 
fr=getappdata(0,'fr'); 
xmax=getappdata(0,'xmax');    
xmin=getappdata(0,'xmin'); 
aspec=getappdata(0,'aspec'); 
damp=getappdata(0,'damp');    
        
 
[Shock_Response_Spectrum,fig_num]=...
      wavelet_synth_srs_plot_h(f,fr,xmax,xmin,aspec,damp,iunit,fig_num);       



function edit_tol_Callback(hObject, eventdata, handles)
% hObject    handle to edit_tol (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_tol as text
%        str2double(get(hObject,'String')) returns contents of edit_tol as a double


% --- Executes during object creation, after setting all properties.
function edit_tol_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_tol (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_ntrials_Callback(hObject, eventdata, handles)
% hObject    handle to edit_ntrials (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_ntrials as text
%        str2double(get(hObject,'String')) returns contents of edit_ntrials as a double


% --- Executes during object creation, after setting all properties.
function edit_ntrials_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_ntrials (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function pushbutton_calculate_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called



function edit_taper_Callback(hObject, eventdata, handles)
% hObject    handle to edit_taper (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_taper as text
%        str2double(get(hObject,'String')) returns contents of edit_taper as a double


% --- Executes during object creation, after setting all properties.
function edit_taper_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_taper (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_primary_Callback(hObject, eventdata, handles)
% hObject    handle to edit_primary (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_primary as text
%        str2double(get(hObject,'String')) returns contents of edit_primary as a double


% --- Executes during object creation, after setting all properties.
function edit_primary_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_primary (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_secondary_Callback(hObject, eventdata, handles)
% hObject    handle to edit_secondary (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_secondary as text
%        str2double(get(hObject,'String')) returns contents of edit_secondary as a double


% --- Executes during object creation, after setting all properties.
function edit_secondary_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_secondary (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_error_limit_Callback(hObject, eventdata, handles)
% hObject    handle to edit_error_limit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_error_limit as text
%        str2double(get(hObject,'String')) returns contents of edit_error_limit as a double


% --- Executes during object creation, after setting all properties.
function edit_error_limit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_error_limit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_scale_iter_Callback(hObject, eventdata, handles)
% hObject    handle to edit_scale_iter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_scale_iter as text
%        str2double(get(hObject,'String')) returns contents of edit_scale_iter as a double


% --- Executes during object creation, after setting all properties.
function edit_scale_iter_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_scale_iter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

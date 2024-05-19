function varargout = signal_generate(varargin)
% SIGNAL_GENERATE MATLAB code for signal_generate.fig
%      SIGNAL_GENERATE, by itself, creates a new SIGNAL_GENERATE or raises the existing
%      singleton*.
%
%      H = SIGNAL_GENERATE returns the handle to a new SIGNAL_GENERATE or the handle to
%      the existing singleton*.
%
%      SIGNAL_GENERATE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SIGNAL_GENERATE.M with the given input arguments.
%
%      SIGNAL_GENERATE('Property','Value',...) creates a new SIGNAL_GENERATE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before signal_generate_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to signal_generate_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help signal_generate

% Last Modified by GUIDE v2.5 17-Jun-2021 17:31:56

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @signal_generate_OpeningFcn, ...
                   'gui_OutputFcn',  @signal_generate_OutputFcn, ...
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


% --- Executes just before signal_generate is made visible.
function signal_generate_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to signal_generate (see VARARGIN)

% Choose default command line output for signal_generate
handles.output = hObject;

set(handles.pushbutton_sdof,'Visible','off');

set(handles.pushbutton_stats,'Visible','off');

set(handles.listbox_signal,'Value',1);
set(handles.listbox_1,'Value',1);
listbox_signal_Callback(hObject, eventdata, handles);

set(handles.text_s6,'Visible','off');
set(handles.edit6,'Visible','off');

set(handles.text_s7,'Visible','off');
set(handles.listbox_1,'Visible','off');

set(handles.text_s8,'Visible','off');
set(handles.edit8,'Visible','off');

set(handles.text_s9,'Visible','off');
set(handles.edit9,'Visible','off');

set(handles.edit1,'String','');
set(handles.edit2,'String','');
set(handles.edit3,'String','');
set(handles.edit4,'String','');
set(handles.edit5,'String','');
set(handles.edit6,'String','');
set(handles.edit8,'String','');
set(handles.edit9,'String','');

set(handles.edit4,'String','0');

set(handles.edit_output_array,'Enable','off');
set(handles.pushbutton_save,'Enable','off');
set(handles.pushbutton_export,'Enable','off');


set(handles.text_input_array_name,'Visible','off');
set(handles.edit_input_array_name,'Visible','off');
set(handles.text_input_array_name_2,'Visible','off');  


sine_parameters(hObject, eventdata, handles)



% Update handles structure
guidata(hObject, handles);

% UIWAIT makes signal_generate wait for user response (see UIRESUME)
% uiwait(handles.figure1);


function sine_parameters(hObject, eventdata, handles)

set(handles.text_rectify,'Visible','on');
set(handles.listbox_rectify,'Visible','on');

set(handles.edit4,'String','0');
    
set(handles.text_s1,'Visible','on');
set(handles.text_s2,'Visible','on');
set(handles.text_s3,'Visible','on');
set(handles.text_s4,'Visible','on');
set(handles.text_s5,'Visible','on');
    
set(handles.edit1,'Visible','on');
set(handles.edit2,'Visible','on');
set(handles.edit3,'Visible','on');
set(handles.edit4,'Visible','on');
set(handles.edit5,'Visible','on');
    
set(handles.text_s1,'String','Amplitude');
set(handles.text_s2,'String','Duration (sec)');
set(handles.text_s3,'String','Frequency (Hz)');    
set(handles.text_s4,'String','Phase (deg)'); 
set(handles.text_s5,'String','Sample Rate (Hz)');  


% --- Outputs from this function are returned to the command line.
function varargout = signal_generate_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in listbox_signal.
function listbox_signal_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_signal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_signal contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_signal

n=get(handles.listbox_signal,'Value');

set(handles.text_seed,'Visible','off');
set(handles.listbox_seed,'Visible','off');

set(handles.text_rectify,'Visible','off');
set(handles.listbox_rectify,'Visible','off');

set(handles.edit_output_array,'Enable','off');
set(handles.pushbutton_save,'Enable','off');
set(handles.pushbutton_export,'Enable','off');

set(handles.edit3,'Enable','on');

set(handles.text_s1,'Visible','off');
set(handles.text_s2,'Visible','off');
set(handles.text_s3,'Visible','off');
set(handles.text_s4,'Visible','off');
set(handles.text_s5,'Visible','off');
set(handles.text_s6,'Visible','off');
set(handles.text_s7,'Visible','off');
set(handles.text_s8,'Visible','off');

set(handles.listbox_1,'Visible','off');

set(handles.edit1,'Visible','off');
set(handles.edit2,'Visible','off');
set(handles.edit3,'Visible','off');
set(handles.edit4,'Visible','off');
set(handles.edit5,'Visible','off');
set(handles.edit6,'Visible','off');
set(handles.edit8,'Visible','off');
set(handles.edit9,'Visible','off');

set(handles.edit1,'String','');
set(handles.edit2,'String','');
set(handles.edit3,'String','');
set(handles.edit4,'String','');
set(handles.edit5,'String','');
set(handles.edit6,'String','');
set(handles.edit8,'String','');
set(handles.edit9,'String','');



if(n==1) % sine
    
    sine_parameters(hObject, eventdata, handles)
       
end
if(n==2) % cosine
    set(handles.text_s1,'Visible','on');
    set(handles.text_s2,'Visible','on');
    set(handles.text_s3,'Visible','on');
    set(handles.text_s4,'Visible','on');
    
    set(handles.edit1,'Visible','on');
    set(handles.edit2,'Visible','on');
    set(handles.edit3,'Visible','on');
    set(handles.edit4,'Visible','on');   

    set(handles.text_s1,'String','Amplitude');
    set(handles.text_s2,'String','Duration (sec)');
    set(handles.text_s3,'String','Frequency (Hz)');     
    set(handles.text_s4,'String','Sample Rate (Hz)');
      
end
if(n==3) % damped sine
    set(handles.text_s1,'Visible','on');
    set(handles.text_s2,'Visible','on');
    set(handles.text_s3,'Visible','on');
    set(handles.text_s4,'Visible','on');
    set(handles.text_s5,'Visible','on');
    set(handles.text_s6,'Visible','on');
    
    set(handles.edit1,'Visible','on');
    set(handles.edit2,'Visible','on');
    set(handles.edit3,'Visible','on');
    set(handles.edit4,'Visible','on');
    set(handles.edit5,'Visible','on');
    set(handles.edit6,'Visible','on');
    
    set(handles.text_s1,'String','Amplitude');    
    set(handles.text_s2,'String','Delay Time (sec)');
    set(handles.text_s3,'String','End Time (sec)');    
    set(handles.text_s4,'String','Frequency (Hz)');  
    set(handles.text_s5,'String','Damping ratio < 1'); 
    set(handles.text_s6,'String','Sample Rate (Hz)'); 
      
end
if(n==4) % sine sweep
    signal_sine_sweep_a;    
end
if(n==5) % white noise
    
    set(handles.text_seed,'Visible','on');
    set(handles.listbox_seed,'Visible','on');

    set(handles.text_s1,'Visible','on');
    set(handles.text_s2,'Visible','on');
    set(handles.text_s3,'Visible','on');
    set(handles.text_s8,'Visible','on');
    
    set(handles.edit1,'Visible','on');
    set(handles.edit2,'Visible','on');
    set(handles.edit3,'Visible','on');
    set(handles.edit8,'Visible','on');
    
    set(handles.text_s1,'String','Duration (sec)');    
    set(handles.text_s2,'String','Std Dev');
    set(handles.text_s3,'String','Sample Rate (Hz)');     
    set(handles.text_s8,'String','Low Pass Frequency (Hz)');
    
    set(handles.text_s7,'String','Band-limit via filtering?','Visible','on');
    set(handles.listbox_1,'Visible','on'); 
    
    string_box{1}=sprintf('Yes, Low Pass');
    string_box{2}=sprintf('Yes, Band Pass');
    string_box{3}=sprintf('No');    
    
    set(handles.listbox_1,'String',string_box); 
    
    listbox_1_Callback(hObject, eventdata, handles);    
    
end
if(n==6) % pink noise

    set(handles.edit3,'Enable','off');
    
    set(handles.text_s1,'Visible','on');
    set(handles.text_s2,'Visible','on');
    set(handles.text_s3,'Visible','on');
    
    set(handles.edit1,'Visible','on');
    set(handles.edit2,'Visible','on');
    set(handles.edit3,'Visible','on');
    
    set(handles.text_s1,'String','Duration (sec)');    
    set(handles.text_s2,'String','Std Dev');
    set(handles.text_s3,'String','Sample Rate (Hz)');     
    
end
% terminal sawtooth pulse 
% symmetric sawtooth pulse
% half-sine pulse
% versed sine pulse
if((n>=7 && n<=10) || (n==12)) 
    set(handles.text_s1,'Visible','on');
    set(handles.text_s2,'Visible','on');
    set(handles.text_s3,'Visible','on');
    set(handles.text_s4,'Visible','on');
    set(handles.text_s5,'Visible','on');
    
    set(handles.edit1,'Visible','on');
    set(handles.edit2,'Visible','on');
    set(handles.edit3,'Visible','on');
    set(handles.edit4,'Visible','on');
    set(handles.edit5,'Visible','on');
    
    set(handles.text_s1,'String','Amplitude');    
    set(handles.text_s2,'String','Pre-pulse Duration (sec)');
    set(handles.text_s3,'String','Pulse Duration (sec)');       
    set(handles.text_s4,'String','Post-pulse Duration (sec)');
    set(handles.text_s5,'String','Sample Rate (Hz)');   
end
if(n==11) % wavelet

    set(handles.text_s1,'Visible','on');
    set(handles.text_s2,'Visible','on');
    set(handles.text_s3,'Visible','on');
    set(handles.text_s4,'Visible','on');
    set(handles.text_s5,'Visible','on');
    
    set(handles.edit1,'Visible','on');
    set(handles.edit2,'Visible','on');
    set(handles.edit3,'Visible','on');
    set(handles.edit4,'Visible','on');
    set(handles.edit5,'Visible','on');

    set(handles.text_s1,'String','Amplitude'); 
    set(handles.text_s2,'String','Frequency (Hz)');
    set(handles.text_s3,'String','Delay Time (sec)');
    set(handles.text_s4,'String','End Time (sec)');    
    set(handles.text_s5,'String','Sample Rate (Hz)');   
    set(handles.text_s7,'String','Number of Half-Sines'); 
    
    string_box{1}=sprintf('3');
    string_box{2}=sprintf('5');
    string_box{3}=sprintf('7');
    string_box{4}=sprintf('9');
    string_box{5}=sprintf('11');
    string_box{6}=sprintf('13');
    string_box{7}=sprintf('15');
    string_box{8}=sprintf('17');   
    string_box{9}=sprintf('19');   
    string_box{10}=sprintf('21');    
    string_box{11}=sprintf('23');
    string_box{12}=sprintf('25');   
    string_box{13}=sprintf('27');
    string_box{14}=sprintf('29');    
    string_box{15}=sprintf('31');    
    string_box{16}=sprintf('33');    
    string_box{17}=sprintf('35');
    string_box{18}=sprintf('37');
    string_box{19}=sprintf('39');
    string_box{20}=sprintf('41');
    string_box{21}=sprintf('43');    
    string_box{22}=sprintf('45');  
    string_box{23}=sprintf('47');  
    string_box{24}=sprintf('49');       
    string_box{25}=sprintf('51');      
    string_box{26}=sprintf('53');  
    string_box{27}=sprintf('55');       
    string_box{28}=sprintf('57');         
    string_box{29}=sprintf('59');  
    string_box{30}=sprintf('61');       
    string_box{31}=sprintf('63');       
    
    
    
    set(handles.text_s7,'Visible','on');
    set(handles.listbox_1,'Visible','on');     
 
    set(handles.listbox_1,'String',string_box); 
end


if(n==13) % beat frequency
    handles.sbf= signal_beat_frequency; 
    set(handles.sbf,'Visible','on');    
end
if(n==14) % IEEE Sine Beat
    handles.sbf= IEEE_693_Sine_Beat; 
    set(handles.sbf,'Visible','on');    
end


if(n==15) % students t distribution
    handles.sbf= vibrationdata_students_t; 
    set(handles.sbf,'Visible','on');    
end
if(n==16) % random with specified kurtosis
    
    set(handles.text_s1,'Visible','on');
    set(handles.text_s2,'Visible','on');
    set(handles.text_s3,'Visible','on');
    set(handles.text_s6,'Visible','on');
    set(handles.text_s8,'Visible','on');
    
    set(handles.edit1,'Visible','on');
    set(handles.edit2,'Visible','on');
    set(handles.edit3,'Visible','on');
    set(handles.edit6,'Visible','on');
    set(handles.edit8,'Visible','on');    
    
    set(handles.text_s1,'String','Duration (sec)');    
    set(handles.text_s2,'String','Std Dev');
    set(handles.text_s3,'String','Sample Rate (Hz)');     
    set(handles.text_s6,'String','Kurtosis');
    set(handles.text_s8,'String','Low Pass Frequency (Hz)');     
    
    
    set(handles.text_s7,'Visible','on');
    set(handles.listbox_1,'Visible','on','Value',1); 
    
    string_box{1}=sprintf('Yes, Low Pass');
    string_box{2}=sprintf('Yes, Band Pass');
    string_box{3}=sprintf('No');    
    
    set(handles.listbox_1,'String',string_box); 
        
    listbox_1_Callback(hObject, eventdata, handles);    
    
end

 
if(n==17) % random with specified skewness & kurtosis
    handles.sss= random_skew_kurtosis; 
    set(handles.sss,'Visible','on');
end    
 
if(n==18) % add sine tones
    handles.sss= vibrationdata_add_sine_tones; 
    set(handles.sss,'Visible','on');
end 
 
if(n==19) % HALT/HASS simulation
    handles.sss= vibrationdata_PSD_accel_synth_HALT; 
    set(handles.sss,'Visible','on');
end 

if(n==20)  % Sarkani random
    handles.sss= Sarkani_random; 
    set(handles.sss,'Visible','on');   
end
if(n==21) % chirp
    handles.sss= chirp; 
    set(handles.sss,'Visible','on');    
end
if(n==22) % unit impulse
    set(handles.edit1,'Visible','on');
    set(handles.edit2,'Visible','on');    
    
    set(handles.text_s1,'String','Duration (sec)','Visible','on');    
    set(handles.text_s2,'String','Sample Rate (Hz)','Visible','on');    
end
if(n==23) % sine multiple columns
    handles.sss= sine_multiple_columns; 
    set(handles.sss,'Visible','on');    
end
if(n==24) % white noise acceleration, corrected
    handles.sss= white_noise_acceleration_corrected; 
    set(handles.sss,'Visible','on');    
end
if(n==25) % add trailing zeros
    handles.sss=add_trailing_zeros; 
    set(handles.sss,'Visible','on');    
end
if(n==26) % two correlated white noise signals
    handles.sss=two_correlated_white_noise_signals; 
    set(handles.sss,'Visible','on');    
end
if(n==27) % mutliple sine sweeps
    handles.sss=multiple_sine_sweeps; 
    set(handles.sss,'Visible','on');    
end
if(n==28) % series of intermittent half sine pulses
    handles.sss=series_half_sine_pulses; 
    set(handles.sss,'Visible','on');    
end

if(n==29) % add white noise to existing signal
    
    
    set(handles.text_s2,'Visible','on');
    set(handles.edit2,'Visible','on');
    set(handles.edit8,'Visible','on');
    
%    set(handles.text_s1,'String','Duration (sec)');    
    set(handles.text_s2,'String','Std Dev');
%    set(handles.text_s3,'String','Sample Rate (Hz)');     
    set(handles.text_s8,'String','Low Pass Frequency (Hz)');
    
    set(handles.text_s7,'Visible','on');
    set(handles.listbox_1,'Visible','on'); 
    
    string_box{1}=sprintf('Yes, Low Pass');
    string_box{2}=sprintf('Yes, Band Pass');
    string_box{3}=sprintf('No');    
    
    set(handles.listbox_1,'String',string_box); 
    
    
    
    listbox_1_Callback(hObject, eventdata, handles);        
    
    
    set(handles.text_input_array_name,'Visible','on');
    set(handles.edit_input_array_name,'Visible','on');
    set(handles.text_input_array_name_2,'Visible','on');
else   
    set(handles.text_input_array_name,'Visible','off');
    set(handles.edit_input_array_name,'Visible','off');
    set(handles.text_input_array_name_2,'Visible','off');    
end


% --- Executes during object creation, after setting all properties.
function listbox_signal_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_signal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit3_Callback(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double


% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit4_Callback(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit4 as text
%        str2double(get(hObject,'String')) returns contents of edit4 as a double


% --- Executes during object creation, after setting all properties.
function edit4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
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



function edit6_Callback(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit6 as text
%        str2double(get(hObject,'String')) returns contents of edit6 as a double


% --- Executes during object creation, after setting all properties.
function edit6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

set(handles.pushbutton_sdof,'Visible','off');

try

    Figures = findobj( 'Type', 'Figure' , '-not' , 'Tag' , get( handles.output , 'Tag' ) );
    NFigures = length( Figures );
    for nFigures = 1 : NFigures
        close( Figures( nFigures ) );
    end
catch
end    


pflag=0;

TT=0;   % need initializations
a=0;

n=get(handles.listbox_signal,'Value');

histogram_status=0;

ylab=get(handles.edit_ylabel,'String');



if(n==1) % sine
    
    irec=get(handles.listbox_rectify,'Value');
    
      amp=str2num(get(handles.edit1,'String'));
     tmax=str2num(get(handles.edit2,'String'));
     freq=str2num(get(handles.edit3,'String'));
    phase=str2num(get(handles.edit4,'String'));
       sr=str2num(get(handles.edit5,'String')); 
       
    dt=1./sr;
    disp(' ')
    omega=2.*pi*freq;
    phase=phase*pi/180.;
%    
    if(freq>(sr/20))
       sr=freq*20;
       dt=1/sr;
       msgbox('Note: sample rate increased ','Warning','warn');
       out1=sprintf('%8.4g',sr);
       set(handles.edit5,'String',out1);
    end    
    np=ceil(tmax/dt);
    TT=linspace(0,np*dt,(np+1));
    a=amp*sin(omega*TT+phase);
    
    if(irec==2)
        a=abs(a);
    end
    
    tstring='Sine Time History';
    pflag=1;
end
if(n==2) % cosine
      amp=str2num(get(handles.edit1,'String'));
     tmax=str2num(get(handles.edit2,'String'));
     freq=str2num(get(handles.edit3,'String'));
       sr=str2num(get(handles.edit4,'String'));
       
    dt=1./sr;
    disp(' ')
    omega=2.*pi*freq;
%    
    if(freq>(sr/20))
       sr=freq*20;
       dt=1/sr;
       msgbox('Note: sample rate increased ','Warning','warn');
       out1=sprintf('%8.4g',sr);
       set(handles.edit4,'String',out1);
    end    
    np=round(tmax/dt);
    TT=linspace(0,np*dt,(np+1)); 
    a=amp*cos(omega*TT);
    tstring='Cosine Time History';
    pflag=1;
end

if(n==3) % damped sine

     amp=str2num(get(handles.edit1,'String'));    
      td=str2num(get(handles.edit2,'String'));     
      t2=str2num(get(handles.edit3,'String'));  
    freq=str2num(get(handles.edit4,'String'));     
    damp=str2num(get(handles.edit5,'String'));   
      sr=str2num(get(handles.edit6,'String'));
    
    omega=2.*pi*freq;
    omegan=omega;
%
    omegad=omegan*sqrt(1-damp^2);
    dt=1./sr;
%
    if(freq>(sr/20))
       sr=freq*20;
       dt=1/sr;
       msgbox('Note: sample rate increased ','Warning','warn');
       out1=sprintf('%8.4g',sr);
       set(handles.edit6,'String',out1);
   end
%
    t1=0;
    np=fix((t2-t1)/dt);
    TT=linspace(0,(np-1)*dt,np); 
    TT=TT+t1;  
%
    td=td+t1;
    for i=1:length(TT)
        if(TT(i)>td)
            a(i)=amp*sin(omegad*(TT(i)-td));
            arg=-omegan*damp*(TT(i)-td);
            a(i)=a(i)*exp(arg);
        else
            a(i)=0;
        end
    end
    tstring='Damped Sine Time History'; 
    pflag=1;
end

if(n==5) % white noise

    ns=get(handles.listbox_seed,'Value');
    
    if(ns==1)
        rng(1);
    end
    
    histogram_status=99;
    
    m=get(handles.listbox_1,'Value');
     
    tmax=str2num(get(handles.edit1,'String'));    
    sigma=str2num(get(handles.edit2,'String'));     
    sr=str2num(get(handles.edit3,'String'));
     
    dt=1./sr;   
    np=ceil(tmax/dt);
    TT=linspace(0,(np-1)*dt,np); 
  
%%%    [a] = normrnd_function(sigma,np);

    clear length;
    np=length(TT);
    
    [a]=simple_white_noise(0,sigma,np);
    
%
    if(m==1)
%
%    iband:   1=lowpass  2=highpass  3=bandpass 
%
%    iphase=1  for refiltering for phase correction
%          =2  for no refiltering
%
      try 
        iband=1;
        fl=str2num(get(handles.edit8,'String'));
        if(fl>sr/2.)
          fl=0.49*sr;
          msgbox('Note: lowpass filter frequency decreased ','Warning','warn');
          out1=sprintf('%8.4g',fl);
          set(handles.edit8,'String',out1);         
        end
        fh=0;
      catch
          warndlg('Enter filter frequency');
          return;
      end
%
    end
%      
    if(m==2)
        
      try  
        iband=3;
        fh=str2num(get(handles.edit8,'String'));
        if(fh>sr/2.)
          fh=0.49*sr;
          msgbox('Note: lower frequency decreased ','Warning','warn');
          out1=sprintf('%8.4g',fh);
          set(handles.edit8,'String',out1);         
        end

        fl=str2num(get(handles.edit9,'String'));
        if(fl>sr/2.)
          fl=0.49*sr;
          msgbox('Note: upper frequency decreased ','Warning','warn');
          out1=sprintf('%8.4g',fl);
          set(handles.edit9,'String',out1);         
        end
      catch
          warndlg('Enter filter frequency');
          return;          
      end
      
      
    end
    
    if(m<=2)
        
      try  
        tstring='Band-limited White Noise';
        iphase=2;     
        [a,~,~,~]=Butterworth_filter_function_alt(a,dt,iband,fl,fh,iphase);      
      catch
        warndlg('Filter failed.  Check filter frequency.');
        return;        
      end
        
%    scale for the std deviation
%
      ave=mean(a);
      stddev=std(a);
      sss=sigma/stddev;
%    
      a=(a-ave)*sss;        
        
    end    
    
    if(m==3)
       tstring='White Noise';
    end     
    pflag=1;
%    
end

if(n==6)  % pink noise
    
    histogram_status=1;
    
    m=get(handles.listbox_1,'Value');
     
    set(handles.edit3,'String','96000');     
    
    tmax=str2num(get(handles.edit1,'String'));    
    sigma=str2num(get(handles.edit2,'String'));     
    sr=str2num(get(handles.edit3,'String'));
 
    dt=1./sr;   
    np=ceil(tmax/dt);
    TT=linspace(0,(np-1)*dt,np); 
  
%%%    [a] = normrnd_function(sigma,np);

    clear length;
    np=length(TT);
    a=randn(np,1);
%
    Fs=sr;
%
    num=2^(ceil(log(np)/log(2)));
%
    t=dt+linspace(0,(num-1)*dt,num);
%
%  generate white noise time history
%
%%%    [white] = white_basic(dt,num);
%
    white=randn(num,1);    
%
    white_FFT=fft(white);
%
    epi=8*pi;
    tpi=2*pi;
%
    df=1/(num*dt);
%
    nh=num/2;
%
    H=zeros(nh,1);
%
    disp(' transfer function ');
    disp(' ');
%
    for i=1:nh
        s=(1i)*(i-1)*tpi*df;   
        H(i)=3/sqrt(s+epi);
    end
%
    nf=nh;
    frf=zeros(2*nf,1);
    frf(1:nf)=H(1:nf);
%
    for i=1:nf
        frf(i+nf)=(i+nf)*df;
    end
%
    aa=H;
    bb= flipud(aa);
%
    for i=1:nf
        frf(i+nf)=real(bb(i))-(1i)*imag(bb(i));
    end
%
    nf=2*nf;
    frf_amp=flipud(frf);
%
    A=zeros(num,1);
    for i=1:num
        A(i)=frf_amp(i)*white_FFT(i);
    end
%
    disp(' inverse FFT ');
    disp(' ');
%
    pink=real(ifft(A,num,'symmetric'));   
%
    PP=pink(1:np);
    TT=t(1:np);
    TT=fix_size(TT);
    PP=fix_size(PP);
%
    iphase=2;
    f=24e+03;
%
    disp(' Lowpass filter ');
    disp(' ');
    [PP]=Butterworth_LPF(PP,dt,f,iphase);
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  fade in & out
%
    np=length(PP);
    na=floor(0.5/dt);
    nb=np-na;
    delta=np-nb;
%
    for i=1:na
        arg=pi*(( (i-1)/(na-1) )+1); 
        PP(i)=PP(i)*0.5*(1+(cos(arg)));
    end
%
    for i=nb:np
        arg=pi*( (i-nb)/delta );
        PP(i)=PP(i)*(1+cos(arg))*0.5;
    end
%
    MP=max(PP);
    PP=floor((32768/4)*(PP/MP));
%
    disp(' ');
    disp(' Output array:');
    disp(' pink_time_history');
    pink_time_history=[TT PP];     
%
    tstring='Pink Noise';
    pflag=1;
    a=PP;
%    
    a=fix_size(a);
%
    a=a-mean(a);
    a=a*sigma/std(a);    
%    
end
if(n==7) % terminal sawtooth pulse
    amp = str2num(get(handles.edit1,'String'));
    t1=str2num(get(handles.edit2,'String'));
    t2=str2num(get(handles.edit3,'String'));
    t3=str2num(get(handles.edit4,'String'));    
    sr = str2num(get(handles.edit5,'String'));
    dt=1./sr;    
%
    t12=t1+t2;   
    t2half=t2/2;
    t12h=t1+t2half;
%   
    tmax=t1+t2+t3;
    np=round(tmax/dt);
    TT=linspace(0,np*dt,(np+1)); 
    a = zeros(1,(np+1));   
    for i=1:np
        t=TT(i);
        if(t>=t1 && t<=t12)
            a(i) = (t-t1)/t2;
        end
        if(t>=t12)
            break;
        end
    end
    a=a*amp;  
    tstring='Terminal Sawtooth Pulse';
    pflag=1;
end

if(n==8) % symmetric sawtooth pulse
    amp = str2num(get(handles.edit1,'String'));
    t1=str2num(get(handles.edit2,'String'));
    t2=str2num(get(handles.edit3,'String'));
    t3=str2num(get(handles.edit4,'String'));    
    sr = str2num(get(handles.edit5,'String'));
    dt=1./sr;    
%

%
    tstring='Symmetric Sawtooth Pulse';
    pflag=1;
end
if(n==9) % half-sine pulse

%
    tmax=t1+t2+t3;
    np=round(tmax/dt);
    TT=linspace(0,np*dt,(np+1)); 
    a = zeros(1,(np+1));   
    for i=1:np
        t=TT(i);
        if(t>=t1 && t<=t12)
            a(i) = sin(pi*(t-t1)/t2);
        end
        if(t>=t12)
            break;
        end
    end
    a=a*amp;    
%    
    tstring='Half-Sine Pulse';
    pflag=1;
end
if(n==10) % versed sine pulse
    amp = str2num(get(handles.edit1,'String'));
    t1=str2num(get(handles.edit2,'String'));
    t2=str2num(get(handles.edit3,'String'));
    t3=str2num(get(handles.edit4,'String'));    
    sr = str2num(get(handles.edit5,'String'));
    dt=1./sr;    
    t12=t1+t2;
%
    tmax=t1+t2+t3;
    np=round(tmax/dt);
    TT=linspace(0,np*dt,(np+1)); 
    a = zeros(1,(np+1));   
    for i=1:np
        t=TT(i);
        if(t>=t1 && t<=t12)
            a(i) = 1-cos(2*pi*(t-t1)/t2);
        end
        if(t>=t12)
            break;
        end
    end
%%
    a=a*amp/2;    
%    
    tstring='Versed Sine Pulse';
    pflag=1;
end
if(n==11) % wavelet
%
    amp=str2num(get(handles.edit1,'String'));    
    freq=str2num(get(handles.edit2,'String'));     
    td=str2num(get(handles.edit3,'String'));  
    t2=str2num(get(handles.edit4,'String'));        
    sr=str2num(get(handles.edit5,'String'));
    dt=1./sr;
%
    omega=2.*pi*freq;
    omegan=omega;
%
    if(freq>(sr/20))
       sr=freq*20;
       dt=1/sr;
       msgbox('Note: sample rate increased ','Warning','warn');
       out1=sprintf('%8.4g',sr);
       set(handles.edit4,'String',out1);
    end   
%
    m=get(handles.listbox_1,'Value');
    N=2*m+1;
    tmax=N/(2*freq)+td;
    if(tmax>t2)
        t2=dt+tmax;
    end
    t1=0;
    np=ceil((t2-t1)/dt);
    TT=linspace(0,np*dt,(np+1)); 
    TT=TT+t1;   
    beta= (2*pi*freq);
    alpha= beta/N;    
%
    np=max(size(TT));
    for(i=1:np)
        t=TT(i);
        a(i)=0.;
        v(i)=0.;
        d(i)=0.;
        if(t>=td && t<= tmax)
            a(i) = sin(pi*t/tmax);
            apb=alpha+beta;
            amb=alpha-beta;
            ttd=t-td;
%            
            at=alpha*(ttd);
            bt= beta*(ttd);
%
            a(i)= sin(at)*sin(bt);
            v(i)=-(sin(apb*ttd)/apb) + (sin(amb*ttd)/amb);
            d(i)=+((cos(apb*ttd)-1)/apb^2)-((cos(amb*ttd)-1)/amb^2);
        end
    end
    a= a*amp;
    v= v*amp/2;
    d= d*amp/2;    
%
    tstring='Wavelet';
    pflag=1;
end
if(n==12) % rectangular pulse
    amp = str2num(get(handles.edit1,'String'));
    t1=str2num(get(handles.edit2,'String'));
    t2=str2num(get(handles.edit3,'String'));
    t3=str2num(get(handles.edit4,'String'));    
    sr = str2num(get(handles.edit5,'String'));
    dt=1./sr;    
%
    t12=t1+t2;
%
    ttt=t1+t2+t3;
    nnn=round(ttt*sr);
%
    a=zeros(nnn,1);
    TT=zeros(nnn,1);
 %   
    for i=1:nnn
        t=(i-1)*dt;
        TT(i)=t;
        if(t>=t1 && t<=t12)
            a(i)=amp;
        end
    end
%
    tstring='Rectangular Pulse';
    pflag=1;
end


TT=fix_size(TT);
a=fix_size(a);


if(n==16) % random with specified kurtosis
    
    histogram_status=1;
    
    m=get(handles.listbox_1,'Value');
     
    tmax=str2num(get(handles.edit1,'String'));    
    sigma=str2num(get(handles.edit2,'String'));     
    sr=str2num(get(handles.edit3,'String'));
    kkt=str2num(get(handles.edit6,'String'));
     
    dt=1./sr;   
    np=ceil(tmax/dt);
    TT=linspace(0,(np-1)*dt,np); 
  
%%%    [a] = normrnd_function(sigma,np);

    clear length;
    np=length(TT);
    a=randn(np,1);
%
    a=fix_size(a);
%
    a=a-mean(a);
%    scale for the std deviation
%%
%
    if(m==1)
%
%    iband:   1=lowpass  2=highpass  3=bandpass 
%
%    iphase=1  for refiltering for phase correction
%          =2  for no refiltering
%
      iband=1;
      fl=str2num(get(handles.edit8,'String'));
      if(fl>sr/2.)
          fl=0.49*sr;
          msgbox('Note: lowpass filter frequency decreased ','Warning','warn');
          out1=sprintf('%8.4g',fl);
          set(handles.edit5,'String',out1);         
      end
      fh=0;
      iphase=2;
      [a,~,~,~]=Butterworth_filter_function_alt(a,dt,iband,fl,fh,iphase);
      
    end    
%     
    ex = 0.842*(kkt-1.36)^0.378;
%
    num=np;
%
    c=zeros(num,1);
%
    for i=1:num
        c(i)=sign(a(i))*(abs(a(i))^ex);
    end
%   
    c=c*sigma/std(a);
%
%    scale for the std deviation
%
    ave=mean(c);
    stddev=std(c);
    sss=sigma/stddev;
%    
    c=(c-ave)*sss; 
%
    mu=mean(c);
    sd=std(c);
    kts=0.;
%
    for i=1:num
        kts=kts+(c(i)-mu)^4;
    end      
    kt=kts/(num*sd^4);   
%
    a=c;
    %
%
%%
    tstring=sprintf('Random with kurtosis=%6.3g',kt);
    pflag=1;
%    
end

if(n==17) % random with specified skewness & kurtosis
    handles.sss= random_skew_kurtosis; 
    set(handles.sss,'Visible','on');
end    

if(n==18) % add sine tones
    handles.sss= vibrationdata_add_sine_tones; 
    set(handles.sss,'Visible','on');
end 

if(n==19) % HALT/HASS simulation
    handles.sss= vibrationdata_PSD_accel_synth_HALT; 
    set(handles.sss,'Visible','on');
end 
if(n==20)  % Sarkani random
    handles.sss= Sarkani_random; 
    set(handles.sss,'Visible','on');   
end    
if(n==21) % chirp
    handles.sss= chirp; 
    set(handles.sss,'Visible','on');    
end
if(n==22) % unit impulse
    dur=str2num(get(handles.edit1,'String'));     
    sr=str2num(get(handles.edit2,'String'));
    dt=1./sr;   
    
    np=floor(dur/dt);
    
    TT=linspace(0,np*dt,(np+1)); 
    a = zeros(1,(np+1));
    
    a(2)=1/dt;

    tstring='Unit Impulse, Area=1';
    pflag=1;    
    
end
if(n==20)  % Sarkani random
    handles.sss= Sarkani_random; 
    set(handles.sss,'Visible','on');   
end
if(n==21) % chirp
    handles.sss= chirp; 
    set(handles.sss,'Visible','on');    
end
if(n==22) % unit impulse
    set(handles.edit1,'Visible','on');
    set(handles.edit2,'Visible','on');    
    
    set(handles.text_s1,'String','Duration (sec)','Visible','on');    
    set(handles.text_s2,'String','Sample Rate (Hz)','Visible','on');    
end
if(n==23) % sine multiple columns
    handles.sss= sine_multiple_columns; 
    set(handles.sss,'Visible','on');    
end
if(n==24) % white noise acceleration, corrected
    handles.sss= white_noise_acceleration_corrected; 
    set(handles.sss,'Visible','on');    
end
if(n==25) % add trailing zeros
    handles.sss=add_trailing_zeros; 
    set(handles.sss,'Visible','on');    
end
if(n==26) % two correlated white noise signals
    handles.sss=two_correlated_white_noise_signals; 
    set(handles.sss,'Visible','on');    
end
if(n==27) % mutliple sine sweeps
    handles.sss=multiple_sine_sweeps; 
    set(handles.sss,'Visible','on');    
end
if(n==28) % series of intermittent half sine pulses
    handles.sss=series_half_sine_pulses; 
    set(handles.sss,'Visible','on');    
end
if(n<=28)

    disp(' ');
    disp(' * * * * * * ');
    disp(' ');
    
    fig_num=1;

    if(pflag==1)
        clear length;
        num_a=length(a);  
    
        a=fix_size(a);
        TT=fix_size(TT);
    
        figure(fig_num);
        fig_num=fig_num+1;
        plot(TT(1:num_a),a);
        title(tstring);
        grid on;
        xlabel('Time (sec)');
        ylabel(ylab);

        signal=[TT(1:num_a) a];
        setappdata(0,'signal',signal);
    
        set(handles.edit_output_array,'Enable','on');
        set(handles.pushbutton_save,'Enable','on');  
        set(handles.pushbutton_export,'Enable','on'); 
    
        THM=signal;
        t_string=tstring;
        x_label='Time (sec)';
        y_label=ylab;
        nbars=31;
    
        [fig_num]=plot_time_history_histogram(fig_num,THM,t_string,x_label,y_label,nbars);
        
        [mu,sd,rms,sk,kt]=kurtosis_stats(a);
    
        fprintf(' max=%8.4g \n min=%8.4g ',max(a),min(a));
        fprintf('\n rms=%8.4g \n std dev=%8.4g \n mean=%8.4g ',rms,sd,mu);       
        fprintf('\n crest factor=%8.4g \n',max(abs(a))/sd); 
        fprintf('\n skewness=%8.4g \n kurtosis=%8.4g \n\n',sk,kt);
         
    end

    if(histogram_status==1) % histogram
        nbars=31;
        figure(fig_num);
        xx=max(abs(signal(:,2)));
        x=linspace(-xx,xx,nbars);       
        hist(signal(:,2),x)
        ylabel('Counts');
        title('Histogram');
        xlabel(ylab); 
    end
end


if(n==29)
    
    pflag=1;
    
    try
        FS=get(handles.edit_input_array_name,'String');
        THM=evalin('base',FS);     
    catch
        warndlg('Input array not found');
        return;
    end
    
    sz=size(THM);
    num=sz(2)-1;
    
    m=get(handles.listbox_1,'Value');
     
    sigma=str2num(get(handles.edit2,'String'));    
     
    np=sz(1);
    dt=(THM(end,1)-THM(1,1))/(np-1);
    sr=1/dt;
    
   if(m==1)
%
%    iband:   1=lowpass  2=highpass  3=bandpass 
%
%    iphase=1  for refiltering for phase correction
%          =2  for no refiltering
%
      iband=1;
      fl=str2num(get(handles.edit8,'String'));
      if(fl>sr/2.)
          fl=0.49*sr;
          msgbox('Note: lowpass filter frequency decreased ','Warning','warn');
          out1=sprintf('%8.4g',fl);
          set(handles.edit8,'String',out1);         
      end
      fh=0;
%
    end
%      
    if(m==2)
        
      iband=3;
      fh=str2num(get(handles.edit8,'String'));
      if(fh>sr/2.)
          fh=0.49*sr;
          msgbox('Note: lower frequency decreased ','Warning','warn');
          out1=sprintf('%8.4g',fh);
          set(handles.edit8,'String',out1);         
      end

      fl=str2num(get(handles.edit9,'String'));
      if(fl>sr/2.)
          fl=0.49*sr;
          msgbox('Note: upper frequency decreased ','Warning','warn');
          out1=sprintf('%8.4g',fl);
          set(handles.edit9,'String',out1);         
      end     
       
    end
        
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    for i=1:num
    
        a=randn(np,1);
        a=fix_size(a);
        a=a-mean(a);
        a=a*sigma/std(a);
% 
        if(m<=2)
        
            tstring='Band-limited White Noise';
      
            iphase=2;     
            [a,~,~,~]=Butterworth_filter_function_alt(a,dt,iband,fl,fh,iphase);      
        
%    scale for the std deviation
%
            ave=mean(a);
            stddev=std(a);
            sss=sigma/stddev;
            a=(a-ave)*sss;        
        
        end
        
        THM(:,1+i)=THM(:,1+i)+a;
    end

    if(pflag==1)    
        setappdata(0,'signal',THM);
        set(handles.edit_output_array,'Enable','on');
        set(handles.pushbutton_save,'Enable','on');  
        set(handles.pushbutton_export,'Enable','on');    
    end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    fig_num=1;

    x_label='Time (sec)';
    y_label=ylab;
    try
        t_string=tstring;
    catch
        t_string=' ';
    end
        
    if(pflag==1 && num==1)
    
        figure(fig_num);
        fig_num=fig_num+1;
        plot(THM(:,1),THM(:,2));
        title(t_string);
        grid on;
        xlabel(x_label);
        ylabel(ylab);
        nbars=31;
        [fig_num]=plot_time_history_histogram(fig_num,THM,t_string,x_label,y_label,nbars);
    
    end
    if(pflag==1 && num==2)
        figure(fig_num);
        
        subplot(2,1,1);
        plot(THM(:,1),THM(:,2));
        title('Channel 1');       
        grid on;
        xlabel(x_label);
        
        subplot(2,1,2);
        plot(THM(:,1),THM(:,3));
         title('Channel 2');        
        grid on;
        xlabel(x_label);

    end    
    if(pflag==1 && num==3)
        hp=figure(fig_num);
        subplot(3,1,1);
        plot(THM(:,1),THM(:,2));
        title('Channel 1');       
        grid on;
        xlabel(x_label);
        
        subplot(3,1,2);
        plot(THM(:,1),THM(:,3));
        title('Channel 2');        
        grid on;
        xlabel(x_label);
        
        subplot(3,1,3);
        plot(THM(:,1),THM(:,4));
        title('Channel 3');        
        grid on;
        xlabel(x_label);       
        
        set(hp, 'Position', [0 0 700 650]);
    end
    
end
    
% --- Executes on button press in pushbutton_return.
function pushbutton_return_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_return (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
delete(signal_generate);

% --- Executes on selection change in listbox_1.
function listbox_1_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_1

n=get(handles.listbox_1,'Value');


set(handles.text_s8,'Visible','off');
set(handles.edit8,'Visible','off'); 
set(handles.text_s9,'Visible','off');
set(handles.edit9,'Visible','off'); 


if(n<=2)
    set(handles.text_s8,'Visible','on');
    set(handles.edit8,'Visible','on');  
end


if(n==1)
   sss='Low Pass Frequency (Hz)'; 
   set(handles.text_s8,'String',sss);
end
if(n==2)
   sss1='Lower Frequency (Hz)'; 
   sss2='Upper Frequency (Hz)'; 
   set(handles.text_s8,'String',sss1); 
   set(handles.text_s9,'String',sss2);
   set(handles.text_s9,'Visible','on');
   set(handles.edit9,'Visible','on');       
end



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


% --- Executes on button press in pushbutton_save.
function pushbutton_save_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

data=getappdata(0,'signal');

output_name=strtrim(get(handles.edit_output_array,'String'));
assignin('base', output_name, data);

msgbox('Save Complete'); 

set(handles.pushbutton_stats,'Visible','on');
set(handles.pushbutton_sdof,'Visible','on');

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


data=getappdata(0,'signal');
assignin('base','export_signal_nastran',data);

handles.s=Vibrationdata_export_to_Nastran;    
set(handles.s,'Visible','on'); 




function edit_nastran_Callback(hObject, eventdata, handles)
% hObject    handle to edit_nastran (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_nastran as text
%        str2double(get(hObject,'String')) returns contents of edit_nastran as a double


% --- Executes during object creation, after setting all properties.
function edit_nastran_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_nastran (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_stats.
function pushbutton_stats_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_stats (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

vibrationdata_statistics_App;     


% --- Executes on key press with focus on listbox_signal and none of its controls.
function listbox_signal_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to listbox_signal (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
n=get(hObject,'Value');

 
if(n==17) % random with specified skewness & kurtosis
    handles.sss= random_skew_kurtosis; 
    set(handles.sss,'Visible','on');
end    
 
if(n==18) % add sine tones
    handles.sss= vibrationdata_add_sine_tones; 
    set(handles.sss,'Visible','on');
end 
 
if(n==19) % HALT/HASS simulation
    handles.sss= vibrationdata_PSD_accel_synth_HALT; 
    set(handles.sss,'Visible','on');
end 


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over listbox_signal.
function listbox_signal_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to listbox_signal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
n=get(hObject,'Value');

 
if(n==17) % random with specified skewness & kurtosis
    handles.sss= random_skew_kurtosis; 
    set(handles.sss,'Visible','on');
end    
 
if(n==18) % add sine tones
    handles.sss= vibrationdata_add_sine_tones; 
    set(handles.sss,'Visible','on');
end 
 
if(n==19) % HALT/HASS simulation
    handles.sss= vibrationdata_PSD_accel_synth_HALT; 
    set(handles.sss,'Visible','on');
end 


% --- Executes during object creation, after setting all properties.
function pushbutton_calculate_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called



function edit9_Callback(hObject, eventdata, handles)
% hObject    handle to edit9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit9 as text
%        str2double(get(hObject,'String')) returns contents of edit9 as a double


% --- Executes during object creation, after setting all properties.
function edit9_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_ylabel_Callback(hObject, eventdata, handles)
% hObject    handle to edit_ylabel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_ylabel as text
%        str2double(get(hObject,'String')) returns contents of edit_ylabel as a double


% --- Executes during object creation, after setting all properties.
function edit_ylabel_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_ylabel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_rectify.
function listbox_rectify_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_rectify (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_rectify contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_rectify


% --- Executes during object creation, after setting all properties.
function listbox_rectify_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_rectify (see GCBO)
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


% --- Executes on button press in pushbutton_sdof.
function pushbutton_sdof_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_sdof (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
vibrationdata_sdof_base_Apph;



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

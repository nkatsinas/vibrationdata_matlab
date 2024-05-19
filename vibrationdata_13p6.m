function varargout = vibrationdata_13p6(varargin)
% VIBRATIONDATA_13P6 MATLAB code for vibrationdata_13p6.fig
%      VIBRATIONDATA_13P6, by itself, creates a new VIBRATIONDATA_13P6 or raises the existing
%      singleton*.
%
%      H = VIBRATIONDATA_13P6 returns the handle to a new VIBRATIONDATA_13P6 or the handle to
%      the existing singleton*.
%
%      VIBRATIONDATA_13P6('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in VIBRATIONDATA_13P6.M with the given input arguments.
%
%      VIBRATIONDATA_13P6('Property','Value',...) creates a new VIBRATIONDATA_13P6 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before vibrationdata_13p6_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to vibrationdata_13p6_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help vibrationdata_13p6

% Last Modified by GUIDE v2.5 15-Aug-2018 15:22:11

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @vibrationdata_13p6_OpeningFcn, ...
                   'gui_OutputFcn',  @vibrationdata_13p6_OutputFcn, ...
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


% --- Executes just before vibrationdata_13p6 is made visible.
function vibrationdata_13p6_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to vibrationdata_13p6 (see VARARGIN)

% Choose default command line output for vibrationdata_13p6
handles.output = hObject;

% listbox_input_type


set(handles.listbox_input_domain,'value',1);
set(handles.listbox_input_type,'value',1);
set(handles.listbox_analysis,'value',1);

listbox_input_type_string(hObject,eventdata, handles)

setappdata(0,'psd_type',1); 
fig_num=1;
setappdata(0,'fig_num',fig_num); 

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes vibrationdata_13p6 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


function listbox_analysis_string(hObject,eventdata,handles)

n=get(handles.listbox_input_domain,'Value');

m=get(handles.listbox_input_type,'Value');

set(handles.listbox_analysis, 'String', '');

if(n==1) % Time History
    if(m==1) % Acceleration
       string_th{1}=sprintf('Statistics');   
       string_th{2}=sprintf('Signal Editing Utilities');   
       string_th{3}=sprintf('Integrate or Differentiate');  
       string_th{4}=sprintf('Fourier Transform');   
       string_th{5}=sprintf('FFT');   
       string_th{6}=sprintf('Waterfall FFT & Spectrogram');
       string_th{7}=sprintf('Time-Varying Freq & Amp');       
       string_th{8}=sprintf('PSD, Spectral Densities, Transmissibility, etc.'); 
       string_th{9}=sprintf('PSD Envelope via ERS or FDS');            
       string_th{10}=sprintf('SDOF Response to Base Input');   
       string_th{11}=sprintf('Shock Response Spectrum, Various');    
       string_th{12}=sprintf('Shock Saturation Removal');          
       string_th{13}=sprintf('Rainflow Cycle Counting'); 
       string_th{14}=sprintf('Fatigue Damage Spectrum');    
       string_th{15}=sprintf('Auto & Cross-correlation, Pearson Coefficient'); 
       string_th{16}=sprintf('Filters, Various');      
       string_th{17}=sprintf('Cepstrum & Auto Cepstrum');           
       string_th{18}=sprintf('Sine & Damped Sine Curve-fit');
       string_th{19}=sprintf('Wavelet Reconstruction'); 
       string_th{20}=sprintf('Temporal Moments');
       string_th{21}=sprintf('Energy Response Spectrum');    
       string_th{22}=sprintf('ISO Generic VC, 2631, 10816');               
       string_th{23}=sprintf('Lomb–Scargle Periodogram for unevenly spaced data');  
       string_th{24}=sprintf('Batch Processing');      
    end
    if(m==2) % Velocity
       string_th{1}=sprintf('Statistics');   
       string_th{2}=sprintf('Signal Editing Utilities');   
       string_th{3}=sprintf('Integrate or Differentitate');  
       string_th{4}=sprintf('Fourier Transform');   
       string_th{5}=sprintf('FFT');   
       string_th{6}=sprintf('Waterfall FFT & Spectrogram');
       string_th{7}=sprintf('Time-Varying Freq & Amp');       
       string_th{8}=sprintf('PSD, Spectral Densities, Transmissibility, etc.');       
       string_th{9}=sprintf('Rainflow Cycle Counting'); 
       string_th{10}=sprintf('Auto & Cross-correlation, Pearson Coefficient'); 
       string_th{11}=sprintf('ISO Generic Vibration Criteria');
       string_th{12}=sprintf('Filters, Various');        
       string_th{13}=sprintf('Cepstrum & Auto Cepstrum');
       string_th{14}=sprintf('Sine & Damped Sine Curve-fit');
       string_th{15}=sprintf('Batch Processing');       
    end
    if(m==3) % Displacement
       string_th{1}=sprintf('Statistics');   
       string_th{2}=sprintf('Signal Editing Utilities');   
       string_th{3}=sprintf('Integrate or Differentiate');       
       string_th{4}=sprintf('Fourier Transform');   
       string_th{5}=sprintf('FFT');   
       string_th{6}=sprintf('Waterfall FFT & Spectrogram');
       string_th{7}=sprintf('Time-Varying Freq & Amp');       
       string_th{8}=sprintf('PSD, Spectral Densities, Transmissibility, etc.');     
       string_th{9}=sprintf('Rainflow Cycle Counting'); 
       string_th{10}=sprintf('Auto & Cross-correlation, Pearson Coefficient'); 
       string_th{11}=sprintf('Filters, Various');        
       string_th{12}=sprintf('Cepstrum & Auto Cepstrum'); 
       string_th{13}=sprintf('Sine & Damped Sine Curve-fit');
       string_th{14}=sprintf('Batch Processing');       
    end
    if(m==4) % Force
       string_th{1}=sprintf('Statistics');   
       string_th{2}=sprintf('Signal Editing Utilities');      
       string_th{3}=sprintf('Fourier Transform');   
       string_th{4}=sprintf('FFT');   
       string_th{5}=sprintf('Waterfall FFT & Spectrogram');
       string_th{6}=sprintf('Time-Varying Freq & Amp');       
       string_th{7}=sprintf('PSD, Spectral Densities, Transmissibility, etc.');      
       string_th{8}=sprintf('SDOF Response to Applied Force');   
       string_th{9}=sprintf('Shock Response Spectrum');   
       string_th{10}=sprintf('Rainflow Cycle Counting');
       string_th{11}=sprintf('Fatigue Damage Spectrum');       
       string_th{12}=sprintf('Auto & Cross-correlation, Pearson Coefficient');        
       string_th{13}=sprintf('Filters, Various');    
       string_th{14}=sprintf('Sine & Damped Sine Curve-fit');
       string_th{15}=sprintf('Batch Processing');        
    end
    if(m==5) % Pressure
       string_th{1}=sprintf('Statistics');   
       string_th{2}=sprintf('Signal Editing Utilities');      
       string_th{3}=sprintf('Fourier Transform');   
       string_th{4}=sprintf('FFT');   
       string_th{5}=sprintf('Waterfall FFT & Spectrogram');
       string_th{6}=sprintf('Time-Varying Freq & Amp');       
       string_th{7}=sprintf('PSD, Spectral Densities, Transmissibility, etc.');     
       string_th{8}=sprintf('Sound Pressure Level');             
       string_th{9}=sprintf('Auto & Cross-correlation, Pearson Coefficient'); 
       string_th{10}=sprintf('Filters, Various');      
       string_th{11}=sprintf('Sine & Damped Sine Curve-fit');
       string_th{12}=sprintf('Batch Processing');        
    end
    if(m==6) % Stress
       string_th{1}=sprintf('Statistics');   
       string_th{2}=sprintf('Signal Editing Utilities');      
       string_th{3}=sprintf('Fourier Transform');   
       string_th{4}=sprintf('FFT');   
       string_th{5}=sprintf('Waterfall FFT & Spectrogram');
       string_th{6}=sprintf('Time-Varying Freq & Amp');   
       string_th{7}=sprintf('PSD, Spectral Densities, Transmissibility, etc.');    
       string_th{8}=sprintf('Auto & Cross-correlation, Pearson Coefficient');  
       string_th{9}=sprintf('Rainflow Cycle Counting'); 
       string_th{10}=sprintf('Filters, Various');         
       string_th{11}=sprintf('Sine & Damped Sine Curve-fit');
       string_th{12}=sprintf('Principal, von Mises & Tresca, Multiaxis Input');       
       string_th{13}=sprintf('Batch Processing');

    end
    if(m==7) % Strain
       string_th{1}=sprintf('Statistics');   
       string_th{2}=sprintf('Signal Editing Utilities');      
       string_th{3}=sprintf('Fourier Transform');   
       string_th{4}=sprintf('FFT');   
       string_th{5}=sprintf('Waterfall FFT & Spectrogram');
       string_th{6}=sprintf('Time-Varying Freq & Amp');     
       string_th{7}=sprintf('PSD, Spectral Densities, Transmissibility, etc.');    
       string_th{8}=sprintf('Auto & Cross-correlation, Pearson Coefficient');  
       string_th{9}=sprintf('Rainflow Cycle Counting');
       string_th{10}=sprintf('Filters, Various');         
       string_th{11}=sprintf('Sine & Damped Sine Curve-fit');
       string_th{12}=sprintf('Batch Processing');        
    end
    if(m==8) % Other
       string_th{1}=sprintf('Statistics');   
       string_th{2}=sprintf('Signal Editing Utilities');   
       string_th{3}=sprintf('Integrate or Differentiate');  
       string_th{4}=sprintf('Fourier Transform');   
       string_th{5}=sprintf('FFT');   
       string_th{6}=sprintf('Waterfall FFT & Spectrogram');
       string_th{7}=sprintf('Time-Varying Freq & Amp');       
       string_th{8}=sprintf('PSD, Spectral Densities, Transmissibility, etc.');    
       string_th{9}=sprintf('Auto & Cross-correlation, Pearson Coefficient'); 
       string_th{10}=sprintf('Rainflow Cycle Counting');
       string_th{11}=sprintf('Filters, Various');     
       string_th{12}=sprintf('Cepstrum & Auto Cepstrum'); 
       string_th{13}=sprintf('Sine & Damped Sine Curve-fit');
       string_th{14}=sprintf('Batch Processing');        
    end
    set(handles.listbox_analysis,'String',string_th)    
end
if(n==2)  % PSD
    if(m==1) % Acceleration PSD
       string_f{1}=sprintf('Overall RMS'); 
       string_f{2}=sprintf('Convert to Octave Format');  
       string_f{3}=sprintf('SDOF Response to Base Input');   
       string_f{4}=sprintf('Vibration Response Spectrum (VRS)'); 
       string_f{5}=sprintf('Fatigue Damage Spectrum (FDS)');         
       string_f{6}=sprintf('Time History Synthesis from White Noise');
       string_f{7}=sprintf('Power Transmissibility from two PSDs');  
       string_f{8}=sprintf('Response PSD from Input PSD & Power Trans');         
       string_f{9}=sprintf('Envelope PSD via VRS');  
       string_f{10}=sprintf('PSD Specification Time Scaling');
       string_f{11}=sprintf('PSD Band-splitting');   
       string_f{12}=sprintf('Spectral Moments');
       string_f{13}=sprintf('Add dB Margin');       
       string_f{14}=sprintf('Batch Processing');      
       setappdata(0,'wnd_label','Acceleration');       
    end
    if(m==2) % Velocity PSD
       string_f{1}=sprintf('Overall RMS');  
       string_f{2}=sprintf('Convert to Octave Format');  
       string_f{3}=sprintf('Time History Synthesis from White Noise');
       string_f{4}=sprintf('Spectral Moments');
       setappdata(0,'wnd_label','Velocity');       
    end
    if(m==3) % Displacement PSD
       string_f{1}=sprintf('Overall RMS');              
       string_f{2}=sprintf('Convert to Octave Format');   
       string_f{3}=sprintf('Time History Synthesis from White Noise');
       string_f{4}=sprintf('Spectral Moments');        
       setappdata(0,'wnd_label','Displacement');       
    end
    if(m==4) % Force PSD
       string_f{1}=sprintf('Overall RMS');              
       string_f{2}=sprintf('Convert to Octave Format');
       string_f{3}=sprintf('Time History Synthesis from White Noise');
       string_f{4}=sprintf('Time History Synthesis from White Noise, Kurtosis');
       string_f{5}=sprintf('Time History Synthesis from Sine Series');       
       string_f{6}=sprintf('Power Transmissibility from two PSDs');       
       string_f{7}=sprintf('Response PSD from Input PSD & Power Trans');       
       string_f{8}=sprintf('SDOF Response to force PSD');  
       string_f{9}=sprintf('Vibration Response Spectrum (VRS)');
       string_f{10}=sprintf('Fatigue Damage Spectrum (FDS)');
       string_f{11}=sprintf('Spectral Moments'); 
       setappdata(0,'wnd_label','Force');
    end 
    if(m==5) % Pressure PSD
       string_f{1}=sprintf('Overall RMS');     
       string_f{2}=sprintf('Convert to Octave Format');      
       string_f{3}=sprintf('Time History Synthesis from White Noise');
       string_f{4}=sprintf('Time History Synthesis from White Noise, Kurtosis');       
       string_f{5}=sprintf('Time History Synthesis from Sine Series');       
       string_f{6}=sprintf('Power Transmissibility from two PSDs');        
       string_f{7}=sprintf('Response PSD from Input PSD & Power Trans');
       string_f{8}=sprintf('Spectral Moments');  
       string_f{9}=sprintf('Convert to Acoustic SPL');  
       string_f{10}=sprintf('Convert Octave to Narrowband Format');  
       string_f{11}=sprintf('Vibration Response Spectrum (VRS)');
       setappdata(0,'wnd_label','Pressure');
    end      
    if(m==6) % Stress PSD
       string_f{1}=sprintf('Overall RMS');     
       string_f{2}=sprintf('Convert to Octave Format');      
       string_f{3}=sprintf('Time History Synthesis from White Noise');
       string_f{4}=sprintf('Time History Synthesis from White Noise, Kurtosis');       
       string_f{5}=sprintf('Power Transmissibility from two PSDs');  
       string_f{6}=sprintf('Response PSD from Input PSD & Power Trans');      
       string_f{7}=sprintf('Stress PSD Fatigue Damage');
       string_f{8}=sprintf('Spectral Moments');        
       setappdata(0,'wnd_label','Stress');
    end      

    set(handles.listbox_analysis,'String',string_f)      
end

if(n==3)  % SPL
    string_f{1}=sprintf('Overall SPL');  
    string_f{2}=sprintf('Convert SPL to Pressure PSD');
    string_f{3}=sprintf('Convert Full Octave SPL to One-Third');    
    string_f{4}=sprintf('Convert Digitized One-Third SPL to True One-Third'); 
    string_f{5}=sprintf('Convert Narrowband SPL to One-Third');    
    string_f{6}=sprintf('Perceived Noise Level PNL');
    string_f{7}=sprintf('Effective Perceived Noise Level EPNL');
    
    set(handles.listbox_analysis,'String',string_f)     
end 

if(n==4)  % SRS
    string_srs{1}=sprintf('Wavelet Synthesis'); 
    string_srs{2}=sprintf('Damped Sine Synthesis');  
    string_srs{3}=sprintf('Earthquake Synthesis'); 
    string_srs{4}=sprintf('Pyroshock Synthesis');      
    string_srs{5}=sprintf('Random Synthesis');  
    string_srs{6}=sprintf('Envelope SRS via PSD, peak response');    
    string_srs{7}=sprintf('Convert Accel SRS to Pseudo Velocity SRS');
    string_srs{8}=sprintf('Convert SRS to FDS');
    string_srs{9}=sprintf('Satisfy SRS with Classical Pulse');
    string_srs{10}=sprintf('Convert SRS Spec to a New Q Value');        
    string_srs{11}=sprintf('IEC 980 Sine Dwell One-Third Octave');    
    string_srs{12}=sprintf('Envelope Measured SRS Data');  
    string_srs{13}=sprintf('Add dB Margin');      
    
    set(handles.listbox_analysis,'String',string_srs)     
end    

if(n==5)  % Fourier transform
    string_f{1}=sprintf('Overall level');  
    string_f{2}=sprintf('Inverse Fourier Transform'); 
    string_f{3}=sprintf('Convert Fourier Transform Magnitude to PSD');     
    set(handles.listbox_analysis,'String',string_f)     
end    
if(n==6) % Wavelet Table
    if(m==1) % Acceleration
        string_f{1}=sprintf('Construct Time History');  
        string_f{2}=sprintf('Shock Distance Attenuation');
        string_f{3}=sprintf('Shock Joint Attenuation');      
        set(handles.listbox_analysis,'String',string_f);           
    end
end    

function listbox_input_type_string(hObject,eventdata,handles)

set(handles.listbox_input_type, 'String', '');

n=get(handles.listbox_input_domain,'value');


if(n==1) % time history
    string_th{1}=sprintf('Acceleration');
    string_th{2}=sprintf('Velocity');
    string_th{3}=sprintf('Displacement');
    string_th{4}=sprintf('Force');
    string_th{5}=sprintf('Pressure');
    string_th{6}=sprintf('Stress');
    string_th{7}=sprintf('Strain');
    string_th{8}=sprintf('Other');    
    set(handles.listbox_input_type,'String',string_th)
end
if(n==2 || n==5) % psd or Fourier transform
    string_psd{1}=sprintf('Acceleration');
    string_psd{2}=sprintf('Velocity');
    string_psd{3}=sprintf('Displacement');
    string_psd{4}=sprintf('Force');
    string_psd{5}=sprintf('Pressure');
    string_psd{6}=sprintf('Stress');    
    set(handles.listbox_input_type,'String',string_psd)
end 
if(n==3) % spl
    string_spl{1}=sprintf('Pressure');
    set(handles.listbox_input_type,'String',string_spl)
end
if(n==4) % srs
    string_srs{1}=sprintf('Acceleration');
    set(handles.listbox_input_type,'String',string_srs)
end
if(n==6) % wavelet table
    string_w{1}=sprintf('Acceleration');
    set(handles.listbox_input_type,'String',string_w)    
end    

listbox_analysis_string(hObject,eventdata,handles);



% --- Outputs from this function are returned to the command line.
function varargout = vibrationdata_13p6_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in listbox_input_domain.
function listbox_input_domain_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_input_domain (see GCBO)
% eventdata  reserved - to be definlistbox_input_type_stringed in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_input_domain contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_input_domain

set(handles.listbox_input_type,'value',1);
set(handles.listbox_analysis,'value',1);

listbox_input_type_string(hObject,eventdata, handles)


% --- Executes during object creation, after setting all properties.
function listbox_input_domain_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_input_domain (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_input_type.
function listbox_input_type_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_input_type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_input_type contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_input_type

set(handles.listbox_analysis,'value',1);

listbox_input_type_string(hObject,eventdata,handles)


% --- Executes during object creation, after setting all properties.
function listbox_input_type_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_input_type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end






% --- Executes on selection change in listbox_analysis.
function listbox_analysis_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_analysis (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_analysis contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_analysis


% --- Executes during object creation, after setting all properties.
function listbox_analysis_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_analysis (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_begin_analysis.
function pushbutton_begin_analysis_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_begin_analysis (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

n=get(handles.listbox_input_domain,'value');
m=get(handles.listbox_input_type,'value');
p=get(handles.listbox_analysis,'value');

setappdata(0,'imput_domain',n);
setappdata(0,'input_type',m);
setappdata(0,'analysis',p);


if(n==1) % time history
    if(m==1) % Acceleration
       if(p==1) % Statistics
          handles.s= vibrationdata_statistics;            
       end    
       if(p==2) % Signal Editing Utilities
          handles.s= vibrationdata_signal_editing_utilities;            
       end    
       if(p==3) % Integrate & differentiate
          handles.s= vibrationdata_integrate_differentiate;            
       end        
       if(p==4) % Fourier Transform
          handles.s= vibrationdata_fourier_transform;              
       end          
       if(p==5) % FFT
          handles.s= vibrationdata_fft;           
       end        
       if(p==6) % Waterfall FFT & Spectrogram
           handles.s= vibrationdata_waterfall_fft;           
       end     
       if(p==7) % Time-Varying Freq & Amp
           handles.s= vibrationdata_tvfa;             
       end     
       if(p==8) % Power Spectral Density
           handles.s= vibrationdata_sd_various;              
       end     
       if(p==9) % Power Spectral Density Envelope
           handles.s= vibrationdata_psd_envelope_main;              
       end        
       if(p==10) % SDOF Response to Base Input
           handles.s= vibrationdata_sdof_base;      
       end           
       if(p==11) % Shock Response Spectrum
           handles.s= vibrationdata_srs_various;            
       end
       if(p==12) % Shock Saturation Removal
           handles.s= vibrationdata_mean_filter_saturation;            
       end       
       if(p==13) % Rainflow Cycle Counting
           handles.s= vibrationdata_rainflow;         
       end   
       if(p==14) % Fatigue Damage Spectrum
           handles.s= vibrationdata_fds;         
       end          
       if(p==15) % Auto & cross-correlation
           handles.s= vibrationdata_correlation_various;         
       end        
       if(p==16) % Filters
           handles.s= vibrationdata_filters_various;              
       end  
       if(p==17) % Cepstrum
           handles.s= vibrationdata_cepstrum;                   
       end       
       if(p==18) % Sine & Damped Sine Curve-fit
           handles.s= sine_curve_fit;                  
       end        
       if(p==19) % Wavelet Reconstruction
           handles.s= vibrationdata_wavelet_reconstruction_main;                  
       end 
       if(p==20) % Temporal Moments
           handles.s= vibrationdata_temporal_moments;                  
       end 
       if(p==21) % Energy Response Spectrum
           handles.s= vibrationdata_energy_base;                  
       end 
       if(p==22) % ISO Main
           handles.s= vibrationdata_iso_main;         
       end  
       if(p==23) % Lomb_Scargle Periodgram
           handles.s= Lomb_Scargle_Periodogram;         
       end            
       if(p==24) % Batch
           handles.s= vibrationdata_batch_acceleration;         
       end            
%
       set(handles.s,'Visible','on');       
    end
    if(m==2) % Velocity
       if(p==1) % Statistics
          handles.s= vibrationdata_statistics;         
       end       
       if(p==2) % Signal Editing Utilities
          handles.s= vibrationdata_signal_editing_utilities;            
       end   
       if(p==3) % Integrate or differentiate
          handles.s= vibrationdata_integrate_differentiate;            
       end    
       if(p==4) % Fourier Transform
          handles.s= vibrationdata_fourier_transform;              
       end      
       if(p==5) % FFT
          handles.s= vibrationdata_fft;              
       end       
       if(p==6) % Waterfall FFT & Spectrogram
           handles.s= vibrationdata_waterfall_fft;             
       end     
       if(p==7) % Time-Varying Freq & Amp
           handles.s= vibrationdata_tvfa;           
       end        
       if(p==8) % Power Spectral Density
           handles.s= vibrationdata_sd_various;             
       end         
       if(p==9) % Rainflow Cycle Counting
           handles.s= vibrationdata_rainflow;           
       end   
       if(p==10) % Auto & cross-correlation
           handles.s= vibrationdata_correlation_various;         
       end           
       if(p==11) % ISO Generic Vibration Criteria
           handles.s= vibrationdata_iso_generic;            
       end  
       if(p==12) % Filters
           handles.s= vibrationdata_filters_various;                   
       end        
       if(p==13) % Cepstrum
           handles.s= vibrationdata_cepstrum;            
       end    
       if(p==14) % Sine & Damped Sine Curve-fit
           handles.s= sine_curve_fit;                  
       end        
       if(p==15) % Batch
           handles.s= vibrationdata_batch;         
       end          
       set(handles.s,'Visible','on');
    end
    if(m==3) % Displacement
       if(p==1) % Statistics
          handles.s= vibrationdata_statistics;            
       end            
       if(p==2) % Signal Editing Utilities
          handles.s= vibrationdata_signal_editing_utilities;       
       end     
       if(p==3) % Integrate or Differentiate
          handles.s= vibrationdata_integrate_differentiate;         
       end          
       if(p==4) % Fourier Transform
          handles.s= vibrationdata_fourier_transform;           
       end       
       if(p==5) % FFT
          handles.s= vibrationdata_fft;     
       end    
       if(p==6) % Waterfall FFT & Spectrogram
           handles.s= vibrationdata_waterfall_fft;            
       end     
       if(p==7) % Time-Varying Freq & Amp
           handles.s= vibrationdata_tvfa;          
       end        
       if(p==8) % Power Spectral Density
           handles.s= vibrationdata_sd_various;           
       end         
       if(p==9) % Rainflow Cycle Counting
           handles.s= vibrationdata_rainflow;          
       end   
       if(p==10) % Auto & cross-correlation
           handles.s= vibrationdata_correlation_various;         
       end      
       if(p==11) % Filters
           handles.s= vibrationdata_filters_various;           
       end          
       if(p==12) % Cepstrum
           handles.s= vibrationdata_cepstrum;            
       end     
       if(p==13) % Sine & Damped Sine Curve-fit
           handles.s= sine_curve_fit;                  
       end     
       if(p==14) % Batch
           handles.s= vibrationdata_batch;         
       end          
       set(handles.s,'Visible','on');       
    end
    if(m==4) % Force
       if(p==1) % Statistics
          handles.s= vibrationdata_statistics;            
       end       
       if(p==2) % Signal Editing Utilities
          handles.s= vibrationdata_signal_editing_utilities;          
       end        
       if(p==3) % Fourier Transform
           handles.s= vibrationdata_fourier_transform;         
       end       
       if(p==4) % FFT
           handles.s= vibrationdata_fft;  
       end       
       if(p==5) % Waterfall FFT & Spectrogram
           handles.s= vibrationdata_waterfall_fft;       
       end     
       if(p==6) % Time-Varying Freq & Amp
           handles.s= vibrationdata_tvfa;        
       end        
       if(p==7) % Power Spectral Density
           handles.s= vibrationdata_sd_various;           
       end    
       if(p==8) % SDOF Response to Applied Force
           handles.s=vibrationdata_sdof_Force;   
       end    
       if(p==9) % Shock Response Spectrum
           handles.s= vibrationdata_srs_force;        
       end  
       if(p==10) % Rainflow Cycle Counting
          handles.s= vibrationdata_rainflow;      
       end   
       if(p==11) % Fatigue Damage Spectrum
          handles.s= vibrationdata_force_FDS;      
       end         
       if(p==12) % Auto & cross-correlation
           handles.s= vibrationdata_correlation_various;         
       end      
       if(p==13) % Filters
           handles.s= vibrationdata_filters_various;                
       end    
       if(p==14) % Sine & Damped Sine Curve-fit
           handles.s= sine_curve_fit;                  
       end    
       if(p==15) % Batch
           handles.s= vibrationdata_batch;         
       end          
       set(handles.s,'Visible','on');          
    end
    if(m==5) % Pressure
       if(p==1) % Statistics
          handles.s= vibrationdata_statistics;               
       end       
       if(p==2) % Signal Editing Utilities
          handles.s= vibrationdata_signal_editing_utilities;        
       end        
       if(p==3) % Fourier Transform
          handles.s= vibrationdata_fourier_transform;          
       end       
       if(p==4) % FFT
          handles.s= vibrationdata_fft;            
       end   
       if(p==5) % Waterfall FFT & Spectrogram
          handles.s= vibrationdata_waterfall_fft;            
       end     
       if(p==6) % Time-Varying Freq & Amp
          handles.s= vibrationdata_tvfa;        
       end        
       if(p==7) % Power Spectral Density
          handles.s= vibrationdata_sd_various;           
       end     
       if(p==8) % Sound Pressure Level
          handles.s=vibrationdata_SPL;                 
       end                     
       if(p==9) % Auto & cross-correlation
           handles.s= vibrationdata_correlation_various;         
       end           
       if(p==10) % Filters
          handles.s= vibrationdata_filters_various;                
       end   
       if(p==11) % Sine & Damped Sine Curve-fit
           handles.s= sine_curve_fit;                  
       end     
       if(p==12) % Batch
           handles.s= vibrationdata_batch;         
       end         
       set(handles.s,'Visible','on');        
    end
    if(m==6) % Stress
       if(p==1) % Statistics
          handles.s= vibrationdata_statistics;        
       end       
       if(p==2) % Signal Editing Utilities
          handles.s= vibrationdata_signal_editing_utilities;       
       end        
       if(p==3) % Fourier Transform
          handles.s= vibrationdata_fourier_transform;              
       end   
       if(p==4) % FFT
          handles.s= vibrationdata_fft;        
       end   
       if(p==5) % Waterfall FFT & Spectrogram
          handles.s= vibrationdata_waterfall_fft;            
       end     
       if(p==6) % Time-Varying Freq & Amp
          handles.s= vibrationdata_tvfa;        
       end   
       if(p==7) % Power Spectral Density
          handles.s= vibrationdata_sd_various;            
       end      
       if(p==8) % Auto & cross-correlation
           handles.s= vibrationdata_correlation_various;         
       end      
       if(p==9) % Rainflow Cycle Counting
          handles.s= vibrationdata_rainflow;     
       end
       if(p==10) % Filters
           handles.s= vibrationdata_filters_various;                  
       end          
       if(p==11) % Sine & Damped Sine Curve-fit
           handles.s= sine_curve_fit;                  
       end
       if(p==12) % Principal, von Mises, Tresca
           handles.s= vibrationdata_equivalent_uniaxial;         
       end                 
       if(p==13) % Batch
           handles.s= vibrationdata_batch;         
       end          
       set(handles.s,'Visible','on');          
    end     
    if(m==7) % Strain
       if(p==1) % Statistics
           handles.s= vibrationdata_statistics;           
       end
       if(p==2) % Signal Editing Utilities
           handles.s= vibrationdata_signal_editing_utilities;          
       end        
       if(p==3) % Fourier Transform
           handles.s= vibrationdata_fourier_transform;            
       end    
       if(p==4) % FFT
           handles.s= vibrationdata_fft;      
       end   
       if(p==5) % Waterfall FFT & Spectrogram
           handles.s= vibrationdata_waterfall_fft;       
       end     
       if(p==6) % Time-Varying Freq & Amp
           handles.s= vibrationdata_tvfa;         
       end   
       if(p==7) % Power Spectral Density
           handles.s= vibrationdata_sd_various;          
       end          
       if(p==8) % Auto & cross-correlation
           handles.s= vibrationdata_correlation_various;         
       end           
       if(p==9) % Rainflow Cycle Counting
           handles.s= vibrationdata_rainflow;         
       end     
       if(p==10) % Filters
           handles.s= vibrationdata_filters_various;                
       end       
       if(p==11) % Sine & Damped Sine Curve-fit
           handles.s= sine_curve_fit;                  
       end     
       if(p==12) % Batch
           handles.s= vibrationdata_batch;         
       end          
       set(handles.s,'Visible','on');         
    end
    if(m==8) % Other
       if(p==1) % Statistics
          handles.s= vibrationdata_statistics;         
       end       
       if(p==2) % Signal Editing Utilities
          handles.s= vibrationdata_signal_editing_utilities;             
       end     
       if(p==3) % Integrate or differentiate
          handles.s= vibrationdata_integrate_differentiate;    
       end   
       if(p==4) % Fourier Transform
          handles.s= vibrationdata_fourier_transform;              
       end    
       if(p==5) % FFT
          handles.s= vibrationdata_fft;            
       end   
       if(p==6) % Waterfall FFT & Spectrogram
          handles.s= vibrationdata_waterfall_fft;              
       end     
       if(p==7) % Time-Varying Freq & Amp
          handles.s= vibrationdata_tvfa;           
       end        
       if(p==8) % Power Spectral Density
          handles.s= vibrationdata_sd_various;            
       end       
       if(p==9) % Auto & cross-correlation
           handles.s= vibrationdata_correlation_various;         
       end      
       if(p==10) % Rainflow Cycle Counting
          handles.s= vibrationdata_rainflow;         
       end     
       if(p==11) % Filters
           handles.s= vibrationdata_filters_various;                  
       end  
       if(p==12) % Cepstrum
           handles.s= vibrationdata_cepstrum;                   
       end 
       if(p==13) % Sine & Damped Sine Curve-fit
           handles.s= sine_curve_fit;                  
       end        
       if(p==14) % Batch
           handles.s= vibrationdata_batch;         
       end          
       set(handles.s,'Visible','on');        
    end        
%    
end
if(n==2) % psd
   if(m==1) % acceleration
       if(p==1) % overall RMS
           setappdata(0,'psd_type',1);           
           handles.s= vibrationdata_psd_rms;              
       end
       if(p==2) % octave format
           handles.s= vibrationdata_psd_oct;           
       end      
       if(p==3) % SDOF response
           handles.s= vibrationdata_psd_sdof_base;              
       end       
       if(p==4 || p==5) % VRS & FDS
           handles.s= vibrationdata_vrs_base;    
       end   
       if(p==6) % PSD synthesis
           handles.s= vibrationdata_PSD_accel_synth;    
       end  
       if(p==7) % Power Transmissibility from two PSDs
           handles.s= vibrationdata_power_transmissibility;    
       end      
       if(p==8) % Response PSD from Input PSD & Power Trans
           handles.s= vibrationdata_input_trans_mult;    
       end          
       if(p==9) % Envelope PSD via VRS
           handles.s=vibrationdata_envelope_psd;    
       end     
       if(p==10) % psd_time_scaling
           handles.s=vibrationdata_psd_time_scaling;    
       end       
       if(p==11) % bandsplit
           handles.s=vibrationdata_bandsplit;    
       end   
       if(p==12) % spectral moments
           handles.s=vibrationdata_spectral_moments;    
       end  
       if(p==13) % add margin
           handles.s=add_margin;    
       end           
       if(p==14) % batch processing
           handles.s=vibrationdata_batch_psd;    
       end        
       set(handles.s,'Visible','on');           
   end
   if(m==2) % velocity
       if(p==1) % overall RMS
           setappdata(0,'psd_type',2);          
           handles.s= vibrationdata_psd_rms;           
       end   
       if(p==2) % octave format
           handles.s= vibrationdata_psd_oct;       
       end   
       if(p==3) % synthesize from white noise
           handles.s= vibrationdata_PSD_vel_synth;       
       end        
       if(p==4) % spectral moments
           handles.s=vibrationdata_spectral_moments;    
       end         
       set(handles.s,'Visible','on');       
   end
   if(m==3) % displacement
       if(p==1) % overall RMS
            setappdata(0,'psd_type',3);          
           handles.s= vibrationdata_psd_rms;               
       end  
       if(p==2) % octave format
           handles.s= vibrationdata_psd_oct;        
       end  
       if(p==3) % time history synthesis
           handles.s= vibrationdata_psd_syn_wnb;             
       end       
       if(p==4) % spectral moments
           handles.s=vibrationdata_spectral_moments;    
       end       
       set(handles.s,'Visible','on');          
   end
   if(m==4) % force
       if(p==1) % overall RMS
           setappdata(0,'psd_type',4);           
           handles.s= vibrationdata_psd_rms;              
       end    
       if(p==2) % octave format
           handles.s= vibrationdata_psd_oct;             
       end      
       if(p==3) % time history synthesis - white noise
           handles.s= vibrationdata_psd_syn_wnb;             
       end      
       if(p==4) % time history synthesis - white noise, kurtosis
           handles.s= vibrationdata_psd_syn_wnb_kurtosis;             
       end         
       if(p==5) % time history synthesis - sine
           handles.s= vibrationdata_psd_syn_fp_sine;             
       end             
       if(p==6) % power transmissibility
           handles.s= vibrationdata_power_transmissibility;             
       end        
       if(p==7) % Response PSD from Input PSD & Power Trans
           handles.s= vibrationdata_input_trans_mult;    
       end                 
       if(p==8) % SDOF Response to Force PSD
           handles.s= vibrationdata_sdof_ran_force;             
       end   
       if(p==9 || p==10) % VRS
           handles.s= vibrationdata_VRS_force;             
       end
       if(p==11) % spectral moments
           handles.s=vibrationdata_spectral_moments;    
       end       
       set(handles.s,'Visible','on');         
   end
   if(m==5) % pressure
       if(p==1) % overall RMS
           setappdata(0,'psd_type',5);           
           handles.s= vibrationdata_psd_rms;                 
       end     
       if(p==2) % octave format
           handles.s= vibrationdata_psd_oct;         
       end 
       if(p==3) % time history synthesis - white noise
           handles.s= vibrationdata_psd_syn_wnb;             
       end       
       if(p==4) % time history synthesis - white noise, kurtosis
           handles.s= vibrationdata_psd_syn_wnb_kurtosis;             
       end          
       if(p==5) % time history synthesis - sine
           handles.s= vibrationdata_psd_syn_fp_sine;             
       end          
       if(p==6) % power transmissibility
           handles.s= vibrationdata_power_transmissibility;             
       end    
       if(p==7) % Response PSD from Input PSD & Power Trans
           handles.s= vibrationdata_input_trans_mult;    
       end     
       if(p==8) % spectral moments
           handles.s=vibrationdata_spectral_moments;    
       end   
       if(p==9) % convert pressure psd to acoustic spl
           handles.s=vibrationdata_psd_spl;    
       end 
       if(p==10) % Convert Octave to Narrowband Format
           handles.s=convert_octave_narrowband;             
       end
       if(p==11) % vibration response spectrum
           handles.s=vibrationdata_VRS_pressure;             
       end
       set(handles.s,'Visible','on');         
   end
   if(m==6) % stress
       if(p==1) % overall RMS
           setappdata(0,'psd_type',6);
           handles.s= vibrationdata_psd_rms;                 
       end     
       if(p==2) % octave format
           handles.s= vibrationdata_psd_oct;         
       end 
       if(p==3) % time history synthesis
           handles.s= vibrationdata_psd_syn_wnb;             
       end    
       if(p==4) % time history synthesis - white noise, kurtosis
           handles.s= vibrationdata_psd_syn_wnb_kurtosis;             
       end          
       if(p==5) % power transmissibility
           handles.s= vibrationdata_power_transmissibility;             
       end   
       if(p==6) % Response PSD from Input PSD & Power Trans
           handles.s= vibrationdata_input_trans_mult;    
       end                 
       if(p==7) % stress PSD fatigue damage
           handles.s= vibrationdata_stress_psd_fatigue;             
       end    
        if(p==8) % spectral moments
           handles.s=vibrationdata_spectral_moments;    
       end      
       set(handles.s,'Visible','on');         
   end   
end

if(n==3) % spl
    if(p==1) % overall RMS
           handles.s= oaspl;                  
    end     
    if(p==2) % Convert Full to One-Third
           handles.s= spl_to_pressure_psd;         
    end 
    if(p==3) % Convert Full to One-Third
           handles.s= spl_full_to_onethird;         
    end     
    if(p==4) % Convert Digitized One-Third to True One-Third
           handles.s= digitized_onethird_to_true_onethird;         
    end      
    if(p==5) % Convert Narrowband SPL to One-Third
           handles.s= narrowband_to_onethird_SPL;         
    end     
    if(p==6) % PNL
           handles.s= pnl;         
    end       
    if(p==7) % EPNL
           handles.s= epnl;         
    end        
    set(handles.s,'Visible','on');      
end

if(n==4) % srs
    if(p==1) % wavelet synth
           handles.s= vibrationdata_wavelet_synth;                  
    end  
    if(p==2) % damped sine synth
           handles.s= vibrationdata_damped_sine_synth;                  
    end    
    if(p==3) % earthquake synth
           handles.s= quake_srs_synth;                  
    end
    if(p==4) % pyroshock synth
           handles.s= pyro_srs_synth;                  
    end   
    if(p==5) % random synth
           handles.s= vibrationdata_random_srs_synth;                  
    end      
    if(p==6) % envelope SRS via PSD
           handles.s= vibrationdata_envelope_srs_psd;                  
    end 
    if(p==7) % convert accel SRS to PV SRS
           handles.s= vibrationdata_accel_SRS_PV_SRS;                  
    end        
    if(p==8) % convert accel SRS to FDS
           handles.s= vibrationdata_srs_fds;                  
    end   
    if(p==9) % satisfy SRS with classical pulse
           handles.s= srs_classical_pulse_synth;      
    end
    if(p==10) % convert SRS specification to a new Q value
           handles.s= srs_spec_convert_Q;      
    end    
    if(p==11) % satisfy SRS with classical pulse
           handles.s= IEC_980_Sine_Dwell;      
    end    
    if(p==12) % envelope_srs_data
           handles.s= envelope_srs_data;      
    end     
    if(p==13) % Add margin
           handles.s= add_margin;      
    end      
    
    set(handles.s,'Visible','on');      
end

if(n==5) % Fourier transform  
    if(p==1) % Overall RMS
            handles.s= vibrationdata_overall_Fourier_transform;  
    end 
    if(p==2) % Inverse
            handles.s= vibrationdata_inverse_Fourier_transform;  
    end  
    if(p==3) % Convert Fourier Transform Magnitude to PSD
            handles.s= Fourier_magnitude_psd;  
    end      
    set(handles.s,'Visible','on');       
end     

if(n==6) % Wavelet Table  
    if(p==1) % Construct Time History
            handles.s= wavelet_construct_time_history;  
    end 
    if(p==2) % Distance
            handles.s= shock_distance;  
    end 
    if(p==3) % Joint
            handles.s= shock_joint;  
    end     
    set(handles.s,'Visible','on');       
end  


% --- Executes on button press in pushbutton_generate.
function pushbutton_generate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_generate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.s= signal_generate;
set(handles.s,'Visible','on'); 


% --- Executes on button press in pushbutton_modal_frf.
function pushbutton_modal_frf_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_modal_frf (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.s= modal_frf;
set(handles.s,'Visible','on'); 


% --- Executes on button press in damping_functions.
function damping_functions_Callback(hObject, eventdata, handles)
% hObject    handle to damping_functions (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.s= damping_functions;
set(handles.s,'Visible','on'); 


% --- Executes on button press in pushbutton_classical_pulse_base_input.
function pushbutton_classical_pulse_base_input_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_classical_pulse_base_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.s=classical_pulse_base_input;
set(handles.s,'Visible','on'); 


% --- Executes on button press in pushbutton_amplitude.
function pushbutton_amplitude_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_amplitude (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.s=amplitude_conversion_utilities;
set(handles.s,'Visible','on'); 


% --- Executes on button press in pushbutton_peak_sigma.
function pushbutton_peak_sigma_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_peak_sigma (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.s=peak_sigma_random;
set(handles.s,'Visible','on'); 


% --- Executes on button press in pushbutton8.
function pushbutton8_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.s=srs_amplitude_conversion;
set(handles.s,'Visible','on'); 


% --- Executes on button press in pushbutton_structural_dynamics.
function pushbutton_structural_dynamics_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_structural_dynamics (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.s=structural_dynamics;
set(handles.s,'Visible','on'); 


% --- Executes on selection change in listbox_misc.
function listbox_misc_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_misc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_misc contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_misc


% --- Executes during object creation, after setting all properties.
function listbox_misc_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_misc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_misc_analysis.
function pushbutton_misc_analysis_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_misc_analysis (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

n=get(handles.listbox_misc,'Value');

if(n==1)
    handles.s= signal_generate;
end  
if(n==2)
    handles.s= modal_frf_main;
end 
if(n==3)
    handles.s= damping_functions;
end 
if(n==4)
    handles.s=amplitude_conversion_utilities;
end
if(n==5)
    handles.s=sine_sweep_parameters;
end
if(n==6)
    handles.s=structural_dynamics;
end 
if(n==7)
    handles.s=vibrationdata_shock;
end 
if(n==8)
    handles.s=sdof_response_various;    
end 
if(n==9)
    handles.s=dboct;    
end 
if(n==10)
    handles.s=statistical_distributions;    
end 
if(n==11)
    handles.s=wavelength;    
end 
if(n==12)
    handles.s=vibrationdata_acoustics_vibroacoustics;    
end
if(n==13)
    handles.s=vibrationdata_rotation;    
end 
if(n==14)
    handles.s=plot_utilities;    
end 
if(n==15)
    handles.s=sound_editor;    
end
if(n==16)
    handles.s=aliasing_frequencies;    
end 
if(n==17)
    handles.s=wind_waves;    
end 
if(n==18)
    handles.s=fatigue_toolbox;    
end 
if(n==19)
    handles.s=Steinberg_toolbox;    
end 
if(n==20)
    handles.s=ESS_screening_strength;    
end 
if(n==21)
    handles.s=nastran_toolbox;    
end 
if(n==22)
    handles.s=sandwich_panel_toolbox;    
end 
if(n==23)
    handles.s=envelope_toolbox;    
end 


set(handles.s,'Visible','on'); 


% --- Executes on button press in pushbutton_import_data.
function pushbutton_import_data_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_import_data (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.s=vibrationdata_read_main;
set(handles.s,'Visible','on'); 


% --- Executes on button press in pushbutton_export.
function pushbutton_export_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_export (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.s=export_junction;
set(handles.s,'Visible','on'); 


% --- Executes on selection change in listbox_misc_II.
function listbox_misc_II_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_misc_II (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_misc_II contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_misc_II


% --- Executes during object creation, after setting all properties.
function listbox_misc_II_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_misc_II (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_misc_II.
function pushbutton_misc_II_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_misc_II (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


n=get(handles.listbox_misc_II,'Value');

if(n==1)
    handles.s=vibrationdata_linear_algebra;      
end
if(n==2)
    handles.s=structural_static_analysis;      
end
if(n==3)
    handles.s=vibrationdata_fracture;      
end
if(n==4)
   handles.s=traveling_wave_animation; 
end
if(n==5)
    handles.s=burst_overpressure;    
end 
if(n==6)
    handles.s=fluid_systems;    
end 
if(n==7)
    handles.s=vibrationdata_panel_flutter;    
end 
if(n==8)
    handles.s=vibrationdata_unit_conversion;    
end 
if(n==9)
    handles.s=vibrationdata_time_conversion;    
end 
if(n==10)
    handles.s=vibrationdata_atmospheric_properties;    
end 
if(n==11)
    handles.s=vibrationdata_reynolds;    
end 
if(n==12)
    handles.s=vibrationdata_interpolate_coordinates;    
end 
if(n==13)
    handles.s=dB_Addition_overall;    
end 
if(n==14)
    handles.s=dB_Margin_RSS;    
end 

set(handles.s,'Visible','on'); 


% --- Executes on button press in pushbutton_close_all_plots.
function pushbutton_close_all_plots_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_close_all_plots (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%%% evalin('base', 'close all')
setappdata(0,'fig_num',1);


Figures = findobj( 'Type', 'Figure' , '-not' , 'Tag' , get( handles.output , 'Tag' ) );
NFigures = length( Figures );
for nFigures = 1 : NFigures
  close( Figures( nFigures ) );
end

msgbox('Plots Cleared'); 


% --- Executes on button press in pushbutton_application_data.
function pushbutton_application_data_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_application_data (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

appdata = get(0,'ApplicationData');
fnsx = fieldnames(appdata);
for ii = 1:numel(fnsx)
  rmappdata(0,fnsx{ii});
end
% appdata = get(0,'ApplicationData') %make sure it's gone

msgbox('Data Cleared'); 

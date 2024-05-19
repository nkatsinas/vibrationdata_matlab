function varargout = vibrationdata_cepstrum(varargin)
% VIBRATIONDATA_CEPSTRUM MATLAB code for vibrationdata_cepstrum.fig
%      VIBRATIONDATA_CEPSTRUM, by itself, creates a new VIBRATIONDATA_CEPSTRUM or raises the existing
%      singleton*.
%
%      H = VIBRATIONDATA_CEPSTRUM returns the handle to a new VIBRATIONDATA_CEPSTRUM or the handle to
%      the existing singleton*.
%
%      VIBRATIONDATA_CEPSTRUM('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in VIBRATIONDATA_CEPSTRUM.M with the given input arguments.
%
%      VIBRATIONDATA_CEPSTRUM('Property','Value',...) creates a new VIBRATIONDATA_CEPSTRUM or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before vibrationdata_cepstrum_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to vibrationdata_cepstrum_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% edit_input_array the above text to modify the response to help vibrationdata_cepstrum

% Last Modified by GUIDE v2.5 01-Jun-2013 19:31:36

% Begin initialization code - DO NOT EDIT_INPUT_ARRAY
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @vibrationdata_cepstrum_OpeningFcn, ...
                   'gui_OutputFcn',  @vibrationdata_cepstrum_OutputFcn, ...
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
% End initialization code - DO NOT EDIT_INPUT_ARRAY


% --- Executes just before vibrationdata_cepstrum is made visible.
function vibrationdata_cepstrum_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to vibrationdata_cepstrum (see VARARGIN)

% Choose default command line output for vibrationdata_cepstrum
handles.output = hObject;

set(handles.listbox_method,'Value',1);
set(handles.listbox_mean_removal,'Value',1);
set(handles.listbox_window,'Value',1);
set(handles.edit_output_array,'Enable','off');
set(handles.pushbutton_save,'Enable','off');

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes vibrationdata_cepstrum wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = vibrationdata_cepstrum_OutputFcn(hObject, eventdata, handles) 
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
n=get(handles.listbox_output,'Value');

if(n==1)
    data=getappdata(0,'cepstrum');
else
    data=getappdata(0,'autocepstrum');
end
   

output_name=get(handles.edit_output_array,'String');
assignin('base', output_name,data);

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

% Hint: edit_input_array controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox16.
function listbox16_Callback(hObject, eventdata, handles)
% hObject    handle to listbox16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox16 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox16


% --- Executes during object creation, after setting all properties.
function listbox16_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox16 (see GCBO)
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

% Hint: edit_input_array controls usually have a white background on Windows.
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

set(handles.text_input_array_name,'Visible','on');
set(handles.edit_input_array,'Visible','on');

set(handles.edit_output_array,'Enable','off');


set(handles.pushbutton_save,'Enable','off');

set(handles.edit_input_array,'String',' ');

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
set(handles.edit_output_array,'Enable','on');
set(handles.pushbutton_save,'Enable','on');

yname=get(handles.edit_ylabel,'String');

k=get(handles.listbox_method,'Value');
 
if(k==1)
  FS=get(handles.edit_input_array,'String');
  THM=evalin('base',FS);   
else
  THM=getappdata(0,'THM');
end

amp=double(THM(:,2));

n=length(amp);
dur=THM(n,1)-THM(1,1);
dt=dur/(n-1);

m_choice=get(handles.listbox_mean_removal,'Value');

h_choice=get(handles.listbox_window,'Value');

if(h_choice==2)
    m_choice=1;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

YS=get(handles.edit_ylabel,'String');

fig_num=1;
figure(fig_num);
fig_num=fig_num+1;
plot(THM(:,1),THM(:,2));
grid on;
title('Time History');
xlabel('Time (sec)')
ylabel(YS);

%
    t=THM(:,1);
    t=t-t(1);
    amp=THM(:,2);
    n=length(amp);
    N=2^floor(log(n)/log(2));    
%
    out4 = sprintf(' time history length = %d ',n);
    disp(out4)
%
    if(N<n)  % zeropad
        N=2*N;
        amp(n+1:N)=0;
    end
%    
    NHS=N/2;
%
    [freq,full,phase,complex_FFT]=...
                                 full_FFT_core(m_choice,h_choice,amp,N,dt);    
%
    clear magnitude_FFT;
    magnitude_FFT=[freq full];
%    
    [~,fmax]=find_max(magnitude_FFT);
%
    out5 = sprintf('\n Peak occurs at %10.5g Hz \n',fmax);
    disp(out5)
%
    figure(fig_num);    
    fig_num=fig_num+1; 
    subplot(3,1,1);
    plot(freq,phase)
    title('FFT Magnitude & Phase ');
    xlabel(' Frequency (Hz)');
    ylabel(' Phase (deg)'); 
    grid on; 
    set(gca,'MinorGridLineStyle','none','GridLineStyle',':','XScale',...
                         'lin','YScale','lin','ytick',[-180,-90,0,90,180]);
                     
    subplot(3,1,[2 3]);
    plot(freq,full)
    xlabel(' Frequency (Hz)');
    ylabel(' Magnitude');
    grid on; 
    zoom on;                     
                     
    a=complex(complex_FFT(:,2),complex_FFT(:,3));
    b=log(abs(a));
%                
                                          
% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
    c=ifft(b);
    figure(fig_num);
    fig_num=fig_num+1;
%
    plot(t(2:NHS),real(c(2:NHS)));
    title('Cepstrum  ifft(log(abs(fft(a))))');
    ylabel('Amplitude');
    xlabel('Quefrency(sec)');
    grid on;
    
    
t=fix_size(t);

cr=real(c);

cepstrum=[t(2:NHS) cr(2:NHS)];

setappdata(0,'cepstrum',cepstrum); 

    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% autocorrelation

ac1 = ifft(abs(fft(amp, 2*n-1)).^2);

ac1=ac1/n;

sz=size(ac1);
if(sz(2)>sz(1))
    ac1=ac1';
end

m=floor(length(ac1)/2);

ac2 = ac1(1:m);

ac2r=flipud(ac2);

ac2r(m)=[];

ac3=[ ac2r ; ac2];

n=length(ac3);

t=linspace(0,(n-1)*dt,n);

t=t-t(n)/2;

[~,I] = min(abs(t));

t(I)=0;


sz=size(t);
if(sz(2)>sz(1))
    t=t';
end

xc=[t,ac3];

%
figure(fig_num);
fig_num=fig_num+1;
plot(t,ac3);
xlabel('Delay (sec)');
ylabel('Rxx');
title('Autocorrelation');
grid on;
%
    t=xc(:,1);
    t=t-t(1);
    amp=xc(:,2);
    n=length(amp);
    N=2^floor(log(n)/log(2));    
%
    out4 = sprintf(' Autocorrelation length = %d ',n);
    disp(out4)
%    
    NHS=N/2;
%
    [freq,full,phase,complex_FFT]=...
                                 full_FFT_core(m_choice,h_choice,amp,N,dt);    
%
    clear magnitude_FFT;
    magnitude_FFT=[freq full];
%
    figure(fig_num);
    fig_num=fig_num+1;
%
    plot(freq,full);
    title('Fourier Magnitude of Autocorrelation');
    ylabel('Magnitude');
    xlabel('Frequency (Hz)');
    grid on;
%
    a=complex(complex_FFT(:,2),complex_FFT(:,3));
    
    a=abs(a);
    
    na=length(a);
    
    b=zeros(na,1);
    for i=1:na
      
        ccc=log10(a(i));
        
        
        if(ccc >-1.0e+20 )
            if(ccc<1.0e+20)
                b(i)=ccc;
            end
        end       
        
    end
%    
    c=ifft(b);    
%
    NHS=floor(0.5*length(freq));
%
    figure(fig_num);
    fig_num=fig_num+1;
%
    plot(t(2:NHS),real(c(2:NHS)));
    title('Autocepstrum  ifft(log(abs(fft(autocorrelation))))');
    ylabel('Amplitude');
    xlabel('Quefrency(sec)');
    grid on;

acr=real(c);

acr=fix_size(acr);
    
autocepstrum=[t(2:NHS) acr(2:NHS)];

setappdata(0,'autocepstrum',autocepstrum); 




% --- Executes on button press in pushbutton_return.
function pushbutton_return_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_return (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
delete(vibrationdata_cepstrum);

% --- Executes on selection change in listbox_mean_removal.
function listbox_mean_removal_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_mean_removal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_mean_removal contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_mean_removal


% --- Executes during object creation, after setting all properties.
function listbox_mean_removal_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_mean_removal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_window.
function listbox_window_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_window (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_window contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_window


% --- Executes during object creation, after setting all properties.
function listbox_window_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_window (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
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

% Hint: edit_input_array controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit15_Callback(hObject, eventdata, handles)
% hObject    handle to edit15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit15 as text
%        str2double(get(hObject,'String')) returns contents of edit15 as a double


% --- Executes during object creation, after setting all properties.
function edit15_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit_input_array controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_output.
function listbox_output_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_output (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_output contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_output


% --- Executes during object creation, after setting all properties.
function listbox_output_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_output (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

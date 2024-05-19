function varargout = signal_beat_frequency(varargin)
% SIGNAL_BEAT_FREQUENCY MATLAB code for signal_beat_frequency.fig
%      SIGNAL_BEAT_FREQUENCY, by itself, creates a new SIGNAL_BEAT_FREQUENCY or raises the existing
%      singleton*.
%
%      H = SIGNAL_BEAT_FREQUENCY returns the handle to a new SIGNAL_BEAT_FREQUENCY or the handle to
%      the existing singleton*.
%
%      SIGNAL_BEAT_FREQUENCY('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SIGNAL_BEAT_FREQUENCY.M with the given input arguments.
%
%      SIGNAL_BEAT_FREQUENCY('Property','Value',...) creates a new SIGNAL_BEAT_FREQUENCY or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before signal_beat_frequency_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to signal_beat_frequency_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help signal_beat_frequency

% Last Modified by GUIDE v2.5 27-Jun-2013 13:57:35

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @signal_beat_frequency_OpeningFcn, ...
                   'gui_OutputFcn',  @signal_beat_frequency_OutputFcn, ...
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


% --- Executes just before signal_beat_frequency is made visible.
function signal_beat_frequency_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to signal_beat_frequency (see VARARGIN)

% Choose default command line output for signal_beat_frequency
handles.output = hObject;

set(handles.listbox_number,'Value',1);

for i = 1:2
   for j=1:2
      data_s{i,j} = '';     
   end 
   data_s{i,3} = '0';   
end
set(handles.uitable_data,'Data',data_s); 

set(handles.edit_output_array,'Enable','off');
set(handles.pushbutton_save,'Enable','off');

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes signal_beat_frequency wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = signal_beat_frequency_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton_calculate.



% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


  


% --- Executes on button press in pushbutton_return.
function pushbutton_return_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_return (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
delete(signal_beat_frequency);


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


% --- Executes on selection change in listbox_number.
function listbox_number_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_number (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_number contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_number

n=get(hObject,'Value');

for i = 1:(n+1)
   for j=1:2
      data_s{i,j} = '';     
   end  
   data_s{i,3} = '0';   
end
set(handles.uitable_data,'Data',data_s);       

set(handles.edit_output_array,'Enable','off');
set(handles.pushbutton_save,'Enable','off');

% --- Executes during object creation, after setting all properties.
function listbox_number_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_number (see GCBO)
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


% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


    m=get(handles.listbox_number,'Value');
    
    N=m+1;
    
    A=char(get(handles.uitable_data,'Data'));
    
    B=str2num(A);
    
    peak=B(1:N);
    freq=B((N+1):(2*N)); 
    phase=B((2*N+1):(3*N)); 
    
    phase=phase*pi/180;
    
    tmax=str2num(get(handles.edit_duration,'String'));
    sr=str2num(get(handles.edit_sr,'String'));
    
    dt=1./sr;
    if(max(freq)>(sr/20))
       sr=max(freq)*20;
       dt=1/sr;
       msgbox('Note: sample rate increased ','Warning','warn');
       out1=sprintf('%8.4g',sr);
       set(handles.edit_sr,'String',out1);
    end    
%
%    
    omega=2.*pi*freq;
%    
    np=round(tmax/dt);
    TT=linspace(0,np*dt,(np+1)); 
    a = zeros(1,(np+1));  
%    
    for i=1:N
        a=a+peak(i)*sin(omega(i)*TT-phase(i));
    end  
    
    TT=fix_size(TT);
    a=fix_size(a);
    
    figure(1);
    plot(TT,a);
    if(i==2)
        tstring='Beat Frequency Effect';
    else
        tstring='Multiple Sine Tones';        
    end
    title(tstring);
    grid on;
    xlabel('Time (sec)');
    ylabel('Amplitude');
    
    signal=[TT a];
    setappdata(0,'signal',signal);
    
    set(handles.edit_output_array,'Enable','on');
    set(handles.pushbutton_save,'Enable','on');  

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

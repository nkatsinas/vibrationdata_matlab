function varargout = sine_amplitude(varargin)
% SINE_AMPLITUDE MATLAB code for sine_amplitude.fig
%      SINE_AMPLITUDE, by itself, creates a new SINE_AMPLITUDE or raises the existing
%      singleton*.
%
%      H = SINE_AMPLITUDE returns the handle to a new SINE_AMPLITUDE or the handle to
%      the existing singleton*.
%
%      SINE_AMPLITUDE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SINE_AMPLITUDE.M with the given input arguments.
%
%      SINE_AMPLITUDE('Property','Value',...) creates a new SINE_AMPLITUDE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before sine_amplitude_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to sine_amplitude_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help sine_amplitude

% Last Modified by GUIDE v2.5 10-Aug-2013 15:10:00

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @sine_amplitude_OpeningFcn, ...
                   'gui_OutputFcn',  @sine_amplitude_OutputFcn, ...
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


% --- Executes just before sine_amplitude is made visible.
function sine_amplitude_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to sine_amplitude (see VARARGIN)

% Choose default command line output for sine_amplitude
handles.output = hObject;


set(handles.edit_results,'Enable','off');

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes sine_amplitude wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = sine_amplitude_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in listbox_input_type.
function listbox_input_type_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_input_type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_input_type contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_input_type
n=get(hObject,'Value');

s1='Enter Displacement (peak-to-peak)';
s2='Enter Displacement (zero-to-peak)';
s3='Enter Velocity';
s4='Enter Acceleration';

if(n==1 || n==2)
    str{1}='inch';
    str{2}='mm';
end

if(n==1)
    set(handles.text_select_input,'String',s1); 
end
if(n==2)
    set(handles.text_select_input,'String',s2);      
end
if(n==3)
    set(handles.text_select_input,'String',s3);
    str{1}='inch/sec';
    str{2}='m/sec';
end
if(n==4)
    set(handles.text_select_input,'String',s4);  
    str{1}='G';
    str{2}='m/sec^2';
end

set(handles.listbox_unit,'String',str);
str=' ';
set(handles.edit_results,'String',str);
set(handles.edit_results,'Enable','off');



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



function edit_amplitude_Callback(hObject, eventdata, handles)
% hObject    handle to edit_amplitude (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_amplitude as text
%        str2double(get(hObject,'String')) returns contents of edit_amplitude as a double


% --- Executes during object creation, after setting all properties.
function edit_amplitude_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_amplitude (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
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
str=' ';
set(handles.edit_results,'String',str);
set(handles.edit_results,'Enable','off');

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



function edit_freq_Callback(hObject, eventdata, handles)
% hObject    handle to edit_freq (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_freq as text
%        str2double(get(hObject,'String')) returns contents of edit_freq as a double


% --- Executes during object creation, after setting all properties.
function edit_freq_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_freq (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
n=get(handles.listbox_input_type,'Value');
m=get(handles.listbox_unit,'Value');

amp=str2num(get(handles.edit_amplitude,'String'));
freq=str2num(get(handles.edit_freq,'String'));

omega=2*pi*freq;
om2=omega^2;

mm_per_in=25.4;
in_per_mm=1/mm_per_in;

m_per_in=mm_per_in/1000;
in_per_m=1/m_per_in;

dzp_in=0;
dzp_mm=0;
dpp_in=0;
dpp_mm=0;

if(n==1)
%
   if(m==1)  % inch input
       dpp_in=amp;
       dpp_mm=amp*mm_per_in;       
   else
       dpp_mm=amp;
       dpp_in=amp*in_per_mm;     
   end
%
   dzp_in=dpp_in/2;
   dzp_mm=dpp_mm/2;
%
end

if(n==2)
%
   if(m==1)  % inch input
       dzp_in=amp;
       dzp_mm=amp*mm_per_in;       
   else
       dzp_mm=amp;
       dzp_in=amp*in_per_mm;     
   end
%
end
%
if(n==3)
%
   if(m==1)  % in/sec input
     v_ips=amp;
     v_mps=amp*m_per_in;  
%
   else  % m/sec
     v_mps=amp; 
     v_ips=amp*in_per_m;
%
   end
%
   dzp_in=v_ips/omega;
   dzp_mm=(v_mps/omega)*1000;
%
end
%
if(n==4)
%
   if(m==1)  % G input
     a_g=amp;
     a_mps2=amp*9.81; 
%
   else  % m/sec
     a_mps2=amp; 
     a_g=amp/9.81;
%
   end
%
   dzp_in=(a_g/om2)*386;
   dzp_mm=(a_mps2/om2)*1000;
%
end
%
if(n~=1)
   dpp_in=dzp_in*2;
   dpp_mm=dzp_mm*2;
end
%
if(n~=3)
   v_ips=omega*dzp_in;
   v_mps=omega*(dzp_mm)/1000;
end
%
if(n~=4)
   a_g=om2*dzp_in/386;
   a_mps2=om2*dzp_mm/1000;
end
%

p=1;
str{p}=sprintf('Frequency = %8.4g Hz',freq);
p=p+1;
str{p}=sprintf('\n Displacement (peak-to-peak)');
p=p+1;
str{p}=sprintf('%8.4g in',dpp_in);
p=p+1;
str{p}=sprintf('%8.4g mm',dpp_mm);
p=p+1;
str{p}=sprintf('\n Displacement (zero-to-peak)');
p=p+1;
str{p}=sprintf('%8.4g in',dzp_in);
p=p+1;
str{p}=sprintf('%8.4g mm',dzp_mm);
p=p+1;
str{p}=sprintf('\n Velocity (zero-to-peak)');
p=p+1;
str{p}=sprintf('%8.4g in/sec',v_ips);
p=p+1;
str{p}=sprintf('%8.4g m/sec',v_mps);
p=p+1;
str{p}=sprintf('%8.4g cm/sec',v_mps*100);
p=p+1;
str{p}=sprintf('\n Accceleration (zero-to-peak)');
p=p+1;
str{p}=sprintf('%8.4g G',a_g);
p=p+1;
str{p}=sprintf('%8.4g m/sec^2',a_mps2);
p=p+1;

set(handles.edit_results,'String',str);
set(handles.edit_results,'Visible','on');
set(handles.edit_results,'Enable','on');

% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
delete(sine_amplitude);

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


% --- Executes on key press with focus on edit_amplitude and none of its controls.
function edit_amplitude_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_amplitude (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
str=' ';
set(handles.edit_results,'String',str);
set(handles.edit_results,'Enable','off');


% --- Executes on key press with focus on edit_freq and none of its controls.
function edit_freq_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_freq (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
str=' ';
set(handles.edit_results,'String',str);
set(handles.edit_results,'Enable','off');

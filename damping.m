function varargout = damping(varargin)
% DAMPING MATLAB code for damping.fig
%      DAMPING, by itself, creates a new DAMPING or raises the existing
%      singleton*.
%
%      H = DAMPING returns the handle to a new DAMPING or the handle to
%      the existing singleton*.
%
%      DAMPING('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DAMPING.M with the given input arguments.
%
%      DAMPING('Property','Value',...) creates a new DAMPING or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before damping_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to damping_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help damping

% Last Modified by GUIDE v2.5 12-Aug-2013 14:28:26

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @damping_OpeningFcn, ...
                   'gui_OutputFcn',  @damping_OutputFcn, ...
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


% --- Executes just before damping is made visible.
function damping_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to damping (see VARARGIN)

% Choose default command line output for damping
handles.output = hObject;

handles.frequency=100;
handles.damping=0;
handles.frequency_unit=1;
handles.damping_unit=1;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes damping wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = damping_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in frequencylistbox.
function frequencylistbox_Callback(hObject, eventdata, handles)
% hObject    handle to frequencylistbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns frequencylistbox contents as cell array
%        contents{get(hObject,'Value')} returns selected item from frequencylistbox

handles.frequency_unit= get(hObject,'value');
guidata(hObject, handles);

calculate(hObject, eventdata, handles);

% --- Executes during object creation, after setting all properties.
function frequencylistbox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to frequencylistbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function frequencyeditbox_Callback(hObject, eventdata, handles)
% hObject    handle to frequencyeditbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of frequencyeditbox as text
%        str2double(get(hObject,'String')) returns contents of frequencyeditbox as a double

string=get(hObject,'String');
handles.frequency=str2num(string);
guidata(hObject, handles);

calculate(hObject, eventdata, handles);



% --- Executes during object creation, after setting all properties.
function frequencyeditbox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to frequencyeditbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function dampingeditbox_Callback(hObject, eventdata, handles)
% hObject    handle to dampingeditbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of dampingeditbox as text
%        str2double(get(hObject,'String')) returns contents of dampingeditbox as a double

string=get(hObject,'String');
handles.damping=str2num(string);
guidata(hObject, handles);

calculate(hObject, eventdata, handles);

% --- Executes during object creation, after setting all properties.
function dampingeditbox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to dampingeditbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in dampinglistbox.
function dampinglistbox_Callback(hObject, eventdata, handles)
% hObject    handle to dampinglistbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns dampinglistbox contents as cell array
%        contents{get(hObject,'Value')} returns selected item from dampinglistbox

handles.damping_unit= get(hObject,'value');

guidata(hObject, handles);
calculate(hObject, eventdata, handles);

% --- Executes during object creation, after setting all properties.
function dampinglistbox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to dampinglistbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Answer_Callback(hObject, eventdata, handles)
% hObject    handle to Answer (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Answer as text
%        str2double(get(hObject,'String')) returns contents of Answer as a double


% --- Executes during object creation, after setting all properties.
function Answer_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Answer (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function calculate(hObject, eventdata, handles)
%  user defined function

tpi=2*pi;

if(handles.frequency_unit==1)
    fn=handles.frequency;
    om=tpi*fn;
else
    om=handles.frequency;
    fn=om/tpi;    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

dd=handles.damping;

if(handles.damping_unit==1)  % Q
   Q=dd;
end
if(handles.damping_unit==2)  % fraction of critical damping
   Q=1/(2*dd); 
end
if(handles.damping_unit==3)  % loss factor
   Q=1/dd; 
end
if(handles.damping_unit==4)  % 3 dB Bandwidth delta omega
   Q=om/dd;
end
if(handles.damping_unit==5)  % 3 dB Bandwidth delta f
   Q=fn/dd; 
end
if(handles.damping_unit==6)  % damping frequency
   Q=(om/(4*pi))/dd;    
end
if(handles.damping_unit==7)  % decay constant
   Q=(om/2)/dd;   
end
if(handles.damping_unit==8)  % time_constant
   Q=dd*om/2;
end
if(handles.damping_unit==9)  % reverberation time
   Q=dd*om/13.8; 
end
if(handles.damping_unit==10)  % decay rate
   Q=4.34*om/dd; 
end
if(handles.damping_unit==11)  % logarithmic decrement
   Q=pi/dd; 
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

zeta=1/(2*Q);
loss_factor=1/Q;
three_dB_om=om/Q;
three_dB_f=fn/Q;
fd=(om/(4*pi))/Q;
sigma=(om/2)/Q;
tau=2*Q/om;
RT60=13.8*Q/om;
D=4.34*om/Q;
log_dec=pi/Q;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(handles.damping_unit==1)  % Q
   Q=handles.damping; 
end
if(handles.damping_unit==2)  % fraction of critical damping
   zeta=handles.damping;     
end
if(handles.damping_unit==3)  % loss factor
   loss_factor=handles.damping;     
end
if(handles.damping_unit==4)  % 3 dB Bandwidth delta omega
    three_dB_om=handles.damping;
end
if(handles.damping_unit==5)  % 3 dB Bandwidth delta f
   three_dB_f=handles.damping; 
end
if(handles.damping_unit==6)  % damping frequency
   fd=handles.damping; 
end
if(handles.damping_unit==7)  % decay constant
   sigma=handles.damping; 
end
if(handles.damping_unit==8)  % time_constant
  tau=handles.damping;  
end
if(handles.damping_unit==9)  % reverberation time
   RT60=handles.damping; 
end
if(handles.damping_unit==10)  % decay rate
   D=handles.damping; 
end
if(handles.damping_unit==11)  % logarithmic decrement
   log_dec=handles.damping; 
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

string1=sprintf('quality factor Q=%8.4g',Q);
string2=sprintf('\nfraction of critical damping [zeta]=%8.4g',zeta);
string3=sprintf('\nloss factor [eta]=%8.4g',loss_factor);
string4=sprintf('\n\n3 dB Bandwidth [delta omega]=%8.4g rad/sec',three_dB_om);
string5=sprintf('\n3 dB Bandwidth [delta f]=%8.4g Hz',three_dB_f);
string6=sprintf('\n\ndamping frequency [fd]=%8.4g Hz',fd);
string7=sprintf('\ndecay constant [sigma]=%8.4g (1/sec)',sigma);
string8=sprintf('\n\ntime constant [tau]= %8.4g sec',tau);
string9=sprintf('\nreverberation time [RT60]=%8.4g sec ',RT60);
string10=sprintf('\n\ndecay Rate D=%8.4g dB/sec',D);
string11=sprintf('\nlogarithmic decrement [delta]=%8.4g',log_dec);

big_string=strcat(string1,string2);
big_string=strcat(big_string,string3);
big_string=strcat(big_string,string4);
big_string=strcat(big_string,string5);
big_string=strcat(big_string,string6);
big_string=strcat(big_string,string7);
big_string=strcat(big_string,string8);
big_string=strcat(big_string,string9);
big_string=strcat(big_string,string10);
big_string=strcat(big_string,string11);

set(handles.Answer,'String',big_string);


% --- Executes on key press with focus on frequencyeditbox and none of its controls.
function frequencyeditbox_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to frequencyeditbox (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)

set(handles.Answer,'String','');



% --- Executes on key press with focus on dampingeditbox and none of its controls.
function dampingeditbox_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to dampingeditbox (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.Answer,'String','');


% --- Executes on button press in pushbutton_return.
function pushbutton_return_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_return (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
delete(damping);

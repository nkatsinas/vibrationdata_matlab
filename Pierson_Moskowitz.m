function varargout = Pierson_Moskowitz(varargin)
% PIERSON_MOSKOWITZ MATLAB code for Pierson_Moskowitz.fig
%      PIERSON_MOSKOWITZ, by itself, creates a new PIERSON_MOSKOWITZ or raises the existing
%      singleton*.
%
%      H = PIERSON_MOSKOWITZ returns the handle to a new PIERSON_MOSKOWITZ or the handle to
%      the existing singleton*.
%
%      PIERSON_MOSKOWITZ('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PIERSON_MOSKOWITZ.M with the given input arguments.
%
%      PIERSON_MOSKOWITZ('Property','Value',...) creates a new PIERSON_MOSKOWITZ or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Pierson_Moskowitz_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Pierson_Moskowitz_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Pierson_Moskowitz

% Last Modified by GUIDE v2.5 10-Jul-2014 11:40:13

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Pierson_Moskowitz_OpeningFcn, ...
                   'gui_OutputFcn',  @Pierson_Moskowitz_OutputFcn, ...
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


% --- Executes just before Pierson_Moskowitz is made visible.
function Pierson_Moskowitz_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Pierson_Moskowitz (see VARARGIN)

% Choose default command line output for Pierson_Moskowitz
handles.output = hObject;

set(handles.pushbutton_save,'Enable','off');

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Pierson_Moskowitz wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Pierson_Moskowitz_OutputFcn(hObject, eventdata, handles) 
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

delete(Pierson_Moskowitz);


% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

set(handles.pushbutton_save,'Enable','on');

n=get(handles.listbox_speed,'Value');

U=9+n;
%
g = 9.81;
alpha = 8.1e-03;
beta=0.74;
omega_zero =g/U; 
tpi=2*pi;
%
fm=(0.877*g/U)/tpi;
%
fmax=0.5;
%
m=200;
%
df = fmax/m;
%
f=zeros(m,1);
% omega=zeros(m,1);
Sf=zeros(m,1);
%
ms=0;
for i=1:m
    if( (i*df)<=fmax )
        f(i)=i*df;
%        omega(i)=tpi*f;
        A=alpha*g^2/( (f(i)^5)*(tpi^4) );
        Sf(i)=A*exp(-(5/4)*(fm/f(i))^4);
        ms=ms+Sf(i)*df;
    end
end
%
drms=sqrt(ms);
%
out1=sprintf('\n Wind speed = %8.4g m/sec',U);
disp(out1);
%
out2=sprintf('\n Overall level = %8.4g m RMS',drms);
disp(out2);
%
out3=sprintf('\n Peak frequency = %8.4g Hz ',fm);
disp(out3);
%
figure(1);
plot(f,Sf);
grid on;
%
ylabel('Wave Spectral Density (m^2/Hz)');
xlabel('Frequency (Hz)');
out1=sprintf(' Pierson-Moskowitz Spectrum  U = %g m/sec at 19.5 m ',U);
title(out1);
%
xlim([0,fmax]);
%
Ocean_PSD=[f Sf];
%
setappdata(0,'Ocean_PSD',Ocean_PSD);



% --- Executes on selection change in listbox_speed.
function listbox_speed_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_speed (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_speed contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_speed


% --- Executes during object creation, after setting all properties.
function listbox_speed_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_speed (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_save.
function pushbutton_save_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

data=getappdata(0,'Ocean_PSD');
%

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

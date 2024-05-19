function varargout = one_third_octave_pressure_to_psd(varargin)
% ONE_THIRD_OCTAVE_PRESSURE_TO_PSD MATLAB code for one_third_octave_pressure_to_psd.fig
%      ONE_THIRD_OCTAVE_PRESSURE_TO_PSD, by itself, creates a new ONE_THIRD_OCTAVE_PRESSURE_TO_PSD or raises the existing
%      singleton*.
%
%      H = ONE_THIRD_OCTAVE_PRESSURE_TO_PSD returns the handle to a new ONE_THIRD_OCTAVE_PRESSURE_TO_PSD or the handle to
%      the existing singleton*.
%
%      ONE_THIRD_OCTAVE_PRESSURE_TO_PSD('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ONE_THIRD_OCTAVE_PRESSURE_TO_PSD.M with the given input arguments.
%
%      ONE_THIRD_OCTAVE_PRESSURE_TO_PSD('Property','Value',...) creates a new ONE_THIRD_OCTAVE_PRESSURE_TO_PSD or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before one_third_octave_pressure_to_psd_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to one_third_octave_pressure_to_psd_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help one_third_octave_pressure_to_psd

% Last Modified by GUIDE v2.5 13-Apr-2021 09:44:42

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @one_third_octave_pressure_to_psd_OpeningFcn, ...
                   'gui_OutputFcn',  @one_third_octave_pressure_to_psd_OutputFcn, ...
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


% --- Executes just before one_third_octave_pressure_to_psd is made visible.
function one_third_octave_pressure_to_psd_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to one_third_octave_pressure_to_psd (see VARARGIN)

% Choose default command line output for one_third_octave_pressure_to_psd
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes one_third_octave_pressure_to_psd wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = one_third_octave_pressure_to_psd_OutputFcn(hObject, eventdata, handles) 
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

delete(one_third_octave_pressure_to_psd);


% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

try
    FS=get(handles.edit_input_array,'String');
    THM=evalin('base',FS);  
catch
    warndlg('Input Array does not exist.  Try again.')
    return;    
end
    
sz=size(THM);

num=sz(1);

psd=zeros(num,1);

psd(:,1)=THM(:,1);

%%%%%

c=2^(1/6)-1/(2^(1/6));

ms=0;

for i=1:num
    ms=ms+(THM(i,2)/sqrt(2))^2;
    bw=THM(i,2)*c; 
    psd(i,2)=(THM(i,2)/sqrt(2))^2/bw; 
end

rms=sqrt(ms);

%%%%%

iu=get(handles.listbox_unit,'Value');

fig_num=1;
x_label='Frequency (Hz)';
ppp=psd;
fmin=psd(1,1);
fmax=psd(end,1);
if(iu==1)
    t_string=sprintf('Pressure PSD  %7.3g psi rms',rms);
    y_label='Pressure (psi^2/Hz)';
else
    t_string=sprintf('Pressure PSD  %7.3g Pa rms',rms); 
    y_label='Pressure (Pa^2/Hz)';    
end

md=6;
[fig_num]=plot_loglog_function_md(fig_num,x_label,y_label,t_string,ppp,fmin,fmax,md);

output_name=get(handles.edit_output_array,'String');

try
    assignin('base', output_name, psd);
catch
    warndlg('Enter output name');
    return;
end

h = msgbox('Save Complete');



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

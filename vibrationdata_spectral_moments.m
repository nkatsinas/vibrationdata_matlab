function varargout = vibrationdata_spectral_moments(varargin)
% VIBRATIONDATA_SPECTRAL_MOMENTS MATLAB code for vibrationdata_spectral_moments.fig
%      VIBRATIONDATA_SPECTRAL_MOMENTS, by itself, creates a new VIBRATIONDATA_SPECTRAL_MOMENTS or raises the existing
%      singleton*.
%
%      H = VIBRATIONDATA_SPECTRAL_MOMENTS returns the handle to a new VIBRATIONDATA_SPECTRAL_MOMENTS or the handle to
%      the existing singleton*.
%
%      VIBRATIONDATA_SPECTRAL_MOMENTS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in VIBRATIONDATA_SPECTRAL_MOMENTS.M with the given input arguments.
%
%      VIBRATIONDATA_SPECTRAL_MOMENTS('Property','Value',...) creates a new VIBRATIONDATA_SPECTRAL_MOMENTS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before vibrationdata_spectral_moments_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to vibrationdata_spectral_moments_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help vibrationdata_spectral_moments

% Last Modified by GUIDE v2.5 11-Jan-2022 11:59:45

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @vibrationdata_spectral_moments_OpeningFcn, ...
                   'gui_OutputFcn',  @vibrationdata_spectral_moments_OutputFcn, ...
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


% --- Executes just before vibrationdata_spectral_moments is made visible.
function vibrationdata_spectral_moments_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to vibrationdata_spectral_moments (see VARARGIN)

% Choose default command line output for vibrationdata_spectral_moments
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes vibrationdata_spectral_moments wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = vibrationdata_spectral_moments_OutputFcn(hObject, eventdata, handles) 
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

disp(' ');
disp(' * * * * * *');
disp(' ');

try  
    FS=get(handles.edit_input_array,'String');
    THM=evalin('base',FS);  
catch
    warndlg('Input Array does not exist.  Try again.')
    return;
end

fmin=str2num(get(handles.edit_fmin,'String'));
fmax=str2num(get(handles.edit_fmax,'String'));

T=str2num(get(handles.edit_duration,'String'));
yu=get(handles.edit_yu,'String');

f=THM(:,1);
a=THM(:,2);

fig_num=1;

yyy=getappdata(0,'wnd_label'); 

ylab=sprintf('%s (%s^2/Hz)',yyy,yu);
xlab='Frequency (Hz)';
%

if(f(1)<0.001)
    f(1)=0.001;
end

df=0.5;

[s,rms]=calculate_PSD_slopes_no(f,a);

[fi,ai]=interpolate_PSD(f,a,s,df);

t_string=sprintf('Power Spectral Density %6.3g %s RMS Overall ',rms,yu);    
[fig_num,~]=plot_PSD_function(fig_num,xlab,ylab,t_string,[f,a],fmin,fmax);

out1=sprintf(' m0=%8.4g \n m1=%8.4g  \n m2=%8.4g  \n m4=%8.4g \n',m0,m1,m2,m4);
disp(out1);


[EP,vo,m0,m1,m2,m4,alpha2,e]=spectal_moments_alt(fi,ai,df);

data=sprintf(' %8.4g \t %8.4g \t %8.4g \t %8.4g \t %8.4g \t %8.4g \t %8.4g \t %8.4g ',m0,m1,m2,m4,vo,EP,alpha2,e);
clipboard('copy', data)


out1=sprintf(' overall level =%8.4g %s rms \n ',sqrt(m0),yu);
disp(out1);

out1=sprintf(' duration =%8.4g sec \n ',T);
disp(out1);

out1=sprintf(' m0=%8.4g \n m1=%8.4g  \n m2=%8.4g  \n m4=%8.4g \n',m0,m1,m2,m4);
disp(out1);


out1=sprintf(' v0+=%8.4g Hz, rate of zero upcrossings \n ',vo);
disp(out1);
out1=sprintf(' EP=%8.4g Hz, expected peak rate \n ',EP);
disp(out1);
out1=sprintf(' alpha2=%8.4g \n',alpha2);
disp(out1);
out1=sprintf(' e=%8.4g spectral width',e);
disp(out1);

ax=0.5;
[ps]=risk_overshoot(vo,T,ax);


disp(' ');
out1=sprintf(' The maximum expected peak response is: %8.4g %s (%4.3g sigma) ',ps*rms,yu,ps);
disp(out1);


msgbox('Results written to Command Window');


% --- Executes on button press in pushbutton_return.
function pushbutton_return_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_return (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

delete(vibrationdata_spectral_moments);



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



function edit_yu_Callback(hObject, eventdata, handles)
% hObject    handle to edit_yu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_yu as text
%        str2double(get(hObject,'String')) returns contents of edit_yu as a double


% --- Executes during object creation, after setting all properties.
function edit_yu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_yu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_fmin_Callback(hObject, eventdata, handles)
% hObject    handle to edit_fmin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_fmin as text
%        str2double(get(hObject,'String')) returns contents of edit_fmin as a double


% --- Executes during object creation, after setting all properties.
function edit_fmin_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_fmin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_fmax_Callback(hObject, eventdata, handles)
% hObject    handle to edit_fmax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_fmax as text
%        str2double(get(hObject,'String')) returns contents of edit_fmax as a double


% --- Executes during object creation, after setting all properties.
function edit_fmax_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_fmax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

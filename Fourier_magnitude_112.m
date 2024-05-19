function varargout = Fourier_magnitude_112(varargin)
% FOURIER_MAGNITUDE_112 MATLAB code for Fourier_magnitude_112.fig
%      FOURIER_MAGNITUDE_112, by itself, creates a new FOURIER_MAGNITUDE_112 or raises the existing
%      singleton*.
%
%      H = FOURIER_MAGNITUDE_112 returns the handle to a new FOURIER_MAGNITUDE_112 or the handle to
%      the existing singleton*.
%
%      FOURIER_MAGNITUDE_112('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in FOURIER_MAGNITUDE_112.M with the given input arguments.
%
%      FOURIER_MAGNITUDE_112('Property','Value',...) creates a new FOURIER_MAGNITUDE_112 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Fourier_magnitude_112_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Fourier_magnitude_112_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Fourier_magnitude_112

% Last Modified by GUIDE v2.5 15-Apr-2020 20:45:23

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Fourier_magnitude_112_OpeningFcn, ...
                   'gui_OutputFcn',  @Fourier_magnitude_112_OutputFcn, ...
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


% --- Executes just before Fourier_magnitude_112 is made visible.
function Fourier_magnitude_112_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Fourier_magnitude_112 (see VARARGIN)

% Choose default command line output for Fourier_magnitude_112
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Fourier_magnitude_112 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Fourier_magnitude_112_OutputFcn(hObject, eventdata, handles) 
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

delete(Fourier_magnitude_112);


% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

disp(' ');
disp(' * * * * * * * * ');
disp(' ');


fig_num=1;

FS=strtrim(get(handles.edit_input_array_name,'String'));

try
	THM=evalin('base',FS);
catch
    warndlg('Input array not found');
    return;
end

ioct=get(handles.listbox_oct,'Value');


%%

freq=THM(:,1);
full=THM(:,2);

%
[fl,fc,fu,imax]=octaves_alt(ioct);
%
[band_rms]=convert_FFT_to_octave_band(freq,fl,fu,full);                   
%
f=fc;

f=fix_size(f);
band_rms=fix_size(band_rms);

size(f)
size(band_rms)


try
   output_name=get(handles.edit_output_array_name,'String');
   output_name=strtrim(output_name);   
   assignin('base', output_name, [f band_rms]); 
catch
   warndlg('Enter output array name');
   return;
end

THM=[f band_rms];


disp(' ');
disp('  fc(Hz)   RMS ');
disp(' ');

sz=size(THM);

for i=1:sz(1)
    out1=sprintf(' %9.5g \t %9.4g ',THM(i,1),THM(i,2));
    disp(out1); 
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


% --- Executes on selection change in listbox_oct.
function listbox_oct_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_oct (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_oct contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_oct


% --- Executes during object creation, after setting all properties.
function listbox_oct_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_oct (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_output_array_name_Callback(hObject, eventdata, handles)
% hObject    handle to edit_output_array_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_output_array_name as text
%        str2double(get(hObject,'String')) returns contents of edit_output_array_name as a double


% --- Executes during object creation, after setting all properties.
function edit_output_array_name_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_output_array_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

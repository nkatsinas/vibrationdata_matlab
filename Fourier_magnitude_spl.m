function varargout = Fourier_magnitude_spl(varargin)
% FOURIER_MAGNITUDE_SPL MATLAB code for Fourier_magnitude_spl.fig
%      FOURIER_MAGNITUDE_SPL, by itself, creates a new FOURIER_MAGNITUDE_SPL or raises the existing
%      singleton*.
%
%      H = FOURIER_MAGNITUDE_SPL returns the handle to a new FOURIER_MAGNITUDE_SPL or the handle to
%      the existing singleton*.
%
%      FOURIER_MAGNITUDE_SPL('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in FOURIER_MAGNITUDE_SPL.M with the given input arguments.
%
%      FOURIER_MAGNITUDE_SPL('Property','Value',...) creates a new FOURIER_MAGNITUDE_SPL or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Fourier_magnitude_spl_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Fourier_magnitude_spl_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Fourier_magnitude_spl

% Last Modified by GUIDE v2.5 08-Jul-2019 17:45:43

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Fourier_magnitude_spl_OpeningFcn, ...
                   'gui_OutputFcn',  @Fourier_magnitude_spl_OutputFcn, ...
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


% --- Executes just before Fourier_magnitude_spl is made visible.
function Fourier_magnitude_spl_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Fourier_magnitude_spl (see VARARGIN)

% Choose default command line output for Fourier_magnitude_spl
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Fourier_magnitude_spl wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Fourier_magnitude_spl_OutputFcn(hObject, eventdata, handles) 
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

delete(Fourier_magnitude_spl);


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

iu=get(handles.listbox_unit,'Value');


if(iu==1)
    ref=2.9e-09;
else
    ref=20e-06;
end


%%

freq=THM(:,1);
full=THM(:,2);

 %
    [fl,fc,fu,imax]=one_third_octave_frequencies();
%
    [band_rms]=convert_FFT_to_one_third(freq,fl,fu,full);                   
%
    [splevel,oaspl]=convert_one_third_octave_mag_to_dB(band_rms,ref);
%
    [pf,pspl,oaspl]=trim_acoustic_SPL(fc,splevel,ref);  
%
    imax=length(pf); 


%%

f=pf;
dB=pspl;

f=fix_size(f);
dB=fix_size(dB);

n_type=1;

[fig_num]=spl_plot(fig_num,n_type,f,dB);


try
   output_name=get(handles.edit_output_array_name,'String');
   assignin('base', output_name, [f dB]); 
catch
   warndlg('Enter output array name');
   return;
end

THM=[f dB];

disp(' ');
disp(' Format:  %9.5g '); 
disp(' ');
disp('  fc(Hz)   spl(dB) ');
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

function varargout = dB_pressure_unit_conversion(varargin)
% DB_PRESSURE_UNIT_CONVERSION MATLAB code for dB_pressure_unit_conversion.fig
%      DB_PRESSURE_UNIT_CONVERSION, by itself, creates a new DB_PRESSURE_UNIT_CONVERSION or raises the existing
%      singleton*.
%
%      H = DB_PRESSURE_UNIT_CONVERSION returns the handle to a new DB_PRESSURE_UNIT_CONVERSION or the handle to
%      the existing singleton*.
%
%      DB_PRESSURE_UNIT_CONVERSION('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DB_PRESSURE_UNIT_CONVERSION.M with the given input arguments.
%
%      DB_PRESSURE_UNIT_CONVERSION('Property','Value',...) creates a new DB_PRESSURE_UNIT_CONVERSION or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before dB_pressure_unit_conversion_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to dB_pressure_unit_conversion_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help dB_pressure_unit_conversion

% Last Modified by GUIDE v2.5 20-Feb-2014 10:06:16

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @dB_pressure_unit_conversion_OpeningFcn, ...
                   'gui_OutputFcn',  @dB_pressure_unit_conversion_OutputFcn, ...
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


% --- Executes just before dB_pressure_unit_conversion is made visible.
function dB_pressure_unit_conversion_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to dB_pressure_unit_conversion (see VARARGIN)

% Choose default command line output for dB_pressure_unit_conversion
handles.output = hObject;

set(handles.listbox_input_unit,'Value',1);

set(handles.listbox_medium,'Value',1);

clear_results(hObject, eventdata, handles); 

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes dB_pressure_unit_conversion wait for user response (see UIRESUME)
% uiwait(handles.figure1);


function clear_results(hObject, eventdata, handles) 
%
set(handles.edit_results,'String','');


% --- Outputs from this function are returned to the command line.
function varargout = dB_pressure_unit_conversion_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in listbox_input_unit.
function listbox_input_unit_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_input_unit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_input_unit contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_input_unit
clear_results(hObject, eventdata, handles); 

% --- Executes during object creation, after setting all properties.
function listbox_input_unit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_input_unit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_value_Callback(hObject, eventdata, handles)
% hObject    handle to edit_value (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_value as text
%        str2double(get(hObject,'String')) returns contents of edit_value as a double


% --- Executes during object creation, after setting all properties.
function edit_value_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_value (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



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


% --- Executes on button press in pushbutton_clear_value.
function pushbutton_clear_value_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_clear_value (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.edit_value,'String','');
clear_results(hObject, eventdata, handles); 

% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

n=get(handles.listbox_input_unit,'Value');

P=str2num(get(handles.edit_value,'String'));

m=get(handles.listbox_medium,'Value');

% convert to microPa

if(m==1)  % microPa
    ref=20;
else
    ref=1;
end    

psi_per_microPa=1.4505e-10;
psf_per_microPa=2.0888e-08;
Pa_per_microPa=1.0e-06;
microbar_per_microPa=1e-05;

if(n==1) % dB
    microPa =ref*10^(P/20); 
end 
if(n==2) % psi
    microPa =P/psi_per_microPa;   
end   
if(n==3) % psf
    microPa =P/psf_per_microPa;
end   
if(n==4) % Pa
    microPa =P/Pa_per_microPa;
end   
if(n==5) % microPa
    microPa =P;
end   
if(n==6) % microbar
    microPa =P*microbar_per_microPa;
end   

dB=20*log10(microPa/ref);
psi=microPa*psi_per_microPa;
psf=microPa*psf_per_microPa;
Pa=microPa*Pa_per_microPa;
microbar=microPa*microbar_per_microPa;


if(n==1) % dB
    dB=P;
end 
if(n==2) % psi
    psi=P;
end   
if(n==3) % psf
    psf=P;
end   
if(n==4) % Pa
    Pa=P;
end   
if(n==5) % microPa
    microPa=P;
end   
if(n==6) % microbar
    microbar=P;
end   


s1=sprintf(' %8.4g dB \n\n %8.4g psi rms \n %8.4g psf rms \n\n %8.4g Pa rms \n %8.4g microPa rms \n\n %8.4g microbar rms ',...
                                           dB,psi,psf,Pa,microPa,microbar);

set(handles.edit_results,'String',s1,'Max',12,'Visible','on');




% --- Executes on button press in pushbutton_return.
function pushbutton_return_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_return (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
delete(dB_pressure_unit_conversion);


% --- Executes on key press with focus on edit_value and none of its controls.
function edit_value_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_value (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
clear_results(hObject, eventdata, handles); 


% --- Executes on selection change in listbox_medium.
function listbox_medium_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_medium (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_medium contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_medium
clear_results(hObject, eventdata, handles); 

% --- Executes during object creation, after setting all properties.
function listbox_medium_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_medium (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

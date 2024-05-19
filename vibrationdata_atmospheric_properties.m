function varargout = vibrationdata_atmospheric_properties(varargin)
% VIBRATIONDATA_ATMOSPHERIC_PROPERTIES MATLAB code for vibrationdata_atmospheric_properties.fig
%      VIBRATIONDATA_ATMOSPHERIC_PROPERTIES, by itself, creates a new VIBRATIONDATA_ATMOSPHERIC_PROPERTIES or raises the existing
%      singleton*.
%
%      H = VIBRATIONDATA_ATMOSPHERIC_PROPERTIES returns the handle to a new VIBRATIONDATA_ATMOSPHERIC_PROPERTIES or the handle to
%      the existing singleton*.
%
%      VIBRATIONDATA_ATMOSPHERIC_PROPERTIES('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in VIBRATIONDATA_ATMOSPHERIC_PROPERTIES.M with the given input arguments.
%
%      VIBRATIONDATA_ATMOSPHERIC_PROPERTIES('Property','Value',...) creates a new VIBRATIONDATA_ATMOSPHERIC_PROPERTIES or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before vibrationdata_atmospheric_properties_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to vibrationdata_atmospheric_properties_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help vibrationdata_atmospheric_properties

% Last Modified by GUIDE v2.5 21-Dec-2017 12:59:08

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @vibrationdata_atmospheric_properties_OpeningFcn, ...
                   'gui_OutputFcn',  @vibrationdata_atmospheric_properties_OutputFcn, ...
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


% --- Executes just before vibrationdata_atmospheric_properties is made visible.
function vibrationdata_atmospheric_properties_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to vibrationdata_atmospheric_properties (see VARARGIN)

% Choose default command line output for vibrationdata_atmospheric_properties
handles.output = hObject;

listbox_units_Callback(hObject, eventdata, handles)

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes vibrationdata_atmospheric_properties wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = vibrationdata_atmospheric_properties_OutputFcn(hObject, eventdata, handles) 
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

delete(vibrationdata_atmospheric_properties);


% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

iu=get(handles.listbox_units','Value');

alt=str2num(get(handles.edit_alt,'String'));

[air_pressure,mass_dens,temp_K,temp_C,sound_speed,visc,kvisc]=...
                                         atmospheric_properties_1976(alt,iu);
                                     
                                     
%   output for iu=1
%
%      air_pressure:  psf
%         mass_dens:  slugs/ft^3
%       sound_speed:  ft/sec
%              visc:  slugs/ft-s
%             kvisc:  ft^2/sec
%
%   output for iu=2
%
%      air_pressure:  Pa
%         mass_dens:  kg/m^3
%       sound_speed:  m/sec
%              visc:  kg/m-s
%             kvisc:  m^2/sec
                                     
                                     
if(iu==1)
    s1=sprintf('\n altitude = %9.5g ft',alt);
    s2=sprintf('\n air pressure = %8.4g psi',air_pressure/144);
    s3=sprintf('\n mass density = %8.4g slugs/ft^3',mass_dens);
    s4=sprintf('\n\n temperature = %8.4g K',temp_K);
    s5=sprintf('\n temperature = %8.4g deg C',temp_C);
    s6=sprintf('\n\n sound speed = %8.4g ft/sec',sound_speed);
    s7=sprintf('\n viscosity = %8.4g slugs/ft-s',visc);
    s8=sprintf('\n kinematic viscosity = %8.4g ft^2/sec',kvisc);
else
    s1=sprintf('\n altitude = %9.5g m',alt);
    s2=sprintf('\n air pressure = %8.4g Pa',air_pressure);
    s3=sprintf('\n mass density = %8.4g kg/m^3',mass_dens);
    s4=sprintf('\n\n temperature = %8.4g K',temp_K);
    s5=sprintf('\n temperature = %8.4g deg C',temp_C);
    s6=sprintf('\n\n sound speed = %8.4g m/sec',sound_speed);
    s7=sprintf('\n viscosity = %8.4g kg/m-s',visc);
    s8=sprintf('\n kinematic viscosity = %8.4g m^2/sec',kvisc);    
end
    
ss=strcat(s1,s2,s3,s4,s5,s6,s7,s8);


set(handles.edit_results,'String',ss);

set(handles.uipanel_results,'Visible','on');


% --- Executes on selection change in listbox_units.
function listbox_units_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_units (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_units contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_units

iu=get(handles.listbox_units,'Value');

if(iu==1)
    ss='Altitude (ft)';
else
    ss='Altitude (m)';    
end

set(handles.text_alt,'String',ss); 

set(handles.uipanel_results,'Visible','off');


% --- Executes during object creation, after setting all properties.
function listbox_units_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_units (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_alt_Callback(hObject, eventdata, handles)
% hObject    handle to edit_alt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_alt as text
%        str2double(get(hObject,'String')) returns contents of edit_alt as a double


% --- Executes during object creation, after setting all properties.
function edit_alt_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_alt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on key press with focus on edit_alt and none of its controls.
function edit_alt_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_alt (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)

set(handles.uipanel_results,'Visible','off');



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

function varargout = vibrationdata_doppler(varargin)
% VIBRATIONDATA_DOPPLER MATLAB code for vibrationdata_doppler.fig
%      VIBRATIONDATA_DOPPLER, by itself, creates a new VIBRATIONDATA_DOPPLER or raises the existing
%      singleton*.
%
%      H = VIBRATIONDATA_DOPPLER returns the handle to a new VIBRATIONDATA_DOPPLER or the handle to
%      the existing singleton*.
%
%      VIBRATIONDATA_DOPPLER('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in VIBRATIONDATA_DOPPLER.M with the given input arguments.
%
%      VIBRATIONDATA_DOPPLER('Property','Value',...) creates a new VIBRATIONDATA_DOPPLER or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before vibrationdata_doppler_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to vibrationdata_doppler_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help vibrationdata_doppler

% Last Modified by GUIDE v2.5 04-Feb-2014 09:59:06

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @vibrationdata_doppler_OpeningFcn, ...
                   'gui_OutputFcn',  @vibrationdata_doppler_OutputFcn, ...
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


% --- Executes just before vibrationdata_doppler is made visible.
function vibrationdata_doppler_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to vibrationdata_doppler (see VARARGIN)

% Choose default command line output for vibrationdata_doppler
handles.output = hObject;

set(handles.listbox_units,'value',1);
set(handles.listbox_type,'value',1);

clear_results(hObject, eventdata, handles);
listbox_units_Callback(hObject, eventdata, handles);
listbox_type_Callback(hObject, eventdata, handles);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes vibrationdata_doppler wait for user response (see UIRESUME)
% uiwait(handles.figure1);


function clear_results(hObject, eventdata, handles)
%
set(handles.edit_results,'Visible','off');
set(handles.edit_results,'String',' ');
set(handles.text_results_text,'Visible','off');


function select_analysis(hObject, eventdata, handles)
%
set(handles.text_source_frequency,'Visible','on');
set(handles.text_apparent_frequency,'Visible','on');
set(handles.text_source_velocity,'Visible','on');
set(handles.text_receiver_velocity,'Visible','on');
set(handles.edit_source_frequency,'Visible','on');
set(handles.edit_apparent_frequency,'Visible','on');
set(handles.edit_source_velocity,'Visible','on');
set(handles.edit_receiver_velocity,'Visible','on');
%

n_analysis=get(handles.listbox_type,'Value');

if(n_analysis==1)  % apparent frequency
    set(handles.text_apparent_frequency,'Visible','off');
    set(handles.edit_apparent_frequency,'Visible','off');
end
if(n_analysis==2)  % source frequency
    set(handles.text_source_frequency,'Visible','off');
    set(handles.edit_source_frequency,'Visible','off');
end
if(n_analysis==3)  % source velocity    
    set(handles.text_source_velocity,'Visible','off');
    set(handles.edit_source_velocity,'Visible','off');
end
if(n_analysis==4)  % receiver velocity
    set(handles.text_receiver_velocity,'Visible','off');
    set(handles.edit_receiver_velocity,'Visible','off');
end


% --- Outputs from this function are returned to the command line.
function varargout = vibrationdata_doppler_OutputFcn(hObject, eventdata, handles) 
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


n_units=get(handles.listbox_units,'Value');
n=n_units;
n_analysis=get(handles.listbox_type,'Value');

c=str2num(get(handles.edit_speed,'String'));


clear fs;
clear fa;
clear u;
clear v;
 
if(n_analysis==1)  % apparent frequency
%
    fs=str2num(get(handles.edit_source_frequency,'String'));
     u=str2num(get(handles.edit_source_velocity,'String'));
     v=str2num(get(handles.edit_receiver_velocity,'String'));
%
    set(handles.text_results_text,'String','Apparent Frequency (Hz)');
%
		if(u>=c)
            warndlg('Source velocity must be < speed of sound.','Warning');
        end    
		if(v>=c)
            warndlg('Receiver velocity must be < speed of sound.','Warning');
        end
		if(u<c && v<c)
            clear fa;
			fa=fs*((c-v)/(c-u));
            out1=sprintf('%8.4g',fa);
            set(handles.text_results_text,'Visible','on');
            set(handles.edit_results,'Visible','on');
            set(handles.edit_results,'String',out1);
        end
%
end
%
if(n_analysis==2)  % source frequency
%
    fa=str2num(get(handles.edit_apparent_frequency,'String'));
     u=str2num(get(handles.edit_source_velocity,'String'));
     v=str2num(get(handles.edit_receiver_velocity,'String'));
%    
    set(handles.text_results_text,'String','Source Frequency (Hz)');
%
		if(u>=c)
            warndlg('Source velocity must be < speed of sound.','Warning')
        end    
		if(v>=c)
            warndlg('Receiver velocity must be < speed of sound.','Warning');
        end
		if(u<c && v<c)
            clear fs;
			fs=fa/((c-v)/(c-u));			
            out1=sprintf('%8.4g',fs);
            set(handles.text_results_text,'Visible','on');
            set(handles.edit_results,'Visible','on');
            set(handles.edit_results,'String',out1);
        end    
%
end
%
if(n_analysis==3)  % source velocity    
%
    fs=str2num(get(handles.edit_source_frequency,'String'));
    fa=str2num(get(handles.edit_apparent_frequency,'String'));
     v=str2num(get(handles.edit_receiver_velocity,'String'));
%    
    if(n==1)
        set(handles.text_results_text,'String','Source Velocity (ft/sec)');        
    end
    if(n==2)
        set(handles.text_results_text,'String','Source Velocity (mph)');         
    end
    if(n==3)
        set(handles.text_results_text,'String','Source Velocity (m/sec)');         
    end
    if(n==4)
        set(handles.text_results_text,'String','Source Velocity (km/hr)');         
    end    
%
	if(v>=c)
        warndlg('Receiver velocity must be < speed of sound','Warning');
    else
        clear u;
        u=-((fs/fa)*(c-v))+c;
        out1=sprintf('%8.4g',u);
        set(handles.text_results_text,'Visible','on');
        set(handles.edit_results,'Visible','on');
        set(handles.edit_results,'String',out1);        
    end    
%
end
if(n_analysis==4)  % receiver velocity
%
    fs=str2num(get(handles.edit_source_frequency,'String'));
    fa=str2num(get(handles.edit_apparent_frequency,'String'));
     u=str2num(get(handles.edit_source_velocity,'String'));
%    
    if(n==1)
        set(handles.text_results_text,'String','Receiver Velocity (ft/sec)');        
    end
    if(n==2)
        set(handles.text_results_text,'String','Receiver Velocity (mph)');         
    end
    if(n==3)
        set(handles.text_results_text,'String','Receiver Velocity (m/sec)');         
    end
    if(n==4)
        set(handles.text_results_text,'String','Receiver Velocity (km/hr)');         
    end
%
	if(u>=c)
        warndlg('Source velocity must be < speed of sound.','Warning');
    else    
        clear v;
        v=-((fa/fs)*(c-u))+c;
        out1=sprintf('%8.4g',v);
        set(handles.text_results_text,'Visible','on');
        set(handles.edit_results,'Visible','on');
        set(handles.edit_results,'String',out1);     
    end    
%
end


% --- Executes on button press in pushbutton_return.
function pushbutton_return_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_return (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
delete(vibrationdata_doppler);

% --- Executes on selection change in listbox_units.
function listbox_units_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_units (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_units contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_units
clear_results(hObject, eventdata, handles);



n=get(handles.listbox_units,'Value');

if(n==1)
    set(handles.text_speed_sound,'String','Speed of Sound (ft/sec)');
    set(handles.edit_speed,'String','1120');
    set(handles.text_receiver_velocity,'String','Receiver Velocity (ft/sec)');
    set(handles.text_source_velocity,'String','Source Velocity (ft/sec)');    
end
if(n==2)
    set(handles.text_speed_sound,'String','Speed of Sound (mph)'); 
    set(handles.edit_speed,'String','767');  
    set(handles.text_receiver_velocity,'String','Receiver Velocity (mph)');
    set(handles.text_source_velocity,'String','Source Velocity (mph)');    
end   
if(n==3)
    set(handles.text_speed_sound,'String','Speed of Sound (m/sec)'); 
    set(handles.edit_speed,'String','343');    
    set(handles.text_receiver_velocity,'String','Receiver Velocity (m/sec)');
    set(handles.text_source_velocity,'String','Source Velocity (m/sec)');    
end   
if(n==4)
    set(handles.text_speed_sound,'String','Speed of Sound (km/hr)'); 
    set(handles.edit_speed,'String','1234');   
    set(handles.text_receiver_velocity,'String','Receiver Velocity (km/hr)');
    set(handles.text_source_velocity,'String','Source Velocity (km/hr)');     
end   


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



function edit_speed_Callback(hObject, eventdata, handles)
% hObject    handle to edit_speed (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_speed as text
%        str2double(get(hObject,'String')) returns contents of edit_speed as a double


% --- Executes during object creation, after setting all properties.
function edit_speed_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_speed (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_type.
function listbox_type_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_type contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_type

clear_results(hObject, eventdata, handles);
select_analysis(hObject, eventdata, handles);


% --- Executes during object creation, after setting all properties.
function listbox_type_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_source_frequency_Callback(hObject, eventdata, handles)
% hObject    handle to edit_source_frequency (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_source_frequency as text
%        str2double(get(hObject,'String')) returns contents of edit_source_frequency as a double


% --- Executes during object creation, after setting all properties.
function edit_source_frequency_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_source_frequency (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_apparent_frequency_Callback(hObject, eventdata, handles)
% hObject    handle to edit_apparent_frequency (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_apparent_frequency as text
%        str2double(get(hObject,'String')) returns contents of edit_apparent_frequency as a double


% --- Executes during object creation, after setting all properties.
function edit_apparent_frequency_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_apparent_frequency (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_source_velocity_Callback(hObject, eventdata, handles)
% hObject    handle to edit_source_velocity (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_source_velocity as text
%        str2double(get(hObject,'String')) returns contents of edit_source_velocity as a double


% --- Executes during object creation, after setting all properties.
function edit_source_velocity_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_source_velocity (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_receiver_velocity_Callback(hObject, eventdata, handles)
% hObject    handle to edit_receiver_velocity (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_receiver_velocity as text
%        str2double(get(hObject,'String')) returns contents of edit_receiver_velocity as a double


% --- Executes during object creation, after setting all properties.
function edit_receiver_velocity_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_receiver_velocity (see GCBO)
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


% --- Executes on key press with focus on edit_speed and none of its controls.
function edit_speed_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_speed (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
clear_results(hObject, eventdata, handles);


% --- Executes on key press with focus on edit_source_frequency and none of its controls.
function edit_source_frequency_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_source_frequency (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
clear_results(hObject, eventdata, handles);


% --- Executes on key press with focus on edit_apparent_frequency and none of its controls.
function edit_apparent_frequency_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_apparent_frequency (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
clear_results(hObject, eventdata, handles);


% --- Executes on key press with focus on edit_source_velocity and none of its controls.
function edit_source_velocity_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_source_velocity (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
clear_results(hObject, eventdata, handles);


% --- Executes on key press with focus on edit_receiver_velocity and none of its controls.
function edit_receiver_velocity_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_receiver_velocity (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
clear_results(hObject, eventdata, handles);

function varargout = cross_over_frequency(varargin)
% CROSS_OVER_FREQUENCY MATLAB code for cross_over_frequency.fig
%      CROSS_OVER_FREQUENCY, by itself, creates a new CROSS_OVER_FREQUENCY or raises the existing
%      singleton*.
%
%      H = CROSS_OVER_FREQUENCY returns the handle to a new CROSS_OVER_FREQUENCY or the handle to
%      the existing singleton*.
%
%      CROSS_OVER_FREQUENCY('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CROSS_OVER_FREQUENCY.M with the given input arguments.
%
%      CROSS_OVER_FREQUENCY('Property','Value',...) creates a new CROSS_OVER_FREQUENCY or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before cross_over_frequency_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to cross_over_frequency_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help cross_over_frequency

% Last Modified by GUIDE v2.5 03-Apr-2014 13:14:21

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @cross_over_frequency_OpeningFcn, ...
                   'gui_OutputFcn',  @cross_over_frequency_OutputFcn, ...
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


% --- Executes just before cross_over_frequency is made visible.
function cross_over_frequency_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to cross_over_frequency (see VARARGIN)

% Choose default command line output for cross_over_frequency
handles.output = hObject;

set(handles.edit_results,'string',' ');
set(handles.edit_results,'enable','off');

set(handles.listbox_unit,'value',1);
set(handles.listbox_amplitude_pairs,'value',1);

amplitude_labels(hObject, eventdata, handles);


% Update handles structure
guidata(hObject, handles);

% UIWAIT makes cross_over_frequency wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = cross_over_frequency_OutputFcn(hObject, eventdata, handles) 
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

delete(cross_over_frequency)


% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

set(handles.edit_results,'string',' ');
set(handles.edit_results,'enable','off');

% G, in/sec, in
% G, m/sec, mm
% m/sec^2, m/sec, mm

nunit=get(handles.listbox_unit,'Value');
npair=get(handles.listbox_amplitude_pairs,'Value');

amp1=str2num(get(handles.edit_amplitude_one,'String'));
amp2=str2num(get(handles.edit_amplitude_two,'String'));

if(npair==1 || npair==3)
    d=amp1;
    v=amp2;
end    
if(npair==2 || npair==4)
    d=amp1;
    a=amp2;
end 
if(npair==5)
    v=amp1;
    a=amp2;
end    

if(nunit==1) % G, in/sec, in
    if(npair==1) % disp (zero-peak) -> velocity
    end
    if(npair==2) % disp (zero-peak) -> acceleration
        a=a*386;
    end
    if(npair==3) % disp (peak-peak) -> velocity
        d=d/2;
    end
    if(npair==4) % disp (peak-peak) -> acceleration
        d=d/2;
        a=a*386;
    end
    if(npair==5) % velocity -> acceleration
        a=a*386;
    end   
end
if(nunit==2) % G, m/sec, mm
    d=d/1000;
    if(npair==1) % disp (zero-peak) -> velocity
    end
    if(npair==2) % disp (zero-peak) -> acceleration
        a=a*9.81;
    end
    if(npair==3) % disp (peak-peak) -> velocity
        d=d/2;
    end
    if(npair==4) % disp (peak-peak) -> acceleration
        d=d/2; 
        a=a*9.81;
    end
    if(npair==5) % velocity -> acceleration
        a=a*9.81;
    end   

end
if(nunit==3) % m/sec^2, m/sec, mm
    d=d/1000;
    if(npair==1) % disp (zero-peak) -> velocity
    end
    if(npair==2) % disp (zero-peak) -> acceleration
    end
    if(npair==3) % disp (peak-peak) -> velocity
        d=d/2;        
    end
    if(npair==4) % disp (peak-peak) -> acceleration
        d=d/2; 
    end
    if(npair==5) % velocity -> acceleration
    end   
end

if(npair==1 || npair==3)
    fc=( v/d );
end    
if(npair==2 || npair==4)
    fc=sqrt( a/d );
end 
if(npair==5)
    fc=( a/v );
end    
fc=fc/(2*pi);

out1=sprintf('%8.4g Hz',fc);

set(handles.edit_results,'string',out1);
set(handles.edit_results,'enable','on');




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


% --- Executes on selection change in listbox_unit.
function listbox_unit_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_unit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_unit contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_unit

set(handles.edit_results,'string',' ');
set(handles.edit_results,'enable','off');

amplitude_labels(hObject, eventdata, handles);


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


% --- Executes on selection change in listbox_amplitude_pairs.
function listbox_amplitude_pairs_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_amplitude_pairs (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_amplitude_pairs contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_amplitude_pairs
set(handles.edit_results,'string',' ');
set(handles.edit_results,'enable','off');

amplitude_labels(hObject, eventdata, handles);


function amplitude_labels(hObject, eventdata, handles)

nunit=get(handles.listbox_unit,'Value');
npair=get(handles.listbox_amplitude_pairs,'Value');

if(npair==1)        % disp (zero-peak) -> velocity
    text1='displacement (zero-peak)';
    text2='velocity';
    if(nunit==1) % G, in/sec, in
        text_unit_1 = 'inch';
        text_unit_2 = 'in/sec';        
    end
    if(nunit==2) % G, m/sec, mm
        text_unit_1 = 'mm';
        text_unit_2 = 'm/sec';           
    end
    if(nunit==3) % m/sec^2, m/sec, mm
        text_unit_1 = 'mm';
        text_unit_2 = 'm/sec';          
    end    
end

if(npair==2)     % disp (zero-peak) -> acceleration 
    text1='displacement (zero-peak)';
    text2='acceleration';    
    if(nunit==1) % G, in/sec, in
        text_unit_1 = 'inch';
        text_unit_2 = 'G';          
    end
    if(nunit==2) % G, m/sec, mm
        text_unit_1 = 'mm';
        text_unit_2 = 'G';        
    end
    if(nunit==3) % m/sec^2, m/sec, mm
        text_unit_1 = 'mm';
        text_unit_2 = 'm/sec^2';        
    end 
end

if(npair==3)     % disp (peak-peak) -> velocity 
    text1='displacement (peak-peak)';
    text2='velocity';     
    if(nunit==1) % G, in/sec, in
        text_unit_1 = 'inch';
        text_unit_2 = 'in/sec';          
    end
    if(nunit==2) % G, m/sec, mm
        text_unit_1 = 'mm';
        text_unit_2 = 'm/sec';          
    end
    if(nunit==3) % m/sec^2, m/sec, mm
        text_unit_1 = 'mm';
        text_unit_2 = 'm/sec';         
    end 
end

if(npair==4)     % disp (peak-peak) -> acceleration
    text1='displacement (peak-peak)';
    text2='acceleration';     
    if(nunit==1) % G, in/sec, in
        text_unit_1 = 'inch';
        text_unit_2 = 'G';         
    end
    if(nunit==2) % G, m/sec, mm
        text_unit_1 = 'mm';
        text_unit_2 = 'G';          
    end
    if(nunit==3) % m/sec^2, m/sec, mm
        text_unit_1 = 'mm'; 
        text_unit_2 = 'm/sec^2';         
    end 
end

if(npair==5)     % velocity -> acceleration
    text1='velocity';
    text2='acceleration';     
    if(nunit==1) % G, in/sec, in
        text_unit_1 = 'in/sec';        
        text_unit_2 = 'G';          
    end
    if(nunit==2) % G, m/sec, mm
        text_unit_1 = 'm/sec';
        text_unit_2 = 'G';        
    end
    if(nunit==3) % m/sec^2, m/sec, mm
       text_unit_1 = 'm/sec';
       text_unit_2 = 'm/sec^2';      
    end 
end

set(handles.text_amplitude_one,'string',text1);
set(handles.text_amplitude_two,'string',text2);

set(handles.text_unit_1,'string',text_unit_1);
set(handles.text_unit_2,'string',text_unit_2);

% --- Executes during object creation, after setting all properties.
function listbox_amplitude_pairs_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_amplitude_pairs (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_amplitude_one_Callback(hObject, eventdata, handles)
% hObject    handle to edit_amplitude_one (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_amplitude_one as text
%        str2double(get(hObject,'String')) returns contents of edit_amplitude_one as a double


% --- Executes during object creation, after setting all properties.
function edit_amplitude_one_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_amplitude_one (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_amplitude_two_Callback(hObject, eventdata, handles)
% hObject    handle to edit_amplitude_two (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_amplitude_two as text
%        str2double(get(hObject,'String')) returns contents of edit_amplitude_two as a double
set(handles.edit_results,'string',' ');
set(handles.edit_results,'enable','off');

% --- Executes during object creation, after setting all properties.
function edit_amplitude_two_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_amplitude_two (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on key press with focus on edit_amplitude_one and none of its controls.
function edit_amplitude_one_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_amplitude_one (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.edit_results,'string',' ');
set(handles.edit_results,'enable','off');


% --- Executes on key press with focus on edit_amplitude_two and none of its controls.
function edit_amplitude_two_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_amplitude_two (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.edit_results,'string',' ');
set(handles.edit_results,'enable','off');

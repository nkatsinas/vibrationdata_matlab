function varargout = srs_amplitude_conversion(varargin)
% SRS_AMPLITUDE_CONVERSION MATLAB code for srs_amplitude_conversion.fig
%      SRS_AMPLITUDE_CONVERSION, by itself, creates a new SRS_AMPLITUDE_CONVERSION or raises the existing
%      singleton*.
%
%      H = SRS_AMPLITUDE_CONVERSION returns the handle to a new SRS_AMPLITUDE_CONVERSION or the handle to
%      the existing singleton*.
%
%      SRS_AMPLITUDE_CONVERSION('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SRS_AMPLITUDE_CONVERSION.M with the given input arguments.
%
%      SRS_AMPLITUDE_CONVERSION('Property','Value',...) creates a new SRS_AMPLITUDE_CONVERSION or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before srs_amplitude_conversion_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to srs_amplitude_conversion_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help srs_amplitude_conversion

% Last Modified by GUIDE v2.5 12-Aug-2013 10:49:10

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @srs_amplitude_conversion_OpeningFcn, ...
                   'gui_OutputFcn',  @srs_amplitude_conversion_OutputFcn, ...
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


% --- Executes just before srs_amplitude_conversion is made visible.
function srs_amplitude_conversion_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to srs_amplitude_conversion (see VARARGIN)

% Choose default command line output for srs_amplitude_conversion
handles.output = hObject;

set(handles.listbox_units,'Value',1);
set(handles.listbox_input_metric,'Value',1);

clear_results(hObject, eventdata, handles);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes srs_amplitude_conversion wait for user response (see UIRESUME)
% uiwait(handles.figure1);


function input_type(hObject, eventdata, handles)

n=get(handles.listbox_units,'Value');
m=get(handles.listbox_input_metric,'Value');

if(n==1)  
    if(m==1)  % rel disp
        s='Enter Relative Displacement (in)';
    end
    if(m==2)  % pv
        s='Enter Pseudo Velocity (in/sec)';        
    end
    if(m==3)  % accel
        s='Enter Acceleration (G)';        
    end
end
if(n==2)    
    if(m==1)  % rel disp
        s='Enter Relative Displacement (mm)';  
    end
    if(m==2)  % pv
        s='Enter Pseudo Velocity (m/sec)';
    end
    if(m==3)  % accel
        s='Enter Acceleration (G)';
    end
end
if(n==3)
    if(m==1)  % rel disp
        s='Enter Relative Displacement (mm)'; 
    end
    if(m==2)  % pv
        s='Enter Pseudo Velocity (m/sec)';
    end
    if(m==3)  % accel
        s='Enter Acceleration (m/sec^2)';
    end
end
%          
set(handles.text_enter_amplitude,'String',s);



function clear_results(hObject, eventdata, handles)
set(handles.edit_results,'Enable','off');
str=' ';
set(handles.edit_results,'String',str);


% --- Outputs from this function are returned to the command line.
function varargout = srs_amplitude_conversion_OutputFcn(hObject, eventdata, handles) 
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
set(handles.edit_results,'Enable','on');

n=get(handles.listbox_units,'Value');
m=get(handles.listbox_input_metric,'Value');

s=str2num(get(handles.edit_input_amplitude,'String'));
fn=str2num(get(handles.edit_fn,'String'));

omega=2*pi*fn;
om2=omega^2;

str{1}=sprintf('fn=%8.4g Hz',fn);

if(n==1)  
    if(m==1)  % rel disp (in)
        rd=s;
        pv=omega*rd;
        ac=om2*rd/386;
    end
    if(m==2)  % pv (in/sec)
        pv=s;
        rd=pv/omega;
        ac=omega*pv/386;    
    end
    if(m==3)  % accel (G)        
        ac=s;
        pv=386*ac/omega;          
        rd=386*ac/om2;     
    end
    str{2}=sprintf('\n Relative Displacement \n = %8.4g in',rd);
    str{3}=sprintf('\n Pseudo Velocity \n = %8.4g in/sec',pv);
    str{4}=sprintf('\n Acceleration \n = %8.4g G',ac);
end
if(n==2)    
    if(m==1)  % rel disp (mm)
        rd=s;        
        pv=omega*rd/1000;  
        ac=om2*rd/(9.81*1000);  
    end
    if(m==2)  % pv (m/sec)
        pv=s;
        rd=1000*pv/omega;
        ac=omega*pv/9.81;   
    end
    if(m==3)  % accel (G)
        ac=s;
        pv=9.81*ac/omega;
        rd=9.81*1000*ac/om2;
    end
    str{2}=sprintf('\n Relative Displacement \n = %8.4g mm',rd);
    str{3}=sprintf('\n Pseudo Velocity \n = %8.4g m/sec',pv);
    str{4}=sprintf('\n Acceleration \n = %8.4g G',ac);    
end
if(n==3)
    if(m==1)  % rel disp (mm)
        rd=s;
        pv=omega*rd/1000;
        ac=om2*rd/1000; 
    end
    if(m==2)  % pv (m/sec)
        pv=s;        
        rd=1000*pv/omega;
        ac=omega*pv; 
    end
    if(m==3)  % accel (m/sec^2)
        ac=s;
        pv=ac/omega;
        rd=1000*ac/om2;
    end
    str{2}=sprintf('\n Relative Displacement \n = %8.4g mm',rd);
    str{3}=sprintf('\n Pseudo Velocity \n = %8.4g m/sec',pv);
    str{4}=sprintf('\n Acceleration \n = %8.4g m/sec^2',ac);        
end

set(handles.edit_results,'String',str);


% --- Executes on button press in pushbutton_return.
function pushbutton_return_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_return (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

delete(srs_amplitude_conversion);

% --- Executes on selection change in listbox_units.
function listbox_units_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_units (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_units contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_units
clear_results(hObject, eventdata, handles);
input_type(hObject, eventdata, handles);


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



function edit_fn_Callback(hObject, eventdata, handles)
% hObject    handle to edit_fn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_fn as text
%        str2double(get(hObject,'String')) returns contents of edit_fn as a double


% --- Executes during object creation, after setting all properties.
function edit_fn_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_fn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_input_metric.
function listbox_input_metric_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_input_metric (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_input_metric contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_input_metric

clear_results(hObject, eventdata, handles);
input_type(hObject, eventdata, handles);

% --- Executes during object creation, after setting all properties.
function listbox_input_metric_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_input_metric (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_input_amplitude_Callback(hObject, eventdata, handles)
% hObject    handle to edit_input_amplitude (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_input_amplitude as text
%        str2double(get(hObject,'String')) returns contents of edit_input_amplitude as a double


% --- Executes during object creation, after setting all properties.
function edit_input_amplitude_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_input_amplitude (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on key press with focus on edit_input_amplitude and none of its controls.
function edit_input_amplitude_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_input_amplitude (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
clear_results(hObject, eventdata, handles);


% --- Executes on key press with focus on edit_fn and none of its controls.
function edit_fn_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_fn (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
clear_results(hObject, eventdata, handles);

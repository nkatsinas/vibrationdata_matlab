function varargout = pipe_acoustic_frequencies(varargin)
% PIPE_ACOUSTIC_FREQUENCIES MATLAB code for pipe_acoustic_frequencies.fig
%      PIPE_ACOUSTIC_FREQUENCIES, by itself, creates a new PIPE_ACOUSTIC_FREQUENCIES or raises the existing
%      singleton*.
%
%      H = PIPE_ACOUSTIC_FREQUENCIES returns the handle to a new PIPE_ACOUSTIC_FREQUENCIES or the handle to
%      the existing singleton*.
%
%      PIPE_ACOUSTIC_FREQUENCIES('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PIPE_ACOUSTIC_FREQUENCIES.M with the given input arguments.
%
%      PIPE_ACOUSTIC_FREQUENCIES('Property','Value',...) creates a new PIPE_ACOUSTIC_FREQUENCIES or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before pipe_acoustic_frequencies_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to pipe_acoustic_frequencies_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help pipe_acoustic_frequencies

% Last Modified by GUIDE v2.5 01-Nov-2019 14:11:55

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @pipe_acoustic_frequencies_OpeningFcn, ...
                   'gui_OutputFcn',  @pipe_acoustic_frequencies_OutputFcn, ...
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


% --- Executes just before pipe_acoustic_frequencies is made visible.
function pipe_acoustic_frequencies_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to pipe_acoustic_frequencies (see VARARGIN)

% Choose default command line output for pipe_acoustic_frequencies
handles.output = hObject;

listbox_unit_Callback(hObject, eventdata, handles);

change(hObject, eventdata, handles);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes pipe_acoustic_frequencies wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = pipe_acoustic_frequencies_OutputFcn(hObject, eventdata, handles) 
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

delete(pipe_acoustic_frequencies);


% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

iu=get(handles.listbox_unit,'Value');

ia=get(handles.listbox_analysis,'Value');

ibc=get(handles.listbox_bc,'Value');

c=str2num(get(handles.edit_speed,'String'));


diameter=str2num(get(handles.edit_diameter,'String'));
a=diameter/2;

if(iu==1)  % English
    c=c*12;
    su='in';
else       % metric
    a=a/100;
    su='m';
end

if(ia==1)
    L=str2num(get(handles.edit_L,'String'));
else
    f1=str2num(get(handles.edit_f,'String'));
end

%%%

if(ibc==1 || ibc==3 )  % open-open or closed-closed
    if(ia==1)
        f1=(1/2)*(c/L);
        f2=2*f1;
        f3=3*f1;
    else
        L=(1/2)*c/f1;
    end
end    
%
if(ibc==2)  % closed-open
    if(ia==1)
        f1=(1/4)*(c/L);
        f2=(3/4)*(c/L);
        f3=(5/4)*(c/L);        
    else
        L=(1/4)*c/f1;
    end
end
%

%
if(ibc==4)  % Driven by piston at one end. Open at other end. Large flange at open end.
    term=(8*a)/(3*pi);
    if(ia==1)
        f1=(1/2)*c/(L+term);
        f2=2*f1;
        f3=3*f1;
    else
        L=((1/2)*c/f)-term;
    end
end    
%
if(ibc==5)  % Driven by piston at one end. Open at other end. Unflanged.
    term=0.6*a;
    if(ia==1)
        f1=(1/2)*c/(L+term);
        f2=2*f1;
        f3=3*f1;        
    else
        L=((1/2)*c/f)-term;
    end
end    
%

if(ia==1)
    w1=c/f1;
    w2=c/f2;
    w3=c/f3;

    s1=sprintf('Natural Frequencies (Hz) \n\n f1=%8.4g\n f2=%8.4g\n f3=%8.4g',f1,f2,f3); 
    s2=sprintf(' \n\n Wavelengths (%s) ',su);
    s3=sprintf('\n\n \x03bb 1=%8.4g \n \x03bb 2=%8.4g \n \x03bb 3=%8.4g',w1,w2,w3);
    ss=strcat(s1,s2,s3);            
            
else
    if(iu==1)
        ss=sprintf('Length \n\n %8.4g ft \n %8.4g in \n %8.4g cm',L/12,L,L*2.54);
    else
        ss=sprintf('Length \n\n %8.4g m \n %8.4g cm',L,L*100);        
    end
end

set(handles.uipanel_result,'visible','on');
set(handles.edit_result,'String',ss);
    

% --- Executes on selection change in listbox_analysis.
function listbox_analysis_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_analysis (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_analysis contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_analysis

change(hObject, eventdata, handles);


% --- Executes during object creation, after setting all properties.
function listbox_analysis_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_analysis (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
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
change(hObject, eventdata, handles);

iu=get(handles.listbox_unit,'value');

if(iu==2)
    ss='Speed of Sound (m/sec)';
    c='343';
else
    ss='Speed of Sound (ft/sec)';
    c='1125';
end

set(handles.text_speed,'String',ss);
set(handles.edit_speed,'String',c);



function change(hObject, eventdata, handles)
%
iu=get(handles.listbox_unit,'value');

ia=get(handles.listbox_analysis,'value');

set(handles.text_freq,'Visible','off');
set(handles.edit_f,'Visible','off');

set(handles.text_L,'Visible','off');
set(handles.edit_L,'Visible','off');

set(handles.text_diameter,'Visible','off');
set(handles.edit_diameter,'Visible','off');


if(ia==1)
    set(handles.text_L,'Visible','on');
    set(handles.edit_L,'Visible','on');
else
    set(handles.text_freq,'Visible','on');
    set(handles.edit_f,'Visible','on');    
end


if(iu==1)
    set(handles.text_L,'String','Length (in)');
    set(handles.text_diameter,'String','Diameter (in)');    
else
    set(handles.text_L,'String','Length (m)'); 
    set(handles.text_diameter,'String','Diameter (cm)');    
end

ibc=get(handles.listbox_bc,'Value');

if(ibc>=4)
    set(handles.text_diameter,'Visible','on');
    set(handles.edit_diameter,'Visible','on');
end

set(handles.edit_result,'String','');

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


% --- Executes on selection change in listbox_bc.
function listbox_bc_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_bc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_bc contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_bc
change(hObject, eventdata, handles);

% --- Executes during object creation, after setting all properties.
function listbox_bc_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_bc (see GCBO)
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



function edit_f_Callback(hObject, eventdata, handles)
% hObject    handle to edit_f (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_f as text
%        str2double(get(hObject,'String')) returns contents of edit_f as a double


% --- Executes during object creation, after setting all properties.
function edit_f_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_f (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_L_Callback(hObject, eventdata, handles)
% hObject    handle to edit_L (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_L as text
%        str2double(get(hObject,'String')) returns contents of edit_L as a double


% --- Executes during object creation, after setting all properties.
function edit_L_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_L (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_diameter_Callback(hObject, eventdata, handles)
% hObject    handle to edit_diameter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_diameter as text
%        str2double(get(hObject,'String')) returns contents of edit_diameter as a double


% --- Executes during object creation, after setting all properties.
function edit_diameter_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_diameter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_result_Callback(hObject, eventdata, handles)
% hObject    handle to edit_result (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_result as text
%        str2double(get(hObject,'String')) returns contents of edit_result as a double


% --- Executes during object creation, after setting all properties.
function edit_result_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_result (see GCBO)
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
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.edit_result,'String','');


% --- Executes on key press with focus on edit_f and none of its controls.
function edit_f_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_f (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.edit_result,'String','');


% --- Executes on key press with focus on edit_L and none of its controls.
function edit_L_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_L (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.edit_result,'String','');


% --- Executes on key press with focus on edit_diameter and none of its controls.
function edit_diameter_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_diameter (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.edit_result,'String','');

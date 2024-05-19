function varargout = Helmholtz_Resonator(varargin)
% HELMHOLTZ_RESONATOR MATLAB code for Helmholtz_Resonator.fig
%      HELMHOLTZ_RESONATOR, by itself, creates a new HELMHOLTZ_RESONATOR or raises the existing
%      singleton*.
%
%      H = HELMHOLTZ_RESONATOR returns the handle to a new HELMHOLTZ_RESONATOR or the handle to
%      the existing singleton*.
%
%      HELMHOLTZ_RESONATOR('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in HELMHOLTZ_RESONATOR.M with the given input arguments.
%
%      HELMHOLTZ_RESONATOR('Property','Value',...) creates a new HELMHOLTZ_RESONATOR or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Helmholtz_Resonator_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Helmholtz_Resonator_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Helmholtz_Resonator

% Last Modified by GUIDE v2.5 20-Feb-2014 15:45:17

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Helmholtz_Resonator_OpeningFcn, ...
                   'gui_OutputFcn',  @Helmholtz_Resonator_OutputFcn, ...
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


% --- Executes just before Helmholtz_Resonator is made visible.
function Helmholtz_Resonator_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Helmholtz_Resonator (see VARARGIN)

% Choose default command line output for Helmholtz_Resonator
handles.output = hObject;

set(handles.listbox_units,'Value',1);
set(handles.listbox_medium,'Value',1);
set(handles.listbox_analysis,'Value',1);
set(handles.listbox_flanged,'Value',1);

change_choices(hObject, eventdata, handles);
clear_results(hObject, eventdata, handles);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Helmholtz_Resonator wait for user response (see UIRESUME)
% uiwait(handles.figure1);


function clear_results(hObject, eventdata, handles) 
%
set(handles.edit_results,'String','');
set(handles.edit_results,'Visible','off');
set(handles.text_results,'Visible','off');

% --- Outputs from this function are returned to the command line.
function varargout = Helmholtz_Resonator_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in listbox_medium.
function listbox_medium_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_medium (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_medium contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_medium

change_choices(hObject, eventdata, handles);


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


% --- Executes on selection change in listbox_units.
function listbox_units_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_units (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_units contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_units

change_choices(hObject, eventdata, handles);



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


% --- Executes on selection change in listbox_analysis.
function listbox_analysis_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_analysis (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_analysis contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_analysis

change_choices(hObject, eventdata, handles);


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



function edit_speed_sound_Callback(hObject, eventdata, handles)
% hObject    handle to edit_speed_sound (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_speed_sound as text
%        str2double(get(hObject,'String')) returns contents of edit_speed_sound as a double


% --- Executes during object creation, after setting all properties.
function edit_speed_sound_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_speed_sound (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

set(handles.edit_results,'Visible','on');
set(handles.text_results,'Visible','on');

tpi=2*pi;

n_units=get(handles.listbox_units,'Value');
n_medium=get(handles.listbox_medium,'Value');
n_analysis=get(handles.listbox_analysis,'Value');
n_flanged=get(handles.listbox_flanged,'Value');

if(n_flanged==1)
    scale=1.7;
else
    scale=1.5;
end


if(n_medium==1) % air
    if(n_units==1)
        C=1130*12;
    else
        C=344*1000;
    end       
end   

if(n_medium==2) % water
    if(iu==1)
        C=58307;
    else
        C=1481*1000;
    end 
end    

if(n_medium==3) % other
    
   cg=str2num(get(handles.edit_speed_sound,'Value')); 
    
   if(n_units==1)
       C=cg*12;
   else
       C=cg*1000;   
   end
end    

if(n_analysis~=1)
    fn=str2num(get(handles.edit_fn,'String'));
end
 
if(n_analysis~=2)
    diameter=str2num(get(handles.edit_neck_diameter,'String'));
    A=pi*diameter^2/4; 
    r=diameter/2;
end
 
if(n_analysis~=3)
    length=str2num(get(handles.edit_neck_length,'String'));
    Lc=length+scale*r;   %  scale*r is the end correction
end
 
if(n_analysis~=4)
    volume=str2num(get(handles.edit_volume,'String'));
end

Cp=C/tpi;

if(n_analysis==1)
    fn=Cp*sqrt(A/(Lc*volume));
    s1=sprintf(' %8.4g',fn);
    set(handles.text_results,'String','Natural Frequency (Hz)');
end
%
if(n_analysis==2)    
    A=(Lc/Cp^2)*(fn^2*volume);
    
    s1=sprintf(' %8.4g',A);
    
    if(n_units==1)
        set(handles.text_results,'String','Area (in^2)');       
    else
        set(handles.text_results,'String','Area (mm^2)');             
    end
   
end
%
if(n_analysis==3)
    A=pi*r^2;
    Lc=Cp^2*A/(fn^2*volume);
    L=Lc-scale*r;
    
    s1=sprintf(' %8.4g',L); 
    
    if(n_units==1)
        set(handles.text_results,'String','Length (in)');        
    else
        set(handles.text_results,'String','Length (mm)');            
    end    
end
%
if(n_analysis==4)
    A=pi*r^2;
    V=Cp^2*A/(fn^2*Lc);
    s1=sprintf(' %8.4g',V);
    
    if(n_units==1)
        set(handles.text_results,'String','Volume (in^3)');          
    else
        set(handles.text_results,'String','Volume (mm^3)');              
    end
   
end

set(handles.edit_results,'String',s1);


% --- Executes on button press in pushbutton_return.
function pushbutton_return_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_return (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
delete(Helmholtz_Resonator);



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


function change_choices(hObject, eventdata, handles)
%
clear_results(hObject, eventdata, handles);

n_units=get(handles.listbox_units,'Value');
n_medium=get(handles.listbox_medium,'Value');
n_analysis=get(handles.listbox_analysis,'Value');

if(n_medium==3)
    set(handles.text_speed_sound,'Visible','on');
    set(handles.edit_speed_sound,'Visible','on');
    
    if(n_units==1)
        set(handles.text_speed_sound,'String','Speed of Sound (ft/sec)');        
    else
        set(handles.text_speed_sound,'String','Speed of Sound (m/sec)');           
    end    
    
else
    set(handles.text_speed_sound,'Visible','off'); 
    set(handles.edit_speed_sound,'Visible','off');    
end

if(n_analysis~=1)
    set(handles.text_fn,'Visible','on');
    set(handles.edit_fn,'Visible','on');
else
    set(handles.text_fn,'Visible','off');
    set(handles.edit_fn,'Visible','off');    
end

if(n_analysis~=2)

    set(handles.edit_neck_diameter,'Visible','on');
    set(handles.text_neck_diameter,'Visible','on');
  
    if(n_units==1)
        set(handles.text_neck_diameter,'String','Neck Diameter (inch)');  
    else
        set(handles.text_neck_diameter,'String','Neck Diameter (mm)');         
    end

else
    set(handles.edit_neck_diameter,'Visible','off');  
    set(handles.text_neck_diameter,'Visible','off');     
end

if(n_analysis~=3)

    set(handles.edit_neck_length,'Visible','on');
    set(handles.text_neck_length,'Visible','on');
  
    if(n_units==1)
        set(handles.text_neck_length,'String','Neck Length (inch)');  
    else
        set(handles.text_neck_length,'String','Neck Length (mm)');         
    end
 
else
    set(handles.edit_neck_length,'Visible','off');  
    set(handles.text_neck_length,'Visible','off');     
end

if(n_analysis~=4)
 
    set(handles.edit_volume,'Visible','on');
    set(handles.text_volume,'Visible','on');
  
    if(n_units==1)
        set(handles.text_volume,'String','Volume (in^3)');  
    else
        set(handles.text_volume,'String','Volume (mm^3)');         
    end
 
else
    set(handles.edit_volume,'Visible','off');  
    set(handles.text_volume,'Visible','off');     
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



function edit_neck_diameter_Callback(hObject, eventdata, handles)
% hObject    handle to edit_neck_diameter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_neck_diameter as text
%        str2double(get(hObject,'String')) returns contents of edit_neck_diameter as a double


% --- Executes during object creation, after setting all properties.
function edit_neck_diameter_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_neck_diameter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_neck_length_Callback(hObject, eventdata, handles)
% hObject    handle to edit_neck_length (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_neck_length as text
%        str2double(get(hObject,'String')) returns contents of edit_neck_length as a double


% --- Executes during object creation, after setting all properties.
function edit_neck_length_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_neck_length (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_volume_Callback(hObject, eventdata, handles)
% hObject    handle to edit_volume (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_volume as text
%        str2double(get(hObject,'String')) returns contents of edit_volume as a double


% --- Executes during object creation, after setting all properties.
function edit_volume_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_volume (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on key press with focus on edit_fn and none of its controls.
function edit_fn_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_fn (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
clear_results(hObject, eventdata, handles);


% --- Executes on key press with focus on edit_neck_diameter and none of its controls.
function edit_neck_diameter_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_neck_diameter (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
clear_results(hObject, eventdata, handles);


% --- Executes on key press with focus on edit_neck_length and none of its controls.
function edit_neck_length_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_neck_length (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
clear_results(hObject, eventdata, handles);


% --- Executes on key press with focus on edit_volume and none of its controls.
function edit_volume_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_volume (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
clear_results(hObject, eventdata, handles);


% --- Executes on key press with focus on edit_speed_sound and none of its controls.
function edit_speed_sound_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_speed_sound (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
clear_results(hObject, eventdata, handles);


% --- Executes on selection change in listbox_flanged.
function listbox_flanged_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_flanged (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_flanged contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_flanged

clear_results(hObject, eventdata, handles);

% --- Executes during object creation, after setting all properties.
function listbox_flanged_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_flanged (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

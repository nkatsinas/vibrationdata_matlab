function varargout = stress_strain_to_energy_strain(varargin)
% STRESS_STRAIN_TO_ENERGY_STRAIN MATLAB code for stress_strain_to_energy_strain.fig
%      STRESS_STRAIN_TO_ENERGY_STRAIN, by itself, creates a new STRESS_STRAIN_TO_ENERGY_STRAIN or raises the existing
%      singleton*.
%
%      H = STRESS_STRAIN_TO_ENERGY_STRAIN returns the handle to a new STRESS_STRAIN_TO_ENERGY_STRAIN or the handle to
%      the existing singleton*.
%
%      STRESS_STRAIN_TO_ENERGY_STRAIN('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in STRESS_STRAIN_TO_ENERGY_STRAIN.M with the given input arguments.
%
%      STRESS_STRAIN_TO_ENERGY_STRAIN('Property','Value',...) creates a new STRESS_STRAIN_TO_ENERGY_STRAIN or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before stress_strain_to_energy_strain_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to stress_strain_to_energy_strain_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help stress_strain_to_energy_strain

% Last Modified by GUIDE v2.5 07-Jan-2021 13:47:56

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @stress_strain_to_energy_strain_OpeningFcn, ...
                   'gui_OutputFcn',  @stress_strain_to_energy_strain_OutputFcn, ...
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


% --- Executes just before stress_strain_to_energy_strain is made visible.
function stress_strain_to_energy_strain_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to stress_strain_to_energy_strain (see VARARGIN)

% Choose default command line output for stress_strain_to_energy_strain
handles.output = hObject;

listbox_volume_Callback(hObject, eventdata, handles);
listbox_post_Callback(hObject, eventdata, handles);

set(handles.uipanel_save,'Visible','off');
set(handles.uipanel_post,'Visible','off');
set(handles.text_find,'Visible','off');
set(handles.edit_find,'Visible','off');


% Update handles structure
guidata(hObject, handles);

% UIWAIT makes stress_strain_to_energy_strain wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = stress_strain_to_energy_strain_OutputFcn(hObject, eventdata, handles) 
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
delete(stress_strain_to_energy_strain);


% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

try
    FS=strtrim(get(handles.edit_input_array,'String')); 
	THM=evalin('base',FS);
catch
    warndlg('Input Array not found');
    return;
end

strain=THM(:,1);
stress=THM(:,2);


n=get(handles.listbox_stress,'Value');

if(n==2)
    stress=stress*1000;
end
if(n==3)
    MPa_per_ksi=6.894;
    stress=stress*MPa_per_ksi*1000;
end

m=get(handles.listbox_volume,'Value');

if(m==1)
    volume=str2double(get(handles.edit_volume,'String'));
else
    slength=get(handles.edit_length,'String');
    sdiameter=get(handles.edit_diameter,'String');
    
    if(contains(slength,'/'))
        length=eval(slength);
    else
        length=str2double(slength);
    end
    
    if(contains(sdiameter,'/'))
        diameter=eval(sdiameter);
    else
        diameter=str2double(sdiameter);
    end 
    
    
    volume=pi*length*(diameter^2)/4;
end


strain_int=linspace(strain(1),strain(end),2000)';

xi=strain_int;
x=strain;
y=stress;

stress_int = interp1(x,y,xi);

energy=cumtrapz(strain_int,stress_int);

energy=energy*volume;


strain_energy=[strain_int energy];

setappdata(0,'strain_energy',strain_energy);

set(handles.uipanel_save,'Visible','on');
set(handles.uipanel_post,'Visible','on');
set(handles.listbox_post,'Visible','on');
set(handles.text_find,'Visible','off');
set(handles.edit_find,'Visible','off');

tstring=get(handles.edit_tstring,'String');

h=figure(1);
subplot(1,2,1);
plot(strain,stress/1000);
grid on;
xlabel('Strain'); 
ylabel('Stress (ksi)'); 
out1=sprintf('Stress-Strain  %s',tstring);
title(out1);

subplot(1,2,2);
plot(strain_int,energy);
grid on;
xlabel('Strain'); 
ylabel('Energy (lbf in)');
if(m==1)
    out2=sprintf('Energy-Strain  %s  Vol=%g in^3',tstring,volume);
else
    out2=sprintf('Energy-Strain  %s  Length=%s in Diameter=%s in',tstring,slength,sdiameter);    
end
title(out2);

set(h, 'Position', [0 0 1100 400]);
 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%




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


% --- Executes on selection change in listbox_stress.
function listbox_stress_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_stress (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_stress contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_stress
set(handles.uipanel_save,'Visible','off');
set(handles.uipanel_post,'Visible','off');

% --- Executes during object creation, after setting all properties.
function listbox_stress_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_stress (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_volume.
function listbox_volume_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_volume (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_volume contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_volume

m=get(handles.listbox_volume,'Value');

set(handles.text_volume,'Visible','off');
set(handles.edit_volume,'Visible','off');
set(handles.text_length,'Visible','off');
set(handles.edit_length,'Visible','off');
set(handles.text_diameter,'Visible','off');
set(handles.edit_diameter,'Visible','off');

if(m==1)
    set(handles.text_volume,'Visible','on');
    set(handles.edit_volume,'Visible','on');
else
    set(handles.text_length,'Visible','on');
    set(handles.edit_length,'Visible','on');
    set(handles.text_diameter,'Visible','on');
    set(handles.edit_diameter,'Visible','on');    
end

set(handles.uipanel_save,'Visible','off');
set(handles.uipanel_post,'Visible','off');

% --- Executes during object creation, after setting all properties.
function listbox_volume_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_volume (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
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



function edit_length_Callback(hObject, eventdata, handles)
% hObject    handle to edit_length (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_length as text
%        str2double(get(hObject,'String')) returns contents of edit_length as a double


% --- Executes during object creation, after setting all properties.
function edit_length_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_length (see GCBO)
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


% --- Executes on button press in pushbutton_save.
function pushbutton_save_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

data=getappdata(0,'strain_energy');

output_name=get(handles.edit_output_array_name,'String');
assignin('base', output_name, data);

h = msgbox('Save Complete');


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


% --- Executes on key press with focus on edit_volume and none of its controls.
function edit_volume_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_volume (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.uipanel_save,'Visible','off');
set(handles.uipanel_post,'Visible','off');

% --- Executes on key press with focus on edit_length and none of its controls.
function edit_length_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_length (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.uipanel_save,'Visible','off');
set(handles.uipanel_post,'Visible','off');


% --- Executes on key press with focus on edit_diameter and none of its controls.
function edit_diameter_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_diameter (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.uipanel_save,'Visible','off');
set(handles.uipanel_post,'Visible','off');


function edit_tstring_Callback(hObject, eventdata, handles)
% hObject    handle to edit_tstring (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_tstring as text
%        str2double(get(hObject,'String')) returns contents of edit_tstring as a double


% --- Executes during object creation, after setting all properties.
function edit_tstring_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_tstring (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_post.
function listbox_post_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_post (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_post contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_post

set(handles.edit_find,'Visible','off');
set(handles.text_find,'Visible','off'); 


n=get(handles.listbox_post,'Value');

if(n==1)
    set(handles.text_post,'String','Energy (lbf in)');
    set(handles.text_find,'String','Strain Ratio');    
else
    set(handles.text_post,'String','Strain Ratio');
    set(handles.text_find,'String','Energy (lbf in)');    
end
    

% --- Executes during object creation, after setting all properties.
function listbox_post_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_post (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_post_Callback(hObject, eventdata, handles)
% hObject    handle to edit_post (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_post as text
%        str2double(get(hObject,'String')) returns contents of edit_post as a double


% --- Executes during object creation, after setting all properties.
function edit_post_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_post (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_find.
function pushbutton_find_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_find (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

strain_energy=getappdata(0,'strain_energy');

n=get(handles.listbox_post,'Value');

post=str2double(get(handles.edit_post,'String'));

if(n==2)
      [~,ii]=min(abs(strain_energy(:,1)-post));
      x=strain_energy(ii,2);
else
      [~,ii]=min(abs(strain_energy(:,2)-post));
      x=strain_energy(ii,1);      
end

sss=sprintf('%8.4g',x);
set(handles.edit_find,'String',sss,'Visible','on');
set(handles.text_find,'Visible','on');







function edit_find_Callback(hObject, eventdata, handles)
% hObject    handle to edit_find (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_find as text
%        str2double(get(hObject,'String')) returns contents of edit_find as a double


% --- Executes during object creation, after setting all properties.
function edit_find_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_find (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

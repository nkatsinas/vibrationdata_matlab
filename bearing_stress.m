function varargout = bearing_stress(varargin)
% BEARING_STRESS MATLAB code for bearing_stress.fig
%      BEARING_STRESS, by itself, creates a new BEARING_STRESS or raises the existing
%      singleton*.
%
%      H = BEARING_STRESS returns the handle to a new BEARING_STRESS or the handle to
%      the existing singleton*.
%
%      BEARING_STRESS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in BEARING_STRESS.M with the given input arguments.
%
%      BEARING_STRESS('Property','Value',...) creates a new BEARING_STRESS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before bearing_stress_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to bearing_stress_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help bearing_stress

% Last Modified by GUIDE v2.5 13-Apr-2016 16:21:50

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @bearing_stress_OpeningFcn, ...
                   'gui_OutputFcn',  @bearing_stress_OutputFcn, ...
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


% --- Executes just before bearing_stress is made visible.
function bearing_stress_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to bearing_stress (see VARARGIN)

% Choose default command line output for bearing_stress
handles.output = hObject;

change(hObject, eventdata, handles);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes bearing_stress wait for user response (see UIRESUME)
% uiwait(handles.figure1);

function change(hObject, eventdata, handles)

set(handles.uipanel_stress,'Visible','off');

iu=get(handles.listbox_unit,'Value');
ic=get(handles.listbox_configuration,'Value');

if(iu==1)  % English
    
    set(handles.text_load_unit,'String','lbf');

else       % metric
    
    set(handles.text_load_unit,'String','N');
    
end

cla(handles.axes1);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

posu = getpixelposition(handles.uipanel_data,true);

ux=posu(1);
uy=posu(2);

if(ic==1) % sphere of flat plate

    fstr='sphere_1.jpg';
 
end
if(ic==2) % sphere on sphere

    fstr='sphere_2.jpg';
 
end
if(ic==3) % sphere in spherical socket

    fstr='sphere_3.jpg';
 
end 

bg = imread(fstr);
info = imfinfo(fstr);
w = info.Width;  %An integer indicating the width of the image in pixels
h = info.Height; %An integer indicating the height of the image in pixels
 
axes(handles.axes1);
image(bg);
 
pos1 = getpixelposition(handles.axes1,true);
 
set(handles.axes1, ...
    'Visible', 'off', ...
    'Units', 'pixels', ...
    'Position', [pos1(1)-ux pos1(2)-uy w h]);
axis off;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(iu==1)
    set(handles.text_D1_unit,'String','(in)');
    set(handles.text_E1_unit,'String','(psi)');      
    set(handles.text_D2_unit,'String','(in)');
    set(handles.text_E2_unit,'String','(psi)');   
else
    set(handles.text_D1_unit,'String','(mm)');    
    set(handles.text_E1_unit,'String','(Pa)');    
    set(handles.text_D2_unit,'String','(mm)');    
    set(handles.text_E2_unit,'String','(Pa)');      
end


if(ic==1)
    set(handles.text_D1,'Visible','off');
    set(handles.text_D1_unit,'Visible','off');
    set(handles.edit_D1,'Visible','off');
else
    set(handles.text_D1,'Visible','on');
    set(handles.text_D1_unit,'Visible','on');
    set(handles.edit_D1,'Visible','on')       
end

if(ic==1) % sphere of flat plate
    set(handles.uipanel_top,'title','Sphere');
    set(handles.uipanel_bottom,'title','Flat Plate');  
    
end
if(ic==2) % sphere on sphere
    set(handles.uipanel_top,'title','Top Sphere');
    set(handles.uipanel_bottom,'title','Bottom Sphere');     
    
end
if(ic==3) % sphere in spherical socket
    set(handles.uipanel_top,'title','Sphere');
    set(handles.uipanel_bottom,'title','Socket');    
end



% --- Outputs from this function are returned to the command line.
function varargout = bearing_stress_OutputFcn(hObject, eventdata, handles) 
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

D1=0;
D2=0;

iu=get(handles.listbox_unit,'Value');
ic=get(handles.listbox_configuration,'Value');


P=str2num(get(handles.edit_P,'String'));
TF = isempty(P);

if(TF==1)
    warndlg('Enter Applied Load');
    return;
end    


D2=str2num(get(handles.edit_D2,'String'));

E2=str2num(get(handles.edit_E2,'String'));
v2=str2num(get(handles.edit_v2,'String'));

E1=str2num(get(handles.edit_E1,'String'));
v1=str2num(get(handles.edit_v1,'String'));


if(ic==2 || ic==3)
    D1=str2num(get(handles.edit_D1,'String'));    
end


if(iu==2) % metric
   D1=D1/1000;
   D2=D2/1000;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(ic==1)  % sphere on flat plate
    
    KD=D2;

end
if(ic==2)  % sphere on sphere

    KD=D1*D2/(D1+D2);

end
if(ic==3)  % sphere in spherical socket

    KD=D1*D2/(D1-D2);    

end



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


CE=(1-v1^2)/E1+(1-v2^2)/E2;

a=0.721*(P*KD*CE)^(1/3);
stress=1.5*P/(pi*a^2);

disp('  ');
disp(' * * * ');
disp('  ');

stress1=stress;
stress2=stress/1000;
stress3=stress/1000^2;

s1=sprintf('%8.4g',stress1);
s2=sprintf('%8.4g',stress2);
    
set(handles.edit_stress1,'String',s1);
set(handles.edit_stress2,'String',s2); 

if(iu==1)

    out1=sprintf(' Stress = %8.4g psi ',stress1);
    out2=sprintf('        = %8.4g ksi ',stress2);
    
    set(handles.edit_stress3,'Visible','off');
    set(handles.text_stress3,'Visible','off');  
    
    set(handles.text_stress1,'String','psi');
    set(handles.text_stress2,'String','ksi');  
    

else
    
    out1=sprintf(' Stress = %8.4g Pa ',stress);
    out2=sprintf('        = %8.4g kPa ',stress/1000);
    out3=sprintf('        = %8.4g MPa ',stress/1000^2); 
    
    set(handles.edit_stress3,'Visible','on'); 
    set(handles.text_stress3,'Visible','on');      

    set(handles.text_stress1,'String','Pa');
    set(handles.text_stress2,'String','kPa');      

    s3=sprintf('%8.4g',stress3);    
    
    set(handles.edit_stress3,'String',s3);     
    
end

disp(out1);
disp(out2);

if(iu==2)
    disp(out3);   
end

set(handles.uipanel_stress,'Visible','on');


% --- Executes on selection change in listbox_unit.
function listbox_unit_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_unit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_unit contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_unit

change(hObject, eventdata, handles);


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


% --- Executes on selection change in listbox_configuration.
function listbox_configuration_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_configuration (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_configuration contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_configuration

change(hObject, eventdata, handles);


% --- Executes during object creation, after setting all properties.
function listbox_configuration_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_configuration (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_P_Callback(hObject, eventdata, handles)
% hObject    handle to edit_P (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_P as text
%        str2double(get(hObject,'String')) returns contents of edit_P as a double


% --- Executes during object creation, after setting all properties.
function edit_P_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_P (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function pushbutton_calculate_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on button press in pushbutton_return.
function pushbutton_return_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_return (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

delete(bearing_stress);



function edit6_Callback(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit6 as text
%        str2double(get(hObject,'String')) returns contents of edit6 as a double


% --- Executes during object creation, after setting all properties.
function edit6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit7_Callback(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit7 as text
%        str2double(get(hObject,'String')) returns contents of edit7 as a double


% --- Executes during object creation, after setting all properties.
function edit7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_D1_Callback(hObject, eventdata, handles)
% hObject    handle to edit_D1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_D1 as text
%        str2double(get(hObject,'String')) returns contents of edit_D1 as a double


% --- Executes during object creation, after setting all properties.
function edit_D1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_D1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_D2_Callback(hObject, eventdata, handles)
% hObject    handle to edit_D2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_D2 as text
%        str2double(get(hObject,'String')) returns contents of edit_D2 as a double


% --- Executes during object creation, after setting all properties.
function edit_D2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_D2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_E2_Callback(hObject, eventdata, handles)
% hObject    handle to edit_E2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_E2 as text
%        str2double(get(hObject,'String')) returns contents of edit_E2 as a double


% --- Executes during object creation, after setting all properties.
function edit_E2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_E2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_v2_Callback(hObject, eventdata, handles)
% hObject    handle to edit_v2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_v2 as text
%        str2double(get(hObject,'String')) returns contents of edit_v2 as a double


% --- Executes during object creation, after setting all properties.
function edit_v2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_v2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_v1_Callback(hObject, eventdata, handles)
% hObject    handle to edit_v1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_v1 as text
%        str2double(get(hObject,'String')) returns contents of edit_v1 as a double


% --- Executes during object creation, after setting all properties.
function edit_v1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_v1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_E1_Callback(hObject, eventdata, handles)
% hObject    handle to edit_E1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_E1 as text
%        str2double(get(hObject,'String')) returns contents of edit_E1 as a double


% --- Executes during object creation, after setting all properties.
function edit_E1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_E1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit5_Callback(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit5 as text
%        str2double(get(hObject,'String')) returns contents of edit5 as a double


% --- Executes during object creation, after setting all properties.
function edit5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit3_Callback(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double


% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on key press with focus on edit_P and none of its controls.
function edit_P_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_P (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)

set(handles.uipanel_stress,'Visible','off');


% --- Executes on key press with focus on edit_D2 and none of its controls.
function edit_D2_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_D2 (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)

set(handles.uipanel_stress,'Visible','off');


% --- Executes on key press with focus on edit_E2 and none of its controls.
function edit_E2_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_E2 (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.uipanel_stress,'Visible','off');


% --- Executes on key press with focus on edit_v2 and none of its controls.
function edit_v2_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_v2 (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.uipanel_stress,'Visible','off');


% --- Executes on key press with focus on edit_D1 and none of its controls.
function edit_D1_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_D1 (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.uipanel_stress,'Visible','off');


% --- Executes on key press with focus on edit_E1 and none of its controls.
function edit_E1_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_E1 (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.uipanel_stress,'Visible','off');


% --- Executes on key press with focus on edit_v1 and none of its controls.
function edit_v1_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_v1 (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.uipanel_stress,'Visible','off');



function edit_stress1_Callback(hObject, eventdata, handles)
% hObject    handle to edit_stress1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_stress1 as text
%        str2double(get(hObject,'String')) returns contents of edit_stress1 as a double


% --- Executes during object creation, after setting all properties.
function edit_stress1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_stress1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_stress2_Callback(hObject, eventdata, handles)
% hObject    handle to edit_stress2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_stress2 as text
%        str2double(get(hObject,'String')) returns contents of edit_stress2 as a double


% --- Executes during object creation, after setting all properties.
function edit_stress2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_stress2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_stress3_Callback(hObject, eventdata, handles)
% hObject    handle to edit_stress3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_stress3 as text
%        str2double(get(hObject,'String')) returns contents of edit_stress3 as a double


% --- Executes during object creation, after setting all properties.
function edit_stress3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_stress3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on key press with focus on edit_stress1 and none of its controls.
function edit_stress1_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_stress1 (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)



% --- Executes on key press with focus on edit_stress2 and none of its controls.
function edit_stress2_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_stress2 (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)

function varargout = fracture_stress_partial(varargin)
% FRACTURE_STRESS_PARTIAL MATLAB code for fracture_stress_partial.fig
%      FRACTURE_STRESS_PARTIAL, by itself, creates a new FRACTURE_STRESS_PARTIAL or raises the existing
%      singleton*.
%
%      H = FRACTURE_STRESS_PARTIAL returns the handle to a new FRACTURE_STRESS_PARTIAL or the handle to
%      the existing singleton*.
%
%      FRACTURE_STRESS_PARTIAL('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in FRACTURE_STRESS_PARTIAL.M with the given input arguments.
%
%      FRACTURE_STRESS_PARTIAL('Property','Value',...) creates a new FRACTURE_STRESS_PARTIAL or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before fracture_stress_partial_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to fracture_stress_partial_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help fracture_stress_partial

% Last Modified by GUIDE v2.5 17-Nov-2014 15:29:25

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @fracture_stress_partial_OpeningFcn, ...
                   'gui_OutputFcn',  @fracture_stress_partial_OutputFcn, ...
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


% --- Executes just before fracture_stress_partial is made visible.
function fracture_stress_partial_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to fracture_stress_partial (see VARARGIN)

% Choose default command line output for fracture_stress_partial
handles.output = hObject;

set(handles.uipanel_save,'Visible','off');

set(handles.listbox_KIC,'Value',1);

listbox_KIC_Callback(hObject, eventdata, handles);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes fracture_stress_partial wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = fracture_stress_partial_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% n=get(handles.listbox_KIC,'Value');

KIC=str2num(get(handles.edit_KIC,'String'));

KIC=KIC*(1.0e+06);

a=str2num(get(handles.edit_a,'String'));
t=str2num(get(handles.edit_t,'String'));

a=a/1000;
t=t/1000;

if(a>=0.5*t)
    warndlg('Flaw Depth >= 0.5*Thickness');
    return;
end

arg=(pi*a)/(2.*t);
%
den=sqrt(pi*a)*sqrt(sec(arg));
stress=KIC/den;

stress=stress/(1.0e+06);

stress_ksi=stress*0.1450377;

%
out5 = sprintf('\n Stress = %10.3g MPa',stress);
disp(out5);
out6 = sprintf('\n        = %10.3g ksi\n',stress_ksi);
disp(out6)

ss=sprintf('%10.3g',stress);
set(handles.edit_stress,'String',ss);

ss_ksi=sprintf('%10.3g',stress_ksi);
set(handles.edit_stress_ksi,'String',ss_ksi);


set(handles.uipanel_save,'Visible','on');

% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

delete(fracture_stress_partial)


function edit_a_Callback(hObject, eventdata, handles)
% hObject    handle to edit_a (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_a as text
%        str2double(get(hObject,'String')) returns contents of edit_a as a double


% --- Executes during object creation, after setting all properties.
function edit_a_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_a (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_t_Callback(hObject, eventdata, handles)
% hObject    handle to edit_t (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_t as text
%        str2double(get(hObject,'String')) returns contents of edit_t as a double


% --- Executes during object creation, after setting all properties.
function edit_t_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_t (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_KIC.
function listbox_KIC_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_KIC (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_KIC contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_KIC

set(handles.uipanel_save,'Visible','off');

n=get(handles.listbox_KIC,'Value');

i=1;
KIC(i)= 16;  % Aluminum, Generic, Low
i=i+1;
KIC(i)= 44;  % Aluminum, Generic, High
i=i+1;
KIC(i)= 16;  % Aluminum, 7075, Low
i=i+1;
KIC(i)= 24;  % Aluminum, 7075, Low
i=i+1;
KIC(i)= 41;  % Aluminum, 7075, High
i=i+1;
KIC(i)= 6;   % Cast Iron, Low
i=i+1;
KIC(i)= 20;  % Cast Iron, High
i=i+1;
KIC(i)= 170; % Pressure-vessel Steel (HY130)
i=i+1;
KIC(i)= 50;  % High-Strength Steel, Low
i=i+1;
KIC(i)= 154; % High-Strength Steel, High
i=i+1;
KIC(i)=140; % Mild Steel
i=i+1;
KIC(i)= 77; % Titanium Alloy, Low
i=i+1;
KIC(i)= 116; % Titanium Alloy, High
i=i+1;
KIC(i)= 0.3; % Epoxy, Low
i=i+1;
KIC(i)= 0.5; % Epoxy, High
i=i+1;
KIC(i)= 0.2; % Cement/Concrete
i=i+1;
KIC(i)= 10; % Cement/Concrete, Steel Reinforced, Low
i=i+1;
KIC(i)= 15; % Cement/Concrete, Steel Reinforced, High
i=i+1;


if(n==i)
    set(handles.edit_KIC,'String',' ');
else
    ss=sprintf('%g',KIC(n));
    set(handles.edit_KIC,'String',ss);    
end    
    
    



% --- Executes during object creation, after setting all properties.
function listbox_KIC_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_KIC (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_stress_Callback(hObject, eventdata, handles)
% hObject    handle to edit_stress (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_stress as text
%        str2double(get(hObject,'String')) returns contents of edit_stress as a double


% --- Executes during object creation, after setting all properties.
function edit_stress_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_stress (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_KIC_Callback(hObject, eventdata, handles)
% hObject    handle to edit_KIC (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_KIC as text
%        str2double(get(hObject,'String')) returns contents of edit_KIC as a double


% --- Executes during object creation, after setting all properties.
function edit_KIC_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_KIC (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on key press with focus on edit_t and none of its controls.
function edit_t_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_t (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.uipanel_save,'Visible','off');


% --- Executes on key press with focus on edit_a and none of its controls.
function edit_a_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_a (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.uipanel_save,'Visible','off');


% --- Executes on key press with focus on edit_KIC and none of its controls.
function edit_KIC_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_KIC (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.uipanel_save,'Visible','off');



function edit_stress_ksi_Callback(hObject, eventdata, handles)
% hObject    handle to edit_stress_ksi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_stress_ksi as text
%        str2double(get(hObject,'String')) returns contents of edit_stress_ksi as a double


% --- Executes during object creation, after setting all properties.
function edit_stress_ksi_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_stress_ksi (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function varargout = response_PSD_relative_damage(varargin)
% RESPONSE_PSD_RELATIVE_DAMAGE MATLAB code for response_PSD_relative_damage.fig
%      RESPONSE_PSD_RELATIVE_DAMAGE, by itself, creates a new RESPONSE_PSD_RELATIVE_DAMAGE or raises the existing
%      singleton*.
%
%      H = RESPONSE_PSD_RELATIVE_DAMAGE returns the handle to a new RESPONSE_PSD_RELATIVE_DAMAGE or the handle to
%      the existing singleton*.
%
%      RESPONSE_PSD_RELATIVE_DAMAGE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in RESPONSE_PSD_RELATIVE_DAMAGE.M with the given input arguments.
%
%      RESPONSE_PSD_RELATIVE_DAMAGE('Property','Value',...) creates a new RESPONSE_PSD_RELATIVE_DAMAGE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before response_PSD_relative_damage_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to response_PSD_relative_damage_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help response_PSD_relative_damage

% Last Modified by GUIDE v2.5 25-Jan-2022 15:33:38

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @response_PSD_relative_damage_OpeningFcn, ...
                   'gui_OutputFcn',  @response_PSD_relative_damage_OutputFcn, ...
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


% --- Executes just before response_PSD_relative_damage is made visible.
function response_PSD_relative_damage_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to response_PSD_relative_damage (see VARARGIN)

% Choose default command line output for response_PSD_relative_damage
handles.output = hObject;

clear_damage(hObject, eventdata, handles)

set(handles.uipanel_results,'Visible','off');

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes response_PSD_relative_damage wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = response_PSD_relative_damage_OutputFcn(hObject, eventdata, handles) 
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
delete(response_PSD_relative_damage);


% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



try
      FS=get(handles.edit_input_array,'String');
      THM=evalin('base',FS);
%      disp('ref 2')
catch
      warndlg('Unable to read input file','Warning');
      return;
end    

%%%%%%%%%%%%%%%%

bex=str2num(get(handles.edit_b,'String'));

dur=str2num(get(handles.edit_duration,'String'));


f=THM(:,1);
a=THM(:,2);

df=str2double(get(handles.edit_df,'String'));

[s,~]=calculate_PSD_slopes_no(f,a);

%
[fi,ai]=interpolate_PSD(f,a,s,df);

apsd=[fi ai];

[damage]=Dirlik_fds(apsd,bex,dur,df);

ss=sprintf('%8.4g',damage);

set(handles.edit_damage,'String',ss);

ss=sprintf('unit^%g',bex);

set(handles.text_unit_b,'String',ss);

set(handles.uipanel_results,'Visible','on');



function edit_b_Callback(hObject, eventdata, handles)
% hObject    handle to edit_b (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_b as text
%        str2double(get(hObject,'String')) returns contents of edit_b as a double


% --- Executes during object creation, after setting all properties.
function edit_b_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_b (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



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



function edit_damage_Callback(hObject, eventdata, handles)
% hObject    handle to edit_damage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_damage as text
%        str2double(get(hObject,'String')) returns contents of edit_damage as a double


% --- Executes during object creation, after setting all properties.
function edit_damage_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_damage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on key press with focus on edit_b and none of its controls.
function edit_b_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_b (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)


clear_damage(hObject, eventdata, handles);


function edit_duration_Callback(hObject, eventdata, handles)
% hObject    handle to edit_duration (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_duration as text
%        str2double(get(hObject,'String')) returns contents of edit_duration as a double


% --- Executes during object creation, after setting all properties.
function edit_duration_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_duration (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on key press with focus on edit_duration and none of its controls.
function edit_duration_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_duration (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
clear_damage(hObject, eventdata, handles);


% --- Executes on key press with focus on edit_input_array and none of its controls.
function edit_input_array_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_input_array (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
clear_damage(hObject, eventdata, handles)


function clear_damage(hObject, eventdata, handles)
set(handles.edit_damage,'String','');
set(handles.uipanel_results,'Visible','off');



function edit_df_Callback(hObject, eventdata, handles)
% hObject    handle to edit_df (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_df as text
%        str2double(get(hObject,'String')) returns contents of edit_df as a double


% --- Executes during object creation, after setting all properties.
function edit_df_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_df (see GCBO)
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

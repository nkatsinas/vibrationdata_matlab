function varargout = statistical_response_concentration(varargin)
% STATISTICAL_RESPONSE_CONCENTRATION MATLAB code for statistical_response_concentration.fig
%      STATISTICAL_RESPONSE_CONCENTRATION, by itself, creates a new STATISTICAL_RESPONSE_CONCENTRATION or raises the existing
%      singleton*.
%
%      H = STATISTICAL_RESPONSE_CONCENTRATION returns the handle to a new STATISTICAL_RESPONSE_CONCENTRATION or the handle to
%      the existing singleton*.
%
%      STATISTICAL_RESPONSE_CONCENTRATION('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in STATISTICAL_RESPONSE_CONCENTRATION.M with the given input arguments.
%
%      STATISTICAL_RESPONSE_CONCENTRATION('Property','Value',...) creates a new STATISTICAL_RESPONSE_CONCENTRATION or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before statistical_response_concentration_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to statistical_response_concentration_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help statistical_response_concentration

% Last Modified by GUIDE v2.5 04-May-2018 12:07:03

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @statistical_response_concentration_OpeningFcn, ...
                   'gui_OutputFcn',  @statistical_response_concentration_OutputFcn, ...
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


% --- Executes just before statistical_response_concentration is made visible.
function statistical_response_concentration_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to statistical_response_concentration (see VARARGIN)

% Choose default command line output for statistical_response_concentration
handles.output = hObject;

set(handles.uipanel_result,'Visible','off');

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes statistical_response_concentration wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = statistical_response_concentration_OutputFcn(hObject, eventdata, handles) 
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
delete(statistical_response_concentration);


% --- Executes on button press in pushbutton_eq.
function pushbutton_eq_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_eq (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

     A = imread('statistical_response_concentration.jpg');
     figure(991) 
     imshow(A,'border','tight','InitialMagnification',100)


% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

fc=str2num(get(handles.edit_fc,'String'));
nnet=str2num(get(handles.edit_nnet,'String'));
mdens=str2num(get(handles.edit_mdens,'String'));

nband=get(handles.listbox_band,'Value');
D=get(handles.listbox_D,'Value');

if(nband==1)
    z=2^(1/6);
else
    z=2^(1/2);    
end

delta_f=fc*(z-1/z);


[pure_tone,broadband]=statistical_response_concentration_core(fc,delta_f,nnet,mdens,D);


%% out1=sprintf(' ratio=%8.4g  broadband=%8.4g \n',ratio,ba);
%% disp(out1);


ss1=sprintf('%5.3g',pure_tone);
set(handles.edit_pt,'String',ss1);

ss2=sprintf('%5.3g',broadband);
set(handles.edit_bb,'String',ss2);

set(handles.uipanel_result,'Visible','on');





function edit_fc_Callback(hObject, eventdata, handles)
% hObject    handle to edit_fc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_fc as text
%        str2double(get(hObject,'String')) returns contents of edit_fc as a double


% --- Executes during object creation, after setting all properties.
function edit_fc_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_fc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_band.
function listbox_band_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_band (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_band contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_band
set(handles.uipanel_result,'Visible','off');

% --- Executes during object creation, after setting all properties.
function listbox_band_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_band (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_nnet_Callback(hObject, eventdata, handles)
% hObject    handle to edit_nnet (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_nnet as text
%        str2double(get(hObject,'String')) returns contents of edit_nnet as a double


% --- Executes during object creation, after setting all properties.
function edit_nnet_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_nnet (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_D.
function listbox_D_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_D (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_D contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_D
set(handles.uipanel_result,'Visible','off');

% --- Executes during object creation, after setting all properties.
function listbox_D_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_D (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_mdens_Callback(hObject, eventdata, handles)
% hObject    handle to edit_mdens (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_mdens as text
%        str2double(get(hObject,'String')) returns contents of edit_mdens as a double


% --- Executes during object creation, after setting all properties.
function edit_mdens_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_mdens (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on key press with focus on edit_fc and none of its controls.
function edit_fc_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_fc (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.uipanel_result,'Visible','off');


% --- Executes on key press with focus on edit_nnet and none of its controls.
function edit_nnet_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_nnet (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.uipanel_result,'Visible','off');


% --- Executes on key press with focus on edit_mdens and none of its controls.
function edit_mdens_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_mdens (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.uipanel_result,'Visible','off');



function edit_bb_Callback(hObject, eventdata, handles)
% hObject    handle to edit_bb (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_bb as text
%        str2double(get(hObject,'String')) returns contents of edit_bb as a double


% --- Executes during object creation, after setting all properties.
function edit_bb_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_bb (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_pt_Callback(hObject, eventdata, handles)
% hObject    handle to edit_pt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_pt as text
%        str2double(get(hObject,'String')) returns contents of edit_pt as a double


% --- Executes during object creation, after setting all properties.
function edit_pt_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_pt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function varargout = vibrationdata_tolerance_factor(varargin)
% VIBRATIONDATA_TOLERANCE_FACTOR MATLAB code for vibrationdata_tolerance_factor.fig
%      VIBRATIONDATA_TOLERANCE_FACTOR, by itself, creates a new VIBRATIONDATA_TOLERANCE_FACTOR or raises the existing
%      singleton*.
%
%      H = VIBRATIONDATA_TOLERANCE_FACTOR returns the handle to a new VIBRATIONDATA_TOLERANCE_FACTOR or the handle to
%      the existing singleton*.
%
%      VIBRATIONDATA_TOLERANCE_FACTOR('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in VIBRATIONDATA_TOLERANCE_FACTOR.M with the given input arguments.
%
%      VIBRATIONDATA_TOLERANCE_FACTOR('Property','Value',...) creates a new VIBRATIONDATA_TOLERANCE_FACTOR or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before vibrationdata_tolerance_factor_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to vibrationdata_tolerance_factor_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help vibrationdata_tolerance_factor

% Last Modified by GUIDE v2.5 24-Jul-2015 18:14:38

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @vibrationdata_tolerance_factor_OpeningFcn, ...
                   'gui_OutputFcn',  @vibrationdata_tolerance_factor_OutputFcn, ...
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


% --- Executes just before vibrationdata_tolerance_factor is made visible.
function vibrationdata_tolerance_factor_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to vibrationdata_tolerance_factor (see VARARGIN)

% Choose default command line output for vibrationdata_tolerance_factor
handles.output = hObject;

set(handles.uipanel_results,'Visible','off');

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes vibrationdata_tolerance_factor wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = vibrationdata_tolerance_factor_OutputFcn(hObject, eventdata, handles) 
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

delete(vibrationdata_tolerance_factor);


% --- Executes on button press in pushbutton_Calculate.
function pushbutton_Calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_Calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

disp('ref 1');






function edit_probability_Callback(hObject, eventdata, handles)
% hObject    handle to edit_probability (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_probability as text
%        str2double(get(hObject,'String')) returns contents of edit_probability as a double
set(handles.uipanel_results,'Visible','off');

% --- Executes during object creation, after setting all properties.
function edit_probability_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_probability (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_confidence_Callback(hObject, eventdata, handles)
% hObject    handle to edit_confidence (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_confidence as text
%        str2double(get(hObject,'String')) returns contents of edit_confidence as a double
set(handles.uipanel_results,'Visible','off');

% --- Executes during object creation, after setting all properties.
function edit_confidence_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_confidence (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_samples_Callback(hObject, eventdata, handles)
% hObject    handle to edit_samples (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_samples as text
%        str2double(get(hObject,'String')) returns contents of edit_samples as a double
set(handles.uipanel_results,'Visible','off');

% --- Executes during object creation, after setting all properties.
function edit_samples_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_samples (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end






function edit_k_Callback(hObject, eventdata, handles)
% hObject    handle to edit_k (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_k as text
%        str2double(get(hObject,'String')) returns contents of edit_k as a double


% --- Executes during object creation, after setting all properties.
function edit_k_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_k (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_999.
function pushbutton_999_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_999 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


disp(' ');
disp(' * * * * * * * * * * ');
disp(' ');

p=str2num(get(handles.edit_probability,'String'));
c=str2num(get(handles.edit_confidence,'String'));
nsamples=str2num(get(handles.edit_samples,'String'));

if(nsamples<2)
    warndlg('At least 2 samples required');
    return;
end

h='%';
out1=sprintf(' probabilty = %g %s ',p,h);
out2=sprintf(' confidence = %g %s \n',c,h);
out3=sprintf(' number samples = %d ',nsamples);
disp(out1)
disp(out2)
disp(out3);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[k,Zp,delta,T]=k_factor(p,c,nsamples);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

fprintf('\n Zp=%8.4g  delta=%8.4g  T=%8.4g \n',Zp,delta,T);

ss=sprintf('%8.4g',k);
set(handles.edit_k,'String',ss)
set(handles.uipanel_results,'Visible','on');
 
disp(' ');
sss=sprintf(' Tolerance factor k = %8.4g',k);
disp(sss);


% --- Executes on key press with focus on edit_samples and none of its controls.
function edit_samples_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_samples (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.uipanel_results,'Visible','off');


% --- Executes on key press with focus on edit_confidence and none of its controls.
function edit_confidence_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_confidence (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.uipanel_results,'Visible','off');


% --- Executes on key press with focus on edit_probability and none of its controls.
function edit_probability_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_probability (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.uipanel_results,'Visible','off');

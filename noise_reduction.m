function varargout = noise_reduction(varargin)
% NOISE_REDUCTION MATLAB code for noise_reduction.fig
%      NOISE_REDUCTION, by itself, creates a new NOISE_REDUCTION or raises the existing
%      singleton*.
%
%      H = NOISE_REDUCTION returns the handle to a new NOISE_REDUCTION or the handle to
%      the existing singleton*.
%
%      NOISE_REDUCTION('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in NOISE_REDUCTION.M with the given input arguments.
%
%      NOISE_REDUCTION('Property','Value',...) creates a new NOISE_REDUCTION or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before noise_reduction_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to noise_reduction_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help noise_reduction

% Last Modified by GUIDE v2.5 31-Oct-2017 15:02:52

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @noise_reduction_OpeningFcn, ...
                   'gui_OutputFcn',  @noise_reduction_OutputFcn, ...
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


% --- Executes just before noise_reduction is made visible.
function noise_reduction_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to noise_reduction (see VARARGIN)

% Choose default command line output for noise_reduction
handles.output = hObject;

set(handles.uipanel_results,'Visible','off');

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes noise_reduction wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = noise_reduction_OutputFcn(hObject, eventdata, handles) 
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

delete(noise_reduction);


% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

a=str2num(get(handles.edit_alpha,'String'));
t=str2num(get(handles.edit_tau,'String'));

NR=10*log10( 1 + a/t );

sss=sprintf('%7.3g',NR);

set(handles.edit_NR,'String',sss);

set(handles.uipanel_results,'Visible','on');



function edit_alpha_Callback(hObject, eventdata, handles)
% hObject    handle to edit_alpha (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_alpha as text
%        str2double(get(hObject,'String')) returns contents of edit_alpha as a double


% --- Executes during object creation, after setting all properties.
function edit_alpha_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_alpha (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_tau_Callback(hObject, eventdata, handles)
% hObject    handle to edit_tau (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_tau as text
%        str2double(get(hObject,'String')) returns contents of edit_tau as a double


% --- Executes during object creation, after setting all properties.
function edit_tau_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_tau (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_NR_Callback(hObject, eventdata, handles)
% hObject    handle to edit_NR (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_NR as text
%        str2double(get(hObject,'String')) returns contents of edit_NR as a double


% --- Executes during object creation, after setting all properties.
function edit_NR_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_NR (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on key press with focus on edit_alpha and none of its controls.
function edit_alpha_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_alpha (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)

set(handles.uipanel_results,'Visible','off');


% --- Executes on key press with focus on edit_tau and none of its controls.
function edit_tau_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_tau (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)

set(handles.uipanel_results,'Visible','off');


% --- Executes on button press in pushbutton_eq.
function pushbutton_eq_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_eq (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


     A = imread('noise_reduction_enclosure.jpg');
     figure(999) 
     imshow(A,'border','tight','InitialMagnification',100) 

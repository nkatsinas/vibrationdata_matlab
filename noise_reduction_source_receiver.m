function varargout = noise_reduction_source_receiver(varargin)
% NOISE_REDUCTION_SOURCE_RECEIVER MATLAB code for noise_reduction_source_receiver.fig
%      NOISE_REDUCTION_SOURCE_RECEIVER, by itself, creates a new NOISE_REDUCTION_SOURCE_RECEIVER or raises the existing
%      singleton*.
%
%      H = NOISE_REDUCTION_SOURCE_RECEIVER returns the handle to a new NOISE_REDUCTION_SOURCE_RECEIVER or the handle to
%      the existing singleton*.
%
%      NOISE_REDUCTION_SOURCE_RECEIVER('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in NOISE_REDUCTION_SOURCE_RECEIVER.M with the given input arguments.
%
%      NOISE_REDUCTION_SOURCE_RECEIVER('Property','Value',...) creates a new NOISE_REDUCTION_SOURCE_RECEIVER or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before noise_reduction_source_receiver_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to noise_reduction_source_receiver_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help noise_reduction_source_receiver

% Last Modified by GUIDE v2.5 03-Nov-2017 12:59:14

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @noise_reduction_source_receiver_OpeningFcn, ...
                   'gui_OutputFcn',  @noise_reduction_source_receiver_OutputFcn, ...
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


% --- Executes just before noise_reduction_source_receiver is made visible.
function noise_reduction_source_receiver_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to noise_reduction_source_receiver (see VARARGIN)

% Choose default command line output for noise_reduction_source_receiver
handles.output = hObject;


listbox_units_Callback(hObject, eventdata, handles);

clc;

fstr='source_receiver_room.jpg';

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
    'Position', [pos1(1) pos1(2) w h]);
axis off;



% Update handles structure
guidata(hObject, handles);

% UIWAIT makes noise_reduction_source_receiver wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = noise_reduction_source_receiver_OutputFcn(hObject, eventdata, handles) 
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

delete(noise_reduction_source_receiver);


% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


ia=get(handles.listbox_analysis,'Value');

alpha=str2num(get(handles.edit_alpha,'String'));
Sw=str2num(get(handles.edit_Sw,'String'));
S2=str2num(get(handles.edit_s2,'String'));
aux=str2num(get(handles.edit_aux,'String'));

set(handles.text_TL,'Visible','off');
set(handles.edit_TL,'Visible','off');

if(ia==1)
   tau=aux; 
   TL=10*log10(1/tau);
   den=S2*alpha+tau*Sw;
   NR=TL-10*log10(Sw/den);
   sss=sprintf('%7.3g',NR);
else
   NR=aux; 
   den=-1+10^(NR/10);
   tau=(S2/Sw)*alpha/den;
   sss=sprintf('%7.3g',tau);
   set(handles.text_TL,'Visible','on');
   set(handles.edit_TL,'Visible','on');
   ttt=sprintf('%7.3g',10*log(1/tau));
   set(handles.edit_TL,'String',ttt);  
end

set(handles.edit_result,'String',sss);


set(handles.uipanel_result,'Visible','on');


% --- Executes on button press in pushbutton_eq.
function pushbutton_eq_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_eq (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

     A = imread('noise_reduction_source_receiver.jpg');
     figure(999) 
     imshow(A,'border','tight','InitialMagnification',100) 


% --- Executes on selection change in listbox_units.
function listbox_units_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_units (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_units contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_units


set(handles.uipanel_result,'Visible','off');

iu=get(handles.listbox_units,'Value');

if(iu==1)
    set(handles.text_area,'String','ft^2');
else
    set(handles.text_area,'String','m^2');    
end


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



function edit_aux_Callback(hObject, eventdata, handles)
% hObject    handle to edit_aux (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_aux as text
%        str2double(get(hObject,'String')) returns contents of edit_aux as a double


% --- Executes during object creation, after setting all properties.
function edit_aux_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_aux (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_Sw_Callback(hObject, eventdata, handles)
% hObject    handle to edit_Sw (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_Sw as text
%        str2double(get(hObject,'String')) returns contents of edit_Sw as a double


% --- Executes during object creation, after setting all properties.
function edit_Sw_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_Sw (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_s2_Callback(hObject, eventdata, handles)
% hObject    handle to edit_s2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_s2 as text
%        str2double(get(hObject,'String')) returns contents of edit_s2 as a double


% --- Executes during object creation, after setting all properties.
function edit_s2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_s2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
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

ia=get(handles.listbox_analysis,'Value');

if(ia==1)
    set(handles.text_aux,'String','Partition Transmission Coefficient');
    set(handles.text_result,'String','Noise Reduction (dB)');
else
    set(handles.text_aux,'String','Noise Reduction (dB)');    
    set(handles.text_result,'String','Transmission Coefficient');    
end    
    
    
set(handles.uipanel_result,'Visible','off');

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


% --- Executes on key press with focus on edit_alpha and none of its controls.
function edit_alpha_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_alpha (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)

set(handles.uipanel_result,'Visible','off');


% --- Executes on key press with focus on edit_Sw and none of its controls.
function edit_Sw_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_Sw (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)

set(handles.uipanel_result,'Visible','off');


% --- Executes on key press with focus on edit_aux and none of its controls.
function edit_aux_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_aux (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)

set(handles.uipanel_result,'Visible','off');


% --- Executes on key press with focus on edit_s2 and none of its controls.
function edit_s2_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_s2 (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)

set(handles.uipanel_result,'Visible','off');



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



function edit_TL_Callback(hObject, eventdata, handles)
% hObject    handle to edit_TL (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_TL as text
%        str2double(get(hObject,'String')) returns contents of edit_TL as a double


% --- Executes during object creation, after setting all properties.
function edit_TL_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_TL (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

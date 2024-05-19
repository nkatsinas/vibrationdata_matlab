function varargout = vibrationdata_overall_Fourier_transform(varargin)
% VIBRATIONDATA_OVERALL_FOURIER_TRANSFORM MATLAB code for vibrationdata_overall_Fourier_transform.fig
%      VIBRATIONDATA_OVERALL_FOURIER_TRANSFORM, by itself, creates a new VIBRATIONDATA_OVERALL_FOURIER_TRANSFORM or raises the existing
%      singleton*.
%
%      H = VIBRATIONDATA_OVERALL_FOURIER_TRANSFORM returns the handle to a new VIBRATIONDATA_OVERALL_FOURIER_TRANSFORM or the handle to
%      the existing singleton*.
%
%      VIBRATIONDATA_OVERALL_FOURIER_TRANSFORM('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in VIBRATIONDATA_OVERALL_FOURIER_TRANSFORM.M with the given input arguments.
%
%      VIBRATIONDATA_OVERALL_FOURIER_TRANSFORM('Property','Value',...) creates a new VIBRATIONDATA_OVERALL_FOURIER_TRANSFORM or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before vibrationdata_overall_Fourier_transform_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to vibrationdata_overall_Fourier_transform_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help vibrationdata_overall_Fourier_transform

% Last Modified by GUIDE v2.5 16-Jun-2015 12:21:09

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @vibrationdata_overall_Fourier_transform_OpeningFcn, ...
                   'gui_OutputFcn',  @vibrationdata_overall_Fourier_transform_OutputFcn, ...
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


% --- Executes just before vibrationdata_overall_Fourier_transform is made visible.
function vibrationdata_overall_Fourier_transform_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to vibrationdata_overall_Fourier_transform (see VARARGIN)

% Choose default command line output for vibrationdata_overall_Fourier_transform
handles.output = hObject;

set(handles.uipanel_result,'Visible','off');


% Update handles structure
guidata(hObject, handles);

% UIWAIT makes vibrationdata_overall_Fourier_transform wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = vibrationdata_overall_Fourier_transform_OutputFcn(hObject, eventdata, handles) 
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

try  
    FS=get(handles.edit_input_array,'String');
    THM=evalin('base',FS);  
catch
    warndlg('Input Array does not exist.  Try again.')
    return;
end

n=get(handles.listbox_format,'Value');

sz=size(THM);

num=sz(1);

a=0;

if(n<3)
    THM(:,2)=THM(:,2)/sqrt(2);
end    

for i=1:num
    a=a+(abs(THM(i,2)))^2;
end

a=sqrt(a);

ss=sprintf('%7.3g',a);

set(handles.edit_level,'String',ss);

set(handles.uipanel_result,'Visible','on');




% --- Executes on button press in pushbutton_return.
function pushbutton_return_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_return (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

delete(vibrationdata_overall_Fourier_transform);

% --- Executes on selection change in listbox_format.
function listbox_format_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_format (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_format contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_format

set(handles.uipanel_result,'Visible','off');


% --- Executes during object creation, after setting all properties.
function listbox_format_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_format (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
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

set(handles.uipanel_result,'Visible','off');


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



function edit_level_Callback(hObject, eventdata, handles)
% hObject    handle to edit_level (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_level as text
%        str2double(get(hObject,'String')) returns contents of edit_level as a double


% --- Executes during object creation, after setting all properties.
function edit_level_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_level (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on key press with focus on edit_input_array and none of its controls.
function edit_input_array_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_input_array (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)

set(handles.uipanel_result,'Visible','off');

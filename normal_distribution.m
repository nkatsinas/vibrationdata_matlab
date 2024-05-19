function varargout = normal_distribution(varargin)
% NORMAL_DISTRIBUTION MATLAB code for normal_distribution.fig
%      NORMAL_DISTRIBUTION, by itself, creates a new NORMAL_DISTRIBUTION or raises the existing
%      singleton*.
%
%      H = NORMAL_DISTRIBUTION returns the handle to a new NORMAL_DISTRIBUTION or the handle to
%      the existing singleton*.
%
%      NORMAL_DISTRIBUTION('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in NORMAL_DISTRIBUTION.M with the given input arguments.
%
%      NORMAL_DISTRIBUTION('Property','Value',...) creates a new NORMAL_DISTRIBUTION or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before normal_distribution_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to normal_distribution_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help normal_distribution

% Last Modified by GUIDE v2.5 05-Feb-2014 14:39:14

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @normal_distribution_OpeningFcn, ...
                   'gui_OutputFcn',  @normal_distribution_OutputFcn, ...
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


% --- Executes just before normal_distribution is made visible.
function normal_distribution_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to normal_distribution (see VARARGIN)

% Choose default command line output for normal_distribution
handles.output = hObject;

clear_results(hObject, eventdata, handles);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes normal_distribution wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = normal_distribution_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


function clear_results(hObject, eventdata, handles)
%
set(handles.edit_results,'Enable','off');
set(handles.edit_results,'String',' ');

% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
delete(normal_distribution);


% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

z1=str2num(get(handles.edit_z1,'String'));
z2=str2num(get(handles.edit_z2,'String'));

normal_cdf=@(x)( 1/2*erfc(-x/sqrt(2)));
%
p1 = normal_cdf(z1);
p2 = normal_cdf(z2);
%
q=p2-p1;
w=1.-q;
%

s1=sprintf('Probability within limits \n   %12.8g \n\n Probability of exceeding limits \n   %12.8g',q,w);
%
set(handles.edit_results,'MAX',6);
set(handles.edit_results,'Enable','on');
set(handles.edit_results,'String',s1);




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



function edit_z1_Callback(hObject, eventdata, handles)
% hObject    handle to edit_z1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_z1 as text
%        str2double(get(hObject,'String')) returns contents of edit_z1 as a double


% --- Executes during object creation, after setting all properties.
function edit_z1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_z1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_z2_Callback(hObject, eventdata, handles)
% hObject    handle to edit_z2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_z2 as text
%        str2double(get(hObject,'String')) returns contents of edit_z2 as a double


% --- Executes during object creation, after setting all properties.
function edit_z2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_z2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on key press with focus on edit_z1 and none of its controls.
function edit_z1_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_z1 (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
clear_results(hObject, eventdata, handles);


% --- Executes on key press with focus on edit_z2 and none of its controls.
function edit_z2_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_z2 (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
clear_results(hObject, eventdata, handles);

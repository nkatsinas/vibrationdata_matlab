function varargout = exponential_distribution(varargin)
% EXPONENTIAL_DISTRIBUTION MATLAB code for exponential_distribution.fig
%      EXPONENTIAL_DISTRIBUTION, by itself, creates a new EXPONENTIAL_DISTRIBUTION or raises the existing
%      singleton*.
%
%      H = EXPONENTIAL_DISTRIBUTION returns the handle to a new EXPONENTIAL_DISTRIBUTION or the handle to
%      the existing singleton*.
%
%      EXPONENTIAL_DISTRIBUTION('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in EXPONENTIAL_DISTRIBUTION.M with the given input arguments.
%
%      EXPONENTIAL_DISTRIBUTION('Property','Value',...) creates a new EXPONENTIAL_DISTRIBUTION or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before exponential_distribution_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to exponential_distribution_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help exponential_distribution

% Last Modified by GUIDE v2.5 06-Jul-2017 14:53:02

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @exponential_distribution_OpeningFcn, ...
                   'gui_OutputFcn',  @exponential_distribution_OutputFcn, ...
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


% --- Executes just before exponential_distribution is made visible.
function exponential_distribution_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to exponential_distribution (see VARARGIN)

% Choose default command line output for exponential_distribution
handles.output = hObject;

set(handles.listbox_analysis,'Value',1);

listbox_analysis_Callback(hObject, eventdata, handles);

set(handles.edit_results_box,'Visible','off');
set(handles.edit_results_box,'String',' ');


% Update handles structure
guidata(hObject, handles);

% UIWAIT makes exponential_distribution wait for user response (see UIRESUME)
% uiwait(handles.figure1);


function clear_results(hObject, eventdata, handles)
%




% --- Outputs from this function are returned to the command line.
function varargout = exponential_distribution_OutputFcn(hObject, eventdata, handles) 
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
delete(exponential_distribution);


% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

n=get(handles.listbox_analysis,'Value');

mu=str2num(get(handles.edit_mean,'String'));

lambda=1/mu;


X1=str2num(get(handles.edit_X1,'String'));

if(n==1)
%   
   q=exp(-lambda*X1);
%   
else
   X2=str2num(get(handles.edit_X2,'String')); 
%
    q=abs(exp(-lambda*X1)-exp(-lambda*X2));
%
end

w=1-q;

set(handles.edit_results_box,'Visible','on');

MTBF=mu;

if(n==1)
    
    s1=sprintf('Exceedance Probability = %12.8g \n\n 1-Probability = %12.8g \n\n Failure Rate = %12.8g \n MTBF = %g ',q,w,lambda,MTBF);

else
    
    s1=sprintf('Probability = %12.8g \n\n 1-Probability = %12.8g \n\n Failure Rate = %12.8g \n MTBF = %g ',q,w,lambda,MTBF);
    
end

%
set(handles.edit_results_box,'MAX',5);
set(handles.edit_results_box,'Enable','on');
set(handles.edit_results_box,'String',s1);


function edit_mean_Callback(hObject, eventdata, handles)
% hObject    handle to edit_mean (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_mean as text
%        str2double(get(hObject,'String')) returns contents of edit_mean as a double


% --- Executes during object creation, after setting all properties.
function edit_mean_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_mean (see GCBO)
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

set(handles.edit_results_box,'Visible','off');
set(handles.edit_results_box,'String',' ');

n=get(handles.listbox_analysis,'Value');

set(handles.edit_X1,'Visible','on');
set(handles.edit_X2,'Visible','off'); 
set(handles.text_X2,'String',' ');

if(n==1)
    set(handles.text_X1,'String','X');
else    
    set(handles.text_X1,'String','X1');
    set(handles.text_X2,'String','X2');
    
    set(handles.edit_X2,'Visible','on'); 
end    



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



function edit_results_box_Callback(hObject, eventdata, handles)
% hObject    handle to edit_results_box (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_results_box as text
%        str2double(get(hObject,'String')) returns contents of edit_results_box as a double


% --- Executes during object creation, after setting all properties.
function edit_results_box_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_results_box (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_X1_Callback(hObject, eventdata, handles)
% hObject    handle to edit_X1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_X1 as text
%        str2double(get(hObject,'String')) returns contents of edit_X1 as a double


% --- Executes during object creation, after setting all properties.
function edit_X1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_X1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_X2_Callback(hObject, eventdata, handles)
% hObject    handle to edit_X2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_X2 as text
%        str2double(get(hObject,'String')) returns contents of edit_X2 as a double


% --- Executes during object creation, after setting all properties.
function edit_X2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_X2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on key press with focus on edit_mean and none of its controls.

% hObject    handle to edit_mean (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on key press with focus on edit_X1 and none of its controls.
function edit_X1_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_X1 (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.edit_results_box,'Visible','off');
set(handles.edit_results_box,'String',' ');


% --- Executes on key press with focus on edit_X2 and none of its controls.
function edit_X2_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_X2 (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.edit_results_box,'Visible','off');
set(handles.edit_results_box,'String',' ');


% --- Executes on key press with focus on edit_mean and none of its controls.
function edit_mean_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_mean (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.edit_results_box,'Visible','off');
set(handles.edit_results_box,'String',' ');

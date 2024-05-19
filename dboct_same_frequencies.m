function varargout = dboct_same_frequencies(varargin)
% DBOCT_SAME_FREQUENCIES MATLAB code for dboct_same_frequencies.fig
%      DBOCT_SAME_FREQUENCIES, by itself, creates a new DBOCT_SAME_FREQUENCIES or raises the existing
%      singleton*.
%
%      H = DBOCT_SAME_FREQUENCIES returns the handle to a new DBOCT_SAME_FREQUENCIES or the handle to
%      the existing singleton*.
%
%      DBOCT_SAME_FREQUENCIES('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DBOCT_SAME_FREQUENCIES.M with the given input arguments.
%
%      DBOCT_SAME_FREQUENCIES('Property','Value',...) creates a new DBOCT_SAME_FREQUENCIES or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before dboct_same_frequencies_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to dboct_same_frequencies_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help dboct_same_frequencies

% Last Modified by GUIDE v2.5 04-Feb-2014 12:12:10

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @dboct_same_frequencies_OpeningFcn, ...
                   'gui_OutputFcn',  @dboct_same_frequencies_OutputFcn, ...
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


% --- Executes just before dboct_same_frequencies is made visible.
function dboct_same_frequencies_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to dboct_same_frequencies (see VARARGIN)

% Choose default command line output for dboct_same_frequencies
handles.output = hObject;

set(handles.listbox_dimension,'value',1);
set(handles.listbox_analysis,'value',1);

clear_results(hObject, eventdata, handles);
text_change(hObject, eventdata, handles);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes dboct_same_frequencies wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = dboct_same_frequencies_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


function clear_results(hObject, eventdata, handles)
%
set(handles.edit_results,'String',' ');
set(handles.edit_results,'Visible','off');


% --- Executes on button press in pushbutton_return.
function pushbutton_return_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_return (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
delete(dboct_same_frequencies);


% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

n=get(handles.listbox_dimension,'Value');
m=get(handles.listbox_analysis,'Value');

A=str2num(get(handles.edit_box1,'String'));
B=str2num(get(handles.edit_box2,'String'));

if(m==1)
   if(n==1 || n==2)
       C=20*log10(B/A);
   else
       C=10*log10(B/A);
   end
   out1=sprintf('%8.3g dB',C);
else
   if(n==1 || n==2)
       C=A*10^(B/20);
       out1=sprintf('%8.3g G',C);
   end
   if(n==3)
       C=A*10^(B/10);
       out1=sprintf('%8.3g G^2/Hz',C);       
   end    
end    

set(handles.edit_results,'Visible','on');
set(handles.edit_results,'String',out1);


% --- Executes on selection change in listbox_dimension.
function listbox_dimension_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_dimension (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

text_change(hObject, eventdata, handles);


% Hints: contents = cellstr(get(hObject,'String')) returns listbox_dimension contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_dimension
clear_results(hObject, eventdata, handles);

% --- Executes during object creation, after setting all properties.
function listbox_dimension_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_dimension (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function text_change(hObject, eventdata, handles)
%

n=get(handles.listbox_dimension,'Value');

m=get(handles.listbox_analysis,'Value');

if(n==1)
    set(handles.text_box1,'String','Point 1 SRS(G)');
end
if(n==2)
    set(handles.text_box1,'String','Point 1 (GRMS)');
end
if(n==3)
    set(handles.text_box1,'String','Point 1 PSD(G^2/Hz)');
end

if(m==1)
    if(n==1)
        set(handles.text_box2,'String','Point 2 SRS(G)');
    end
    if(n==2)
        set(handles.text_box2,'String','Point 2 (GRMS)');
    end
    if(n==3)
        set(handles.text_box2,'String','Point 2 PSD(G^2/Hz)');
    end
else
    set(handles.text_box2,'String','dB Difference');    
end    


% --- Executes on selection change in listbox_analysis.
function listbox_analysis_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_analysis (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_analysis contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_analysis
clear_results(hObject, eventdata, handles);
text_change(hObject, eventdata, handles);

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



function edit_box1_Callback(hObject, eventdata, handles)
% hObject    handle to edit_box1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_box1 as text
%        str2double(get(hObject,'String')) returns contents of edit_box1 as a double


% --- Executes during object creation, after setting all properties.
function edit_box1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_box1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_box2_Callback(hObject, eventdata, handles)
% hObject    handle to edit_box2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_box2 as text
%        str2double(get(hObject,'String')) returns contents of edit_box2 as a double


% --- Executes during object creation, after setting all properties.
function edit_box2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_box2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on key press with focus on edit_box1 and none of its controls.
function edit_box1_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_box1 (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
clear_results(hObject, eventdata, handles);


% --- Executes on key press with focus on edit_box2 and none of its controls.
function edit_box2_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_box2 (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
clear_results(hObject, eventdata, handles);

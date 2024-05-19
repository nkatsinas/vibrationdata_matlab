function varargout = Dunkerley(varargin)
% DUNKERLEY MATLAB code for Dunkerley.fig
%      DUNKERLEY, by itself, creates a new DUNKERLEY or raises the existing
%      singleton*.
%
%      H = DUNKERLEY returns the handle to a new DUNKERLEY or the handle to
%      the existing singleton*.
%
%      DUNKERLEY('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DUNKERLEY.M with the given input arguments.
%
%      DUNKERLEY('Property','Value',...) creates a new DUNKERLEY or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Dunkerley_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Dunkerley_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Dunkerley

% Last Modified by GUIDE v2.5 06-May-2015 13:39:36

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Dunkerley_OpeningFcn, ...
                   'gui_OutputFcn',  @Dunkerley_OutputFcn, ...
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


% --- Executes just before Dunkerley is made visible.
function Dunkerley_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Dunkerley (see VARARGIN)

% Choose default command line output for Dunkerley
handles.output = hObject;

set(handles.f1_edit,'enable','on');
set(handles.f2_edit,'enable','on');
set(handles.f3_edit,'enable','off');
set(handles.f4_edit,'enable','off');

set(handles.Answer_edit,'enable','off');

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Dunkerley wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Dunkerley_OutputFcn(hObject, eventdata, handles) 
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
set(handles.Answer_edit,'enable','on');

n=get(handles.number_listbox,'Value');

n=n+1;

f1=str2num(get(handles.f1_edit,'String'));
f2=str2num(get(handles.f2_edit,'String'));

if(n>=2)
  term=(1/f1^2)+(1/f2^2);  
end
if(n>=3)
  f3=str2num(get(handles.f3_edit,'String'));  
  term=term+(1/f3^2);  
end
if(n==4);
  f4=str2num(get(handles.f4_edit,'String'));      
  term=term+(1/f4^2);  
end

fn=sqrt(1/term);

s1=sprintf('%8.3g',fn);

set(handles.Answer_edit,'String',s1);


% --- Executes on selection change in number_listbox.
function number_listbox_Callback(hObject, eventdata, handles)
% hObject    handle to number_listbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns number_listbox contents as cell array
%        contents{get(hObject,'Value')} returns selected item from number_listbox

n=get(hObject,'Value');

n=n+1;

set(handles.Answer_edit,'enable','off');
set(handles.Answer_edit,'String',' ');

set(handles.f1_edit,'enable','on');
set(handles.f2_edit,'enable','on');
set(handles.f3_edit,'enable','off');
set(handles.f4_edit,'enable','off');

if(n>=3)
    set(handles.f3_edit,'enable','on'); 
end
if(n==4)
    set(handles.f4_edit,'enable','on');    
end

if(n==2)
    set(handles.f3_edit,'String',' ');   
    set(handles.f4_edit,'String',' ');
end
if(n==3)
    set(handles.f4_edit,'String',' ');
end

% Update handles structure
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function number_listbox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to number_listbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Answer_edit_Callback(hObject, eventdata, handles)
% hObject    handle to Answer_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Answer_edit as text
%        str2double(get(hObject,'String')) returns contents of Answer_edit as a double


% --- Executes during object creation, after setting all properties.
function Answer_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Answer_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function f1_edit_Callback(hObject, eventdata, handles)
% hObject    handle to f1_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of f1_edit as text
%        str2double(get(hObject,'String')) returns contents of f1_edit as a double


% --- Executes during object creation, after setting all properties.
function f1_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to f1_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function f2_edit_Callback(hObject, eventdata, handles)
% hObject    handle to f2_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of f2_edit as text
%        str2double(get(hObject,'String')) returns contents of f2_edit as a double


% --- Executes during object creation, after setting all properties.
function f2_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to f2_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function f3_edit_Callback(hObject, eventdata, handles)
% hObject    handle to f3_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of f3_edit as text
%        str2double(get(hObject,'String')) returns contents of f3_edit as a double


% --- Executes during object creation, after setting all properties.
function f3_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to f3_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function f4_edit_Callback(hObject, eventdata, handles)
% hObject    handle to f4_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of f4_edit as text
%        str2double(get(hObject,'String')) returns contents of f4_edit as a double


% --- Executes during object creation, after setting all properties.
function f4_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to f4_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on key press with focus on f1_edit and none of its controls.
function f1_edit_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to f1_edit (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.Answer_edit,'enable','off');
set(handles.Answer_edit,'String',' ');

% --- Executes on key press with focus on f2_edit and none of its controls.
function f2_edit_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to f2_edit (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.Answer_edit,'enable','off');
set(handles.Answer_edit,'String',' ');

% --- Executes on key press with focus on f3_edit and none of its controls.
function f3_edit_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to f3_edit (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.Answer_edit,'enable','off');
set(handles.Answer_edit,'String',' ');

% --- Executes on key press with focus on f4_edit and none of its controls.
function f4_edit_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to f4_edit (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.Answer_edit,'enable','off');
set(handles.Answer_edit,'String',' ');


% --- Executes on button press in pushbutton_return.
function pushbutton_return_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_return (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

delete(Dunkerley);

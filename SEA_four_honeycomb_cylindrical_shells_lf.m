function varargout = SEA_four_honeycomb_cylindrical_shells_lf(varargin)
% SEA_FOUR_HONEYCOMB_CYLINDRICAL_SHELLS_LF MATLAB code for SEA_four_honeycomb_cylindrical_shells_lf.fig
%      SEA_FOUR_HONEYCOMB_CYLINDRICAL_SHELLS_LF, by itself, creates a new SEA_FOUR_HONEYCOMB_CYLINDRICAL_SHELLS_LF or raises the existing
%      singleton*.
%
%      H = SEA_FOUR_HONEYCOMB_CYLINDRICAL_SHELLS_LF returns the handle to a new SEA_FOUR_HONEYCOMB_CYLINDRICAL_SHELLS_LF or the handle to
%      the existing singleton*.
%
%      SEA_FOUR_HONEYCOMB_CYLINDRICAL_SHELLS_LF('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SEA_FOUR_HONEYCOMB_CYLINDRICAL_SHELLS_LF.M with the given input arguments.
%
%      SEA_FOUR_HONEYCOMB_CYLINDRICAL_SHELLS_LF('Property','Value',...) creates a new SEA_FOUR_HONEYCOMB_CYLINDRICAL_SHELLS_LF or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before SEA_four_honeycomb_cylindrical_shells_lf_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to SEA_four_honeycomb_cylindrical_shells_lf_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help SEA_four_honeycomb_cylindrical_shells_lf

% Last Modified by GUIDE v2.5 17-Jul-2018 15:37:30

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @SEA_four_honeycomb_cylindrical_shells_lf_OpeningFcn, ...
                   'gui_OutputFcn',  @SEA_four_honeycomb_cylindrical_shells_lf_OutputFcn, ...
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


% --- Executes just before SEA_four_honeycomb_cylindrical_shells_lf is made visible.
function SEA_four_honeycomb_cylindrical_shells_lf_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to SEA_four_honeycomb_cylindrical_shells_lf (see VARARGIN)

% Choose default command line output for SEA_four_honeycomb_cylindrical_shells_lf
handles.output = hObject;



lbox_lf1=getappdata(0,'listbox_lf1');
lbox_lf2=getappdata(0,'listbox_lf2');
lbox_lf3=getappdata(0,'listbox_lf3');
lbox_lf4=getappdata(0,'listbox_lf4');

constant_lf1=getappdata(0,'constant_lf1');
constant_lf2=getappdata(0,'constant_lf2');
constant_lf3=getappdata(0,'constant_lf3');
constant_lf4=getappdata(0,'constant_lf4');

set(handles.listbox_lf1,'Value',1); 
set(handles.listbox_lf2,'Value',1); 
set(handles.listbox_lf3,'Value',1); 
set(handles.listbox_lf4,'Value',1); 


if(~isempty(lbox_lf1))
    set(handles.listbox_lf1,'Value',lbox_lf1);
end
if(~isempty(lbox_lf2))
    set(handles.listbox_lf2,'Value',lbox_lf2);
end
if(~isempty(lbox_lf3))
    set(handles.listbox_lf3,'Value',lbox_lf3);
end
if(~isempty(lbox_lf4))
    set(handles.listbox_lf4,'Value',lbox_lf4);
end


%%%%%%%%%%%%%

if(lbox_lf1==2)
    sss=sprintf('%g',constant_lf1);
    set(handles.edit_lf1,'String',sss);
end
if(lbox_lf2==2)
    sss=sprintf('%g',constant_lf2);
    set(handles.edit_lf2,'String',sss);
end
if(lbox_lf3==2)
    sss=sprintf('%g',constant_lf3);
    set(handles.edit_lf3,'String',sss);
end
if(lbox_lf4==2)
    sss=sprintf('%g',constant_lf4);
    set(handles.edit_lf4,'String',sss);
end


listbox_lf1_Callback(hObject, eventdata, handles);
listbox_lf2_Callback(hObject, eventdata, handles);
listbox_lf3_Callback(hObject, eventdata, handles);
listbox_lf4_Callback(hObject, eventdata, handles);


% Update handles structure
guidata(hObject, handles);

% UIWAIT makes SEA_four_honeycomb_cylindrical_shells_lf wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = SEA_four_honeycomb_cylindrical_shells_lf_OutputFcn(hObject, eventdata, handles) 
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

lbox_lf1=get(handles.listbox_lf1,'Value');
lbox_lf2=get(handles.listbox_lf2,'Value');
lbox_lf3=get(handles.listbox_lf3,'Value');
lbox_lf4=get(handles.listbox_lf4,'Value');

constant_lf1=str2num(get(handles.edit_lf1,'String'));
constant_lf2=str2num(get(handles.edit_lf2,'String'));
constant_lf3=str2num(get(handles.edit_lf3,'String'));
constant_lf4=str2num(get(handles.edit_lf4,'String'));


setappdata(0,'listbox_lf1',lbox_lf1);
setappdata(0,'listbox_lf2',lbox_lf2);
setappdata(0,'listbox_lf3',lbox_lf3);
setappdata(0,'listbox_lf4',lbox_lf4);

setappdata(0,'constant_lf1',constant_lf1);
setappdata(0,'constant_lf2',constant_lf2);
setappdata(0,'constant_lf3',constant_lf3);
setappdata(0,'constant_lf4',constant_lf4);


delete(SEA_four_honeycomb_cylindrical_shells_lf);


% --- Executes on button press in pushbutton_eq.
function pushbutton_eq_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_eq (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


    A = imread('sandwich_lf.jpg');
    figure(995) 
    imshow(A,'border','tight','InitialMagnification',100)       



% --- Executes on selection change in listbox_lf1.
function listbox_lf1_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_lf1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_lf1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_lf1

n=get(handles.listbox_lf1,'Value');

if(n==1)
    set(handles.edit_lf1,'Visible','off');
    set(handles.text_lf1,'Visible','off');     
else    
    set(handles.edit_lf1,'Visible','on');
    set(handles.text_lf1,'Visible','on');    
end



% --- Executes during object creation, after setting all properties.
function listbox_lf1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_lf1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_lf2.
function listbox_lf2_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_lf2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_lf2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_lf2

n=get(handles.listbox_lf2,'Value');

if(n==1)
    set(handles.edit_lf2,'Visible','off');
    set(handles.text_lf2,'Visible','off');     
else    
    set(handles.edit_lf2,'Visible','on');
    set(handles.text_lf2,'Visible','on');    
end



% --- Executes during object creation, after setting all properties.
function listbox_lf2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_lf2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_lf3.
function listbox_lf3_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_lf3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_lf3 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_lf3

n=get(handles.listbox_lf3,'Value');

if(n==1)
    set(handles.edit_lf3,'Visible','off');
    set(handles.text_lf3,'Visible','off');     
else    
    set(handles.edit_lf3,'Visible','on');
    set(handles.text_lf3,'Visible','on');    
end


% --- Executes during object creation, after setting all properties.
function listbox_lf3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_lf3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_lf4.
function listbox_lf4_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_lf4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_lf4 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_lf4

n=get(handles.listbox_lf4,'Value');

if(n==1)
    set(handles.edit_lf4,'Visible','off');
    set(handles.text_lf4,'Visible','off');     
else    
    set(handles.edit_lf4,'Visible','on');
    set(handles.text_lf4,'Visible','on');    
end



% --- Executes during object creation, after setting all properties.
function listbox_lf4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_lf4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_lf1_Callback(hObject, eventdata, handles)
% hObject    handle to edit_lf1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_lf1 as text
%        str2double(get(hObject,'String')) returns contents of edit_lf1 as a double


% --- Executes during object creation, after setting all properties.
function edit_lf1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_lf1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_lf2_Callback(hObject, eventdata, handles)
% hObject    handle to edit_lf2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_lf2 as text
%        str2double(get(hObject,'String')) returns contents of edit_lf2 as a double


% --- Executes during object creation, after setting all properties.
function edit_lf2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_lf2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_lf3_Callback(hObject, eventdata, handles)
% hObject    handle to edit_lf3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_lf3 as text
%        str2double(get(hObject,'String')) returns contents of edit_lf3 as a double


% --- Executes during object creation, after setting all properties.
function edit_lf3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_lf3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_lf4_Callback(hObject, eventdata, handles)
% hObject    handle to edit_lf4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_lf4 as text
%        str2double(get(hObject,'String')) returns contents of edit_lf4 as a double


% --- Executes during object creation, after setting all properties.
function edit_lf4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_lf4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

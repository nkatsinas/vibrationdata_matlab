function varargout = circular_plate_four_points_base(varargin)
% CIRCULAR_PLATE_FOUR_POINTS_BASE MATLAB code for circular_plate_four_points_base.fig
%      CIRCULAR_PLATE_FOUR_POINTS_BASE, by itself, creates a new CIRCULAR_PLATE_FOUR_POINTS_BASE or raises the existing
%      singleton*.
%
%      H = CIRCULAR_PLATE_FOUR_POINTS_BASE returns the handle to a new CIRCULAR_PLATE_FOUR_POINTS_BASE or the handle to
%      the existing singleton*.
%
%      CIRCULAR_PLATE_FOUR_POINTS_BASE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CIRCULAR_PLATE_FOUR_POINTS_BASE.M with the given input arguments.
%
%      CIRCULAR_PLATE_FOUR_POINTS_BASE('Property','Value',...) creates a new CIRCULAR_PLATE_FOUR_POINTS_BASE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before circular_plate_four_points_base_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to circular_plate_four_points_base_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help circular_plate_four_points_base

% Last Modified by GUIDE v2.5 15-Sep-2014 12:01:24

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @circular_plate_four_points_base_OpeningFcn, ...
                   'gui_OutputFcn',  @circular_plate_four_points_base_OutputFcn, ...
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


% --- Executes just before circular_plate_four_points_base is made visible.
function circular_plate_four_points_base_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to circular_plate_four_points_base (see VARARGIN)

% Choose default command line output for circular_plate_four_points_base
handles.output = hObject;

key=getappdata(0,'return');

if(strcmp(key,'yes'))
    set(handles.listbox_type,'Value',1);
    set(handles.text_damp,'String','Q');
    
    Q=getappdata(0,'damp_Q');
    
    ss=sprintf('%g',Q);
    
    set(handles.edit_damp,'String',ss);
    
    set(handles.pushbutton_transmissibility,'Visible','on');
    set(handles.pushbutton_arbitrary,'Visible','on');
    set(handles.pushbutton_psd,'Visible','on');
    set(handles.pushbutton_sine,'Visible','on');    

else
    set(handles.pushbutton_transmissibility,'Visible','off');
    set(handles.pushbutton_arbitrary,'Visible','off');
    set(handles.pushbutton_psd,'Visible','off');
    set(handles.pushbutton_sine,'Visible','off');    
end

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes circular_plate_four_points_base wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = circular_plate_four_points_base_OutputFcn(hObject, eventdata, handles) 
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
delete(circular_plate_four_points_base);


% --- Executes on button press in pushbutton_save.
function pushbutton_save_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


n=get(handles.listbox_type,'Value');

damp=str2num(get(handles.edit_damp,'String'));

if(n==1) % Q
    damp_Q=damp;
    damp_ratio=1/(2*damp);
else
    damp_ratio=damp;
    damp_Q=1/(2*damp);    
end    

damp_ratio=damp_ratio(1);  % need to do this
damp_Q=damp_Q(1);

setappdata(0,'damp_ratio',damp_ratio);
setappdata(0,'damp_Q',damp_Q);

set(handles.pushbutton_transmissibility,'Visible','on');
set(handles.pushbutton_arbitrary,'Visible','on');
set(handles.pushbutton_psd,'Visible','on');
set(handles.pushbutton_sine,'Visible','on');




setappdata(0,'return','yes');


% --- Executes on button press in pushbutton_transmissibility.
function pushbutton_transmissibility_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_transmissibility (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.s=circular_plate_four_trans;

set(handles.s,'Visible','on');


% --- Executes on button press in pushbutton_arbitrary.
function pushbutton_arbitrary_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_arbitrary (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.s=circular_plate_four_arbitrary;
set(handles.s,'Visible','on');


% --- Executes on button press in pushbutton_psd.
function pushbutton_psd_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_psd (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.s=circular_plate_four_psd;

set(handles.s,'Visible','on');


% --- Executes on button press in pushbutton_sine.
function pushbutton_sine_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_sine (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.s=circular_plate_four_sine;

set(handles.s,'Visible','on');

% --- Executes on selection change in listbox_type.
function listbox_type_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_type contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_type
n=get(handles.listbox_type,'Value');

if(n==1)
    set(handles.text_damp,'String','Q');
else
    set(handles.text_damp,'String','Damping Ratio');    
end


% --- Executes during object creation, after setting all properties.
function listbox_type_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_damp_Callback(hObject, eventdata, handles)
% hObject    handle to edit_damp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_damp as text
%        str2double(get(hObject,'String')) returns contents of edit_damp as a double


% --- Executes during object creation, after setting all properties.
function edit_damp_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_damp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

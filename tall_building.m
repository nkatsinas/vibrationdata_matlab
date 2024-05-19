function varargout = tall_building(varargin)
% TALL_BUILDING MATLAB code for tall_building.fig
%      TALL_BUILDING, by itself, creates a new TALL_BUILDING or raises the existing
%      singleton*.
%
%      H = TALL_BUILDING returns the handle to a new TALL_BUILDING or the handle to
%      the existing singleton*.
%
%      TALL_BUILDING('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TALL_BUILDING.M with the given input arguments.
%
%      TALL_BUILDING('Property','Value',...) creates a new TALL_BUILDING or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before tall_building_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to tall_building_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help tall_building

% Last Modified by GUIDE v2.5 04-Feb-2014 16:50:07

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @tall_building_OpeningFcn, ...
                   'gui_OutputFcn',  @tall_building_OutputFcn, ...
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


% --- Executes just before tall_building is made visible.
function tall_building_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to tall_building (see VARARGIN)

% Choose default command line output for tall_building
handles.output = hObject;

set(handles.listbox_analysis,'value',1);
set(handles.listbox_building_type,'value',1);
set(handles.listbox_unit,'value',1);

listbox_analysis_Callback(hObject, eventdata, handles);

clear_results(hObject, eventdata, handles);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes tall_building wait for user response (see UIRESUME)
% uiwait(handles.figure1);


function clear_results(hObject, eventdata, handles)
%
set(handles.edit_results,'String',' ');
set(handles.edit_results,'Visible','off');

% --- Outputs from this function are returned to the command line.
function varargout = tall_building_OutputFcn(hObject, eventdata, handles) 
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

n=get(handles.listbox_analysis,'Value');

m=get(handles.listbox_building_type,'Value');

u=get(handles.listbox_unit,'Value');

if(m==1)
    if(u==1)
        Ct=0.020;
    else   
        Ct=0.049;
    end
end
if(m==2)
    if(u==1)
        Ct=0.030;
    else    
        Ct=0.073;
    end
end
if(m==3)
    if(u==1)
        Ct=0.035;
    else
        Ct=0.085;
    end
end

%%

if(n==1)
   h=str2num(get(handles.edit_input_data,'String'));
   fn=1/(Ct*h^0.75);
   T=1/fn;
end
if(n==2)
   T=str2num(get(handles.edit_input_data,'String'));
   fn=1/T;
   h=(1/(Ct*fn))^(1/0.75);
end
if(n==3)
   fn=str2num(get(handles.edit_input_data,'String'));
   T=1/fn;
   h=(1/(Ct*fn))^(1/0.75);
end

scale=0.3048;

if(u==1)
   h_feet=h;
   h_meters=scale*h;
else
   h_meters=h;
   h_feet=h/scale;
end

s1=sprintf('Height\n  %6.3g ft\n  %6.3g m\n\nPeriod\n  %6.3g sec\n\nFundamental Frequency\n  %6.3g Hz',h_feet,h_meters,T,fn);

set(handles.edit_results,'Visible','on');

set(handles.edit_results, 'Max', 9);
set(handles.edit_results,'String',s1);


% --- Executes on button press in pushbutton_return.
function pushbutton_return_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_return (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
delete(tall_building);


% --- Executes on selection change in listbox_building_type.
function listbox_building_type_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_building_type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_building_type contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_building_type
clear_results(hObject, eventdata, handles);

% --- Executes during object creation, after setting all properties.
function listbox_building_type_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_building_type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
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
clear_results(hObject, eventdata, handles);

n=get(handles.listbox_analysis,'Value');

if(n==1)
   set(handles.listbox_unit,'Visible','on');
else
   set(handles.listbox_unit,'Visible','off');    
end

if(n==1)
    set(handles.text_input,'String','Height');
end
if(n==2)
    set(handles.text_input,'String','Period(sec)');
end
if(n==3)
    set(handles.text_input,'String','Frequency(Hz)');
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



function edit_input_data_Callback(hObject, eventdata, handles)
% hObject    handle to edit_input_data (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_input_data as text
%        str2double(get(hObject,'String')) returns contents of edit_input_data as a double


% --- Executes during object creation, after setting all properties.
function edit_input_data_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_input_data (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_unit.
function listbox_unit_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_unit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_unit contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_unit
clear_results(hObject, eventdata, handles);

% --- Executes during object creation, after setting all properties.
function listbox_unit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_unit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on key press with focus on edit_input_data and none of its controls.
function edit_input_data_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_input_data (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
clear_results(hObject, eventdata, handles);

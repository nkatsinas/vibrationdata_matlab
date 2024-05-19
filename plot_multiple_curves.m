function varargout = plot_multiple_curves(varargin)
% PLOT_MULTIPLE_CURVES MATLAB code for plot_multiple_curves.fig
%      PLOT_MULTIPLE_CURVES, by itself, creates a new PLOT_MULTIPLE_CURVES or raises the existing
%      singleton*.
%
%      H = PLOT_MULTIPLE_CURVES returns the handle to a new PLOT_MULTIPLE_CURVES or the handle to
%      the existing singleton*.
%
%      PLOT_MULTIPLE_CURVES('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PLOT_MULTIPLE_CURVES.M with the given input arguments.
%
%      PLOT_MULTIPLE_CURVES('Property','Value',...) creates a new PLOT_MULTIPLE_CURVES or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before plot_multiple_curves_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to plot_multiple_curves_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help plot_multiple_curves

% Last Modified by GUIDE v2.5 19-Mar-2019 11:06:37

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @plot_multiple_curves_OpeningFcn, ...
                   'gui_OutputFcn',  @plot_multiple_curves_OutputFcn, ...
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


% --- Executes just before plot_multiple_curves is made visible.
function plot_multiple_curves_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to plot_multiple_curves (see VARARGIN)

% Choose default command line output for plot_multiple_curves
handles.output = hObject;

set(handles.listbox_psave,'Value',2);
set(handles.listbox_fsize,'Value',4);

listbox_psave_Callback(hObject, eventdata, handles);

try
    close 1
end
try
    close 2
end
try
    close 3
end
try
    close 4
end
try
    close 5
end
try
    close 6
end
try
    close 7
end
try
    close 8
end
try
    close 9
end
try
    close 10
end
try
    close 11
end
try
    close 12
end


% Update handles structure
guidata(hObject, handles);

% UIWAIT makes plot_multiple_curves wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = plot_multiple_curves_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in listbox_xaxis.
function listbox_xaxis_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_xaxis (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_xaxis contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_xaxis


% --- Executes during object creation, after setting all properties.
function listbox_xaxis_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_xaxis (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_xlabel_Callback(hObject, eventdata, handles)
% hObject    handle to edit_xlabel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_xlabel as text
%        str2double(get(hObject,'String')) returns contents of edit_xlabel as a double


% --- Executes during object creation, after setting all properties.
function edit_xlabel_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_xlabel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_xplotlimits.
function listbox_xplotlimits_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_xplotlimits (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_xplotlimits contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_xplotlimits

n=get(handles.listbox_xplotlimits,'Value');

if(n==1)
    set(handles.edit_xmin,'Enable','off');
    set(handles.edit_xmax,'Enable','off'); 
else
    set(handles.edit_xmin,'Enable','on');
    set(handles.edit_xmax,'Enable','on');  
end


% --- Executes during object creation, after setting all properties.
function listbox_xplotlimits_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_xplotlimits (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_xmin_Callback(hObject, eventdata, handles)
% hObject    handle to edit_xmin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_xmin as text
%        str2double(get(hObject,'String')) returns contents of edit_xmin as a double


% --- Executes during object creation, after setting all properties.
function edit_xmin_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_xmin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_xmax_Callback(hObject, eventdata, handles)
% hObject    handle to edit_xmax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_xmax as text
%        str2double(get(hObject,'String')) returns contents of edit_xmax as a double


% --- Executes during object creation, after setting all properties.
function edit_xmax_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_xmax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_c1_array_name_Callback(hObject, eventdata, handles)
% hObject    handle to edit_c1_array_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_c1_array_name as text
%        str2double(get(hObject,'String')) returns contents of edit_c1_array_name as a double


% --- Executes during object creation, after setting all properties.
function edit_c1_array_name_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_c1_array_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_c2_array_name_Callback(hObject, eventdata, handles)
% hObject    handle to edit_c2_array_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_c2_array_name as text
%        str2double(get(hObject,'String')) returns contents of edit_c2_array_name as a double


% --- Executes during object creation, after setting all properties.
function edit_c2_array_name_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_c2_array_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_c3_array_name_Callback(hObject, eventdata, handles)
% hObject    handle to edit_c3_array_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_c3_array_name as text
%        str2double(get(hObject,'String')) returns contents of edit_c3_array_name as a double


% --- Executes during object creation, after setting all properties.
function edit_c3_array_name_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_c3_array_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_c4_array_name_Callback(hObject, eventdata, handles)
% hObject    handle to edit_c4_array_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_c4_array_name as text
%        str2double(get(hObject,'String')) returns contents of edit_c4_array_name as a double


% --- Executes during object creation, after setting all properties.
function edit_c4_array_name_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_c4_array_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_c1_legend_Callback(hObject, eventdata, handles)
% hObject    handle to edit_c1_legend (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_c1_legend as text
%        str2double(get(hObject,'String')) returns contents of edit_c1_legend as a double


% --- Executes during object creation, after setting all properties.
function edit_c1_legend_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_c1_legend (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_c2_legend_Callback(hObject, eventdata, handles)
% hObject    handle to edit_c2_legend (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_c2_legend as text
%        str2double(get(hObject,'String')) returns contents of edit_c2_legend as a double


% --- Executes during object creation, after setting all properties.
function edit_c2_legend_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_c2_legend (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_c3_legend_Callback(hObject, eventdata, handles)
% hObject    handle to edit_c3_legend (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_c3_legend as text
%        str2double(get(hObject,'String')) returns contents of edit_c3_legend as a double


% --- Executes during object creation, after setting all properties.
function edit_c3_legend_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_c3_legend (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_c4_legend_Callback(hObject, eventdata, handles)
% hObject    handle to edit_c4_legend (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_c4_legend as text
%        str2double(get(hObject,'String')) returns contents of edit_c4_legend as a double


% --- Executes during object creation, after setting all properties.
function edit_c4_legend_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_c4_legend (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_ylabel_Callback(hObject, eventdata, handles)
% hObject    handle to edit_ylabel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_ylabel as text
%        str2double(get(hObject,'String')) returns contents of edit_ylabel as a double


% --- Executes during object creation, after setting all properties.
function edit_ylabel_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_ylabel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_yaxis.
function listbox_yaxis_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_yaxis (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_yaxis contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_yaxis


% --- Executes during object creation, after setting all properties.
function listbox_yaxis_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_yaxis (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_yplotlimits.
function listbox_yplotlimits_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_yplotlimits (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_yplotlimits contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_yplotlimits

n=get(handles.listbox_yplotlimits,'Value');

if(n==1)
    set(handles.edit_ymin,'Enable','off');
    set(handles.edit_ymax,'Enable','off');   
else
    set(handles.edit_ymin,'Enable','on');
    set(handles.edit_ymax,'Enable','on');  
end



% --- Executes during object creation, after setting all properties.
function listbox_yplotlimits_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_yplotlimits (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_ymin_Callback(hObject, eventdata, handles)
% hObject    handle to edit_ymin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_ymin as text
%        str2double(get(hObject,'String')) returns contents of edit_ymin as a double


% --- Executes during object creation, after setting all properties.
function edit_ymin_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_ymin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_ymax_Callback(hObject, eventdata, handles)
% hObject    handle to edit_ymax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_ymax as text
%        str2double(get(hObject,'String')) returns contents of edit_ymax as a double


% --- Executes during object creation, after setting all properties.
function edit_ymax_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_ymax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_title_Callback(hObject, eventdata, handles)
% hObject    handle to edit_title (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_title as text
%        str2double(get(hObject,'String')) returns contents of edit_title as a double


% --- Executes during object creation, after setting all properties.
function edit_title_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_title (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_figure_number.
function listbox_figure_number_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_figure_number (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_figure_number contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_figure_number


% --- Executes during object creation, after setting all properties.
function listbox_figure_number_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_figure_number (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_legend.
function listbox_legend_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_legend (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_legend contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_legend


% --- Executes during object creation, after setting all properties.
function listbox_legend_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_legend (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_grid.
function listbox_grid_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_grid (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_grid contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_grid


% --- Executes during object creation, after setting all properties.
function listbox_grid_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_grid (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_plot.
function pushbutton_plot_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_plot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


%%%


zzz='';

setappdata(0,'FS1',zzz);
setappdata(0,'FS2',zzz);
setappdata(0,'FS3',zzz);
setappdata(0,'FS4',zzz);
setappdata(0,'FS5',zzz);
setappdata(0,'FS6',zzz);

setappdata(0,'slegend1',zzz);
setappdata(0,'slegend2',zzz);  
setappdata(0,'slegend3',zzz);
setappdata(0,'slegend4',zzz);
setappdata(0,'slegend5',zzz);  
setappdata(0,'slegend6',zzz);  


setappdata(0,'xs1',zzz);
setappdata(0,'xs2',zzz); 

setappdata(0,'ys1',zzz);
setappdata(0,'ys2',zzz); 

%%%


radio1Value = get(handles.radiobutton1, 'Value');
radio2Value = get(handles.radiobutton2, 'Value');
radio3Value = get(handles.radiobutton3, 'Value');
radio4Value = get(handles.radiobutton4, 'Value');
radio5Value = get(handles.radiobutton5, 'Value');
radio6Value = get(handles.radiobutton6, 'Value');


if(max([ radio1Value,radio2Value,radio3Value,radio4Value,radio5Value,radio6Value])==0)
    warndlg('Select at least one curve to plot');
    return;
end

setappdata(0,'radio1Value',radio1Value);
setappdata(0,'radio2Value',radio2Value);
setappdata(0,'radio3Value',radio3Value);
setappdata(0,'radio4Value',radio4Value);
setappdata(0,'radio5Value',radio5Value);
setappdata(0,'radio6Value',radio6Value);

%
nx_type=get(handles.listbox_xaxis,'Value');
ny_type=get(handles.listbox_yaxis,'Value');
ng=get(handles.listbox_grid,'Value');
nx_limits=get(handles.listbox_xplotlimits,'Value');
ny_limits=get(handles.listbox_yplotlimits,'Value');
n=get(handles.listbox_figure_number,'Value');
nlegend=get(handles.listbox_legend,'Value');
%


setappdata(0,'nx_type',nx_type);
setappdata(0,'ny_type',ny_type);
setappdata(0,'ng',ng);
setappdata(0,'nx_limits',nx_limits);
setappdata(0,'ny_limits',ny_limits);
setappdata(0,'n',n);
setappdata(0,'nlegend',nlegend);


%%%

if(radio1Value==1)
    
    FS1=strtrim(get(handles.edit_c1_array_name,'String'));
    setappdata(0,'FS1',FS1);
     
    try        
        THM1=evalin('base',FS1);
    catch
        warndlg('Array 1 does not exist','Warning');
        return;
    end
    if(nx_type==2)
        if(THM1(1,1)<1.0e-20)
            THM1(1,:)=[];
        end    
    end 
    if(nlegend==1)
        slegend1=get(handles.edit_c1_legend,'String');
        setappdata(0,'slegend1',slegend1);
    end
end    
if(radio2Value==1)
     
    FS2=strtrim(get(handles.edit_c2_array_name,'String'));
    setappdata(0,'FS2',FS2);
 
    try

        THM2=evalin('base',FS2);
    catch
        warndlg('Array 2 does not exist','Warning');
        return;
    end
    if(nx_type==2)
        if(THM2(1,1)<1.0e-20)
            THM2(1,:)=[];
        end    
    end   
    if(nlegend==1)
        slegend2=get(handles.edit_c2_legend,'String');  
        setappdata(0,'slegend2',slegend2);        
    end    
end
if(radio3Value==1)
    
    FS3=strtrim(get(handles.edit_c3_array_name,'String'));
    setappdata(0,'FS3',FS3);

    try
        THM3=evalin('base',FS3);
    catch
        warndlg('Array 3 does not exist','Warning');
        return;
    end    
    if(nx_type==2)
        if(THM3(1,1)<1.0e-20)
            THM3(1,:)=[];
        end    
    end      
    if(nlegend==1)
        slegend3=get(handles.edit_c3_legend,'String');
        setappdata(0,'slegend3',slegend3);     
    end    
end
if(radio4Value==1)
    
    FS4=strtrim(get(handles.edit_c4_array_name,'String'));    
    setappdata(0,'FS4',FS4);
    
    try
        THM4=evalin('base',FS4);
    catch
        warndlg('Array 4 does not exist','Warning');
        return;
    end    
    if(nx_type==2)
        if(THM4(1,1)<1.0e-20)
            THM4(1,:)=[];
        end    
    end      
    if(nlegend==1)
        slegend4=get(handles.edit_c4_legend,'String');
        setappdata(0,'slegend4',slegend4); 
    end    
end
if(radio5Value==1)
    
    FS5=strtrim(get(handles.edit_c5_array_name,'String'));  
    setappdata(0,'FS5',FS5); 

    try
        THM5=evalin('base',FS5);
    catch
        warndlg('Array 5 does not exist','Warning');
        return;
    end    
    if(nx_type==2)
        if(THM5(1,1)<1.0e-20)
            THM5(1,:)=[];
        end    
    end      
    if(nlegend==1)
        slegend5=get(handles.edit_c5_legend,'String');  
        setappdata(0,'slegend5',slegend5);         
    end    
end
if(radio6Value==1)
    
    FS6=strtrim(get(handles.edit_c6_array_name,'String'));  
    setappdata(0,'FS6',FS6); 

    try
        THM6=evalin('base',FS6);
    catch
        warndlg('Array 6 does not exist','Warning');
        return;
    end    
    if(nx_type==2)
        if(THM6(1,1)<1.0e-20)
            THM6(1,:)=[];
        end    
    end      
    if(nlegend==1)
        slegend6=get(handles.edit_c6_legend,'String');  
        setappdata(0,'slegend6',slegend6);         
    end    
end

%%%%

stitle=get(handles.edit_title,'String');
sxlabel=get(handles.edit_xlabel,'String');
sylabel=get(handles.edit_ylabel,'String');

setappdata(0,'stitle',stitle);
setappdata(0,'sxlabel',sxlabel);
setappdata(0,'sylabel',sylabel);

%
if(nx_limits==2)

     xs1=get(handles.edit_xmin,'String');
     if isempty(xs1)
        warndlg('Enter xmin','Warning');
        return;
     else
        xmin=str2num(xs1);
     end
     
     xs2=get(handles.edit_xmax,'String');
     if isempty(xs2)
        warndlg('Enter xmax','Warning');
        return;
     else
        xmax=str2num(xs2);
     end
     
    setappdata(0,'xs1',xs1);
    setappdata(0,'xs2',xs2);  
 
end
%


%

xpm1=0;
xpm2=0;
xpm3=0;
xpm4=0;
xpm5=0;
xpm6=0;

xmin1=1.e+99;
xmin2=1.e+99;
xmin3=1.e+99;
xmin4=1.e+99;
xmin5=1.e+99;
xmin6=1.e+99;

xmax1=-xmin1;
xmax2=-xmin2;
xmax3=-xmin3;
xmax4=-xmin4;
xmax5=-xmin5;
xmax6=-xmin6;

ymin1=1.e+99;
ymin2=1.e+99;
ymin3=1.e+99;
ymin4=1.e+99;
ymin5=1.e+99;
ymin6=1.e+99;
 
ymax1=-ymin1;
ymax2=-ymin2;
ymax3=-ymin3;
ymax4=-ymin4;
ymax5=-ymin5;
ymax6=-ymin6;


psave=get(handles.listbox_psave,'Value');
setappdata(0,'psave',psave);

try
    close(n);
catch    
end    
    
hp=figure(n);
hold all;
%
if(radio1Value==1)
    if(nlegend==2)
        plot(THM1(:,1),THM1(:,2),'color','blue');
    else  
        plot(THM1(:,1),THM1(:,2),'color','blue','DisplayName',slegend1);
    end
    
    [x1]=get(gca,'xlim');

    xpm1=min(x1);
    
    xmin1=THM1(1,1);
    xmax1=max(x1);
    
    ymin1=min(THM1(:,2));
    ymax1=max(THM1(:,2));    
    
end
if(radio2Value==1)
    if(nlegend==2)
        plot(THM2(:,1),THM2(:,2),'color','red');
    else  
        plot(THM2(:,1),THM2(:,2),'color','red','DisplayName',slegend2);
    end
    
    [x2]=get(gca,'xlim');
    
    xpm2=min(x2);
    
    xmin2=THM2(1,1);
    xmax2=max(x2);

    ymin2=min(THM2(:,2));
    ymax2=max(THM2(:,2));        
    
end
if(radio3Value==1)
    if(nlegend==2)
        plot(THM3(:,1),THM3(:,2),'color','black');
    else  
        plot(THM3(:,1),THM3(:,2),'color','black','DisplayName',slegend3);
    end
    
    [x3]=get(gca,'xlim');
    
    xpm3=min(x3);
    
    xmin3=THM3(1,1);
    xmax3=max(x3);
    
    ymin3=min(THM3(:,2));
    ymax3=max(THM3(:,2));        
    
end
if(radio4Value==1)
    if(nlegend==2)
        plot(THM4(:,1),THM4(:,2),'color',[0 .5 0]);
    else  
        plot(THM4(:,1),THM4(:,2),'color',[0 .5 0] ,'DisplayName',slegend4);
    end   
    
    [x4]=get(gca,'xlim');
    
    xpm4=min(x4);
    
    xmin4=THM4(1,1);
    xmax4=max(x4);  
    
    ymin4=min(THM4(:,2));
    ymax4=max(THM4(:,2));    

end
if(radio5Value==1)
    if(nlegend==2)
        plot(THM5(:,1),THM5(:,2),'color',[1 .5 0]);
    else  
        plot(THM5(:,1),THM5(:,2),'color',[1 .5 0] ,'DisplayName',slegend5);
    end   
    
    [x5]=get(gca,'xlim');
    
    xpm5=min(x5);
    
    xmin5=THM5(1,1);
    xmax5=max(x5);  
    
    ymin5=min(THM5(:,2));
    ymax5=max(THM5(:,2));    
 
end
if(radio6Value==1)
    if(nlegend==2)
        plot(THM6(:,1),THM6(:,2),'color',[0.5 1 0]);
    else  
        plot(THM6(:,1),THM6(:,2),'color',[0.3 0.6 0.7] ,'DisplayName',slegend6);
    end   
    
    [x6]=get(gca,'xlim');
    
    xpm6=min(x6);
    
    xmin6=THM6(1,1);
    xmax6=max(x6);  
    
    ymin6=min(THM6(:,2));
    ymax6=max(THM6(:,2));    
 
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
title(stitle);
xlabel(sxlabel);
ylabel(sylabel);

%
grid off;
%

if(ng==1)
    
    grid on;
    set(gca, 'xminorgrid', 'on', 'yminorgrid', 'on')
    
 
    if(nx_type==1 && ny_type==2)
        set(gca,'MinorGridLineStyle',':','GridLineStyle','-','XScale','lin','YScale','log');
    end
    if(nx_type==2 && ny_type==1)
        set(gca,'MinorGridLineStyle',':','GridLineStyle','-','XScale','log','YScale','lin');
    end
    if(nx_type==2 && ny_type==2)
        set(gca,'MinorGridLineStyle',':','GridLineStyle','-','XScale','log','YScale','log');
    end    
    
end    
if(ng==2)
    
    grid on;
    set(gca, 'xminorgrid', 'on', 'yminorgrid', 'on')
 

    if(nx_type==1 && ny_type==1)
        set(gca,'MinorGridLineStyle','none','GridLineStyle','-','XScale','lin','YScale','lin');
    end    
    if(nx_type==1 && ny_type==2)
        set(gca,'MinorGridLineStyle','none','GridLineStyle','-','XScale','lin','YScale','log');
    end
    if(nx_type==2 && ny_type==1)
        set(gca,'MinorGridLineStyle','none','GridLineStyle','-','XScale','log','YScale','lin');
    end
    if(nx_type==2 && ny_type==2)
        set(gca,'MinorGridLineStyle','none','GridLineStyle','-','XScale','log','YScale','log');
    end    
    
end
if(ng==3)
 
    if(nx_type==1 && ny_type==2)
        set(gca,'MinorGridLineStyle','none','GridLineStyle','none','XScale','lin','YScale','log');
    end
    if(nx_type==2 && ny_type==1)
        set(gca,'MinorGridLineStyle','none','GridLineStyle','none','XScale','log','YScale','lin');
    end
    if(nx_type==2 && ny_type==2)
        set(gca,'MinorGridLineStyle','none','GridLineStyle','none','XScale','log','YScale','log');
    end    
    
end

%

if(nx_type==1)
    xx1=[xpm1,xpm2,xpm3,xpm4,xpm5,xpm6 ];
else
    xx1=[xmin1,xmin2,xmin3,xmin4,xmin5,xmin6 ];
end

xx2=[xmax1,xmax2,xmax3,xmax4,xmax5,xmax6 ];

yy1=[ymin1,ymin2,ymin3,ymin4,ymin5,ymin6 ];
yy2=[ymax1,ymax2,ymax3,ymax4,ymax5,ymax6 ];

%

if(nx_limits==1) % automatic
    xmin=min(xx1);
    xmax=max(xx2);
   
    xlim([xmin,xmax]);
        
    if(nx_type==2)
        
        [xtt,xTT,iflag]=xtick_label(xmin,xmax); 
        
        if(iflag==1)
            try
                xmin=min(xtt);
                xmax=max(xtt);

                xlim([xmin,xmax]);
                set(gca,'xtick',xtt);
                set(gca,'XTickLabel',xTT);
            catch    
            end
        end
    end    
end
if(nx_limits==2 ) % manual 
    
    xlim([xmin,xmax]);
    
    if(nx_type==2) % log
        
        try
            [xtt,xTT,iflag]=xtick_label(xmin,xmax);
            
            if(iflag==1)
                set(gca,'xtick',xtt);
                set(gca,'XTickLabel',xTT);
            end
        catch    
        end
    end    
end

     
if(ny_limits==1 && ny_type==2)  % automatic log
    
    yymin=min(yy1);
    yymax=max(yy2);
    
    try
        [ymin,ymax]=ytick_log(yymin,yymax);
        ylim([ymin,ymax]);
    end    
end    


if(ny_limits==2)
     
     ys1=get(handles.edit_ymin,'String');
 
     if isempty(ys1)
        warndlg('Enter ymin','Warning');
        return;
     else
        ymin=str2num(ys1);
     end
     
     ys2=get(handles.edit_ymax,'String');
     if isempty(ys2)
        warndlg('Enter ymax','Warning');
        return;
     else
        ymax=str2num(ys2);
     end 
     ylim([ymin,ymax]);
     
     setappdata(0,'ys1',ys1);
     setappdata(0,'ys2',ys2);     
end

if(psave==1)
    
    % put twice
    if(nlegend==1)
        legend show;
    end  
    
    pname=get(handles.edit_png_name,'String'); 
    
    fsize=9+get(handles.listbox_fsize,'Value');
    
    set(gca,'Fontsize',fsize);
    print(hp,pname,'-dpng','-r300');
    
    msgbox('Plot file exported to hard drive');
    
else   
    % put last
    if(nlegend==1)
        legend show;
    end     
end


hold off;

%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%

% --- Executes on button press in pushbutton_return.
function pushbutton_return_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_return (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
delete(plot_multiple_curves);


% --- Executes on button press in radiobutton1.
function radiobutton1_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton1


% --- Executes on button press in radiobutton2.
function radiobutton2_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton2


% --- Executes on button press in radiobutton3.
function radiobutton3_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton3


% --- Executes on button press in radiobutton4.
function radiobutton4_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton4


% --- Executes on button press in pushbutton_export.
function pushbutton_export_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_export (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function edit_png_name_Callback(hObject, eventdata, handles)
% hObject    handle to edit_png_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_png_name as text
%        str2double(get(hObject,'String')) returns contents of edit_png_name as a double


% --- Executes during object creation, after setting all properties.
function edit_png_name_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_png_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_psave.
function listbox_psave_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_psave (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_psave contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_psave

n=get(handles.listbox_psave,'Value');

if(n==1)
    set(handles.text_pfn,'Visible','on');
    set(handles.edit_png_name,'Visible','on');
    set(handles.text_font_size,'Visible','on');
    set(handles.listbox_fsize,'Visible','on');    
else
    set(handles.text_pfn,'Visible','off');
    set(handles.edit_png_name,'Visible','off');  
    set(handles.text_font_size,'Visible','off');
    set(handles.listbox_fsize,'Visible','off');      
end


% --- Executes during object creation, after setting all properties.
function listbox_psave_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_psave (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_fsize.
function listbox_fsize_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_fsize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_fsize contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_fsize


% --- Executes during object creation, after setting all properties.
function listbox_fsize_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_fsize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in radiobutton5.
function radiobutton5_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton5



function edit_c5_array_name_Callback(hObject, eventdata, handles)
% hObject    handle to edit_c5_array_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_c5_array_name as text
%        str2double(get(hObject,'String')) returns contents of edit_c5_array_name as a double


% --- Executes during object creation, after setting all properties.
function edit_c5_array_name_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_c5_array_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_c5_legend_Callback(hObject, eventdata, handles)
% hObject    handle to edit_c5_legend (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_c5_legend as text
%        str2double(get(hObject,'String')) returns contents of edit_c5_legend as a double


% --- Executes during object creation, after setting all properties.
function edit_c5_legend_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_c5_legend (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_save.
function pushbutton_save_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

try
    radio1Value = get(handles.radiobutton1, 'Value');
    PlotSave.radio1Value=radio1Value;
end 
try
    radio2Value = get(handles.radiobutton2, 'Value');
    PlotSave.radio2Value=radio2Value;
end 
try
    radio3Value = get(handles.radiobutton3, 'Value');
    PlotSave.radio3Value=radio3Value;
end 
try
    radio4Value = get(handles.radiobutton4, 'Value');
    PlotSave.radio4Value=radio4Value;
end 
try
    radio5Value = get(handles.radiobutton5, 'Value'); 
    PlotSave.radio5Value=radio5Value;
end
try
    radio6Value = get(handles.radiobutton6, 'Value'); 
    PlotSave.radio6Value=radio6Value;
end


try
    nx_type=get(handles.listbox_xaxis,'Value');
    PlotSave.nx_type=nx_type;
end 
try
    ny_type=get(handles.listbox_yaxis,'Value');
    PlotSave.ny_type=ny_type;
end 
try
    ng=get(handles.listbox_grid,'Value');
    PlotSave.ng=ng;
end 
try
    nx_limits=get(handles.listbox_xplotlimits,'Value');
    PlotSave.nx_limits=nx_limits;
end 
try
    ny_limits=get(handles.listbox_yplotlimits,'Value');
    PlotSave.ny_limits=ny_limits;
end 
try
    n=get(handles.listbox_figure_number,'Value');
    PlotSave.n=n;
end 
try
    nlegend=get(handles.listbox_legend,'Value');
    PlotSave.nlegend=nlegend;
end 
try
    stitle=get(handles.edit_title,'String');    
    PlotSave.stitle=stitle;
end 
try
    sxlabel=get(handles.edit_xlabel,'String');
    PlotSave.sxlabel=sxlabel;
end 
try
    sylabel=get(handles.edit_ylabel,'String');
    PlotSave.sylabel=sylabel;
end 
try
    psave=get(handles.listbox_psave,'Value');
    PlotSave.psave=psave;
end  

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

try
    FS1=strtrim(get(handles.edit_c1_array_name,'String'));
    PlotSave.FS1=FS1;
    
    try
        THM1=evalin('base',FS1);
        PlotSave.THM1=THM1;
    catch
    end
    
end 
try
    FS2=strtrim(get(handles.edit_c2_array_name,'String'));
    PlotSave.FS2=FS2;
     
    try
        THM2=evalin('base',FS2);
        PlotSave.THM2=THM2;
    catch
    end    
end 
try
    FS3=strtrim(get(handles.edit_c3_array_name,'String'));
    PlotSave.FS3=FS3;
        
    try
        THM3=evalin('base',FS3);
        PlotSave.THM3=THM3;
    catch
    end    
end 
try
    FS4=strtrim(get(handles.edit_c4_array_name,'String'));
    PlotSave.FS4=FS4;
        
    try
        THM4=evalin('base',FS4);
        PlotSave.THM4=THM4;
    catch
    end
end 
try
    FS5=strtrim(get(handles.edit_c5_array_name,'String'));  
    PlotSave.FS5=FS5;
        
    try
        THM5=evalin('base',FS5);
        PlotSave.THM5=THM5;
    catch
    end    
end 
try
    FS6=strtrim(get(handles.edit_c6_array_name,'String'));  
    PlotSave.FS6=FS6;
        
    try
        THM6=evalin('base',FS6);
        PlotSave.THM6=THM6;
    catch
    end    
end 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

try
    slegend1=get(handles.edit_c1_legend,'String');
    PlotSave.slegend1=slegend1;
end 
try
    slegend2=get(handles.edit_c2_legend,'String');  
    PlotSave.slegend2=slegend2;
end 
try
    slegend3=get(handles.edit_c3_legend,'String');
    PlotSave.slegend3=slegend3;
end 
try
    slegend4=get(handles.edit_c4_legend,'String');
    PlotSave.slegend4=slegend4;
end 
try
    slegend5=get(handles.edit_c5_legend,'String');  
    PlotSave.slegend5=slegend5;
end 
try
    slegend6=get(handles.edit_c6_legend,'String');  
    PlotSave.slegend6=slegend6;
end 

try
    xs1=get(handles.edit_xmin,'String');
    PlotSave.xs1=xs1;
end 
try
    xs2=get(handles.edit_xmax,'String');
    PlotSave.xs2=xs2;
end 
try
    ys1=get(handles.edit_ymin,'String');
    PlotSave.ys1=ys1;
end 
try
    ys2=get(handles.edit_ymax,'String');  
    PlotSave.ys2=ys2;
end 

% % %

structnames = fieldnames(PlotSave, '-full'); % fields in the struct

% % %

   [writefname, writepname] = uiputfile('*.mat','Save data as');

   %%%    writepfname = fullfile(writepname, writefname);
    
%%%    pattern = '.mat';
%%%    replacement = '';
%%%    sname=regexprep(writefname,pattern,replacement);
   
    elk=sprintf('%s%s',writepname,writefname);

    try
 
        save(elk, 'PlotSave'); 
 
    catch
        warndlg('Save error');
        return;
    end
 


% --- Executes on button press in pushbutton_load.
function pushbutton_load_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_load (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[filename, pathname] = uigetfile('*.mat', 'Select plot save file');

NAME = [pathname,filename];

struct=load(NAME);
structnames = fieldnames(struct, '-full'); % fields in the struct

k=length(structnames);


for i=1:k
    namevar=strcat('struct.',structnames{i});
    value=eval(namevar);
    assignin('base',structnames{i},value);
end

% struct

try

   PlotSave=evalin('base','PlotSave');

catch
   warndlg(' evalin failed ');
   return;
end


try
    radio1Value=PlotSave.radio1Value;
    set(handles.radiobutton1,'Value',radio1Value);
    setappdata(0,'radio1Value',radio1Value);
catch    
end

try
    radio2Value=PlotSave.radio2Value;
    set(handles.radiobutton2,'Value',radio2Value);
    setappdata(0,'radio2Value',radio2Value);
catch    
end

try
    radio3Value=PlotSave.radio3Value;
    set(handles.radiobutton3,'Value',radio3Value); 
    setappdata(0,'radio3Value',radio3Value);
catch    
end

try
    radio4Value=PlotSave.radio4Value;
    set(handles.radiobutton4,'Value',radio4Value); 
    setappdata(0,'radio4Value',radio4Value);
catch    
end

try
    radio5Value=PlotSave.radio5Value;
    set(handles.radiobutton5,'Value',radio5Value);
    setappdata(0,'radio5Value',radio5Value); 
catch    
end

try
    radio6Value=PlotSave.radio6Value;
    set(handles.radiobutton6,'Value',radio6Value);
    setappdata(0,'radio6Value',radio6Value); 
catch    
end




try
    nx_type=PlotSave.nx_type;
    set(handles.listbox_xaxis,'Value',nx_type);
    setappdata(0,'nx_type',nx_type);
catch    
end

try
    ny_type=PlotSave.ny_type;
    set(handles.listbox_yaxis,'Value',ny_type);
    setappdata(0,'ny_type',ny_type);
catch    
end

try
    ng=PlotSave.ng;
    set(handles.listbox_grid,'Value',ng);
    setappdata(0,'ng',ng);
catch    
end

try
    nx_limits=PlotSave.nx_limits;
    set(handles.listbox_xplotlimits,'Value',nx_limits); 
    setappdata(0,'nx_limits',nx_limits);
catch    
end

try
    ny_limits=PlotSave.ny_limits;
    set(handles.listbox_yplotlimits,'Value',ny_limits);
    setappdata(0,'ny_limits',ny_limits);
catch    
end

try
    n=PlotSave.n;
    set(handles.listbox_figure_number,'Value',n);
    setappdata(0,'n',n);
catch    
end

try
    nlegend=PlotSave.nlegend;
    set(handles.listbox_legend,'Value',nlegend);
    setappdata(0,'nlegend',nlegend);
catch    
end

try
    stitle=PlotSave.stitle;
    set(handles.edit_title,'String',stitle);
    setappdata(0,'stitle',stitle);  
catch    
end

try
    sxlabel=PlotSave.sxlabel;
    set(handles.edit_xlabel,'String',sxlabel);
    setappdata(0,'sxlabel',sxlabel);
catch    
end

try
    sylabel=PlotSave.sylabel;
    set(handles.edit_ylabel,'String',sylabel); 
    setappdata(0,'sylabel',sylabel);
catch    
end

try
    psave=PlotSave.psave;
    set(handles.listbox_psave,'Value',psave);
    setappdata(0,'psave',psave);
catch    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

try
    FS1=strtrim(PlotSave.FS1);
    set(handles.edit_c1_array_name,'String',FS1);
 
    iflag=0;
    
    try
        temp=evalin('base',FS1);
        ss=sprintf('Replace %s with Previously Saved Array',FS1);
        answer = questdlg(ss,'Array Overwrite','Yes','No','No');
 
        switch answer
            case 'Yes'
                iflag=0;
            case 'No'
                iflag=1;
        end    
    catch 
    end
    
    if(iflag==0)
        try
            THM1=PlotSave.THM1;
            assignin('base',FS1,THM1); 
        catch
        end
    end
    
catch    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

try
    FS2=strtrim(PlotSave.FS2);
    set(handles.edit_c2_array_name,'String',FS2);
 
    iflag=0;
    
    try
        temp=evalin('base',FS2);
        ss=sprintf('Replace %s with Previously Saved Array',FS2);
        answer = questdlg(ss,'Array Overwrite','Yes','No','No');
 
        switch answer
            case 'Yes'
                iflag=0;
            case 'No'
                iflag=1;
        end    
    catch 
    end
    
    if(iflag==0)
        try
            THM2=PlotSave.THM2;
            assignin('base',FS2,THM2); 
        catch
        end
    end
    
catch    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

try
    FS3=strtrim(PlotSave.FS3);
    set(handles.edit_c3_array_name,'String',FS3);
 
    iflag=0;
    
    try
        temp=evalin('base',FS3);
        ss=sprintf('Replace %s with Previously Saved Array',FS3);
        answer = questdlg(ss,'Array Overwrite','Yes','No','No');
 
        switch answer
            case 'Yes'
                iflag=0;
            case 'No'
                iflag=1;
        end    
    catch 
    end
    
    if(iflag==0)
        try
            THM3=PlotSave.THM3;
            assignin('base',FS3,THM3); 
        catch
        end
    end
    
catch    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

try
    FS4=strtrim(PlotSave.FS4);
    set(handles.edit_c4_array_name,'String',FS4);
 
    iflag=0;
    
    try
        temp=evalin('base',FS4);
        ss=sprintf('Replace %s with Previously Saved Array',FS4);
        answer = questdlg(ss,'Array Overwrite','Yes','No','No');
 
        switch answer
            case 'Yes'
                iflag=0;
            case 'No'
                iflag=1;
        end    
    catch 
    end
    
    if(iflag==0)
        try
            THM4=PlotSave.THM4;
            assignin('base',FS4,THM4); 
        catch
        end
    end
    
catch    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

try
    FS5=strtrim(PlotSave.FS5);
    set(handles.edit_c5_array_name,'String',FS5);
 
    iflag=0;
    
    try
        temp=evalin('base',FS5);
        ss=sprintf('Replace %s with Previously Saved Array',FS5);
        answer = questdlg(ss,'Array Overwrite','Yes','No','No');
 
        switch answer
            case 'Yes'
                iflag=0;
            case 'No'
                iflag=1;
        end    
    catch 
    end
    
    if(iflag==0)
        try
            THM5=PlotSave.THM5;
            assignin('base',FS5,THM5); 
        catch
        end
    end
    
catch    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

try
    FS6=strtrim(PlotSave.FS6);
    set(handles.edit_c6_array_name,'String',FS6);
catch
end

try
    iflag=0;
    
    try
        temp=evalin('base',FS6);
        ss=sprintf('Replace %s with Previously Saved Array',FS6);
        answer = questdlg(ss,'Array Overwrite','Yes','No','No');
 
        switch answer
            case 'Yes'
                iflag=0;
            case 'No'
                iflag=1;
        end    
    catch 
    end
    
    if(iflag==0)
        try
            THM6=PlotSave.THM6;
            assignin('base',FS6,THM6); 
        catch
        end
    end
    
catch    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%

try
    slegend1=PlotSave.slegend1;
    set(handles.edit_c1_legend,'String',slegend1);
    setappdata(0,'slegend1',slegend1);
catch    
end

try
    slegend2=PlotSave.slegend2;
    set(handles.edit_c2_legend,'String',slegend2); 
    setappdata(0,'slegend2',slegend2);  
catch    
end

try
    slegend3=PlotSave.slegend3;
    set(handles.edit_c3_legend,'String',slegend3); 
    setappdata(0,'slegend3',slegend3);
catch    
end

try
    slegend4=PlotSave.slegend4;
    set(handles.edit_c4_legend,'String',slegend4);
    setappdata(0,'slegend4',slegend4);
catch    
end

try
    slegend5=PlotSave.slegend5;
    set(handles.edit_c5_legend,'String',slegend5); 
    setappdata(0,'slegend5',slegend5); 
catch    
end

try
    slegend6=PlotSave.slegend6;
    set(handles.edit_c6_legend,'String',slegend6); 
    setappdata(0,'slegend6',slegend6); 
catch    
end

try
    xs1=PlotSave.xs1;
    set(handles.edit_xmin,'String',xs1);
    setappdata(0,'xs1',xs1);
catch    
end

try
    xs2=PlotSave.xs2;
    set(handles.edit_xmax,'String',xs2);
    setappdata(0,'xs2',xs2); 
catch    
end

try
    ys1=PlotSave.ys1;
    set(handles.edit_ymin,'String',ys1);  
    setappdata(0,'ys1',ys1);
catch    
end

try
    ys2=PlotSave.ys2;
    set(handles.edit_ymax,'String',ys2);
    setappdata(0,'ys2',ys2);  
catch    
end

listbox_xplotlimits_Callback(hObject, eventdata, handles);
listbox_yplotlimits_Callback(hObject, eventdata, handles);


% --- Executes on button press in radiobutton6.
function radiobutton6_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton6



function edit_c6_array_name_Callback(hObject, eventdata, handles)
% hObject    handle to edit_c6_array_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_c6_array_name as text
%        str2double(get(hObject,'String')) returns contents of edit_c6_array_name as a double


% --- Executes during object creation, after setting all properties.
function edit_c6_array_name_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_c6_array_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_c6_legend_Callback(hObject, eventdata, handles)
% hObject    handle to edit_c6_legend (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_c6_legend as text
%        str2double(get(hObject,'String')) returns contents of edit_c6_legend as a double


% --- Executes during object creation, after setting all properties.
function edit_c6_legend_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_c6_legend (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function pushbutton_save_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pushbutton_save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

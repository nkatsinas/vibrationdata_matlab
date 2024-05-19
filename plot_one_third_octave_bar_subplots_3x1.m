function varargout = plot_one_third_octave_bar_subplots_3x1(varargin)
% PLOT_ONE_THIRD_OCTAVE_BAR_SUBPLOTS_3X1 MATLAB code for plot_one_third_octave_bar_subplots_3x1.fig
%      PLOT_ONE_THIRD_OCTAVE_BAR_SUBPLOTS_3X1, by itself, creates a new PLOT_ONE_THIRD_OCTAVE_BAR_SUBPLOTS_3X1 or raises the existing
%      singleton*.
%
%      H = PLOT_ONE_THIRD_OCTAVE_BAR_SUBPLOTS_3X1 returns the handle to a new PLOT_ONE_THIRD_OCTAVE_BAR_SUBPLOTS_3X1 or the handle to
%      the existing singleton*.
%
%      PLOT_ONE_THIRD_OCTAVE_BAR_SUBPLOTS_3X1('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PLOT_ONE_THIRD_OCTAVE_BAR_SUBPLOTS_3X1.M with the given input arguments.
%
%      PLOT_ONE_THIRD_OCTAVE_BAR_SUBPLOTS_3X1('Property','Value',...) creates a new PLOT_ONE_THIRD_OCTAVE_BAR_SUBPLOTS_3X1 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before plot_one_third_octave_bar_subplots_3x1_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to plot_one_third_octave_bar_subplots_3x1_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help plot_one_third_octave_bar_subplots_3x1

% Last Modified by GUIDE v2.5 26-Sep-2018 15:52:46

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @plot_one_third_octave_bar_subplots_3x1_OpeningFcn, ...
                   'gui_OutputFcn',  @plot_one_third_octave_bar_subplots_3x1_OutputFcn, ...
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


% --- Executes just before plot_one_third_octave_bar_subplots_3x1 is made visible.
function plot_one_third_octave_bar_subplots_3x1_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to plot_one_third_octave_bar_subplots_3x1 (see VARARGIN)

% Choose default command line output for plot_one_third_octave_bar_subplots_3x1
handles.output = hObject;

listbox_plot_files_Callback(hObject, eventdata, handles);

set(handles.listbox_psave,'Value',1);
set(handles.listbox_fsize,'Value',1);

listbox_psave_Callback(hObject, eventdata, handles);

listbox_format_Callback(hObject, eventdata, handles);

Nrows=3;
Ncolumns=1;

headers1={'Title'};
set(handles.uitable_title,'Data',cell(Nrows,Ncolumns),'ColumnName',headers1);



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

% UIWAIT makes plot_one_third_octave_bar_subplots_3x1 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = plot_one_third_octave_bar_subplots_3x1_OutputFcn(hObject, eventdata, handles) 
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

n=get(hObject,'Value');

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



function edit_ylabel_1_Callback(hObject, eventdata, handles)
% hObject    handle to edit_ylabel_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_ylabel_1 as text
%        str2double(get(hObject,'String')) returns contents of edit_ylabel_1 as a double


% --- Executes during object creation, after setting all properties.
function edit_ylabel_1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_ylabel_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_yaxis_1.
function listbox_yaxis_1_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_yaxis_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_yaxis_1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_yaxis_1


% --- Executes during object creation, after setting all properties.
function listbox_yaxis_1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_yaxis_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_yplotlimits_1.
function listbox_yplotlimits_1_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_yplotlimits_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_yplotlimits_1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_yplotlimits_1
n=get(handles.listbox_yplotlimits_1,'Value');

if(n==1)
    set(handles.edit_ymin_1,'Enable','off');
    set(handles.edit_ymax_1,'Enable','off');   
else
    set(handles.edit_ymin_1,'Enable','on');
    set(handles.edit_ymax_1,'Enable','on');  
end



% --- Executes during object creation, after setting all properties.
function listbox_yplotlimits_1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_yplotlimits_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_ymin_1_Callback(hObject, eventdata, handles)
% hObject    handle to edit_ymin_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_ymin_1 as text
%        str2double(get(hObject,'String')) returns contents of edit_ymin_1 as a double


% --- Executes during object creation, after setting all properties.
function edit_ymin_1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_ymin_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_ymax_1_Callback(hObject, eventdata, handles)
% hObject    handle to edit_ymax_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_ymax_1 as text
%        str2double(get(hObject,'String')) returns contents of edit_ymax_1 as a double


% --- Executes during object creation, after setting all properties.
function edit_ymax_1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_ymax_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_title_1_Callback(hObject, eventdata, handles)
% hObject    handle to edit_title_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_title_1 as text
%        str2double(get(hObject,'String')) returns contents of edit_title_1 as a double


% --- Executes during object creation, after setting all properties.
function edit_title_1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_title_1 (see GCBO)
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


nf=get(handles.listbox_format,'Value');

try
    A=char(get(handles.uitable_array_name,'Data'));
catch
    warndlg('Input Array not found');
    return;
end
    
if(nf==1)
    FS=A(1,:);
    
    try
        THM=evalin('base',FS);
    catch
        warndlg('Input array not found ');
        return;
    end
    
    THM1=[THM(:,1) THM(:,2)];
    THM2=[THM(:,1) THM(:,3)];
    THM3=[THM(:,1) THM(:,4)];
    
else
   
    FS1=A(1,:);
    FS2=A(2,:);    
    FS3=A(3,:);  

    
    try
        THM1=evalin('base',FS1);
    catch
        warndlg('Input array 1 not found ');
        return;
    end
    
    try
        THM2=evalin('base',FS2);
    catch
        warndlg('Input array 2 not found ');
        return;
    end
    
    try
        THM3=evalin('base',FS3);
    catch
        warndlg('Input array 3 not found ');
        return;
    end    
    
end

xmin=min([  THM1(1,1)  THM2(1,1)  THM3(1,1) ]);
xmax=max([  THM1(end,1)  THM2(end,1)  THM3(end,1) ]);

fmin=xmin*0.95;
fmax=xmax*1.05;


B=char(get(handles.uitable_title,'Data'));

t_string_1=B(1,:);
t_string_2=B(2,:);
t_string_3=B(3,:);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%


ng=get(handles.listbox_grid,'Value');

nx_limits=get(handles.listbox_xplotlimits,'Value');
ny_limits_1=get(handles.listbox_yplotlimits_1,'Value');
ny_limits_2=get(handles.listbox_yplotlimits_2,'Value');
ny_limits_3=get(handles.listbox_yplotlimits_3,'Value');

%
n=get(handles.listbox_figure_number,'Value');
%



sxlabel=get(handles.edit_xlabel,'String');

sylabel_1=get(handles.edit_ylabel_1,'String');
sylabel_2=get(handles.edit_ylabel_2,'String');
sylabel_3=get(handles.edit_ylabel_3,'String');

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
end
%
if(ny_limits_1==2)
     
     ys1=get(handles.edit_ymin_1,'String');
 
     if isempty(ys1)
        warndlg('Enter ymin','Warning');
        return;
     else
        ymin_1=str2num(ys1);
     end
     
     ys2=get(handles.edit_ymax_1,'String');
     if isempty(ys2)
        warndlg('Enter ymax','Warning');
        return;
     else
        ymax_1=str2num(ys2);
     end 
end

if(ny_limits_2==2)
     
     ys2=get(handles.edit_ymin_2,'String');
 
     if isempty(ys2)
        warndlg('Enter ymin','Warning');
        return;
     else
        ymin_2=str2num(ys2);
     end
     
     ys2=get(handles.edit_ymax_2,'String');
     if isempty(ys2)
        warndlg('Enter ymax','Warning');
        return;
     else
        ymax_2=str2num(ys2);
     end 
end

if(ny_limits_3==2)
     
     ys3=get(handles.edit_ymin_3,'String');
 
     if isempty(ys3)
        warndlg('Enter ymin','Warning');
        return;
     else
        ymin_3=str2num(ys3);
     end
     
     ys3=get(handles.edit_ymax_3,'String');
     if isempty(ys3)
        warndlg('Enter ymax','Warning');
        return;
     else
        ymax_3=str2num(ys3);
     end 
end

%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

hp=figure(n);

fsize=9+get(handles.listbox_fsize,'Value');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[xtt,xTT,iflag]=xtick_label(fmin,fmax);

if(iflag==1)
    for i=1:length(xtt)
        xtt(i)=log10(xtt(i));
    end
end

subplot(3,1,1);

n=length(THM1(:,1)); 
for i=2:n
    THM1(i,1)=THM1(i-1,1)*2^(1/3);
end

bar(log10(THM1(:,1)),THM1(:,2));
title(t_string_1);
ylabel(sylabel_1);


if(iflag==1)    
    set(gca,'xtick',xtt);
    set(gca,'XTickLabel',xTT);
    fmin=min(xtt);
    fmax=max(xtt);
    xlim([fmin,fmax]);    
end  


try
    dB=THM1(:,2);
    nn=length(dB);
catch
    warndlg('Error THM1 dB nn');
    return;
end
    
for i=nn:-1:1
    if(dB(i)==0)
        dB(i)=[];
    end
end

[ymin,ymax]=dB_ylimits(dB);
ylim([ymin,ymax])


if(ny_limits_1==2)
     ylim([ymin_1,ymax_1]);
end


    set(gca,'MinorGridLineStyle',':','GridLineStyle',':','XScale','lin',...
                     'YScale','lin','XminorTick','off','YminorTick','off');
 

%

grid off;
if(ng==1)   
    set(gca,'XGrid','on','GridLineStyle',':');
    set(gca,'YGrid','on','GridLineStyle',':');    
end


set(gca,'Fontsize',fsize);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%
subplot(3,1,2);

n=length(THM2(:,1)); 
for i=2:n
    THM2(i,1)=THM2(i-1,1)*2^(1/3);
end

bar(log10(THM2(:,1)),THM2(:,2));
title(t_string_2);
ylabel(sylabel_2);

if(iflag==1)
    set(gca,'xtick',xtt);
    set(gca,'XTickLabel',xTT);
    fmin=min(xtt);
    fmax=max(xtt);
    xlim([fmin,fmax]);    
end  

dB=THM2(:,2);

nn=length(dB);

for i=nn:-1:1
    if(dB(i)==0)
        dB(i)=[];
    end
end

[ymin,ymax]=dB_ylimits(dB);
ylim([ymin,ymax])


if(ny_limits_2==2)
     ylim([ymin_2,ymax_2]);
end

set(gca,'MinorGridLineStyle',':','GridLineStyle',':','XScale','lin',...
                     'YScale','lin','XminorTick','off','YminorTick','off');
%


grid off;
if(ng==1)   
    set(gca,'XGrid','on','GridLineStyle',':');
    set(gca,'YGrid','on','GridLineStyle',':');    
end


set(gca,'Fontsize',fsize);



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

subplot(3,1,3);

n=length(THM3(:,1)); 
for i=2:n
    THM3(i,1)=THM3(i-1,1)*2^(1/3);
end

bar(log10(THM3(:,1)),THM3(:,2));
grid on;
title(t_string_3);
ylabel(sylabel_3);

if(iflag==1)
    set(gca,'xtick',xtt);
    set(gca,'XTickLabel',xTT);
    fmin=min(xtt);
    fmax=max(xtt);
    xlim([fmin,fmax]);    
end  

dB=THM3(:,2);

[ymin,ymax]=dB_ylimits(dB);
ylim([ymin,ymax])

try

    if(ny_limits_3==2)
        ylim([ymin_3,ymax_3]);
    end

catch
end

set(gca,'MinorGridLineStyle',':','GridLineStyle',':','XScale','lin',...
                     'YScale','lin','XminorTick','off','YminorTick','off');
%
grid off;
if(ng==1)   
    set(gca,'XGrid','on','GridLineStyle',':');
    set(gca,'YGrid','on','GridLineStyle',':');    
end


set(gca,'Fontsize',fsize); 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%
xlabel(sxlabel);

%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%


% --- Executes on button press in pushbutton_return.
function pushbutton_return_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_return (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
delete(plot_one_third_octave_bar_subplots_3x1);


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



function edit_ylabel_3_Callback(hObject, eventdata, handles)
% hObject    handle to edit_ylabel_3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_ylabel_3 as text
%        str2double(get(hObject,'String')) returns contents of edit_ylabel_3 as a double


% --- Executes during object creation, after setting all properties.
function edit_ylabel_3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_ylabel_3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_yaxis_3.
function listbox_yaxis_3_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_yaxis_3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_yaxis_3 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_yaxis_3


% --- Executes during object creation, after setting all properties.
function listbox_yaxis_3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_yaxis_3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_yplotlimits_3.
function listbox_yplotlimits_3_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_yplotlimits_3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_yplotlimits_3 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_yplotlimits_3

n=get(handles.listbox_yplotlimits_3,'Value');

if(n==1)
    set(handles.edit_ymin_3,'Enable','off');
    set(handles.edit_ymax_3,'Enable','off');   
else
    set(handles.edit_ymin_3,'Enable','on');
    set(handles.edit_ymax_3,'Enable','on');  
end

% --- Executes during object creation, after setting all properties.
function listbox_yplotlimits_3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_yplotlimits_3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_ymin_3_Callback(hObject, eventdata, handles)
% hObject    handle to edit_ymin_3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_ymin_3 as text
%        str2double(get(hObject,'String')) returns contents of edit_ymin_3 as a double


% --- Executes during object creation, after setting all properties.
function edit_ymin_3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_ymin_3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_ymax_3_Callback(hObject, eventdata, handles)
% hObject    handle to edit_ymax_3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_ymax_3 as text
%        str2double(get(hObject,'String')) returns contents of edit_ymax_3 as a double


% --- Executes during object creation, after setting all properties.
function edit_ymax_3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_ymax_3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_title_2_Callback(hObject, eventdata, handles)
% hObject    handle to edit_title_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_title_2 as text
%        str2double(get(hObject,'String')) returns contents of edit_title_2 as a double


% --- Executes during object creation, after setting all properties.
function edit_title_2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_title_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_plot_files.
function listbox_plot_files_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_plot_files (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_plot_files contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_plot_files


% --- Executes during object creation, after setting all properties.
function listbox_plot_files_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_plot_files (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_title_3_Callback(hObject, eventdata, handles)
% hObject    handle to edit_title_3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_title_3 as text
%        str2double(get(hObject,'String')) returns contents of edit_title_3 as a double


% --- Executes during object creation, after setting all properties.
function edit_title_3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_title_3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_yaxis_2.
function listbox_yaxis_2_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_yaxis_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_yaxis_2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_yaxis_2


% --- Executes during object creation, after setting all properties.
function listbox_yaxis_2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_yaxis_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_yplotlimits_2.
function listbox_yplotlimits_2_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_yplotlimits_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_yplotlimits_2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_yplotlimits_2

n=get(handles.listbox_yplotlimits_2,'Value');

if(n==1)
    set(handles.edit_ymin_2,'Enable','off');
    set(handles.edit_ymax_2,'Enable','off');   
else
    set(handles.edit_ymin_2,'Enable','on');
    set(handles.edit_ymax_2,'Enable','on');  
end



% --- Executes during object creation, after setting all properties.
function listbox_yplotlimits_2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_yplotlimits_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_ylabel_2_Callback(hObject, eventdata, handles)
% hObject    handle to edit_ylabel_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_ylabel_2 as text
%        str2double(get(hObject,'String')) returns contents of edit_ylabel_2 as a double


% --- Executes during object creation, after setting all properties.
function edit_ylabel_2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_ylabel_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_ymax_2_Callback(hObject, eventdata, handles)
% hObject    handle to edit_ymax_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_ymax_2 as text
%        str2double(get(hObject,'String')) returns contents of edit_ymax_2 as a double


% --- Executes during object creation, after setting all properties.
function edit_ymax_2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_ymax_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_ymin_2_Callback(hObject, eventdata, handles)
% hObject    handle to edit_ymin_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_ymin_2 as text
%        str2double(get(hObject,'String')) returns contents of edit_ymin_2 as a double


% --- Executes during object creation, after setting all properties.
function edit_ymin_2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_ymin_2 (see GCBO)
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
    format=get(handles.listbox_format,'Value');
    PlotSave3x1.format=format;
end  

try
    xaxis=get(handles.listbox_xaxis,'Value');
    PlotSave3x1.xaxis=xaxis;
end  
try
    xplotlimits=get(handles.listbox_xplotlimits,'Value');
    xplotlimits.xplotlimits=xplotlimits;
end  
try
    grid=get(handles.listbox_grid,'Value');
    PlotSave3x1.grid=grid;
end  
try
    figure_number=get(handles.listbox_figure_number,'Value');
    PlotSave3x1.figure_number=figure_number;
end  

try
    yaxis_1=get(handles.listbox_yaxis_1,'Value');
    PlotSave3x1.yaxis_1=yaxis_1;
end
try
    yaxis_2=get(handles.listbox_yaxis_2,'Value');
    PlotSave3x1.yaxis_2=yaxis_2;
end  
try
    yaxis_3=get(handles.listbox_yaxis_3,'Value');
    PlotSave3x1.yaxis_3=yaxis_3;
end  
try
    yplotlimits_1=get(handles.listbox_yplotlimits_1,'Value');
    PlotSave3x1.yplotlimits_1=yplotlimits_1;
end
try
    yplotlimits_2=get(handles.listbox_yplotlimits_2,'Value');
    PlotSave3x1.yplotlimits_2=yplotlimits_2;
end
try
    yplotlimits_3=get(handles.listbox_yplotlimits_3,'Value');
    PlotSave3x1.yplotlimits_3=yplotlimits_3;
end


try
    ylabel_1=get(handles.edit_ylabel_1,'String');
    PlotSave3x1.ylabel_1=ylabel_1;
end
try
    ylabel_2=get(handles.edit_ylabel_2,'String');
    PlotSave3x1.ylabel_2=ylabel_2;
end
try
    ylabel_3=get(handles.edit_ylabel_3,'String');
    PlotSave3x1.ylabel_3=ylabel_3;
end

try
    ymin_1=get(handles.edit_ymin_1,'String');
    PlotSave3x1.ymin_1=ymin_1;
end
try
    ymin_2=get(handles.edit_ymin_2,'String');
    PlotSave3x1.ymin_2=ymin_2;
end
try
    ymin_3=get(handles.edit_ymin_3,'String');
    PlotSave3x1.ymin_3=ymin_3;
end

try
    ymax_1=get(handles.edit_ymax_1,'String');
    PlotSave3x1.ymax_1=ymax_1;
end
try
    ymax_2=get(handles.edit_ymax_2,'String');
    PlotSave3x1.ymax_2=ymax_2;
end
try
    ymax_3=get(handles.edit_ymax_3,'Value');
    PlotSave3x1.ymax_3=ymax_3;
end

try
    xlabel=get(handles.edit_xlabel,'String');
    PlotSave3x1.xlabel=xlabel;
end
try
    xmin=get(handles.edit_xmin,'String');
    PlotSave3x1.xmin=xmin;
end
try
    xmax=get(handles.edit_xmax,'String');
    PlotSave3x1.xmax=xmax;
end


% % %

try
    array_name=get(handles.uitable_array_name,'Data');
    PlotSave3x1.array_name=array_name;
    
    A=char(array_name);
    

    if(format==1)
        
        FS=A(1,:);
          
        try
            THM=evalin('base',FS);
        catch
            warndlg('THM error');
            return;
        end
        
        try
            PlotSave3x1.THM=THM;            
        catch
            warndlg('Input array not found ');
            return;
        end
        
    else
        
        FS1=A(1,:);
        FS2=A(2,:);    
        FS3=A(3,:);  
 
        try
            THM1=evalin('base',FS1);
            PlotSave3x1.THM1=THM1;  
        catch
            warndlg('Input array 1 not found ');
            return;
        end
    
        try
            THM2=evalin('base',FS2);
            PlotSave3x1.THM2=THM2;  
        catch
            warndlg('Input array 2 not found ');
            return;
        end
    
        try
            THM3=evalin('base',FS3);
            PlotSave3x1.THM3=THM3;              
        catch
            warndlg('Input array 3 not found ');
            return;
        end    
        
    end
    
end
try
    title=get(handles.uitable_title,'Data');
    PlotSave3x1.title=title;
end


% % %
 
structnames = fieldnames(PlotSave3x1, '-full'); % fields in the struct
 
% % %
 
   [writefname, writepname] = uiputfile('*.mat','Save data as');
 
   %%%    writepfname = fullfile(writepname, writefname);
    
%%%    pattern = '.mat';
%%%    replacement = '';
%%%    sname=regexprep(writefname,pattern,replacement);
   
    elk=sprintf('%s%s',writepname,writefname);
 
    try
 
        save(elk, 'PlotSave3x1'); 
 
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
 
   PlotSave3x1=evalin('base','PlotSave3x1');
 
catch
   warndlg(' evalin failed ');
   return;
end
 
% % % %
 
try
    format=PlotSave3x1.format;    
    set(handles.listbox_format,'Value',format);
    listbox_format_Callback(hObject, eventdata, handles);
end  


try
    xaxis=PlotSave3x1.xaxis; 
    set(handles.listbox_xaxis,'Value',xaxis);
end  
try
    xplotlimits.format=xplotlimits; 
    set(handles.listbox_xplotlimits,'Value',xplotlimits);
end  
try
    grid=PlotSave3x1.grid; 
    set(handles.listbox_grid,'Value',grid);
end  
try
    figure_number=PlotSave3x1.figure_number;    
    set(handles.listbox_figure_number,'Value',figure_number);
end  
 
try
    yaxis_1=PlotSave3x1.yaxis_1;    
    set(handles.listbox_yaxis_1,'Value',yaxis_1);
end
try
    yaxis_2=PlotSave3x1.yaxis_2;    
    set(handles.listbox_yaxis_2,'Value',yaxis_2);
end  
try
    yaxis_3=PlotSave3x1.yaxis_3;    
    set(handles.listbox_yaxis_3,'Value',yaxis_3);
end  
try
    yplotlimits_1=PlotSave3x1.yplotlimits_1;    
    set(handles.listbox_yplotlimits_1,'Value',yplotlimits_1);
end
try
    yplotlimits_2=PlotSave3x1.yplotlimits_2;    
    set(handles.listbox_yplotlimits_2,'Value',yplotlimits_2);
end
try
    yplotlimits_3=PlotSave3x1.yplotlimits_3;    
    set(handles.listbox_yplotlimits_3,'Value',yplotlimits_3);
end
 
 
try
    ylabel_1=PlotSave3x1.ylabel_1; 
    set(handles.edit_ylabel_1,'String',ylabel_1);
end
try
    ylabel_2=PlotSave3x1.ylabel_2;    
    set(handles.edit_ylabel_2,'String',ylabel_2);
end
try
    ylabel_3=PlotSave3x1.ylabel_3;    
    set(handles.edit_ylabel_3,'String',ylabel_3);
end
 
try
    ymin_1=PlotSave3x1.ymin_1;    
    set(handles.edit_ymin_1,'String',ymin_1);
end
try
    ymin_2=PlotSave3x1.ymin_2;    
    set(handles.edit_ymin_2,'String',ymin_2);
end
try
    ymin_3=PlotSave3x1.ymin_3;    
    set(handles.edit_ymin_3,'String',ymin_3);
end
 
try
    ymax_1=PlotSave3x1.ymax_1;    
    set(handles.edit_ymax_1,'String',ymax_1);
end
try
    ymax_2=PlotSave3x1.ymax_2;    
    set(handles.edit_ymax_2,'String',ymax_2);
end
try
    ymax_3=PlotSave3x1.ymax_3;    
    set(handles.edit_ymax_3,'String',ymax_3);
end
 
try
    xlabel=PlotSave3x1.xlabel;    
    set(handles.edit_xlabel,'String',xlabel);
end
try
    xmin=PlotSave3x1.xmin;    
    set(handles.edit_xmin,'String',xmin);
end
try
    xmax=PlotSave3x1.xmax;    
    set(handles.edit_xmax,'String',xmax);
end

try
    title=PlotSave3x1.title; 
    set(handles.uitable_title,'Data',title);
end
 
% % % % % %

try
    
    array_name=PlotSave3x1.array_name;    
    set(handles.uitable_array_name,'Data',array_name);

end

% % % % % %

try
    A=char(get(handles.uitable_array_name,'Data'));
catch    
end 



if(format==1)

    try
        THM=PlotSave3x1.THM;  
        FS=strtrim(A(1,:));
        assignin('base',FS,THM);
    catch    
    end

else

    try
        THM1=PlotSave3x1.THM1;  
        FS1=strtrim(A(1,:));
        assignin('base',FS1,THM1);
    catch    
    end
    try
        THM2=PlotSave3x1.THM2;  
        FS2=strtrim(A(2,:));    
        assignin('base',FS2,THM2);
    catch    
    end
    try
        THM3=PlotSave3x1.THM3;
        FS3=strtrim(A(3,:));        
        assignin('base',FS3,THM3);
    catch    
    end

end



% % % % % %

listbox_plot_files_Callback(hObject, eventdata, handles);

listbox_psave_Callback(hObject, eventdata, handles);


listbox_yplotlimits_1_Callback(hObject, eventdata, handles);
listbox_yplotlimits_2_Callback(hObject, eventdata, handles);
listbox_yplotlimits_3_Callback(hObject, eventdata, handles);

% % % % % % 



% --- Executes on selection change in listbox_format.
function listbox_format_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_format (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_format contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_format


nf=get(handles.listbox_format,'Value');

if(nf==1)
    Nrows=1;
else
    Nrows=3;
end
    
Ncolumns=1;

headers1={'Array Name'};
set(handles.uitable_array_name,'Data',cell(Nrows,Ncolumns),'ColumnName',headers1);





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

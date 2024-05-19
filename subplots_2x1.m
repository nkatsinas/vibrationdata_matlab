function varargout = subplots_2x1(varargin)
% SUBPLOTS_2X1 MATLAB code for subplots_2x1.fig
%      SUBPLOTS_2X1, by itself, creates a new SUBPLOTS_2X1 or raises the existing
%      singleton*.
%
%      H = SUBPLOTS_2X1 returns the handle to a new SUBPLOTS_2X1 or the handle to
%      the existing singleton*.
%
%      SUBPLOTS_2X1('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SUBPLOTS_2X1.M with the given input arguments.
%
%      SUBPLOTS_2X1('Property','Value',...) creates a new SUBPLOTS_2X1 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before subplots_2x1_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to subplots_2x1_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help subplots_2x1

% Last Modified by GUIDE v2.5 08-Nov-2019 13:47:04

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @subplots_2x1_OpeningFcn, ...
                   'gui_OutputFcn',  @subplots_2x1_OutputFcn, ...
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


% --- Executes just before subplots_2x1 is made visible.
function subplots_2x1_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to subplots_2x1 (see VARARGIN)

% Choose default command line output for subplots_2x1
handles.output = hObject;

listbox_format_Callback(hObject, eventdata, handles);

listbox_plot_files_Callback(hObject, eventdata, handles);

set(handles.listbox_psave,'Value',2);
set(handles.listbox_fsize,'Value',1);

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

% UIWAIT makes subplots_2x1 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = subplots_2x1_OutputFcn(hObject, eventdata, handles) 
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

nlayout=get(handles.listbox_layout,'Value');

nplot=get(handles.listbox_plot_files,'Value');

%
nx_type=get(handles.listbox_xaxis,'Value');
ny_type_1=get(handles.listbox_yaxis_1,'Value');
ny_type_2=get(handles.listbox_yaxis_2,'Value');

ng=get(handles.listbox_grid,'Value');
nx_limits=get(handles.listbox_xplotlimits,'Value');
ny_limits_1=get(handles.listbox_yplotlimits_1,'Value');
ny_limits_2=get(handles.listbox_yplotlimits_2,'Value');

%
n=get(handles.listbox_figure_number,'Value');
%

nf=get(handles.listbox_format,'Value');


if(nf==1)
     set(handles.listbox_fsize,'Visible','on');    try
        FS=get(handles.edit_c1_array_name,'String');
        THM=evalin('base',FS);
    catch
        warndlg('Array does not exist','Warning');
        return;
    end
    
    THM1=[THM(:,1) THM(:,2)];
    THM2=[THM(:,1) THM(:,3)];
    
else    
    try
        FS1=strtrim(get(handles.edit_c1_array_name,'String'));
        THM1=evalin('base',FS1);
    catch
        warndlg('Array 1 does not exist','Warning');
        return;
    end

    try
        FS2=strtrim(get(handles.edit_c2_array_name,'String'));
        THM2=evalin('base',FS2);
    catch
        warndlg('Array 2 does not exist','Warning');
        return;
    end
end


sxlabel=get(handles.edit_xlabel,'String');

sylabel_1=get(handles.edit_ylabel_1,'String');
sylabel_2=get(handles.edit_ylabel_2,'String');

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

%

psave=get(handles.listbox_psave,'Value');

t_string_1=get(handles.edit_title_1,'String');
t_string_2=get(handles.edit_title_2,'String');


t_string_1=strrep(t_string_1,'_',' ');
t_string_2=strrep(t_string_2,'_',' ');


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

hp=figure(n);

fsize=9+get(handles.listbox_fsize,'Value');

data1=THM1;
data2=THM2;

if(nlayout==1)
    subplot(1,2,1);
else
    subplot(2,1,1);    
end

plot(data1(:,1),data1(:,2));
grid on;


ylabel(sylabel_1);
title(t_string_1);
if(ny_limits_1==2)
     ylim([ymin_1,ymax_1]);
end

if(ny_type_1==2)
    if(ny_limits_1==1)
        try
            [ymin,ymax]=ytick_log(min(data1(:,2)),max(data1(:,2)));
            ylim([ymin,ymax]);
        catch
        end    
    end    
end 


if(nx_limits==2)  
    xlim([xmin,xmax]);
end 

if(nx_type==2)
     
    if(nx_limits==1)
        
        [xtt,xTT,iflag]=xtick_label(min(data1(:,1)),max(data1(:,1)));
        
        if(iflag==1)
            xmin=xtt(1);
            xmax=xtt(end);
            xlim([xmin,xmax]);
            set(gca,'xtick',xtt);
            set(gca,'XTickLabel',xTT);
        end    
    end
       
end

if(nlayout==1)
	xlabel(sxlabel);
end


%
grid off;
if(ng==1)
    grid on;   
end
%
if(nx_type==1 && ny_type_1==2)
    set(gca,'MinorGridLineStyle','none','GridLineStyle',':','XScale','lin','YScale','log');
end
if(nx_type==2 && ny_type_1==1)
    set(gca,'MinorGridLineStyle','none','GridLineStyle',':','XScale','log','YScale','lin');
end
if(nx_type==2 && ny_type_1==2)
    set(gca,'MinorGridLineStyle','none','GridLineStyle',':','XScale','log','YScale','log');
end

set(gca,'Fontsize',fsize);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%

if(nlayout==1)
    subplot(1,2,2);
else
    subplot(2,1,2);    
end
    
plot(data2(:,1),data2(:,2));
grid on;


title(t_string_2);
xlabel(sxlabel);
ylabel(sylabel_2);
if(ny_limits_2==2)
     ylim([ymin_2,ymax_2]);
end
if(ny_type_2==2)
    if(ny_limits_2==1)
        try
            [ymin,ymax]=ytick_log(min(data2(:,2)),max(data2(:,2)));
            ylim([ymin,ymax]);
        catch
        end    
    end    
end    

if(nx_limits==2)
    xlim([xmin,xmax]);
end    
if(nx_type==2)
    
    if(nx_limits==1)
        
        xmin=xtt(1);
        xmax=xtt(end);
        xlim([xmin,xmax]);        
        
        [xtt,xTT,iflag]=xtick_label(min(data2(:,1)),max(data2(:,1)));
        
        if(iflag==1)            
            set(gca,'xtick',xtt);
            set(gca,'XTickLabel',xTT);
        end    
        
    end
end

set(gca,'Fontsize',fsize);

%
xlabel(sxlabel);

%
grid off;
if(ng==1)
    grid on;   
end
%
if(nx_type==1 && ny_type_2==2)
    set(gca,'MinorGridLineStyle','none','GridLineStyle',':','XScale','lin','YScale','log');
end
if(nx_type==2 && ny_type_2==1)
    set(gca,'MinorGridLineStyle','none','GridLineStyle',':','XScale','log','YScale','lin');
end
if(nx_type==2 && ny_type_2==2)
    set(gca,'MinorGridLineStyle','none','GridLineStyle',':','XScale','log','YScale','log');
end
%


if(nlayout==1)
    set(hp, 'Position', [0 0 950 400]);
else
    set(hp, 'Position', [0 0 950 600]);
end
 



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(nplot==1)

    if(psave==1 || psave==2)
    
%%%%    % put twice
%%%%    if(nlegend==1)
%%%%        legend show;
%%%%    end  
    
        pname=get(handles.edit_png_name,'String'); 
    
        if(psave==1)
            print(hp,pname,'-dmeta','-r300');        
        else
            print(hp,pname,'-dpng','-r300');        
        end   
    
        out1=sprintf('Plot file: %s exported to hard drive',pname);
        msgbox(out1);
   
    end

end


pname='a.emf';
print(hp,pname,'-dmeta','-r300');  

pushbutton_save_file_Callback(hObject, eventdata, handles);

%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%


% --- Executes on button press in pushbutton_return.
function pushbutton_return_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_return (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
delete(subplots_2x1);


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

n=get(handles.listbox_plot_files,'Value');

set(handles.listbox_fsize,'Visible','on');
set(handles.text_font_size,'Visible','on');


if(n==1)
    set(handles.text_pfn,'Visible','on');
    set(handles.edit_png_name,'Visible','on');
    set(handles.text_format,'Visible','on');
    set(handles.listbox_psave,'Visible','on');     
else
    set(handles.text_pfn,'Visible','off');
    set(handles.edit_png_name,'Visible','off');  
    set(handles.text_format,'Visible','off');
    set(handles.listbox_psave,'Visible','off');       
end


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


% --- Executes on selection change in listbox_format.
function listbox_format_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_format (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_format contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_format

nf=get(handles.listbox_format,'Value');

if(nf==1)
    set(handles.edit_c2_array_name,'Visible','off');
    set(handles.text_2,'Visible','off');
    set(handles.text_1,'Visible','off');      
else
    set(handles.edit_c2_array_name,'Visible','on');
    set(handles.text_2,'Visible','on');  
    set(handles.text_1,'Visible','on');  
end



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


% --- Executes on button press in pushbutton_save_file.
function pushbutton_save_file_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_save_file (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% % %

try
    nlayout=get(handles.nlayout,'Value');
    PlotSave2x1.nlayout=nlayout;
catch    
end  


try
    format=get(handles.listbox_format,'Value');
    PlotSave2x1.format=format;
catch        
end  


try
    xaxis=get(handles.listbox_xaxis,'Value');
    PlotSave2x1.xaxis=xaxis;
catch        
end  
try
    xplotlimits=get(handles.listbox_xplotlimits,'Value');
    PlotSave2x1.xplotlimits=xplotlimits;
catch        
end  
try
    yaxis_1=get(handles.listbox_yaxis_1,'Value');
    PlotSave2x1.yaxis_1=yaxis_1;
catch        
end  
try
    yplotlimits_1=get(handles.listbox_yplotlimits_1,'Value');
    PlotSave2x1.yplotlimits_1=yplotlimits_1;
catch        
end  
try
    yaxis_2=get(handles.listbox_yaxis_2,'Value');
    PlotSave2x1.yaxis_2=yaxis_2;
catch        
end  
try
    yplotlimits_2=get(handles.listbox_yplotlimits_2,'Value');
    PlotSave2x1.yplotlimits_2=yplotlimits_2;
catch        
end  
try
    figure_number=get(handles.listbox_figure_number,'Value');
    PlotSave2x1.figure_number=figure_number;
catch        
end  
try
    grid=get(handles.listbox_grid,'Value');
    PlotSave2x1.grid=grid;
catch        
end  
try
    plot_files=get(handles.listbox_plot_files,'Value');
    PlotSave2x1.plot_files=plot_files;
catch        
end  
try
    psave=get(handles.listbox_psave,'Value');
    PlotSave2x1.psave=psave;
catch        
end  
try
    fsize=get(handles.listbox_fsize,'Value');
    PlotSave2x1.fsize=fsize;
catch        
end  

% % %

try
    title_1=get(handles.edit_title_1,'String');
    PlotSave2x1.title_1=title_1;
catch        
end
try
    title_2=get(handles.edit_title_2,'String');
    PlotSave2x1.title_2=title_2;
catch        
end



try
    xlabel=get(handles.edit_xlabel,'String');
    PlotSave2x1.fsize=xlabel;
catch        
end 
try
    ylabel_1=get(handles.edit_ylabel_1,'String');
    PlotSave2x1.ylabel_1=ylabel_1;
end 
try
    ylabel_2=get(handles.edit_ylabel_2,'String');
    PlotSave2x1.ylabel_2=ylabel_2;
catch        
end 

% % %

try
    xmin=get(handles.edit_xmin,'String');
    PlotSave2x1.xmin=xmin;
catch        
end 
try
    xmax=get(handles.edit_xmax,'String');
    PlotSave2x1.xmax=xmax;
catch        
end 
try
    ymin_1=get(handles.edit_ymin_1,'String');
    PlotSave2x1.ymin_1=ymin_1;
catch        
end 
try
    ymax_1=get(handles.edit_ymax_1,'String');
    PlotSave2x1.ymax_1=ymax_1;
catch        
end 
try
    ymin_2=get(handles.edit_ymin_2,'String');
    PlotSave2x1.ymin_2=ymin_2;
catch        
end 
try
    ymax_2=get(handles.edit_ymax_2,'String');
    PlotSave2x1.ymax_2=ymax_2;
catch        
end 
try
    png_name=get(handles.edit_png_name,'String');
    PlotSave2x1.png_name=png_name;
catch        
end 

% % %

try
    c1_array_name=get(handles.edit_c1_array_name,'String');
    PlotSave2x1.c1_array_name=c1_array_name;
            
    try
        THM1=evalin('base',c1_array_name);
        PlotSave2x1.THM1=THM1;
    catch
    end    
catch    
end 

try
    c2_array_name=get(handles.edit_c2_array_name,'String');
    PlotSave2x1.c2_array_name=c2_array_name;

    try
        THM2=evalin('base',c2_array_name);
        PlotSave2x1.THM2=THM2;
    catch
    end    
catch            
end 

% % %

structnames = fieldnames(PlotSave2x1, '-full'); % fields in the struct
 
% % %
 
%   [writefname, writepname] = uiputfile('*.mat','Save data as');
 
   %%%    writepfname = fullfile(writepname, writefname);
    
%%%    pattern = '.mat';
%%%    replacement = '';
%%%    sname=regexprep(writefname,pattern,replacement);
%   
%    elk=sprintf('%s%s',writepname,writefname);
% 
%    try
% 
%        save(elk, 'PlotSave2x1'); 
% 
%    catch
%        warndlg('Save error');
%        return;
%   end
 
try
   name=get(handles.edit_save_name,'String');
   name=strrep(name,' ','');
   set(handles.edit_save_name,'String',name);
   PlotSave2x1.name=name;  
   writefname=name;
catch
   warndlg('Enter plot output name');
   return;
end

if(isempty(name))
   warndlg('Enter plot output name');
   return;    
end

    name=strrep(name,'.mat','');
    name=strrep(name,'_plot','');
    name2=sprintf('%s_plot',name);
    name=sprintf('%s_plot.mat',name);
    
    
    kflag=0;
    
    try
        fid = fopen(name,'r');
        kflag=1;
        
        if(fid>0)
            out1=sprintf('%s   already exists.  Replace? ',name);
            choice = questdlg(out1,'Options','Yes','No','No');
        
% Handle response
 
            switch choice
                case 'Yes'                        
                    kflag=0; 
            end 
        end
        
    catch
    end
    
    if(fid==-1)
        kflag=0;
    end

    
%%%
    
    if(kflag==0)
        try
        save(name, 'PlotSave2x1'); 
        catch
            warndlg('Save error 2');
            return;
        end
    end    
    setappdata(0,'kflag',kflag);

    
%%%@@@@@

    disp('**ref b**');
    
  
    
    try
        filename = 'subplots_2x1_load_list.txt';
        THM=importdata(filename);
        
 %        THM
        

    catch
         THM=[];
         disp('no read 1');       
    end
    
   
   try
        [THM,nrows]=THM_save(THM,name2);

%    NTHM
        
        disp('**ref c**');
        
 
        fileID = fopen(filename,'w');

        for row = 1:nrows
            fprintf(fileID,'%s\n',char(THM{row,:}));
            char(THM{row,:})
        end
        fclose(fileID);
   catch
   end
    
%%%@@@@@
    
pflag=getappdata(0,'pflag');   

kflag=getappdata(0,'kflag');



    if(kflag==0)
        out1=sprintf(' Save Complete: %s \n Plot file saved as: a.emf ',name); 
    else
        out1=sprintf(' Plot file saved as: a.emf ');        
    end   

    
msgbox(out1);

%%%%%%%%%%%%%%%%%%%%





% --- Executes on button press in pushbutton_load_file.
function pushbutton_load_file_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_load_file (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


try
    
    [filename, pathname] = uigetfile('*.mat');

    setappdata(0,'filename',filename);
    setappdata(0,'pathname',pathname);
 
    load_core(hObject, eventdata, handles)

catch
end
    

function load_core(hObject, eventdata, handles)


disp('*** ref 1 ***');

setappdata(0,'pflag',0);

filename=strtrim(getappdata(0,'filename'))
% pathname=getappdata(0,'pathname')

try
%    NAME = [pathname,filename];
    NAME=filename;
    struct=load(NAME);
catch    
    NAME
    warndlg('load failed');
    return;
end


structnames = fieldnames(struct, '-full'); % fields in the struct
 
k=length(structnames);
 
 
for i=1:k
    namevar=strcat('struct.',structnames{i});
    value=eval(namevar);
    assignin('base',structnames{i},value);
end
 
% struct
 
try
 
   PlotSave2x1=evalin('base','PlotSave2x1');
 
catch
   warndlg(' evalin failed ');
   return;
end

% % % %

try
   name=PlotSave2x1.name;     
   name=strrep(name,' ','');
   set(handles.edit_save_name,'String',name);      
catch
end

try
    nlayout=PlotSave2x1.nlayout;    
    set(handles.nlayout,'Value',nlayout);
catch    
end

try
    format=PlotSave2x1.format;    
    set(handles.listbox_format,'Value',format);
catch        
end  


try
    xaxis=PlotSave2x1.xaxis;
    set(handles.listbox_xaxis,'Value',xaxis);
catch        
end  
try
    xplotlimits=PlotSave2x1.xplotlimits; 
    set(handles.listbox_xplotlimits,'xplotlimits');
catch        
end  
try
    yaxis_1=PlotSave2x1.yaxis_1;    
    set(handles.listbox_yaxis_1,'Value',yaxis_1);
catch        
end  
try
    yplotlimits_1=PlotSave2x1.yplotlimits_1;    
    set(handles.listbox_yplotlimits_1,'Value',yplotlimits_1);
catch        
end  
try
    yaxis_2=PlotSave2x1.yaxis_2;    
    set(handles.listbox_yaxis_2,'Value',yaxis_2);
catch        
end  
try
    yplotlimits_2=PlotSave2x1.yplotlimits_2; 
    set(handles.listbox_yplotlimits_2,'Value',yplotlimits_2);
catch        
end  
try
    figure_number=PlotSave2x1.figure_number; 
    set(handles.listbox_figure_number,'Value',figure_number);
catch        
end  
try
    grid=PlotSave2x1.grid;    
    set(handles.listbox_grid,'Value',grid);
catch        
end  
try
    plot_files=PlotSave2x1.plot_files;    
    set(handles.listbox_plot_files,'Value',plot_files);
catch        
end  
try
    psave=PlotSave2x1.psave;    
    set(handles.listbox_psave,'Value',psave);
catch        
end  
try
    fsize=PlotSave2x1.fsize;    
    set(handles.listbox_fsize,'Value',fsize);
catch        
end  
 
% % %
 
try
    title_1=PlotSave2x1.title_1;    
    set(handles.edit_title_1,'String',title_1);
catch        
end
try
    title_2=PlotSave2x1.title_2;    
    set(handles.edit_title_2,'String',title_2);
catch        
end



try
    xlabel=PlotSave2x1.fsize;    
    set(handles.edit_xlabel,'String',xlabel);
catch        
end 
try
    ylabel_1=PlotSave2x1.ylabel_1; 
    set(handles.edit_ylabel_1,'String',ylabel_1);
catch        
end 
try
    ylabel_2=PlotSave2x1.ylabel_2;    
    set(handles.edit_ylabel_2,'String',ylabel_2);
catch        
end 
 
% % %
 
try
    xmin=PlotSave2x1.xmin;    
    set(handles.edit_xmin,'String',xmin);
catch        
end 
try
    xmax=PlotSave2x1.xmax;    
    set(handles.edit_xmax,'String',xmax);
catch        
end 
try
    ymin_1=PlotSave2x1.ymin_1;    
    set(handles.edit_ymin_1,'String',ymin_1);
catch        
end 
try
    ymax_1=PlotSave2x1.ymax_1;    
    set(handles.edit_ymax_1,'String',ymax_1);
catch        
end 
try
    ymin_2=PlotSave2x1.ymin_2;    
    set(handles.edit_ymin_2,'String',ymin_2);
catch        
end 
try
    ymax_2=PlotSave2x1.ymax_2;    
    set(handles.edit_ymax_2,'String',ymax_2);
catch        
end 
try
    png_name=PlotSave2x1.png_name;    
    set(handles.edit_png_name,'String',png_name);
catch        
end 

% % % %

try
    c1_array_name=strtrim(PlotSave2x1.c1_array_name);
    set(handles.edit_c1_array_name,'String',c1_array_name);
 
    iflag=0;
    
    try
        temp=evalin('base',c1_array_name);
        ss=sprintf('Replace %s with Previously Saved Array',c1_array_name);
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
            THM1=PlotSave2x1.THM1;
            assignin('base',c1_array_name,THM1); 
        catch
        end
    end
    
catch    
end

 
% % % %

try
    c2_array_name=strtrim(PlotSave2x1.c2_array_name);
    set(handles.edit_c2_array_name,'String',c2_array_name);
 
    iflag=0;
    
    try
        temp=evalin('base',c2_array_name);
        ss=sprintf('Replace %s with Previously Saved Array',c2_array_name);
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
            THM2=PlotSave2x1.THM2;
            assignin('base',c2_array_name,THM2); 
        catch
        end
    end
    
catch    
end


% % % %

listbox_format_Callback(hObject, eventdata, handles);

listbox_plot_files_Callback(hObject, eventdata, handles);

listbox_psave_Callback(hObject, eventdata, handles);


% --- Executes on selection change in listbox_linewidth.
function listbox_linewidth_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_linewidth (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_linewidth contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_linewidth


% --- Executes during object creation, after setting all properties.
function listbox_linewidth_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_linewidth (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_layout.
function listbox_layout_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_layout (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_layout contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_layout


% --- Executes during object creation, after setting all properties.
function listbox_layout_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_layout (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton8.
function pushbutton8_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

subplots_2x1_load;

uiwait()

uiresume(subplots_2x1_load)

delete(subplots_2x1_load);
    
Lflag=getappdata(0,'Lflag');


if(Lflag==0)
    
    load_core(hObject, eventdata, handles);

    delete(subplots_2x1_load);

else
    delete(subplots_2x1_load);    
end


function edit_save_name_Callback(hObject, eventdata, handles)
% hObject    handle to edit_save_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_save_name as text
%        str2double(get(hObject,'String')) returns contents of edit_save_name as a double


% --- Executes during object creation, after setting all properties.
function edit_save_name_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_save_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function varargout = fds_subplots_2x2_two_curves_alt(varargin)
% FDS_SUBPLOTS_2X2_TWO_CURVES_ALT MATLAB code for fds_subplots_2x2_two_curves_alt.fig
%      FDS_SUBPLOTS_2X2_TWO_CURVES_ALT, by itself, creates a new FDS_SUBPLOTS_2X2_TWO_CURVES_ALT or raises the existing
%      singleton*.
%
%      H = FDS_SUBPLOTS_2X2_TWO_CURVES_ALT returns the handle to a new FDS_SUBPLOTS_2X2_TWO_CURVES_ALT or the handle to
%      the existing singleton*.
%
%      FDS_SUBPLOTS_2X2_TWO_CURVES_ALT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in FDS_SUBPLOTS_2X2_TWO_CURVES_ALT.M with the given input arguments.
%
%      FDS_SUBPLOTS_2X2_TWO_CURVES_ALT('Property','Value',...) creates a new FDS_SUBPLOTS_2X2_TWO_CURVES_ALT or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before fds_subplots_2x2_two_curves_alt_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to fds_subplots_2x2_two_curves_alt_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help fds_subplots_2x2_two_curves_alt

% Last Modified by GUIDE v2.5 26-May-2020 13:39:54

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @fds_subplots_2x2_two_curves_alt_OpeningFcn, ...
                   'gui_OutputFcn',  @fds_subplots_2x2_two_curves_alt_OutputFcn, ...
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


% --- Executes just before fds_subplots_2x2_two_curves_alt is made visible.
function fds_subplots_2x2_two_curves_alt_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to fds_subplots_2x2_two_curves_alt (see VARARGIN)

% Choose default command line output for fds_subplots_2x2_two_curves_alt
handles.output = hObject;

listbox_plot_files_Callback(hObject, eventdata, handles);

set(handles.listbox_psave,'Value',1);
set(handles.listbox_fontsize,'Value',1);

listbox_psave_Callback(hObject, eventdata, handles);

listbox_format_Callback(hObject, eventdata, handles);

listbox_yplotlimits_1_Callback(hObject, eventdata, handles);

Nrows=4;
Ncolumns=2;

headers1={'Title','b'};
set(handles.uitable_title,'Data',cell(Nrows,Ncolumns),'ColumnName',headers1);



% Update handles structure
guidata(hObject, handles);

% UIWAIT makes fds_subplots_2x2_two_curves_alt wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = fds_subplots_2x2_two_curves_alt_OutputFcn(hObject, eventdata, handles) 
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
    set(handles.uitable_ylim,'Visible','off');
else
    set(handles.uitable_ylim,'Visible','on');   
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


disp('  ');
disp(' * * * * * * ');
disp('  ');

Figures = findobj( 'Type', 'Figure' , '-not' , 'Tag' , get( handles.output , 'Tag' ) );
NFigures = length( Figures );
for nFigures = 1 : NFigures
  close( Figures( nFigures ) );
end


% nf=get(handles.listbox_format,'Value');

nf=2;

legend_1=get(handles.edit_legend_1,'String');
legend_2=get(handles.edit_legend_2,'String');

A=char(get(handles.uitable_array_name_1,'Data'));
B=char(get(handles.uitable_array_name_2,'Data'));

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
    THM4=[THM(:,1) THM(:,5)];
    
else
   
    FS11=A(1,:);
    FS12=A(2,:);    
    FS13=A(3,:);  
    FS14=A(4,:);  
    
    try
        THM11=evalin('base',FS11);
    catch
        warndlg('Input array 11 not found ');
        return;
    end
    
    try
        THM12=evalin('base',FS12);
    catch
        warndlg('Input array 12 not found ');
        return;
    end
    
    try
        THM13=evalin('base',FS13);
    catch
        warndlg('Input array 13 not found ');
        return;
    end    

    try
        THM14=evalin('base',FS14);
    catch
        warndlg('Input array 14 not found ');
        return;
    end    

%
    FS21=B(1,:);
    FS22=B(2,:);    
    FS23=B(3,:);  
    FS24=B(4,:);  
    
    try
        THM21=evalin('base',FS21);
    catch
        warndlg('Input array 21 not found ');
        return;
    end
    
    try
        THM22=evalin('base',FS22);
    catch
        warndlg('Input array 22 not found ');
        return;
    end
    
    try
        THM23=evalin('base',FS23);
    catch
        warndlg('Input array 23 not found ');
        return;
    end    

    try
        THM24=evalin('base',FS24);
    catch
        warndlg('Input array 34 not found ');
        return;
    end    
    
    THM11(:,2)=log10(THM11(:,2));
    THM12(:,2)=log10(THM12(:,2));
    THM13(:,2)=log10(THM13(:,2));
    THM14(:,2)=log10(THM14(:,2));    
    
    THM21(:,2)=log10(THM21(:,2));
    THM22(:,2)=log10(THM22(:,2));
    THM23(:,2)=log10(THM23(:,2));
    THM24(:,2)=log10(THM24(:,2));     
    
end

C=char(get(handles.uitable_title,'Data'));

t_string_1=C(1,:);
t_string_2=C(2,:);
t_string_3=C(3,:);
t_string_4=C(4,:);

t_string_1=strrep(t_string_1,'_',' ');
t_string_2=strrep(t_string_2,'_',' ');
t_string_3=strrep(t_string_3,'_',' ');
t_string_4=strrep(t_string_4,'_',' ');

dB_title=get(handles.edit_dB_title,'String');

t_string_1d=sprintf('%s Ratio %s',t_string_1,dB_title);
t_string_2d=sprintf('%s Ratio %s',t_string_2,dB_title);
t_string_3d=sprintf('%s Ratio %s',t_string_3,dB_title);
t_string_4d=sprintf('%s Ratio %s',t_string_4,dB_title);


b1=str2double(C(5,:));
b2=str2double(C(6,:));
b3=str2double(C(7,:));
b4=str2double(C(8,:));


sylabel_1=sprintf('Damage log10(G^%g)',b1);
sylabel_2=sprintf('Damage log10(G^%g)',b2);
sylabel_3=sprintf('Damage log10(G^%g)',b3);
sylabel_4=sprintf('Damage log10(G^%g)',b4);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
nx_type=get(handles.listbox_xaxis,'Value');
ny_type=get(handles.listbox_yaxis,'Value');

ng=get(handles.listbox_grid,'Value');

nx_limits=get(handles.listbox_xplotlimits,'Value');

ny_limits=get(handles.listbox_yplotlimits_1,'Value');

if(ny_limits==2)

    C=char(get(handles.uitable_ylim,'Data'));

    ymin_1=str2num(C(1,:));
    ymin_2=str2num(C(2,:));
    ymin_3=str2num(C(3,:));
    ymin_4=str2num(C(4,:));

    ymax_1=str2num(C(5,:));
    ymax_2=str2num(C(6,:));
    ymax_3=str2num(C(7,:));
    ymax_4=str2num(C(8,:));

end

%
n=get(handles.listbox_figure_number,'Value');
%

sxlabel=get(handles.edit_xlabel,'String');


xmin=min([ THM11(1,1)  THM21(1,1)]);
xmax=max([ THM11(end,1)   THM21(end,1)]);

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
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

hp=figure(n);

nfont=get(handles.listbox_fontsize,'Value');


fsize=9+nfont;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

sylabel_1=strtrim(sylabel_1);
sylabel_2=strtrim(sylabel_2);
sylabel_3=strtrim(sylabel_3);
sylabel_4=strtrim(sylabel_4);


subplot(2,2,1);
plot(THM11(:,1),THM11(:,2),THM21(:,1),THM21(:,2));
legend(legend_1,legend_2,'location','northwest');
grid on;
ylabel(sylabel_1);
title(t_string_1);
if(ny_limits==2)
     ylim([ymin_1,ymax_1]);
else
    ymax=max([ max(THM11(:,2))  max(THM21(:,2))]);
    ymin=min([ min(THM11(:,2))  min(THM21(:,2))]);

    [ytt,yTT]=ytick_linear_min_max_alt(1.1*ymax,ymin);
    set(gca,'ytick',ytt);
    set(gca,'YTickLabel',yTT);
    ylim([min(ytt),max(ytt)]);
end

xlim([xmin,xmax]);

if(nx_type==2)
        
        [xtt,xTT,iflag]=xtick_label(xmin,xmax);
        
        if(iflag==1)
            set(gca,'xtick',xtt);
            set(gca,'XTickLabel',xTT);
        end    
end

if(nx_type==1 && ny_type==2)
    set(gca,'MinorGridLineStyle','none','GridLineStyle',':','XScale','lin','YScale','log');
end
if(nx_type==2 && ny_type==1)
    set(gca,'MinorGridLineStyle',':','GridLineStyle','-','XScale','log','YScale','lin');
end
if(nx_type==2 && ny_type==2)
    set(gca,'MinorGridLineStyle','none','GridLineStyle',':','XScale','log','YScale','log');
end

set(gca,'Fontsize',fsize);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%
subplot(2,2,2);
plot(THM12(:,1),THM12(:,2),THM22(:,1),THM22(:,2));
legend(legend_1,legend_2,'location','northwest');
grid on;
title(t_string_2);
ylabel(sylabel_2);

if(ny_limits==2)
     ylim([ymin_2,ymax_2]);
else
    ymax=max([ max(THM12(:,2))  max(THM22(:,2))]);
    ymin=min([ min(THM12(:,2))  min(THM22(:,2))]);

    [ytt,yTT]=ytick_linear_min_max_alt(1.1*ymax,ymin);
    set(gca,'ytick',ytt);
    set(gca,'YTickLabel',yTT);
    ylim([min(ytt),max(ytt)]);
end

xlim([xmin,xmax]);

if(nx_type==2)
        
        [xtt,xTT,iflag]=xtick_label(xmin,xmax);
        
        if(iflag==1)
            set(gca,'xtick',xtt);
            set(gca,'XTickLabel',xTT);
        end    
end


if(nx_type==1 && ny_type==2)
    set(gca,'MinorGridLineStyle','none','GridLineStyle',':','XScale','lin','YScale','log');
end
if(nx_type==2 && ny_type==1)
    set(gca,'MinorGridLineStyle',':','GridLineStyle','-','XScale','log','YScale','lin');
end
if(nx_type==2 && ny_type==2)
    set(gca,'MinorGridLineStyle','none','GridLineStyle',':','XScale','log','YScale','log');
end

set(gca,'Fontsize',fsize);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

subplot(2,2,3);
plot(THM13(:,1),THM13(:,2),THM23(:,1),THM23(:,2));
legend(legend_1,legend_2,'location','northwest');
grid on;
title(t_string_3);
xlabel(sxlabel);
ylabel(sylabel_3);

if(ny_limits==2)
     ylim([ymin_3,ymax_3]);
else
    ymax=max([ max(THM13(:,2))  max(THM23(:,2))]);
    ymin=min([ min(THM13(:,2))  min(THM23(:,2))]);

    [ytt,yTT]=ytick_linear_min_max_alt(1.1*ymax,ymin);
    set(gca,'ytick',ytt);
    set(gca,'YTickLabel',yTT);
    ylim([min(ytt),max(ytt)]);
end

xlim([xmin,xmax]);

if(nx_type==2)
        
        [xtt,xTT,iflag]=xtick_label(xmin,xmax);
        
        if(iflag==1)
            set(gca,'xtick',xtt);
            set(gca,'XTickLabel',xTT);
        end    
end

if(nx_type==1 && ny_type==2)
    set(gca,'MinorGridLineStyle','none','GridLineStyle',':','XScale','lin','YScale','log');
end
if(nx_type==2 && ny_type==1)
    set(gca,'MinorGridLineStyle',':','GridLineStyle','-','XScale','log','YScale','lin');
end
if(nx_type==2 && ny_type==2)
    set(gca,'MinorGridLineStyle','none','GridLineStyle',':','XScale','log','YScale','log');
end

set(gca,'Fontsize',fsize);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

subplot(2,2,4);
plot(THM14(:,1),THM14(:,2),THM24(:,1),THM24(:,2));
legend(legend_1,legend_2,'location','northwest');
grid on;
title(t_string_4);
xlabel(sxlabel);
ylabel(sylabel_4);

if(ny_limits==2)
     ylim([ymin_4,ymax_4]);
else
    ymax=max([ max(THM14(:,2))  max(THM24(:,2))]);
    ymin=min([ min(THM14(:,2))  min(THM24(:,2))]);

    [ytt,yTT]=ytick_linear_min_max_alt(1.1*ymax,ymin);
    set(gca,'ytick',ytt);
    set(gca,'YTickLabel',yTT);
    ylim([min(ytt),max(ytt)]);
end

xlim([xmin,xmax]);

if(nx_type==2)
        
        [xtt,xTT,iflag]=xtick_label(xmin,xmax);
        
        if(iflag==1)
            set(gca,'xtick',xtt);
            set(gca,'XTickLabel',xTT);
        end    
end

set(gca,'Fontsize',fsize);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%
xlabel(sxlabel);

%
grid off;
if(ng==1)
    grid on;   
end
%
if(nx_type==1 && ny_type==2)
    set(gca,'MinorGridLineStyle','none','GridLineStyle',':','XScale','lin','YScale','log');
end
if(nx_type==2 && ny_type==1)
    set(gca,'MinorGridLineStyle',':','GridLineStyle','-','XScale','log','YScale','lin');
end
if(nx_type==2 && ny_type==2)
    set(gca,'MinorGridLineStyle','none','GridLineStyle',':','XScale','log','YScale','log');
end
%
 
set(hp, 'Position', [0 0 900 700]);


%% pname='a.emf';
%% print(hp,pname,'-dmeta','-r300'); 

%% msgbox('Plot file:  a.emf');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

disp('ref 1');

max_dB=str2double(get(handles.edit_max_dB,'String'));
min_dB=str2double(get(handles.edit_min_dB,'String'));

num=length(THM11(:,1));

hp=figure(n+1);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

subplot(2,4,1);
plot(THM11(:,1),THM11(:,2),THM21(:,1),THM21(:,2));


diff1=zeros(num,2);
diff1(:,1)=THM11(:,1);


for i=1:num
    
%%    fr=abs( (THM11(i,1)-THM21(i,1))/THM21(i,1));
%%    if(fr>0.02)
%%        warndlg('Frequency synch error 1');
%%        return;
%%    end
    
    ff=THM11(i,1);
    [~,ii]=min(abs(ff-THM21(:,1)));
    r=10^(THM11(i,2)-THM21(ii,2));
    diff1(i,2)=20*log10(r)/b1;
end




legend(legend_1,legend_2,'location','northwest');
grid on;
ylabel(sylabel_1);
title(t_string_1);
xlabel(sxlabel);
if(ny_limits==2)
     ylim([ymin_1,ymax_1]);
else
    ymax=max([ max(THM11(:,2))  max(THM21(:,2))]);
    ymin=min([ min(THM11(:,2))  min(THM21(:,2))]);

    [ytt,yTT]=ytick_linear_min_max_alt(1.1*ymax,ymin);
    set(gca,'ytick',ytt);
    set(gca,'YTickLabel',yTT);
    ylim([min(ytt),max(ytt)]);
end

xlim([xmin,xmax]);

if(nx_type==2)
        
        [xtt,xTT,iflag]=xtick_label(xmin,xmax);
        
        if(iflag==1)
            set(gca,'xtick',xtt);
            set(gca,'XTickLabel',xTT);
        end    
end

if(nx_type==1 && ny_type==2)
    set(gca,'MinorGridLineStyle','none','GridLineStyle',':','XScale','lin','YScale','log');
end
if(nx_type==2 && ny_type==1)
    set(gca,'MinorGridLineStyle',':','GridLineStyle','-','XScale','log','YScale','lin');
end
if(nx_type==2 && ny_type==2)
    set(gca,'MinorGridLineStyle','none','GridLineStyle',':','XScale','log','YScale','log');
end

set(gca,'Fontsize',fsize);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%
subplot(2,4,2);
plot(THM12(:,1),THM12(:,2),THM22(:,1),THM22(:,2));


diff2=zeros(num,2);
diff2(:,1)=THM11(:,1);

for i=1:num
    
%%    fr=abs( (THM12(i,1)-THM22(i,1))/THM22(i,1));
%%    if(fr>0.02)
%%        warndlg('Frequency synch error 2');
%%        return;
%%    end    
   
    ff=THM12(i,1);
    [~,ii]=min(abs(ff-THM22(:,1)));
    r=10^(THM12(i,2)-THM22(ii,2));
    
    diff2(i,2)=20*log10(r)/b2;
end

legend(legend_1,legend_2,'location','northwest');
grid on;
title(t_string_2);
xlabel(sxlabel);
ylabel(sylabel_2);

if(ny_limits==2)
     ylim([ymin_2,ymax_2]);
else
    ymax=max([ max(THM12(:,2))  max(THM22(:,2))]);
    ymin=min([ min(THM12(:,2))  min(THM22(:,2))]);

    [ytt,yTT]=ytick_linear_min_max_alt(1.1*ymax,ymin);
    set(gca,'ytick',ytt);
    set(gca,'YTickLabel',yTT);
    ylim([min(ytt),max(ytt)]);
end

xlim([xmin,xmax]);

if(nx_type==2)
        
        [xtt,xTT,iflag]=xtick_label(xmin,xmax);
        
        if(iflag==1)
            set(gca,'xtick',xtt);
            set(gca,'XTickLabel',xTT);
        end    
end


if(nx_type==1 && ny_type==2)
    set(gca,'MinorGridLineStyle','none','GridLineStyle',':','XScale','lin','YScale','log');
end
if(nx_type==2 && ny_type==1)
    set(gca,'MinorGridLineStyle',':','GridLineStyle','-','XScale','log','YScale','lin');
end
if(nx_type==2 && ny_type==2)
    set(gca,'MinorGridLineStyle','none','GridLineStyle',':','XScale','log','YScale','log');
end

set(gca,'Fontsize',fsize);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

subplot(2,4,3);
plot(THM13(:,1),THM13(:,2),THM23(:,1),THM23(:,2));

diff3=zeros(num,2);
diff3(:,1)=THM11(:,1);

for i=1:num
    
%%    fr=abs( (THM13(i,1)-THM23(i,1))/THM23(i,1));
%%    if(fr>0.02)
%%        warndlg('Frequency synch error 3');
%%        return;
%%    end       
  
    ff=THM13(i,1);
    [~,ii]=min(abs(ff-THM23(:,1)));
    r=10^(THM13(i,2)-THM23(ii,2));
    diff3(i,2)=20*log10(r)/b3;
end

legend(legend_1,legend_2,'location','northwest');
grid on;
title(t_string_3);
xlabel(sxlabel);
ylabel(sylabel_3);

if(ny_limits==2)
     ylim([ymin_3,ymax_3]);
else
    ymax=max([ max(THM13(:,2))  max(THM23(:,2))]);
    ymin=min([ min(THM13(:,2))  min(THM23(:,2))]);

    [ytt,yTT]=ytick_linear_min_max_alt(1.1*ymax,ymin);
    set(gca,'ytick',ytt);
    set(gca,'YTickLabel',yTT);
    ylim([min(ytt),max(ytt)]);
end

xlim([xmin,xmax]);

if(nx_type==2)
        
        [xtt,xTT,iflag]=xtick_label(xmin,xmax);
        
        if(iflag==1)
            set(gca,'xtick',xtt);
            set(gca,'XTickLabel',xTT);
        end    
end

set(gca,'MinorGridLineStyle',':','GridLineStyle','-','XScale','log','YScale','lin');

set(gca,'Fontsize',fsize);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

subplot(2,4,4);
plot(THM14(:,1),THM14(:,2),THM24(:,1),THM24(:,2));

diff4=zeros(num,2);
diff4(:,1)=THM11(:,1);

for i=1:num
    
%%    fr=abs( (THM14(i,1)-THM24(i,1))/THM24(i,1));
%%    if(fr>0.02)
%%        warndlg('Frequency synch error 4');
%%        return;
%%    end       
  
    ff=THM14(i,1);
    [~,ii]=min(abs(ff-THM24(:,1)));

    r=10^(THM14(i,2)-THM24(ii,2));
    diff4(i,2)=20*log10(r)/b4;
end

legend(legend_1,legend_2,'location','northwest');
grid on;
title(t_string_4);
xlabel(sxlabel);
ylabel(sylabel_4);

if(ny_limits==2)
     ylim([ymin_4,ymax_4]);
else
    ymax=max([ max(THM14(:,2))  max(THM24(:,2))]);
    ymin=min([ min(THM14(:,2))  min(THM24(:,2))]);

    [ytt,yTT]=ytick_linear_min_max_alt(1.1*ymax,ymin);
    set(gca,'ytick',ytt);
    set(gca,'YTickLabel',yTT);
    ylim([min(ytt),max(ytt)]);
end

xlim([xmin,xmax]);

if(nx_type==2)
        
        [xtt,xTT,iflag]=xtick_label(xmin,xmax);
        
        if(iflag==1)
            set(gca,'xtick',xtt);
            set(gca,'XTickLabel',xTT);
        end    
end

set(gca,'Fontsize',fsize);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%
xlabel(sxlabel);

%
grid off;
if(ng==1)
    grid on;   
end
%
if(nx_type==1 && ny_type==2)
    set(gca,'MinorGridLineStyle','none','GridLineStyle',':','XScale','lin','YScale','log');
end
if(nx_type==2 && ny_type==1)
    set(gca,'MinorGridLineStyle',':','GridLineStyle','-','XScale','log','YScale','lin');
end
if(nx_type==2 && ny_type==2)
    set(gca,'MinorGridLineStyle','none','GridLineStyle',':','XScale','log','YScale','log');
end
%
 
set(hp, 'Position', [0 0 1800 700]);

%%%
%%%
%%%

subplot(2,4,5);
plot(diff1(:,1),diff1(:,2));
title(t_string_1d);
xlabel(sxlabel);
ylabel('Difference (dB)');
ylim([min_dB,max_dB]);
xlim([xmin,xmax]);

if(nx_type==2)
        
        [xtt,xTT,iflag]=xtick_label(xmin,xmax);
        
        if(iflag==1)
            set(gca,'xtick',xtt);
            set(gca,'XTickLabel',xTT);
        end    
end

grid on;
set(gca,'MinorGridLineStyle',':','GridLineStyle','-','XScale','log','YScale','lin','YMinorTick','on')
grid minor;

subplot(2,4,6);
plot(diff2(:,1),diff2(:,2));
title(t_string_2d);
xlabel(sxlabel);
ylabel('Difference (dB)');
ylim([min_dB,max_dB]);
xlim([xmin,xmax]);

if(nx_type==2)
        
        [xtt,xTT,iflag]=xtick_label(xmin,xmax);
        
        if(iflag==1)
            set(gca,'xtick',xtt);
            set(gca,'XTickLabel',xTT);
        end    
end
grid on;
set(gca,'MinorGridLineStyle',':','GridLineStyle','-','XScale','log','YScale','lin');
grid minor

subplot(2,4,7);
plot(diff3(:,1),diff3(:,2));
title(t_string_3d);
xlabel(sxlabel);
ylabel('Difference (dB)');
ylim([min_dB,max_dB]);
xlim([xmin,xmax]);

if(nx_type==2)
        
        [xtt,xTT,iflag]=xtick_label(xmin,xmax);
        
        if(iflag==1)
            set(gca,'xtick',xtt);
            set(gca,'XTickLabel',xTT);
        end    
end
grid on;
set(gca,'MinorGridLineStyle',':','GridLineStyle','-','XScale','log','YScale','lin');
grid minor;

subplot(2,4,8);
plot(diff4(:,1),diff4(:,2));
title(t_string_4d);
xlabel(sxlabel);
ylabel('Difference (dB)');
ylim([min_dB,max_dB]);
xlim([xmin,xmax]);

if(nx_type==2)
        
        [xtt,xTT,iflag]=xtick_label(xmin,xmax);
        
        if(iflag==1)
            set(gca,'xtick',xtt);
            set(gca,'XTickLabel',xTT);
        end    
end
grid on;
set(gca,'MinorGridLineStyle',':','GridLineStyle','-','XScale','log','YScale','lin');
grid minor;

disp(' ');
disp(' min dB ');
disp(' ');
out1=sprintf('%8.4g',min(diff1(:,2)));
out2=sprintf('%8.4g',min(diff2(:,2)));
out3=sprintf('%8.4g',min(diff3(:,2)));
out4=sprintf('%8.4g',min(diff4(:,2)));

disp(out1);
disp(out2);
disp(out3);
disp(out4);

disp('ref 2');


d1=sprintf('%s_dB',A(1,:));
d2=sprintf('%s_dB',A(2,:));
d3=sprintf('%s_dB',A(3,:));
d4=sprintf('%s_dB',A(4,:));

d1(d1 == ' ') = [];
d2(d2 == ' ') = [];
d3(d3 == ' ') = [];
d4(d4 == ' ') = [];

assignin('base', d1, diff1);
assignin('base', d2, diff2);
assignin('base', d3, diff3);
assignin('base', d4, diff4);

disp(' ');
disp('Output arrays: ');
disp(d1);
disp(d2);
disp(d3);
disp(d4);



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% --- Executes on button press in pushbutton_return.
function pushbutton_return_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_return (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
delete(fds_subplots_2x2_two_curves_alt);


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


% --- Executes on selection change in listbox_fontsize.
function listbox_fontsize_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_fontsize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_fontsize contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_fontsize


% --- Executes during object creation, after setting all properties.
function listbox_fontsize_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_fontsize (see GCBO)
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
    legend_1=get(handles.edit_legend_1,'String');
    PlotSave2x2.edit_legend_1=legend_1;
end
try
    legend_2=get(handles.edit_legend_2,'String');
    PlotSave2x2.edit_legend_2=legend_2;
end

try
    format=get(handles.listbox_format,'Value');
    PlotSave2x2.format=format;
end  

try
    xaxis=get(handles.listbox_xaxis,'Value');
    PlotSave2x2.xaxis=xaxis;
end  
try
    xplotlimits=get(handles.listbox_xplotlimits,'Value');
    xplotlimits.xplotlimits=xplotlimits;
end  
try
    grid=get(handles.listbox_grid,'Value');
    PlotSave2x2.grid=grid;
end  
try
    figure_number=get(handles.listbox_figure_number,'Value');
    PlotSave2x2.figure_number=figure_number;
end  

try
    yaxis=get(handles.listbox_yaxis,'Value');
    PlotSave2x2.yaxis=yaxis;
end
try
    yplotlimits=get(handles.listbox_yplotlimits_1,'Value');
    PlotSave2x2.yplotlimits_1=yplotlimits;
end

try
    xlabel=get(handles.edit_xlabel,'String');
    PlotSave2x2.xlabel=xlabel;
end

try
    xmin=get(handles.edit_xmin,'String');
    PlotSave2x2.xmin=xmin;
end
try
    xmax=get(handles.edit_xmax,'String');
    PlotSave2x2.xmax=xmax;
end


% % %

try
    array_name_1=get(handles.uitable_array_name_1,'Data');
    PlotSave2x2.array_name_1=array_name_1;
    
    A=char(array_name_1);
    

    if(format==1)
        
        FS=A(1,:);
          
        try
            THM1=evalin('base',FS);
        catch
            warndlg('THM error');
            return;
        end
        
        try
            PlotSave2x2.THM1=THM1;            
        catch
            warndlg('Input array not found ');
            return;
        end
        
    else
        
        FS11=A(1,:);
        FS12=A(2,:);    
        FS13=A(3,:);  
        FS14=A(4,:);  

        try
            THM11=evalin('base',FS11);
            PlotSave2x2.THM11=THM11;  
        catch
            warndlg('Input array 1 not found ');
            return;
        end
    
        try
            THM12=evalin('base',FS12);
            PlotSave2x2.THM12=THM12;  
        catch
            warndlg('Input array 2 not found ');
            return;
        end
    
        try
            THM13=evalin('base',FS13);
            PlotSave2x2.THM13=THM13;              
        catch
            warndlg('Input array 3 not found ');
            return;
        end    
    
        try
            THM14=evalin('base',FS14);
            PlotSave2x2.THM14=THM14;              
        catch
            warndlg('Input array 4 not found ');
            return;
        end   

    end
    
end

% % %

try
    array_name_2=get(handles.uitable_array_name_2,'Data');
    PlotSave2x2.array_name_2=array_name_2;
    
    A=char(array_name_2);
    

    if(format==1)
        
        FS=A(1,:);
          
        try
            THM2=evalin('base',FS);
        catch
            warndlg('THM error');
            return;
        end
        
        try
            PlotSave2x2.THM2=THM2;            
        catch
            warndlg('Input array not found ');
            return;
        end
        
    else
        
        FS21=A(1,:);
        FS22=A(2,:);    
        FS23=A(3,:);  
        FS24=A(4,:);  

        try
            THM21=evalin('base',FS21);
            PlotSave2x2.THM21=THM21;  
        catch
            warndlg('Input array 1 not found ');
            return;
        end
    
        try
            THM22=evalin('base',FS22);
            PlotSave2x2.THM22=THM22;  
        catch
            warndlg('Input array 2 not found ');
            return;
        end
    
        try
            THM23=evalin('base',FS23);
            PlotSave2x2.THM23=THM23;              
        catch
            warndlg('Input array 3 not found ');
            return;
        end    
    
        try
            THM24=evalin('base',FS24);
            PlotSave2x2.THM24=THM24;              
        catch
            warndlg('Input array 4 not found ');
            return;
        end   

    end
    
end

% % %

try
    title=get(handles.uitable_title,'Data');
    PlotSave2x2.title=title;
catch
end
try
    ylim=get(handles.uitable_ylim,'Data');
    PlotSave2x2.ylim=ylim;
catch
end

% % %



% % %
 
structnames = fieldnames(PlotSave2x2, '-full'); % fields in the struct
 
% % %
 
   [writefname, writepname] = uiputfile('*.mat','Save data as');
 
   %%%    writepfname = fullfile(writepname, writefname);
    
%%%    pattern = '.mat';
%%%    replacement = '';
%%%    sname=regexprep(writefname,pattern,replacement);
   
    elk=sprintf('%s%s',writepname,writefname);
 
    try
 
        save(elk, 'PlotSave2x2'); 
 
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
 
   PlotSave2x2=evalin('base','PlotSave2x2');
 
catch
   warndlg(' evalin failed ');
   return;
end
 
% % % %
 
try
    format=PlotSave2x2.format;    
    set(handles.listbox_format,'Value',format);
    listbox_format_Callback(hObject, eventdata, handles);
catch    
end  


try
    xaxis=PlotSave2x2.xaxis; 
    set(handles.listbox_xaxis,'Value',xaxis);
catch    
end  
try
    xplotlimits=xplotlimits.format; 
    set(handles.listbox_xplotlimits,'Value',xplotlimits);
catch    
end  
try
    grid=PlotSave2x2.grid; 
    set(handles.listbox_grid,'Value',grid);
catch    
end  
try
    figure_number=PlotSave2x2.figure_number;    
    set(handles.listbox_figure_number,'Value',figure_number);
catch
end  
 

try
    xmin=PlotSave2x2.xmin;    
    set(handles.edit_xmin,'String',xmin);
catch    
end
try
    xmax=PlotSave2x2.xmax;    
    set(handles.edit_xmax,'String',xmax);
catch
end


try
    xlabel=PlotSave2x2.xlabel;
    set(handles.edit_xlabel,'String',xlabel);
catch
end


try
    yaxis=PlotSave2x2.yaxis;
    set(handles.listbox_yaxis,'Value',yaxis);
catch    
end
try
    yplotlimits=PlotSave2x2.yplotlimits_1;
    set(handles.listbox_yplotlimits_1,'Value',yplotlimits);
catch    
end

% % % % % %

try
    title=PlotSave2x2.title;
    set(handles.uitable_title,'Data',title);
catch
end

% % % % % %

try
% historical    
    
    array_name_1=PlotSave2x2.array_name;    
    set(handles.uitable_array_name_1,'Data',array_name_1);
catch
end

try
    
    array_name_1=PlotSave2x2.array_name_1;    
    set(handles.uitable_array_name_1,'Data',array_name_1);
catch
end

try
    
    array_name_2=PlotSave2x2.array_name_2;    
    set(handles.uitable_array_name_2,'Data',array_name_2);
catch
end

% % % % % %

try
    ylim=PlotSave2x2.ylim;
    set(handles.uitable_ylim,'Data',ylim);
catch
end

% % % % % % 

try
    legend_1=PlotSave2x2.edit_legend_1;    
    set(handles.edit_legend_1,'String',legend_1);
catch    
end
try
    legend_2=PlotSave2x2.edit_legend_2;    
    set(handles.edit_legend_2,'String',legend_2);
catch
end

% % % % % %

listbox_plot_files_Callback(hObject, eventdata, handles);

listbox_psave_Callback(hObject, eventdata, handles);


listbox_yplotlimits_1_Callback(hObject, eventdata, handles);


% % % % % % 



% --- Executes on selection change in listbox_format.
function listbox_format_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_format (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_format contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_format


% nf=get(handles.listbox_format,'Value');

nf=2;

if(nf==1)
    Nrows=1;
else
    Nrows=4;
end
    
Ncolumns=1;

headers1={'Array Name'};
set(handles.uitable_array_name_1,'Data',cell(Nrows,Ncolumns),'ColumnName',headers1);





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



function edit_legend_1_Callback(hObject, eventdata, handles)
% hObject    handle to edit_legend_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_legend_1 as text
%        str2double(get(hObject,'String')) returns contents of edit_legend_1 as a double


% --- Executes during object creation, after setting all properties.
function edit_legend_1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_legend_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_legend_2_Callback(hObject, eventdata, handles)
% hObject    handle to edit_legend_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_legend_2 as text
%        str2double(get(hObject,'String')) returns contents of edit_legend_2 as a double


% --- Executes during object creation, after setting all properties.
function edit_legend_2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_legend_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_old_Callback(hObject, eventdata, handles)
% hObject    handle to edit_old (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_old as text
%        str2double(get(hObject,'String')) returns contents of edit_old as a double


% --- Executes during object creation, after setting all properties.
function edit_old_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_old (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_new_Callback(hObject, eventdata, handles)
% hObject    handle to edit_new (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_new as text
%        str2double(get(hObject,'String')) returns contents of edit_new as a double


% --- Executes during object creation, after setting all properties.
function edit_new_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_new (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_ch.
function pushbutton_ch_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_ch (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%  uitable_array_name_1
%  uitable_array_name_2
%  uitable_title

%%%

b=get(handles.edit_new,'String');
a=get(handles.edit_old,'String');

N=4;

try
    data=get(handles.uitable_array_name_1,'Data');
    A=char(data);
    setappdata(0,'data',data);
    
    k=1;
 
    for i=1:N
        array_name{i}=A(k,:); k=k+1;
        array_name{i} = strtrim(array_name{i});
        array_name{i} = strrep(array_name{i},a,b);
        data_s{i,1}=array_name{i};
    end
    
    set(handles.uitable_array_name_1,'Data',data_s);
    
catch
end

try
    data=get(handles.uitable_array_name_2,'Data');
    A=char(data);
    setappdata(0,'data',data);
    
    k=1;
 
    for i=1:N
        array_name{i}=A(k,:); k=k+1;
        array_name{i} = strtrim(array_name{i});
        array_name{i} = strrep(array_name{i},a,b);
        data_s{i,1}=array_name{i};
    end
    
    set(handles.uitable_array_name_2,'Data',data_s);
    
catch
end

% uitable_title

try
    data=get(handles.uitable_title,'Data');
    A=char(data);
    setappdata(0,'data',data);
    
    k=1;
 
    for i=1:N
        array_name{i}=A(k,:); k=k+1;
        array_name{i} = strtrim(array_name{i});
        array_name{i} = strrep(array_name{i},a,b);
        data_s{i,1}=array_name{i};
    end
    for i=1:N
        aleg{i}=A(k,:); k=k+1;
        aleg{i} = strtrim(aleg{i});
        data_s{i,2}=aleg{i};       
    end 
    
    set(handles.uitable_title,'Data',data_s);
    
catch
end

%%%



function edit_dB_title_Callback(hObject, eventdata, handles)
% hObject    handle to edit_dB_title (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_dB_title as text
%        str2double(get(hObject,'String')) returns contents of edit_dB_title as a double


% --- Executes during object creation, after setting all properties.
function edit_dB_title_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_dB_title (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_max_dB_Callback(hObject, eventdata, handles)
% hObject    handle to edit_max_dB (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_max_dB as text
%        str2double(get(hObject,'String')) returns contents of edit_max_dB as a double


% --- Executes during object creation, after setting all properties.
function edit_max_dB_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_max_dB (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_reference_Callback(hObject, eventdata, handles)
% hObject    handle to edit_reference (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_reference as text
%        str2double(get(hObject,'String')) returns contents of edit_reference as a double


% --- Executes during object creation, after setting all properties.
function edit_reference_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_reference (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_min_dB_Callback(hObject, eventdata, handles)
% hObject    handle to edit_min_dB (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_min_dB as text
%        str2double(get(hObject,'String')) returns contents of edit_min_dB as a double


% --- Executes during object creation, after setting all properties.
function edit_min_dB_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_min_dB (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

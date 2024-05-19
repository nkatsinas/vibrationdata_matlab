function varargout = subplots_2x2(varargin)
% SUBPLOTS_2X2 MATLAB code for subplots_2x2.fig
%      SUBPLOTS_2X2, by itself, creates a new SUBPLOTS_2X2 or raises the existing
%      singleton*.
%
%      H = SUBPLOTS_2X2 returns the handle to a new SUBPLOTS_2X2 or the handle to
%      the existing singleton*.
%
%      SUBPLOTS_2X2('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SUBPLOTS_2X2.M with the given input arguments.
%
%      SUBPLOTS_2X2('Property','Value',...) creates a new SUBPLOTS_2X2 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before subplots_2x2_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to subplots_2x2_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help subplots_2x2

% Last Modified by GUIDE v2.5 24-Dec-2018 10:17:14

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @subplots_2x2_OpeningFcn, ...
                   'gui_OutputFcn',  @subplots_2x2_OutputFcn, ...
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


% --- Executes just before subplots_2x2 is made visible.
function subplots_2x2_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to subplots_2x2 (see VARARGIN)

% Choose default command line output for subplots_2x2
handles.output = hObject;

listbox_plot_files_Callback(hObject, eventdata, handles);

set(handles.listbox_psave,'Value',1);
set(handles.listbox_fontsize,'Value',1);

listbox_psave_Callback(hObject, eventdata, handles);

listbox_format_Callback(hObject, eventdata, handles);

listbox_yplotlimits_1_Callback(hObject, eventdata, handles);

Nrows=4;
Ncolumns=2;

headers1={'Title','Y-axis Label'};
set(handles.uitable_title,'Data',cell(Nrows,Ncolumns),'ColumnName',headers1);



% Update handles structure
guidata(hObject, handles);

% UIWAIT makes subplots_2x2 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = subplots_2x2_OutputFcn(hObject, eventdata, handles) 
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


Figures = findobj( 'Type', 'Figure' , '-not' , 'Tag' , get( handles.output , 'Tag' ) );
NFigures = length( Figures );
for nFigures = 1 : NFigures
  close( Figures( nFigures ) );
end


nf=get(handles.listbox_format,'Value');

A=char(get(handles.uitable_array_name,'Data'));

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
   
    FS1=A(1,:);
    FS2=A(2,:);    
    FS3=A(3,:);  
    FS4=A(4,:);  
    
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

    try
        THM4=evalin('base',FS4);
    catch
        warndlg('Input array 4 not found ');
        return;
    end    
    
end

B=char(get(handles.uitable_title,'Data'));

t_string_1=B(1,:);
t_string_2=B(2,:);
t_string_3=B(3,:);
t_string_4=B(4,:);

t_string_1=strrep(t_string_1,'_',' ');
t_string_2=strrep(t_string_2,'_',' ');
t_string_3=strrep(t_string_3,'_',' ');
t_string_4=strrep(t_string_4,'_',' ');


sylabel_1=B(5,:);
sylabel_2=B(6,:);
sylabel_3=B(7,:);
sylabel_4=B(8,:);

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
plot(THM1(:,1),THM1(:,2));
grid on;
ylabel(sylabel_1);
title(t_string_1);
if(ny_limits==2)
     ylim([ymin_1,ymax_1]);
end

if(nx_limits==1)
    xmin=THM1(1,1);
    xmax=THM1(end,1);
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
    set(gca,'MinorGridLineStyle','none','GridLineStyle',':','XScale','log','YScale','lin');
end
if(nx_type==2 && ny_type==2)
    set(gca,'MinorGridLineStyle','none','GridLineStyle',':','XScale','log','YScale','log');
end

set(gca,'Fontsize',fsize);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%
subplot(2,2,2);
plot(THM2(:,1),THM2(:,2));
grid on;
title(t_string_2);
ylabel(sylabel_2);
if(ny_limits==2)
     ylim([ymin_2,ymax_2]);
end

if(nx_limits==1)
    xmin=THM2(1,1);
    xmax=THM2(end,1);
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
    set(gca,'MinorGridLineStyle','none','GridLineStyle',':','XScale','log','YScale','lin');
end
if(nx_type==2 && ny_type==2)
    set(gca,'MinorGridLineStyle','none','GridLineStyle',':','XScale','log','YScale','log');
end

set(gca,'Fontsize',fsize);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

subplot(2,2,3);
plot(THM3(:,1),THM3(:,2));
grid on;
title(t_string_3);
xlabel(sxlabel);
ylabel(sylabel_3);
if(ny_limits==2)
     ylim([ymin_3,ymax_3]);
end


if(nx_limits==1)
    xmin=THM3(1,1);
    xmax=THM3(end,1);
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
    set(gca,'MinorGridLineStyle','none','GridLineStyle',':','XScale','log','YScale','lin');
end
if(nx_type==2 && ny_type==2)
    set(gca,'MinorGridLineStyle','none','GridLineStyle',':','XScale','log','YScale','log');
end

set(gca,'Fontsize',fsize);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

subplot(2,2,4);
plot(THM4(:,1),THM4(:,2));
grid on;
title(t_string_4);
xlabel(sxlabel);
ylabel(sylabel_4);
if(ny_limits==2)
     ylim([ymin_4,ymax_4]);
end

if(nx_limits==1)
    xmin=THM4(1,1);
    xmax=THM4(end,1);
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
    set(gca,'MinorGridLineStyle','none','GridLineStyle',':','XScale','log','YScale','lin');
end
if(nx_type==2 && ny_type==2)
    set(gca,'MinorGridLineStyle','none','GridLineStyle',':','XScale','log','YScale','log');
end
%
 

set(hp, 'Position', [0 0 1200 600]);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%


% --- Executes on button press in pushbutton_return.
function pushbutton_return_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_return (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
delete(subplots_2x2);


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
    array_name=get(handles.uitable_array_name,'Data');
    PlotSave2x2.array_name=array_name;
    
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
            PlotSave2x2.THM=THM;            
        catch
            warndlg('Input array not found ');
            return;
        end
        
    else
        
        FS1=A(1,:);
        FS2=A(2,:);    
        FS3=A(3,:);  
        FS4=A(4,:);  

        try
            THM1=evalin('base',FS1);
            PlotSave2x2.THM1=THM1;  
        catch
            warndlg('Input array 1 not found ');
            return;
        end
    
        try
            THM2=evalin('base',FS2);
            PlotSave2x2.THM2=THM2;  
        catch
            warndlg('Input array 2 not found ');
            return;
        end
    
        try
            THM3=evalin('base',FS3);
            PlotSave2x2.THM3=THM3;              
        catch
            warndlg('Input array 3 not found ');
            return;
        end    
    
        try
            THM4=evalin('base',FS4);
            PlotSave2x2.THM4=THM4;              
        catch
            warndlg('Input array 4 not found ');
            return;
        end   

    end
    
end
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
    
    array_name=PlotSave2x2.array_name;    
    set(handles.uitable_array_name,'Data',array_name);
catch
end

% % % % % %

try
    ylim=PlotSave2x2.ylim;
    set(handles.uitable_ylim,'Data',ylim);
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


nf=get(handles.listbox_format,'Value');

if(nf==1)
    Nrows=1;
else
    Nrows=4;
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

function varargout = springs_series(varargin)
% SPRINGS_SERIES MATLAB code for springs_series.fig
%      SPRINGS_SERIES, by itself, creates a new SPRINGS_SERIES or raises the existing
%      singleton*.
%
%      H = SPRINGS_SERIES returns the handle to a new SPRINGS_SERIES or the handle to
%      the existing singleton*.
%
%      SPRINGS_SERIES('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SPRINGS_SERIES.M with the given input arguments.
%
%      SPRINGS_SERIES('Property','Value',...) creates a new SPRINGS_SERIES or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before springs_series_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to springs_series_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help springs_series

% Last Modified by GUIDE v2.5 08-Jun-2020 10:08:54

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @springs_series_OpeningFcn, ...
                   'gui_OutputFcn',  @springs_series_OutputFcn, ...
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


% --- Executes just before springs_series is made visible.
function springs_series_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to springs_series (see VARARGIN)

% Choose default command line output for springs_series
handles.output = hObject;

set(handles.listbox_num,'Value',1);

listbox_num_Callback(hObject, eventdata, handles);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes springs_series wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = springs_series_OutputFcn(hObject, eventdata, handles) 
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

disp(' ');
disp(' * * * * ');
disp(' ');

A=char(get(handles.uitable_data,'Data'));
N=get(handles.listbox_num,'Value');
nrows=N+1;

k=zeros(N,1);
c=zeros(N,1);

for i=1:nrows
    k(i)=str2double(strtrim(A(i,:)));
    c(i)=1/k(i);
end

stiff=1/sum(c);

out1=sprintf(' overall stiffness = %8.4g ',stiff);
disp(out1);

ss=sprintf('%8.4g',stiff);

set(handles.edit_stiffness,'String',ss);

set(handles.uipanel_results,'Visible','on');


% --- Executes on button press in pushbutton_return.
function pushbutton_return_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_return (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

delete(spring_series);


% --- Executes on selection change in listbox_num.
function listbox_num_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_num (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_num contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_num

n=get(handles.listbox_num,'Value');

nrows=n+1;
ncols=1;

data_q=get(handles.uitable_data,'Data');
sz=size(data_q);
N=sz(1);

for i=1:nrows
    data_s{i,1}=' ';
end

M=min([nrows N]);

for i=1:M
    data_s{i,1}=data_q{i,1};    
end


cn={'Stiffness'};
set(handles.uitable_data,'Data',data_s,'ColumnName',cn);

set(handles.uipanel_results,'Visible','off');


% --- Executes during object creation, after setting all properties.
function listbox_num_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_num (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_stiffness_Callback(hObject, eventdata, handles)
% hObject    handle to edit_stiffness (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_stiffness as text
%        str2double(get(hObject,'String')) returns contents of edit_stiffness as a double


% --- Executes during object creation, after setting all properties.
function edit_stiffness_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_stiffness (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes when entered data in editable cell(s) in uitable_data.
function uitable_data_CellEditCallback(hObject, eventdata, handles)
% hObject    handle to uitable_data (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.TABLE)
%	Indices: row and column indices of the cell(s) edited
%	PreviousData: previous data for the cell(s) edited
%	EditData: string(s) entered by the user
%	NewData: EditData or its converted form set on the Data property. Empty if Data was not changed
%	Error: error string when failed to convert EditData to appropriate value for Data
% handles    structure with handles and user data (see GUIDATA)
set(handles.uipanel_results,'Visible','off');

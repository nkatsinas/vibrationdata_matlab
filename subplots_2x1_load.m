function varargout = subplots_2x1_load(varargin)
% SUBPLOTS_2X1_LOAD MATLAB code for subplots_2x1_load.fig
%      SUBPLOTS_2X1_LOAD, by itself, creates a new SUBPLOTS_2X1_LOAD or raises the existing
%      singleton*.
%
%      H = SUBPLOTS_2X1_LOAD returns the handle to a new SUBPLOTS_2X1_LOAD or the handle to
%      the existing singleton*.
%
%      SUBPLOTS_2X1_LOAD('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SUBPLOTS_2X1_LOAD.M with the given input arguments.
%
%      SUBPLOTS_2X1_LOAD('Property','Value',...) creates a new SUBPLOTS_2X1_LOAD or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before subplots_2x1_load_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to subplots_2x1_load_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help subplots_2x1_load

% Last Modified by GUIDE v2.5 08-Nov-2019 14:01:39

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @subplots_2x1_load_OpeningFcn, ...
                   'gui_OutputFcn',  @subplots_2x1_load_OutputFcn, ...
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


% --- Executes just before subplots_2x1_load is made visible.
function subplots_2x1_load_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to subplots_2x1_load (see VARARGIN)

% Choose default command line output for subplots_2x1_load
handles.output = hObject;

try
    filename = 'subplots_2x1_load_list.txt';
    THM=importdata(filename);
catch
    THM='none';
end

THM
sz=size(THM);

out1=sprintf(' sz(1)=%d  sz(2)=%d ',sz(1),sz(2));
disp(out1);

%%

try



for i=1:sz(1)
    aaa=THM{i};
%    lastdot_pos = find(aaa == '\', 1, 'last');
%    all_pathname{i} = aaa(1 : lastdot_pos - 1);
    all_filename{i} = aaa;
end

%%

disp('ref g');
% all_filename;

set(handles.listbox_files,'String',all_filename);

% setappdata(0,'all_pathname',all_pathname);  
setappdata(0,'all_filename',all_filename);

catch
    warndlg(' ref d failure');
end


% Update handles structure
guidata(hObject, handles);

% UIWAIT makes subplots_2x1_load wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = subplots_2x1_load_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton_load.
function pushbutton_load_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_load (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

disp('****');

all_pathname=char(getappdata(0,'all_pathname'));  
all_filename=char(getappdata(0,'all_filename'));

n=get(handles.listbox_files,'Value');

% pathname=all_pathname(n,:);
filename=all_filename(n,:);


% pathname
% filename

% setappdata(0,'pathname',pathname);
setappdata(0,'filename',filename);


delete(subplots_2x1_load);

% --- Executes on selection change in listbox_files.
function listbox_files_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_files (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_files contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_files


% --- Executes during object creation, after setting all properties.
function listbox_files_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_files (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_return_only.
function pushbutton_return_only_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_return_only (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

setappdata(0,'Lflag',1);

delete(subplots_2x1_load);

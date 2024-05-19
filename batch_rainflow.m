function varargout = batch_rainflow(varargin)
% BATCH_RAINFLOW MATLAB code for batch_rainflow.fig
%      BATCH_RAINFLOW, by itself, creates a new BATCH_RAINFLOW or raises the existing
%      singleton*.
%
%      H = BATCH_RAINFLOW returns the handle to a new BATCH_RAINFLOW or the handle to
%      the existing singleton*.
%
%      BATCH_RAINFLOW('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in BATCH_RAINFLOW.M with the given input arguments.
%
%      BATCH_RAINFLOW('Property','Value',...) creates a new BATCH_RAINFLOW or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before batch_rainflow_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to batch_rainflow_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help batch_rainflow

% Last Modified by GUIDE v2.5 11-Jun-2018 17:35:25

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @batch_rainflow_OpeningFcn, ...
                   'gui_OutputFcn',  @batch_rainflow_OutputFcn, ...
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


% --- Executes just before batch_rainflow is made visible.
function batch_rainflow_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to batch_rainflow (see VARARGIN)

% Choose default command line output for batch_rainflow
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes batch_rainflow wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = batch_rainflow_OutputFcn(hObject, eventdata, handles) 
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

delete(batch_rainflow);


% --- Executes on selection change in listbox_batch.
function listbox_batch_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_batch (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_batch contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_batch


% --- Executes during object creation, after setting all properties.
function listbox_batch_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_batch (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_analyze.
function pushbutton_analyze_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_analyze (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

n=get(handles.listbox_batch,'Value');

if(n==1)
    handles.s=batch_vibrationdata_rainflow;
end
if(n==2)
    handles.s=batch_vibrationdata_rainflow_Miners_Basquin;
end
if(n==3)
    handles.s=batch_vibrationdata_rainflow_Miners_nasgro;
end
if(n==4)
    handles.s=rainflow_NASGRO_LB_output_batch; 
end

set(handles.s,'Visible','on');

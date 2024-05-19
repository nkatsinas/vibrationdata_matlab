function varargout = damping_functions(varargin)
% DAMPING_FUNCTIONS MATLAB code for damping_functions.fig
%      DAMPING_FUNCTIONS, by itself, creates a new DAMPING_FUNCTIONS or raises the existing
%      singleton*.
%
%      H = DAMPING_FUNCTIONS returns the handle to a new DAMPING_FUNCTIONS or the handle to
%      the existing singleton*.
%
%      DAMPING_FUNCTIONS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DAMPING_FUNCTIONS.M with the given input arguments.
%
%      DAMPING_FUNCTIONS('Property','Value',...) creates a new DAMPING_FUNCTIONS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before damping_functions_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to damping_functions_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help damping_functions

% Last Modified by GUIDE v2.5 04-Jan-2016 15:31:36

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @damping_functions_OpeningFcn, ...
                   'gui_OutputFcn',  @damping_functions_OutputFcn, ...
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


% --- Executes just before damping_functions is made visible.
function damping_functions_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to damping_functions (see VARARGIN)

% Choose default command line output for damping_functions
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes damping_functions wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = damping_functions_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton_half_power_bandwidth.
function pushbutton_half_power_bandwidth_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_half_power_bandwidth (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.s= half_power_bandwidth;
set(handles.s,'Visible','on');


% --- Executes on button press in pushbutton_damping_conversion.
function pushbutton_damping_conversion_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_damping_conversion (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.s= damping;
set(handles.s,'Visible','on');


% --- Executes on button press in pushbutton_return.
function pushbutton_return_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_return (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
delete(damping_functions);


% --- Executes on button press in pushbutton_modal_frf.
function pushbutton_modal_frf_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_modal_frf (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.s= half_power_bandwidth_fc;
set(handles.s,'Visible','on');


% --- Executes on selection change in listbox_analysis.
function listbox_analysis_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_analysis (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_analysis contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_analysis


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


% --- Executes on button press in pushbutton_analyze.
function pushbutton_analyze_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_analyze (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

n=get(handles.listbox_analysis,'Value');

if(n==1)
    handles.s= half_power_bandwidth;    
end
if(n==2)
    handles.s= half_power_bandwidth_fc;    
end
if(n==3)
    handles.s= log_decrement;       
end
if(n==4)
    handles.s= damping;    
end

set(handles.s,'Visible','on');

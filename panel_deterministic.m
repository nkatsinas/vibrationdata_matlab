function varargout = panel_deterministic(varargin)
% PANEL_DETERMINISTIC MATLAB code for panel_deterministic.fig
%      PANEL_DETERMINISTIC, by itself, creates a new PANEL_DETERMINISTIC or raises the existing
%      singleton*.
%
%      H = PANEL_DETERMINISTIC returns the handle to a new PANEL_DETERMINISTIC or the handle to
%      the existing singleton*.
%
%      PANEL_DETERMINISTIC('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PANEL_DETERMINISTIC.M with the given input arguments.
%
%      PANEL_DETERMINISTIC('Property','Value',...) creates a new PANEL_DETERMINISTIC or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before panel_deterministic_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to panel_deterministic_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help panel_deterministic

% Last Modified by GUIDE v2.5 11-Jan-2016 13:07:30

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @panel_deterministic_OpeningFcn, ...
                   'gui_OutputFcn',  @panel_deterministic_OutputFcn, ...
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


% --- Executes just before panel_deterministic is made visible.
function panel_deterministic_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to panel_deterministic (see VARARGIN)

% Choose default command line output for panel_deterministic
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes panel_deterministic wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = panel_deterministic_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in listbox_det.
function listbox_det_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_det (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_det contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_det


% --- Executes during object creation, after setting all properties.
function listbox_det_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_det (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_det.
function pushbutton_det_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_det (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

n=get(handles.listbox_det,'Value');

if(n==1)
    handles.s=structural_dynamics_plates;      
end
if(n==2)
    handles.s=vibrationdata_rectangular_plate_fea;       
end
if(n==3)
    handles.s=vibrationdata_rectangular_plate_uniform_pressure;
end
if(n==4)
    handles.s=vibrationdata_rectangular_plate_oblique_incidence;
end

set(handles.s,'Visible','on');


% --- Executes on button press in pushbutton_return.
function pushbutton_return_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_return (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

delete(panel_deterministic);

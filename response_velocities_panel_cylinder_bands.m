function varargout = response_velocities_panel_cylinder_bands(varargin)
% RESPONSE_VELOCITIES_PANEL_CYLINDER_BANDS MATLAB code for response_velocities_panel_cylinder_bands.fig
%      RESPONSE_VELOCITIES_PANEL_CYLINDER_BANDS, by itself, creates a new RESPONSE_VELOCITIES_PANEL_CYLINDER_BANDS or raises the existing
%      singleton*.
%
%      H = RESPONSE_VELOCITIES_PANEL_CYLINDER_BANDS returns the handle to a new RESPONSE_VELOCITIES_PANEL_CYLINDER_BANDS or the handle to
%      the existing singleton*.
%
%      RESPONSE_VELOCITIES_PANEL_CYLINDER_BANDS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in RESPONSE_VELOCITIES_PANEL_CYLINDER_BANDS.M with the given input arguments.
%
%      RESPONSE_VELOCITIES_PANEL_CYLINDER_BANDS('Property','Value',...) creates a new RESPONSE_VELOCITIES_PANEL_CYLINDER_BANDS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before response_velocities_panel_cylinder_bands_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to response_velocities_panel_cylinder_bands_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help response_velocities_panel_cylinder_bands

% Last Modified by GUIDE v2.5 07-Dec-2015 11:13:59

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @response_velocities_panel_cylinder_bands_OpeningFcn, ...
                   'gui_OutputFcn',  @response_velocities_panel_cylinder_bands_OutputFcn, ...
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


% --- Executes just before response_velocities_panel_cylinder_bands is made visible.
function response_velocities_panel_cylinder_bands_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to response_velocities_panel_cylinder_bands (see VARARGIN)

% Choose default command line output for response_velocities_panel_cylinder_bands
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes response_velocities_panel_cylinder_bands wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = response_velocities_panel_cylinder_bands_OutputFcn(hObject, eventdata, handles) 
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
delete(response_velocities_panel_cylinder_bands);


% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on selection change in listbox_units.
function listbox_units_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_units (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_units contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_units


% --- Executes during object creation, after setting all properties.
function listbox_units_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_units (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

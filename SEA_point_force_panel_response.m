function varargout = SEA_point_force_panel_response(varargin)
% SEA_POINT_FORCE_PANEL_RESPONSE MATLAB code for SEA_point_force_panel_response.fig
%      SEA_POINT_FORCE_PANEL_RESPONSE, by itself, creates a new SEA_POINT_FORCE_PANEL_RESPONSE or raises the existing
%      singleton*.
%
%      H = SEA_POINT_FORCE_PANEL_RESPONSE returns the handle to a new SEA_POINT_FORCE_PANEL_RESPONSE or the handle to
%      the existing singleton*.
%
%      SEA_POINT_FORCE_PANEL_RESPONSE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SEA_POINT_FORCE_PANEL_RESPONSE.M with the given input arguments.
%
%      SEA_POINT_FORCE_PANEL_RESPONSE('Property','Value',...) creates a new SEA_POINT_FORCE_PANEL_RESPONSE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before SEA_point_force_panel_response_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to SEA_point_force_panel_response_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help SEA_point_force_panel_response

% Last Modified by GUIDE v2.5 11-Jan-2016 13:47:07

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @SEA_point_force_panel_response_OpeningFcn, ...
                   'gui_OutputFcn',  @SEA_point_force_panel_response_OutputFcn, ...
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


% --- Executes just before SEA_point_force_panel_response is made visible.
function SEA_point_force_panel_response_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to SEA_point_force_panel_response (see VARARGIN)

% Choose default command line output for SEA_point_force_panel_response
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes SEA_point_force_panel_response wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = SEA_point_force_panel_response_OutputFcn(hObject, eventdata, handles) 
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

delete(SEA_point_force_panel_response);


% --- Executes on button press in pushbutton_point_force.
function pushbutton_point_force_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_point_force (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
n=get(handles.listbox_point_force,'Value');

if(n==1)
    handles.s=panel_point_force_single;  
end
if(n==2)
    panel_point_force_multi_a;  
end

try
    set(handles.s,'Visible','on');
catch
end

% --- Executes on selection change in listbox_point_force.
function listbox_point_force_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_point_force (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_point_force contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_point_force


% --- Executes during object creation, after setting all properties.
function listbox_point_force_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_point_force (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

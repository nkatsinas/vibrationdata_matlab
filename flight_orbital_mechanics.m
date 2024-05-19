function varargout = flight_orbital_mechanics(varargin)
% FLIGHT_ORBITAL_MECHANICS MATLAB code for flight_orbital_mechanics.fig
%      FLIGHT_ORBITAL_MECHANICS, by itself, creates a new FLIGHT_ORBITAL_MECHANICS or raises the existing
%      singleton*.
%
%      H = FLIGHT_ORBITAL_MECHANICS returns the handle to a new FLIGHT_ORBITAL_MECHANICS or the handle to
%      the existing singleton*.
%
%      FLIGHT_ORBITAL_MECHANICS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in FLIGHT_ORBITAL_MECHANICS.M with the given input arguments.
%
%      FLIGHT_ORBITAL_MECHANICS('Property','Value',...) creates a new FLIGHT_ORBITAL_MECHANICS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before flight_orbital_mechanics_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to flight_orbital_mechanics_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help flight_orbital_mechanics

% Last Modified by GUIDE v2.5 17-Jan-2021 08:18:47

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @flight_orbital_mechanics_OpeningFcn, ...
                   'gui_OutputFcn',  @flight_orbital_mechanics_OutputFcn, ...
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


% --- Executes just before flight_orbital_mechanics is made visible.
function flight_orbital_mechanics_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to flight_orbital_mechanics (see VARARGIN)

% Choose default command line output for flight_orbital_mechanics
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes flight_orbital_mechanics wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = flight_orbital_mechanics_OutputFcn(hObject, eventdata, handles) 
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
delete(flight_orbital_mechanics);


% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

n=get(handles.listbox1,'Value');

if(n==1)
   handles.s=gravity; 
end
if(n==2)
   handles.s=Bernoulli_equation; 
end

set(handles.s,'Visible','on');


% --- Executes on selection change in listbox1.
function listbox1_Callback(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox1


% --- Executes during object creation, after setting all properties.
function listbox1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function varargout = shock_propagation(varargin)
% SHOCK_PROPAGATION MATLAB code for shock_propagation.fig
%      SHOCK_PROPAGATION, by itself, creates a new SHOCK_PROPAGATION or raises the existing
%      singleton*.
%
%      H = SHOCK_PROPAGATION returns the handle to a new SHOCK_PROPAGATION or the handle to
%      the existing singleton*.
%
%      SHOCK_PROPAGATION('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SHOCK_PROPAGATION.M with the given input arguments.
%
%      SHOCK_PROPAGATION('Property','Value',...) creates a new SHOCK_PROPAGATION or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before shock_propagation_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to shock_propagation_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help shock_propagation

% Last Modified by GUIDE v2.5 21-Aug-2015 12:24:27

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @shock_propagation_OpeningFcn, ...
                   'gui_OutputFcn',  @shock_propagation_OutputFcn, ...
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


% --- Executes just before shock_propagation is made visible.
function shock_propagation_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to shock_propagation (see VARARGIN)

% Choose default command line output for shock_propagation
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes shock_propagation wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = shock_propagation_OutputFcn(hObject, eventdata, handles) 
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

delete(shock_propagation);


% --- Executes on button press in pushbutton_analyze.
function pushbutton_analyze_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_analyze (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


n=get(handles.listbox_type,'Value');

if(n==1)
    handles.s=MM_shock_distance; 
end
if(n==2)
    handles.s=Martin_Marietta_shock_distance_joints; 
end
if(n==3)
    handles.s=NASA7005_shock_distance; 
end
if(n==4)
    handles.s=NASA7005_shock_distance_joints; 
end
if(n==5)
    handles.s=beam_analogy_shock_distance; 
end
if(n==6)
    handles.s=shock_joint; 
end
if(n==7)
    handles.s=shock_joint_SRS; 
end
if(n==8)
    handles.s=structural_borne_wave_propagation; 
end

set(handles.s,'Visible','on'); 

% --- Executes on selection change in listbox_type.
function listbox_type_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_type contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_type




% --- Executes during object creation, after setting all properties.
function listbox_type_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

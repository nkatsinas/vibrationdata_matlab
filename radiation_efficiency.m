function varargout = radiation_efficiency(varargin)
% RADIATION_EFFICIENCY MATLAB code for radiation_efficiency.fig
%      RADIATION_EFFICIENCY, by itself, creates a new RADIATION_EFFICIENCY or raises the existing
%      singleton*.
%
%      H = RADIATION_EFFICIENCY returns the handle to a new RADIATION_EFFICIENCY or the handle to
%      the existing singleton*.
%
%      RADIATION_EFFICIENCY('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in RADIATION_EFFICIENCY.M with the given input arguments.
%
%      RADIATION_EFFICIENCY('Property','Value',...) creates a new RADIATION_EFFICIENCY or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before radiation_efficiency_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to radiation_efficiency_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help radiation_efficiency

% Last Modified by GUIDE v2.5 01-Dec-2015 15:51:45

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @radiation_efficiency_OpeningFcn, ...
                   'gui_OutputFcn',  @radiation_efficiency_OutputFcn, ...
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


% --- Executes just before radiation_efficiency is made visible.
function radiation_efficiency_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to radiation_efficiency (see VARARGIN)

% Choose default command line output for radiation_efficiency
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes radiation_efficiency wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = radiation_efficiency_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton_analyze.
function pushbutton_analyze_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_analyze (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

n=get(handles.listbox_type,'Value');

if(n==1)
    handles.s=radiation_efficiency_panel;
end
if(n==2)
    handles.s=radiation_efficiency_panel_free;
end
if(n==3)
    handles.s=radiation_efficiency_honeycomb_sandwich_panel;
end
if(n==4)
    handles.s=radiation_efficiency_ribbed_panel;
end
if(n==5)
    handles.s=radiation_efficiency_cylinder;
end
if(n==6)
    handles.s=radiation_efficiency_honeycomb_sandwich_cylinder;
end


set(handles.s,'Visible','on'); 




% --- Executes on button press in pushbutton_return.
function pushbutton_return_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_return (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

delete(radiation_efficiency);

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

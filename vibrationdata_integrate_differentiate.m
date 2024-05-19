function varargout = vibrationdata_integrate_differentiate(varargin)
% VIBRATIONDATA_INTEGRATE_DIFFERENTIATE MATLAB code for vibrationdata_integrate_differentiate.fig
%      VIBRATIONDATA_INTEGRATE_DIFFERENTIATE, by itself, creates a new VIBRATIONDATA_INTEGRATE_DIFFERENTIATE or raises the existing
%      singleton*.
%
%      H = VIBRATIONDATA_INTEGRATE_DIFFERENTIATE returns the handle to a new VIBRATIONDATA_INTEGRATE_DIFFERENTIATE or the handle to
%      the existing singleton*.
%
%      VIBRATIONDATA_INTEGRATE_DIFFERENTIATE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in VIBRATIONDATA_INTEGRATE_DIFFERENTIATE.M with the given input arguments.
%
%      VIBRATIONDATA_INTEGRATE_DIFFERENTIATE('Property','Value',...) creates a new VIBRATIONDATA_INTEGRATE_DIFFERENTIATE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before vibrationdata_integrate_differentiate_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to vibrationdata_integrate_differentiate_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help vibrationdata_integrate_differentiate

% Last Modified by GUIDE v2.5 04-Dec-2014 14:14:59

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @vibrationdata_integrate_differentiate_OpeningFcn, ...
                   'gui_OutputFcn',  @vibrationdata_integrate_differentiate_OutputFcn, ...
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


% --- Executes just before vibrationdata_integrate_differentiate is made visible.
function vibrationdata_integrate_differentiate_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to vibrationdata_integrate_differentiate (see VARARGIN)

% Choose default command line output for vibrationdata_integrate_differentiate
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes vibrationdata_integrate_differentiate wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = vibrationdata_integrate_differentiate_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


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


% --- Executes on button press in pushbutton_return.
function pushbutton_return_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_return (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

delete(vibrationdata_integrate_differentiate);


% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

n=get(handles.listbox_analysis,'Value');

if(n==1)
   handles.s= vibrationdata_integrate;      
end
if(n==2)
   handles.s= vibrationdata_integrate_double;      
end
if(n==3)
   handles.s= vibrationdata_differentiate;        
end
if(n==4)
   accel_vel_disp_correction_App        
end
if(n==5)
   handles.s= vibrationdata_relative_displacement;
end

try
    set(handles.s,'Visible','on');
catch
end

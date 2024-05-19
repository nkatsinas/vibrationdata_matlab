function varargout = vibrationdata_signal_editing_utilities(varargin)
% VIBRATIONDATA_SIGNAL_EDITING_UTILITIES MATLAB code for vibrationdata_signal_editing_utilities.fig
%      VIBRATIONDATA_SIGNAL_EDITING_UTILITIES, by itself, creates a new VIBRATIONDATA_SIGNAL_EDITING_UTILITIES or raises the existing
%      singleton*.
%
%      H = VIBRATIONDATA_SIGNAL_EDITING_UTILITIES returns the handle to a new VIBRATIONDATA_SIGNAL_EDITING_UTILITIES or the handle to
%      the existing singleton*.
%
%      VIBRATIONDATA_SIGNAL_EDITING_UTILITIES('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in VIBRATIONDATA_SIGNAL_EDITING_UTILITIES.M with the given input arguments.
%
%      VIBRATIONDATA_SIGNAL_EDITING_UTILITIES('Property','Value',...) creates a new VIBRATIONDATA_SIGNAL_EDITING_UTILITIES or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before vibrationdata_signal_editing_utilities_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to vibrationdata_signal_editing_utilities_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help vibrationdata_signal_editing_utilities

% Last Modified by GUIDE v2.5 05-Mar-2014 15:00:46

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @vibrationdata_signal_editing_utilities_OpeningFcn, ...
                   'gui_OutputFcn',  @vibrationdata_signal_editing_utilities_OutputFcn, ...
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


% --- Executes just before vibrationdata_signal_editing_utilities is made visible.
function vibrationdata_signal_editing_utilities_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to vibrationdata_signal_editing_utilities (see VARARGIN)

% Choose default command line output for vibrationdata_signal_editing_utilities
handles.output = hObject;

set(handles.listbox_type,'Value',1);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes vibrationdata_signal_editing_utilities wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = vibrationdata_signal_editing_utilities_OutputFcn(hObject, eventdata, handles) 
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

delete(vibrationdata_signal_editing_utilities);


% --- Executes on selection change in listbox_type.
function listbox_type_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_type contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_type
pushbutton_begin_analysis_Callback(hObject, eventdata, handles);

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


% --- Executes on button press in pushbutton_begin_analysis.
function pushbutton_begin_analysis_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_begin_analysis (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

n=get(handles.listbox_type,'Value');

if(n==1)
    handles.s=vibrationdata_trend_removal;
end
if(n==2)
    handles.s=vibrationdata_extract_segment;    
end  
if(n==3)
    handles.s=vibrationdata_decimate;    
end  
if(n==4)
    handles.s=vibrationdata_cubic_spline;    
end  
if(n==5)
    handles.s=vibrationdata_add_time_column;    
end  
if(n==6) % add trailing zeros
    handles.s=add_trailing_zeros; 
end
if(n==7) 
    handles.s=vibrationdata_linear_interpolation; 
end
if(n==8) 
    handles.s=time_history_window; 
end
if(n==9) 
    handles.s=peak_clip; 
end
if(n==10) 
    handles.s=clipped_data_cubic_spline; 
end

set(handles.s,'Visible','on'); 

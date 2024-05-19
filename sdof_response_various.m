function varargout = sdof_response_various(varargin)
% SDOF_RESPONSE_VARIOUS MATLAB code for sdof_response_various.fig
%      SDOF_RESPONSE_VARIOUS, by itself, creates a new SDOF_RESPONSE_VARIOUS or raises the existing
%      singleton*.
%
%      H = SDOF_RESPONSE_VARIOUS returns the handle to a new SDOF_RESPONSE_VARIOUS or the handle to
%      the existing singleton*.
%
%      SDOF_RESPONSE_VARIOUS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SDOF_RESPONSE_VARIOUS.M with the given input arguments.
%
%      SDOF_RESPONSE_VARIOUS('Property','Value',...) creates a new SDOF_RESPONSE_VARIOUS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before sdof_response_various_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to sdof_response_various_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help sdof_response_various

% Last Modified by GUIDE v2.5 10-Jul-2014 10:59:29

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @sdof_response_various_OpeningFcn, ...
                   'gui_OutputFcn',  @sdof_response_various_OutputFcn, ...
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


% --- Executes just before sdof_response_various is made visible.
function sdof_response_various_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to sdof_response_various (see VARARGIN)

% Choose default command line output for sdof_response_various
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes sdof_response_various wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = sdof_response_various_OutputFcn(hObject, eventdata, handles) 
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

delete(sdof_response_various);

% --- Executes on button press in pushbutton_analyze.
function pushbutton_analyze_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_analyze (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

n=get(handles.listbox_analysis,'Value');

if(n==1)
    handles.s=steady;    
end
if(n==2)
    peak_sigma_random_App;       
end
if(n==3)
    handles.s=vibrationdata_Miles;    
end   
if(n==4)
    handles.s=vibrationdata_Miles_acoustic;    
end    
if(n==5)
    handles.s=peak_response_experiment;    
end    

try
    set(handles.s,'Visible','on'); 
catch
end


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

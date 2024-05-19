function varargout = vibrationdata_batch_psd(varargin)
% VIBRATIONDATA_BATCH_PSD MATLAB code for vibrationdata_batch_psd.fig
%      VIBRATIONDATA_BATCH_PSD, by itself, creates a new VIBRATIONDATA_BATCH_PSD or raises the existing
%      singleton*.
%
%      H = VIBRATIONDATA_BATCH_PSD returns the handle to a new VIBRATIONDATA_BATCH_PSD or the handle to
%      the existing singleton*.
%
%      VIBRATIONDATA_BATCH_PSD('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in VIBRATIONDATA_BATCH_PSD.M with the given input arguments.
%
%      VIBRATIONDATA_BATCH_PSD('Property','Value',...) creates a new VIBRATIONDATA_BATCH_PSD or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before vibrationdata_batch_psd_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to vibrationdata_batch_psd_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help vibrationdata_batch_psd

% Last Modified by GUIDE v2.5 29-Aug-2017 14:29:18

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @vibrationdata_batch_psd_OpeningFcn, ...
                   'gui_OutputFcn',  @vibrationdata_batch_psd_OutputFcn, ...
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


% --- Executes just before vibrationdata_batch_psd is made visible.
function vibrationdata_batch_psd_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to vibrationdata_batch_psd (see VARARGIN)

% Choose default command line output for vibrationdata_batch_psd
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes vibrationdata_batch_psd wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = vibrationdata_batch_psd_OutputFcn(hObject, eventdata, handles) 
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

delete(vibrationdata_batch_psd)


% --- Executes on button press in pushbutton_analyze.
function pushbutton_analyze_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_analyze (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

n=get(handles.listbox_analysis,'Value');

if(n==1)
    handles.s=overall_GRMS_batch; 
end    
if(n==2)
    handles.s=VRS_batch; 
end
if(n==3)
    handles.s=Multiple_PSD_FDS_Envelope_batch;     
end
if(n==4)
    handles.s=Multiple_PSD_Envelope_normal_tolerance;     
end
if(n==5)
    handles.s=batch_psd_fds;     
end


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

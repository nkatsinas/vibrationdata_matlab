function varargout = vibrationdata_psd_envelope_main(varargin)
% VIBRATIONDATA_PSD_ENVELOPE_MAIN MATLAB code for vibrationdata_psd_envelope_main.fig
%      VIBRATIONDATA_PSD_ENVELOPE_MAIN, by itself, creates a new VIBRATIONDATA_PSD_ENVELOPE_MAIN or raises the existing
%      singleton*.
%
%      H = VIBRATIONDATA_PSD_ENVELOPE_MAIN returns the handle to a new VIBRATIONDATA_PSD_ENVELOPE_MAIN or the handle to
%      the existing singleton*.
%
%      VIBRATIONDATA_PSD_ENVELOPE_MAIN('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in VIBRATIONDATA_PSD_ENVELOPE_MAIN.M with the given input arguments.
%
%      VIBRATIONDATA_PSD_ENVELOPE_MAIN('Property','Value',...) creates a new VIBRATIONDATA_PSD_ENVELOPE_MAIN or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before vibrationdata_psd_envelope_main_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to vibrationdata_psd_envelope_main_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help vibrationdata_psd_envelope_main

% Last Modified by GUIDE v2.5 14-Jul-2016 10:53:11

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @vibrationdata_psd_envelope_main_OpeningFcn, ...
                   'gui_OutputFcn',  @vibrationdata_psd_envelope_main_OutputFcn, ...
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


% --- Executes just before vibrationdata_psd_envelope_main is made visible.
function vibrationdata_psd_envelope_main_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to vibrationdata_psd_envelope_main (see VARARGIN)

% Choose default command line output for vibrationdata_psd_envelope_main
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes vibrationdata_psd_envelope_main wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = vibrationdata_psd_envelope_main_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

delete(vibrationdata_psd_envelope_main);


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

p=get(handles.listbox_method,'Value');

if(p==1) % Envelope ers
	handles.s= vibrationdata_envelope_ers;         
end        
if(p==2) % Envelope fds
	handles.s= vibrationdata_envelope_fds;         
end   
if(p==3) % Envelope srs
	handles.s= vibrationdata_envelope_th_srs_psd;         
end  
if(p==4) % PSD MPE per SMC-S-016, 3.27
	handles.s=vibrationdata_psd_mpe;         
end 
set(handles.s,'Visible','on');  


% --- Executes on selection change in listbox_method.
function listbox_method_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_method (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_method contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_method


% --- Executes during object creation, after setting all properties.
function listbox_method_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_method (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

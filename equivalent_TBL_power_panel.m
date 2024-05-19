function varargout = equivalent_TBL_power_panel(varargin)
% EQUIVALENT_TBL_POWER_PANEL MATLAB code for equivalent_TBL_power_panel.fig
%      EQUIVALENT_TBL_POWER_PANEL, by itself, creates a new EQUIVALENT_TBL_POWER_PANEL or raises the existing
%      singleton*.
%
%      H = EQUIVALENT_TBL_POWER_PANEL returns the handle to a new EQUIVALENT_TBL_POWER_PANEL or the handle to
%      the existing singleton*.
%
%      EQUIVALENT_TBL_POWER_PANEL('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in EQUIVALENT_TBL_POWER_PANEL.M with the given input arguments.
%
%      EQUIVALENT_TBL_POWER_PANEL('Property','Value',...) creates a new EQUIVALENT_TBL_POWER_PANEL or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before equivalent_TBL_power_panel_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to equivalent_TBL_power_panel_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help equivalent_TBL_power_panel

% Last Modified by GUIDE v2.5 18-Aug-2016 11:56:27

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @equivalent_TBL_power_panel_OpeningFcn, ...
                   'gui_OutputFcn',  @equivalent_TBL_power_panel_OutputFcn, ...
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


% --- Executes just before equivalent_TBL_power_panel is made visible.
function equivalent_TBL_power_panel_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to equivalent_TBL_power_panel (see VARARGIN)

% Choose default command line output for equivalent_TBL_power_panel
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes equivalent_TBL_power_panel wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = equivalent_TBL_power_panel_OutputFcn(hObject, eventdata, handles) 
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

delete(equivalent_acoustic_power_panel);

% --- Executes on selection change in listbox_acoustic_power.
function listbox_acoustic_power_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_acoustic_power (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_acoustic_power contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_acoustic_power


% --- Executes during object creation, after setting all properties.
function listbox_acoustic_power_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_acoustic_power (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_band.
function listbox_band_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_band (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_band contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_band


% --- Executes during object creation, after setting all properties.
function listbox_band_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_band (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_analyze.
function pushbutton_analyze_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_analyze (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



nband=get(handles.listbox_band,'Value');

if(nband==1) % single

    handles.s=SEA_equivalent_TBL_power_single;

else         % multi

    handles.s=SEA_equivalent_TBL_power_multi;
        
end    

set(handles.s,'Visible','on');


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

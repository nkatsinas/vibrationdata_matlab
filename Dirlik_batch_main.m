function varargout = Dirlik_batch_main(varargin)
% DIRLIK_BATCH_MAIN MATLAB code for Dirlik_batch_main.fig
%      DIRLIK_BATCH_MAIN, by itself, creates a new DIRLIK_BATCH_MAIN or raises the existing
%      singleton*.
%
%      H = DIRLIK_BATCH_MAIN returns the handle to a new DIRLIK_BATCH_MAIN or the handle to
%      the existing singleton*.
%
%      DIRLIK_BATCH_MAIN('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DIRLIK_BATCH_MAIN.M with the given input arguments.
%
%      DIRLIK_BATCH_MAIN('Property','Value',...) creates a new DIRLIK_BATCH_MAIN or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Dirlik_batch_main_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Dirlik_batch_main_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Dirlik_batch_main

% Last Modified by GUIDE v2.5 08-Jun-2018 13:24:42

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Dirlik_batch_main_OpeningFcn, ...
                   'gui_OutputFcn',  @Dirlik_batch_main_OutputFcn, ...
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


% --- Executes just before Dirlik_batch_main is made visible.
function Dirlik_batch_main_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Dirlik_batch_main (see VARARGIN)

% Choose default command line output for Dirlik_batch_main
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Dirlik_batch_main wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Dirlik_batch_main_OutputFcn(hObject, eventdata, handles) 
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

delete(Dirlik_batch_main);


% --- Executes on button press in pushbutton_analysis.
function pushbutton_analysis_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_analysis (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


n=get(handles.listbox_analysis,'Value');

if(n==1)
    handles.s=batch_Dirlik_Miners_damage_stress_psd_Basquin; 
end
if(n==2)
    handles.s=batch_Dirlik_Miners_damage_stress_psd_Nasgro; 
end
if(n==3)
    handles.s=batch_Dirlik_Miners_damage_stress_psd_Basquin_mean; 
end
if(n==4)
    handles.s=batch_Dirlik_relative_damage_response_PSD; 
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

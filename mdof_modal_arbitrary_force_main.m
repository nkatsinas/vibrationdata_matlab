function varargout = mdof_modal_arbitrary_force_main(varargin)
% MDOF_MODAL_ARBITRARY_FORCE_MAIN MATLAB code for mdof_modal_arbitrary_force_main.fig
%      MDOF_MODAL_ARBITRARY_FORCE_MAIN, by itself, creates a new MDOF_MODAL_ARBITRARY_FORCE_MAIN or raises the existing
%      singleton*.
%
%      H = MDOF_MODAL_ARBITRARY_FORCE_MAIN returns the handle to a new MDOF_MODAL_ARBITRARY_FORCE_MAIN or the handle to
%      the existing singleton*.
%
%      MDOF_MODAL_ARBITRARY_FORCE_MAIN('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MDOF_MODAL_ARBITRARY_FORCE_MAIN.M with the given input arguments.
%
%      MDOF_MODAL_ARBITRARY_FORCE_MAIN('Property','Value',...) creates a new MDOF_MODAL_ARBITRARY_FORCE_MAIN or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before mdof_modal_arbitrary_force_main_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to mdof_modal_arbitrary_force_main_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help mdof_modal_arbitrary_force_main

% Last Modified by GUIDE v2.5 15-Nov-2016 19:35:59

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @mdof_modal_arbitrary_force_main_OpeningFcn, ...
                   'gui_OutputFcn',  @mdof_modal_arbitrary_force_main_OutputFcn, ...
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


% --- Executes just before mdof_modal_arbitrary_force_main is made visible.
function mdof_modal_arbitrary_force_main_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to mdof_modal_arbitrary_force_main (see VARARGIN)

% Choose default command line output for mdof_modal_arbitrary_force_main
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes mdof_modal_arbitrary_force_main wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = mdof_modal_arbitrary_force_main_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton_analyze_multiple.
function pushbutton_analyze_multiple_Callback(~, eventdata, handles)
% hObject    handle to pushbutton_analyze_multiple (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


n=get(handles.listbox_analysis2,'Value');


if(n==1)
    handles.s=nm_mdof_modal_arbitrary_force;
end
if(n==2)
    handles.s=ri_mdof_modal_arbitrary_force;
end

set(handles.s,'Visible','on')


% --- Executes on button press in pushbutton_return.
function pushbutton_return_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_return (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

delete(mdof_modal_arbitrary_force_main);


% --- Executes on selection change in listbox_analysis2.
function listbox_analysis2_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_analysis2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_analysis2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_analysis2





% --- Executes during object creation, after setting all properties.
function listbox_analysis2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_analysis2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_analysis2.
function listbox2_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_analysis2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_analysis2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_analysis2


% --- Executes during object creation, after setting all properties.
function listbox2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_analysis2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_analyze_single.
function pushbutton_analyze_single_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_analyze_single (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

n=get(handles.listbox_analysis1,'Value');

if(n==1)
    handles.s=nm_mdof_modal_arbitrary_single_force;
end

set(handles.s,'Visible','on')


% --- Executes on selection change in listbox_analysis1.
function listbox_analysis1_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_analysis1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_analysis1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_analysis1


% --- Executes during object creation, after setting all properties.
function listbox_analysis1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_analysis1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

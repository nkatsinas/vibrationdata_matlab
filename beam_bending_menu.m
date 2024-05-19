function varargout = beam_bending_menu(varargin)
% BEAM_BENDING_MENU MATLAB code for beam_bending_menu.fig
%      BEAM_BENDING_MENU, by itself, creates a new BEAM_BENDING_MENU or raises the existing
%      singleton*.
%
%      H = BEAM_BENDING_MENU returns the handle to a new BEAM_BENDING_MENU or the handle to
%      the existing singleton*.
%
%      BEAM_BENDING_MENU('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in BEAM_BENDING_MENU.M with the given input arguments.
%
%      BEAM_BENDING_MENU('Property','Value',...) creates a new BEAM_BENDING_MENU or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before beam_bending_menu_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to beam_bending_menu_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help beam_bending_menu

% Last Modified by GUIDE v2.5 06-Feb-2017 09:14:34

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @beam_bending_menu_OpeningFcn, ...
                   'gui_OutputFcn',  @beam_bending_menu_OutputFcn, ...
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


% --- Executes just before beam_bending_menu is made visible.
function beam_bending_menu_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to beam_bending_menu (see VARARGIN)

% Choose default command line output for beam_bending_menu
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes beam_bending_menu wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = beam_bending_menu_OutputFcn(hObject, eventdata, handles) 
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

delete(beam_bending_menu);


% --- Executes on button press in pushbutton_analysis.
function pushbutton_analysis_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_analysis (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

n=get(handles.listbox_analysis,'Value');

if(n==1)
    handles.s=beam_bending_a;
end 
if(n==2)
    handles.s=beam_bending_composite_laminate;
end
if(n==3)
    handles.s=cantilever_beam_point_mass;
end
if(n==4)
    handles.s=cantilever_beam_force_free_end;
end
if(n==5)
    handles.s=Timoshenko_beam;
end
if(n==6)
    handles.s=vibrationdata_beam_multispan;
end

try
    set(handles.s,'Visible','on')
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


% --- Executes on selection change in listbox_analysis_FEA.
function listbox_analysis_FEA_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_analysis_FEA (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_analysis_FEA contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_analysis_FEA


% --- Executes during object creation, after setting all properties.
function listbox_analysis_FEA_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_analysis_FEA (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_analysis_FEA.
function pushbutton_analysis_FEA_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_analysis_FEA (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

n=get(handles.listbox_analysis_FEA,'Value');

if(n==1)
    beam_bending_FEA_a;
end
if(n==2)
    handles.s=beam_springs;
end
if(n==3)
    handles.s=rotating_beam;
end
if(n==4)
    handles.s=beam_wavelength_FEA;
end
if(n==5)
    handles.s=beam_column_FEA;
end
if(n==6)
    handles.s=beam_column_static_inertia_relief;
end
if(n==7)
    handles.s=beam_column_static_inertia_relief_6dof;
end
if(n==8)
    handles.s=multispan_beam_FEA;
end
if(n==9)
    handles.s=multispan_beam_bends_FEA;
end

try
    set(handles.s,'Visible','on')
catch
end

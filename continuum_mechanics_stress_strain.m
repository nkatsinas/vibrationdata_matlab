function varargout = continuum_mechanics_stress_strain(varargin)
% CONTINUUM_MECHANICS_STRESS_STRAIN MATLAB code for continuum_mechanics_stress_strain.fig
%      CONTINUUM_MECHANICS_STRESS_STRAIN, by itself, creates a new CONTINUUM_MECHANICS_STRESS_STRAIN or raises the existing
%      singleton*.
%
%      H = CONTINUUM_MECHANICS_STRESS_STRAIN returns the handle to a new CONTINUUM_MECHANICS_STRESS_STRAIN or the handle to
%      the existing singleton*.
%
%      CONTINUUM_MECHANICS_STRESS_STRAIN('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CONTINUUM_MECHANICS_STRESS_STRAIN.M with the given input arguments.
%
%      CONTINUUM_MECHANICS_STRESS_STRAIN('Property','Value',...) creates a new CONTINUUM_MECHANICS_STRESS_STRAIN or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before continuum_mechanics_stress_strain_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to continuum_mechanics_stress_strain_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help continuum_mechanics_stress_strain

% Last Modified by GUIDE v2.5 23-Apr-2016 14:45:32

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @continuum_mechanics_stress_strain_OpeningFcn, ...
                   'gui_OutputFcn',  @continuum_mechanics_stress_strain_OutputFcn, ...
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


% --- Executes just before continuum_mechanics_stress_strain is made visible.
function continuum_mechanics_stress_strain_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to continuum_mechanics_stress_strain (see VARARGIN)

% Choose default command line output for continuum_mechanics_stress_strain
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes continuum_mechanics_stress_strain wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = continuum_mechanics_stress_strain_OutputFcn(hObject, eventdata, handles) 
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

n=get(handles.listbox_analysis,'Value');

if(n==1)
     handles.s=principal_stress_strain;
end
if(n==2)
     handles.s=stress_plane_normal;
end
if(n==3)
     handles.s=stress_from_plane_strain;
end
if(n==4)
     handles.s=tensor_coordinate_frame_transformation;
end
if(n==5)
     handles.s=cylinder_torsion;
end
if(n==6)
     handles.s=deviatoric_stress_tensor;
end
if(n==7)
     handles.s=octahedral_stress;
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


% --- Executes on button press in pushbutton_return.
function pushbutton_return_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_return (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

delete(continuum_mechanics_stress_strain);

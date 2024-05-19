function varargout = structural_dynamics_old(varargin)
% STRUCTURAL_DYNAMICS_OLD MATLAB code for structural_dynamics_old.fig
%      STRUCTURAL_DYNAMICS_OLD, by itself, creates a new STRUCTURAL_DYNAMICS_OLD or raises the existing
%      singleton*.
%
%      H = STRUCTURAL_DYNAMICS_OLD returns the handle to a new STRUCTURAL_DYNAMICS_OLD or the handle to
%      the existing singleton*.
%
%      STRUCTURAL_DYNAMICS_OLD('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in STRUCTURAL_DYNAMICS_OLD.M with the given input arguments.
%
%      STRUCTURAL_DYNAMICS_OLD('Property','Value',...) creates a new STRUCTURAL_DYNAMICS_OLD or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before structural_dynamics_old_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to structural_dynamics_old_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help structural_dynamics_old

% Last Modified by GUIDE v2.5 29-Aug-2018 15:34:21

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @structural_dynamics_old_OpeningFcn, ...
                   'gui_OutputFcn',  @structural_dynamics_old_OutputFcn, ...
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


% --- Executes just before structural_dynamics_old is made visible.
function structural_dynamics_old_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to structural_dynamics_old (see VARARGIN)

% Choose default command line output for structural_dynamics_old
handles.output = hObject;

set(handles.listbox_systems,'Value',1);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes structural_dynamics_old wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = structural_dynamics_old_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton_sdof_fn.
function pushbutton_sdof_fn_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_sdof_fn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.s=sdof_fn;
set(handles.s,'Visible','on'); 


% --- Executes on button press in pushbutton_return.
function pushbutton_return_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_return (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
delete(structural_dynamics);


% --- Executes on button press in pushbutton_twodof_fn.
function pushbutton_twodof_fn_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_twodof_fn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.s=two_dof_system;
set(handles.s,'Visible','on');


% --- Executes on button press in pushbutton_rod_longitudinal.
function pushbutton_rod_longitudinal_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_rod_longitudinal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.s=beam_longitudinal;
set(handles.s,'Visible','on');


% --- Executes on button press in pushbutton_beam_bending.
function pushbutton_beam_bending_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_beam_bending (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.s=beam_bending;
set(handles.s,'Visible','on');


% --- Executes on selection change in listbox_systems.
function listbox_systems_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_systems (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_systems contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_systems


% --- Executes during object creation, after setting all properties.
function listbox_systems_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_systems (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_systems.
function pushbutton_systems_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_systems (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

n=get(handles.listbox_systems,'Value');

if(n==1)
    handles.s=vibrationdata_spring_mass_system;
end
if(n==2)
    handles.s=beam_longitudinal;
end
if(n==3)
    handles.s=shaft_torsional;
end
if(n==4)
    handles.s=Holzer_torsional;
end 
if(n==5)
    handles.s=beam_bending_menu;
end 
if(n==6)
    handles.s=structural_dynamics_plates;
end 
if(n==7)
    handles.s=vibrationdata_inplane_rectangular_plate_fea;
end 
if(n==8)
    handles.s=rings_cylinders;
end  
if(n==9)
    handles.s=tall_building;
end  

set(handles.s,'Visible','on');


% --- Executes on selection change in listbox_eigen.
function listbox_eigen_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_eigen (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_eigen contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_eigen


% --- Executes on selection change in listbox_eigen.
function listbox_misc_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_eigen (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_eigen contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_eigen


% --- Executes during object creation, after setting all properties.
function listbox_eigen_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_eigen (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function listbox_misc_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_eigen (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in pushbutton_eigen.
function pushbutton_eigen_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_eigen (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

n=get(handles.listbox_eigen,'Value');

if(n==1)
    handles.s=vibrationdata_generalized_eigenvalue;
end  
if(n==2)
    handles.s=vibrationdata_standard_eigenvalue;
end  
if(n==3)
    handles.s=vibrationdata_convert_general_standard;
end  
if(n==4)
    handles.s=vibrationdata_tridiagonal;
end  

 
set(handles.s,'Visible','on')


% --- Executes on button press in pushbutton_misc.
function pushbutton_misc_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_misc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

n=get(handles.listbox_misc,'Value');

if(n==1)
    handles.s=transfer_functions_from_modes;
end  
if(n==2)
    handles.s=damping_coefficient_matrix;
end  
if(n==3)
    handles.s=vibrationdata_stress_velocity;
end  
if(n==4)
    handles.s=Dunkerley;
end  
if(n==5)
    handles.s=nastran_toolbox;
end  
 
set(handles.s,'Visible','on')

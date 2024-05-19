function varargout = mass_stiffness_matrices(varargin)
% MASS_STIFFNESS_MATRICES MATLAB code for mass_stiffness_matrices.fig
%      MASS_STIFFNESS_MATRICES, by itself, creates a new MASS_STIFFNESS_MATRICES or raises the existing
%      singleton*.
%
%      H = MASS_STIFFNESS_MATRICES returns the handle to a new MASS_STIFFNESS_MATRICES or the handle to
%      the existing singleton*.
%
%      MASS_STIFFNESS_MATRICES('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MASS_STIFFNESS_MATRICES.M with the given input arguments.
%
%      MASS_STIFFNESS_MATRICES('Property','Value',...) creates a new MASS_STIFFNESS_MATRICES or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before mass_stiffness_matrices_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to mass_stiffness_matrices_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help mass_stiffness_matrices

% Last Modified by GUIDE v2.5 17-Dec-2014 11:40:50

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @mass_stiffness_matrices_OpeningFcn, ...
                   'gui_OutputFcn',  @mass_stiffness_matrices_OutputFcn, ...
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


% --- Executes just before mass_stiffness_matrices is made visible.
function mass_stiffness_matrices_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to mass_stiffness_matrices (see VARARGIN)

% Choose default command line output for mass_stiffness_matrices
handles.output = hObject;

set(handles.pushbutton_save,'Enable','off');

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes mass_stiffness_matrices wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = mass_stiffness_matrices_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function edit_save_fn_Callback(hObject, eventdata, handles)
% hObject    handle to edit_save_fn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_save_fn as text
%        str2double(get(hObject,'String')) returns contents of edit_save_fn as a double


% --- Executes during object creation, after setting all properties.
function edit_save_fn_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_save_fn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_save_modeshapes_Callback(hObject, eventdata, handles)
% hObject    handle to edit_save_modeshapes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_save_modeshapes as text
%        str2double(get(hObject,'String')) returns contents of edit_save_modeshapes as a double


% --- Executes during object creation, after setting all properties.
function edit_save_modeshapes_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_save_modeshapes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_save.
function pushbutton_save_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

fn = getappdata(0,'fn');
ModeShapes =getappdata(0,'ModeShapes');

fn_name=get(handles.edit_save_fn,'String');
assignin('base', fn_name,fn);

ModeShapes_name=get(handles.edit_save_modeshapes,'String');
assignin('base',ModeShapes_name,ModeShapes);

h = msgbox('Save Complete'); 

function edit_mass_Callback(hObject, eventdata, handles)
% hObject    handle to edit_mass (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_mass as text
%        str2double(get(hObject,'String')) returns contents of edit_mass as a double


% --- Executes during object creation, after setting all properties.
function edit_mass_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_mass (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_stiffness_Callback(hObject, eventdata, handles)
% hObject    handle to edit_stiffness (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_stiffness as text
%        str2double(get(hObject,'String')) returns contents of edit_stiffness as a double


% --- Executes during object creation, after setting all properties.
function edit_stiffness_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_stiffness (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

FS=get(handles.edit_mass,'String');
mass=evalin('base',FS); 
   
FS=get(handles.edit_stiffness,'String');
stiffness=evalin('base',FS); 



[fn,omega,ModeShapes,MST]=Generalized_Eigen(stiffness,mass,2);
%
disp('         Natural      ');
disp('Mode   Frequency(Hz)  ');
%    
mmm=MST*mass*ModeShapes;   
%
clear length;
dof=length(fn);

set(handles.pushbutton_save,'Enable','off');

if(dof>=1)
    
    msgbox('Results written to Matlab Command Window');
    
    for i=1:dof
        out1 = sprintf('%d  %10.4g ',i,fn(i) );
        disp(out1);
    end

    ModeShapes
    
    fn=fix_size(fn);
    
    setappdata(0,'fn',fn);
    setappdata(0,'ModeShapes',ModeShapes);
    
    set(handles.pushbutton_save,'Enable','on');
    
end




% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

delete(mass_stiffness_matrices);


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



function edit_modes_shapes_Callback(hObject, eventdata, handles)
% hObject    handle to edit_modes_shapes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_modes_shapes as text
%        str2double(get(hObject,'String')) returns contents of edit_modes_shapes as a double


% --- Executes during object creation, after setting all properties.
function edit_modes_shapes_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_modes_shapes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

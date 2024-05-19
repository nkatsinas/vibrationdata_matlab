function varargout = vibrationdata_generalized_eigenvalue(varargin)
% VIBRATIONDATA_GENERALIZED_EIGENVALUE MATLAB code for vibrationdata_generalized_eigenvalue.fig
%      VIBRATIONDATA_GENERALIZED_EIGENVALUE, by itself, creates a new VIBRATIONDATA_GENERALIZED_EIGENVALUE or raises the existing
%      singleton*.
%
%      H = VIBRATIONDATA_GENERALIZED_EIGENVALUE returns the handle to a new VIBRATIONDATA_GENERALIZED_EIGENVALUE or the handle to
%      the existing singleton*.
%
%      VIBRATIONDATA_GENERALIZED_EIGENVALUE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in VIBRATIONDATA_GENERALIZED_EIGENVALUE.M with the given input arguments.
%
%      VIBRATIONDATA_GENERALIZED_EIGENVALUE('Property','Value',...) creates a new VIBRATIONDATA_GENERALIZED_EIGENVALUE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before vibrationdata_generalized_eigenvalue_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to vibrationdata_generalized_eigenvalue_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help vibrationdata_generalized_eigenvalue

% Last Modified by GUIDE v2.5 26-Mar-2014 18:00:03

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @vibrationdata_generalized_eigenvalue_OpeningFcn, ...
                   'gui_OutputFcn',  @vibrationdata_generalized_eigenvalue_OutputFcn, ...
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


% --- Executes just before vibrationdata_generalized_eigenvalue is made visible.
function vibrationdata_generalized_eigenvalue_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to vibrationdata_generalized_eigenvalue (see VARARGIN)

% Choose default command line output for vibrationdata_generalized_eigenvalue
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes vibrationdata_generalized_eigenvalue wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = vibrationdata_generalized_eigenvalue_OutputFcn(hObject, eventdata, handles) 
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

delete(vibrationdata_generalized_eigenvalue);

% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


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

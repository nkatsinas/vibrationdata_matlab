function varargout = vibrationdata_convert_general_standard(varargin)
% VIBRATIONDATA_CONVERT_GENERAL_STANDARD MATLAB code for vibrationdata_convert_general_standard.fig
%      VIBRATIONDATA_CONVERT_GENERAL_STANDARD, by itself, creates a new VIBRATIONDATA_CONVERT_GENERAL_STANDARD or raises the existing
%      singleton*.
%
%      H = VIBRATIONDATA_CONVERT_GENERAL_STANDARD returns the handle to a new VIBRATIONDATA_CONVERT_GENERAL_STANDARD or the handle to
%      the existing singleton*.
%
%      VIBRATIONDATA_CONVERT_GENERAL_STANDARD('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in VIBRATIONDATA_CONVERT_GENERAL_STANDARD.M with the given input arguments.
%
%      VIBRATIONDATA_CONVERT_GENERAL_STANDARD('Property','Value',...) creates a new VIBRATIONDATA_CONVERT_GENERAL_STANDARD or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before vibrationdata_convert_general_standard_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to vibrationdata_convert_general_standard_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help vibrationdata_convert_general_standard

% Last Modified by GUIDE v2.5 28-Jul-2016 16:20:46

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @vibrationdata_convert_general_standard_OpeningFcn, ...
                   'gui_OutputFcn',  @vibrationdata_convert_general_standard_OutputFcn, ...
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


% --- Executes just before vibrationdata_convert_general_standard is made visible.
function vibrationdata_convert_general_standard_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to vibrationdata_convert_general_standard (see VARARGIN)

% Choose default command line output for vibrationdata_convert_general_standard
handles.output = hObject;

set(handles.pushbutton_eigenvalue,'Enable','off');
set(handles.uipanel_Kstandard,'Visible','off');
set(handles.uipanel_save_eigen,'Visible','off');

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes vibrationdata_convert_general_standard wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = vibrationdata_convert_general_standard_OutputFcn(hObject, eventdata, handles) 
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

delete(vibrationdata_convert_general_standard);

% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton_convert.
function pushbutton_convert_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_convert (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

disp(' ');
disp(' * * * * * * * * * ');
disp(' ');

FS=get(handles.edit_mass,'String');
mass=evalin('base',FS); 
   
FS=get(handles.edit_stiffness,'String');
stiffness=evalin('base',FS); 

[Kstandard,~,~,Qinv]=Kstandard_LU(mass,stiffness);

Kstandard

setappdata(0,'Kstandard',Kstandard);
setappdata(0,'Qinv',Qinv);

set(handles.pushbutton_eigenvalue,'Enable','on');

set(handles.uipanel_Kstandard,'Visible','on');

msgbox('Results written to Matlab Command Window');




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


% --- Executes on button press in pushbutton_eigenvalue.
function pushbutton_eigenvalue_Callback(~, eventdata, handles)
% hObject    handle to pushbutton_eigenvalue (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

Kstandard=getappdata(0,'Kstandard');
Qinv=getappdata(0,'Qinv');

[fn,~,ModeShapes,~]=Standard_Eigen(Kstandard,2);
%
disp('         Natural      ');
disp('Mode   Frequency(Hz)  ');
%    
%
clear length;
dof=length(fn);

    
    for i=1:dof
        out1 = sprintf('%d  %10.4g ',i,fn(i) );
        disp(out1);
    end

     Mass_ModeShapes=Qinv*ModeShapes;
    
    if(dof<=8)
        disp(' ');
        disp(' Normalized Mode Shapes from Standard System ');
        ModeShapes
        
        disp(' Mass Normalized Mode Shapes ');        
        Mass_ModeShapes
    end
    
    
    fn=fix_size(fn);
    
    setappdata(0,'fn',fn(:,1));
    setappdata(0,'ModeShapes',Mass_ModeShapes);
    
    set(handles.uipanel_save_eigen,'Visible','on');
    
    msgbox('Results written to Matlab Command Window');    





% --- Executes on key press with focus on edit_mass and none of its controls.
function edit_mass_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_mass (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.pushbutton_eigenvalue,'Enable','off');
set(handles.uipanel_Kstandard,'Visible','off');
set(handles.uipanel_save_eigen,'Visible','off');


% --- Executes on key press with focus on edit_stiffness and none of its controls.
function edit_stiffness_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_stiffness (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.pushbutton_eigenvalue,'Enable','off');
set(handles.uipanel_Kstandard,'Visible','off');
set(handles.uipanel_save_eigen,'Visible','off');

function edit_save_Kstandard_Callback(hObject, eventdata, handles)
% hObject    handle to edit_save_Kstandard (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_save_Kstandard as text
%        str2double(get(hObject,'String')) returns contents of edit_save_Kstandard as a double


% --- Executes during object creation, after setting all properties.
function edit_save_Kstandard_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_save_Kstandard (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_save_Kstandard.
function pushbutton_save_Kstandard_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_save_Kstandard (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

Kstandard=getappdata(0,'Kstandard');

Kstandard_name=get(handles.edit_save_Kstandard,'String');
assignin('base',Kstandard_name,Kstandard);

h = msgbox('Save Complete'); 

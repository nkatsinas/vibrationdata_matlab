function varargout = vibrationdata_tridiagonal(varargin)
% VIBRATIONDATA_TRIDIAGONAL MATLAB code for vibrationdata_tridiagonal.fig
%      VIBRATIONDATA_TRIDIAGONAL, by itself, creates a new VIBRATIONDATA_TRIDIAGONAL or raises the existing
%      singleton*.
%
%      H = VIBRATIONDATA_TRIDIAGONAL returns the handle to a new VIBRATIONDATA_TRIDIAGONAL or the handle to
%      the existing singleton*.
%
%      VIBRATIONDATA_TRIDIAGONAL('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in VIBRATIONDATA_TRIDIAGONAL.M with the given input arguments.
%
%      VIBRATIONDATA_TRIDIAGONAL('Property','Value',...) creates a new VIBRATIONDATA_TRIDIAGONAL or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before vibrationdata_tridiagonal_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to vibrationdata_tridiagonal_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help vibrationdata_tridiagonal

% Last Modified by GUIDE v2.5 29-Jul-2016 12:38:17

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @vibrationdata_tridiagonal_OpeningFcn, ...
                   'gui_OutputFcn',  @vibrationdata_tridiagonal_OutputFcn, ...
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


% --- Executes just before vibrationdata_tridiagonal is made visible.
function vibrationdata_tridiagonal_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to vibrationdata_tridiagonal (see VARARGIN)

% Choose default command line output for vibrationdata_tridiagonal
handles.output = hObject;

set(handles.pushbutton_eigenvalue,'Enable','off');
set(handles.uipanel_Kstandard,'Visible','off');
set(handles.uipanel_save_eigen,'Visible','off');

listbox_type_Callback(hObject, eventdata, handles);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes vibrationdata_tridiagonal wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = vibrationdata_tridiagonal_OutputFcn(hObject, eventdata, handles) 
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

delete(vibrationdata_tridiagonal);

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

ntype=get(handles.listbox_type,'Value');

FS=get(handles.edit_stiffness,'String');
stiffness=evalin('base',FS); 
KS=stiffness;

if(ntype==1)
    FS=get(handles.edit_mass,'String');
    mass=evalin('base',FS);
    
    [Kstandard,~,~,Qinv]=Kstandard_LU(mass,stiffness);

    Kstandard
    
    KS=Kstandard;

    setappdata(0,'Kstandard',Kstandard);
    setappdata(0,'Qinv',Qinv);    
end
   
[Q,Ktridiagonal] = hess(KS);

setappdata(0,'Q',Q);

th=(1.0e-08)*max(max(abs(Ktridiagonal)));

Ktridiagonal(abs(Ktridiagonal)<th) = 0;

setappdata(0,'Ktridiagonal',Ktridiagonal);

Ktridiagonal

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

ntype=get(handles.listbox_type,'Value');

Ktridiagonal=getappdata(0,'Ktridiagonal');

[fn,~,ModeShapes,~]=Standard_Eigen(Ktridiagonal,2);
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

Q=getappdata(0,'Q');
    
disp(' ');

if(ntype==1)
    
    Qinv=getappdata(0,'Qinv');
    Mass_ModeShapes=Qinv*(Q*ModeShapes);
    
    if(dof<=8)
        disp(' Mass Normalized Mode Shapes ');        
        Mass_ModeShapes
    end
    setappdata(0,'ModeShapes',Mass_ModeShapes);    
        
else
    
    Qinv=getappdata(0,'Qinv');
    ModeShapes=Qinv*(Q*ModeShapes);
    
    if(dof<=8)
        disp(' Mode Shapes ');        
        ModeShapes
    end
    setappdata(0,'ModeShapes',ModeShapes);    
    
end   
    
fn=fix_size(fn);   
setappdata(0,'fn',fn(:,1));  
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

function edit_save_Ktridiagonal_Callback(hObject, eventdata, handles)
% hObject    handle to edit_save_Ktridiagonal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_save_Ktridiagonal as text
%        str2double(get(hObject,'String')) returns contents of edit_save_Ktridiagonal as a double


% --- Executes during object creation, after setting all properties.
function edit_save_Ktridiagonal_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_save_Ktridiagonal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_save_Ktridiagonal.
function pushbutton_save_Ktridiagonal_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_save_Ktridiagonal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

Ktridiagonal=getappdata(0,'Ktridiagonal');

Ktridiagonal_name=get(handles.edit_save_Ktridiagonal,'String');
assignin('base',Ktridiagonal_name,Ktridiagonal);

h = msgbox('Save Complete'); 


% --- Executes on selection change in listbox_type.
function listbox_type_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_type contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_type

n=get(handles.listbox_type,'Value');

if(n==1)
    
    set(handles.text_mass,'Visible','on');
    set(handles.edit_mass,'Visible','on');    
    
else
    
    set(handles.text_mass,'Visible','off');
    set(handles.edit_mass,'Visible','off');  

end


% --- Executes during object creation, after setting all properties.
function listbox_type_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_Kstandard.
function pushbutton_Kstandard_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_Kstandard (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

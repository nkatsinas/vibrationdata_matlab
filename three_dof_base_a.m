function varargout = three_dof_base_a(varargin)
% THREE_DOF_BASE_A MATLAB code for three_dof_base_a.fig
%      THREE_DOF_BASE_A, by itself, creates a new THREE_DOF_BASE_A or raises the existing
%      singleton*.
%
%      H = THREE_DOF_BASE_A returns the handle to a new THREE_DOF_BASE_A or the handle to
%      the existing singleton*.
%
%      THREE_DOF_BASE_A('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in THREE_DOF_BASE_A.M with the given input arguments.
%
%      THREE_DOF_BASE_A('Property','Value',...) creates a new THREE_DOF_BASE_A or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before three_dof_base_a_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to three_dof_base_a_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help three_dof_base_a

% Last Modified by GUIDE v2.5 03-Jan-2017 11:32:21

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @three_dof_base_a_OpeningFcn, ...
                   'gui_OutputFcn',  @three_dof_base_a_OutputFcn, ...
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


% --- Executes just before three_dof_base_a is made visible.
function three_dof_base_a_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to three_dof_base_a (see VARARGIN)

% Choose default command line output for three_dof_base_a
handles.output = hObject;

clc;
 
fstr='three_dof_base_ai.jpg';
 
bg = imread(fstr);
info = imfinfo(fstr);
w = info.Width;  %An integer indicating the width of the image in pixels
h = info.Height; %An integer indicating the height of the image in pixels
 
axes(handles.axes1);
image(bg);
 
pos1 = getpixelposition(handles.pushbutton_return,true);
pos2 = getpixelposition(handles.uipanel_enter_data,true);
 
set(handles.axes1, ...
    'Visible', 'off', ...
    'Units', 'pixels', ...
    'Position', [pos1(1) pos2(2) w h]);
axis off;


% Update handles structure
guidata(hObject, handles);

% UIWAIT makes three_dof_base_a wait for user response (see UIRESUME)
% uiwait(handles.figure1);

function clear_buttons(hObject, eventdata, handles)
set(handles.enter_damping_pushbutton,'Visible','off');
set(handles.transmissibility_pushbutton,'Visible','off');
set(handles.steady_sine_pushbutton,'Visible','off');
set(handles.arbitrary_pulse_pushbutton,'Visible','off');
set(handles.PSD_pushbutton,'Visible','off');


% --- Outputs from this function are returned to the command line.
function varargout = three_dof_base_a_OutputFcn(hObject, eventdata, handles) 
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
close(three_dof_base_a);


% --- Executes on button press in calculate_pushbutton.
function calculate_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to calculate_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
iu=get(handles.units_listbox,'value');

mb=str2num( get(handles.massb_edit,'String' ));
m1=str2num( get(handles.mass1_edit,'String' ));
m2=str2num( get(handles.mass2_edit,'String' ));
k1=str2num( get(handles.stiffness1_edit,'String' ));
k2=str2num( get(handles.stiffness2_edit,'String' ));

mass=zeros(3,3);

mass(1,1)=mb;
mass(2,2)=m1;
mass(3,3)=m2;


stiffness=[ k1 -k1 0; -k1 (k1+k2) -k2; 0 -k2 k2];

%
if(iu==1)
   mb=mb/386;
   mass=mass/386.;
end
%
disp(' ');
[fn,omega,ModeShapes,MST]=Generalized_Eigen(stiffness,mass,2);
%
disp(' ');
dof=length(fn);
%
disp(' ');
%
v=ones(1,dof);
%
disp('        Natural    Participation    Effective  ');
disp('Mode   Frequency      Factor        Modal Mass ');
%
LM=MST*mass*v';
pf=LM;
sum=0;
%    
mmm=MST*mass*ModeShapes;   
%
for i=1:dof
        pff(i)=pf(i)/mmm(i,i);
        emm(i)=pf(i)^2/mmm(i,i);
        out1 = sprintf('%d  %10.4g Hz   %10.4g   %10.4g',i,fn(i),pff(i),emm(i) );
        disp(out1)
        sum=sum+emm(i);
end
out1=sprintf('\n modal mass sum = %8.4g \n',sum);
disp(out1);

disp(' ');
disp(' mass matrix ');
mass
disp(' ');
disp(' stiffness matrix ');
stiffness
disp(' ');
ModeShapes
%

setappdata(0,'base_mass',mb);
setappdata(0,'unit',iu);
setappdata(0,'m2',mass);
setappdata(0,'k2',stiffness);
setappdata(0,'fn',fn);
setappdata(0,'ModeShapes',ModeShapes);

assignin('base','three_dof_mass',mass);
assignin('base','three_dof_stiffness',stiffness);
    
disp(' ');
disp('  mass & stiffness matrices saved in workspace as: ');
disp('        ');
disp('     three_dof_mass');
disp('     three_dof_stiffness');

PF=pf;
if(iu==1)
    PF=PF/386;
end

setappdata(0,'pff',pff);
setappdata(0,'PF',PF);

set(handles.enter_damping_pushbutton,'Visible','on');

guidata(hObject, handles);
%
%
msgbox('Calculation complete.  Output written to Matlab Command Window.');




% --- Executes on button press in enter_damping_pushbutton.
function enter_damping_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to enter_damping_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.two_dof_c= generic_damping;
set(handles.two_dof_c,'Visible','on');

set(handles.transmissibility_pushbutton,'Visible','on');
set(handles.steady_sine_pushbutton,'Visible','on');
set(handles.arbitrary_pulse_pushbutton,'Visible','on');
set(handles.PSD_pushbutton,'Visible','on');


% --- Executes on button press in transmissibility_pushbutton.
function transmissibility_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to transmissibility_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.s= three_dof_transmissibility;
set(handles.s,'Visible','on');


% --- Executes on button press in steady_sine_pushbutton.
function steady_sine_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to steady_sine_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.s=three_dof_sine_force_seismic_base;
set(handles.s,'Visible','on');


% --- Executes on button press in half_sine_pushbutton.
function half_sine_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to half_sine_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.s= two_dof_half_sine;
set(handles.s,'Visible','on');



% --- Executes on button press in arbitrary_pulse_pushbutton.
function arbitrary_pulse_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to arbitrary_pulse_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.s= three_dof_arbitrary_seismic_base;
set(handles.s,'Visible','on');

% --- Executes on button press in PSD_pushbutton.
function PSD_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to PSD_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%% warndlg('Option to added in next revision');
%% return;

handles.s= three_dof_PSD_base;
set(handles.s,'Visible','on');



function mass1_edit_Callback(hObject, eventdata, handles)
% hObject    handle to mass1_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of mass1_edit as text
%        str2double(get(hObject,'String')) returns contents of mass1_edit as a double


% --- Executes during object creation, after setting all properties.
function mass1_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to mass1_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function mass2_edit_Callback(hObject, eventdata, handles)
% hObject    handle to mass2_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of mass2_edit as text
%        str2double(get(hObject,'String')) returns contents of mass2_edit as a double


% --- Executes during object creation, after setting all properties.
function mass2_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to mass2_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function stiffness2_edit_Callback(hObject, eventdata, handles)
% hObject    handle to stiffness2_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of stiffness2_edit as text
%        str2double(get(hObject,'String')) returns contents of stiffness2_edit as a double


% --- Executes during object creation, after setting all properties.
function stiffness2_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to stiffness2_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function stiffness1_edit_Callback(hObject, eventdata, handles)
% hObject    handle to stiffness1_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of stiffness1_edit as text
%        str2double(get(hObject,'String')) returns contents of stiffness1_edit as a double


% --- Executes during object creation, after setting all properties.
function stiffness1_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to stiffness1_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function stiffness3_edit_Callback(hObject, eventdata, handles)
% hObject    handle to stiffness3_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of stiffness3_edit as text
%        str2double(get(hObject,'String')) returns contents of stiffness3_edit as a double


% --- Executes during object creation, after setting all properties.
function stiffness3_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to stiffness3_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in units_listbox.
function units_listbox_Callback(hObject, eventdata, handles)
% hObject    handle to units_listbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns units_listbox contents as cell array
%        contents{get(hObject,'Value')} returns selected item from units_listbox
n=get(hObject,'Value');

if(n==1)
    set(handles.mass_unit_text,'String','Mass Unit: lbm');
    set(handles.stiffness_unit_text,'String','Stiffness Unit: lbf/in');    
else
    set(handles.mass_unit_text,'String','Mass Unit: kg'); 
    set(handles.stiffness_unit_text,'String','Stiffness Unit: N/m');     
end
clear_buttons(hObject, eventdata, handles);

% Update handles structure
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function units_listbox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to units_listbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over mass2_edit.
function mass2_edit_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to mass2_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on key press with focus on mass2_edit and none of its controls.
function mass2_edit_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to mass2_edit (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
clear_buttons(hObject, eventdata, handles);


% --- Executes on key press with focus on stiffness2_edit and none of its controls.
function stiffness2_edit_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to stiffness2_edit (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
clear_buttons(hObject, eventdata, handles);


% --- Executes on key press with focus on mass1_edit and none of its controls.

% hObject    handle to mass1_edit (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on key press with focus on stiffness1_edit and none of its controls.
function stiffness1_edit_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to stiffness1_edit (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
clear_buttons(hObject, eventdata, handles);


% --- Executes on key press with focus on mass1_edit and none of its controls.
function mass1_edit_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to mass1_edit (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
clear_buttons(hObject, eventdata, handles);


% --- Executes on button press in pushbutton_SRS.
function pushbutton_SRS_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_SRS (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)





function massb_edit_Callback(hObject, eventdata, handles)
% hObject    handle to massb_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of massb_edit as text
%        str2double(get(hObject,'String')) returns contents of massb_edit as a double


% --- Executes during object creation, after setting all properties.
function massb_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to massb_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

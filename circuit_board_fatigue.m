function varargout = circuit_board_fatigue(varargin)
% CIRCUIT_BOARD_FATIGUE MATLAB code for circuit_board_fatigue.fig
%      CIRCUIT_BOARD_FATIGUE, by itself, creates a new CIRCUIT_BOARD_FATIGUE or raises the existing
%      singleton*.
%
%      H = CIRCUIT_BOARD_FATIGUE returns the handle to a new CIRCUIT_BOARD_FATIGUE or the handle to
%      the existing singleton*.
%
%      CIRCUIT_BOARD_FATIGUE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CIRCUIT_BOARD_FATIGUE.M with the given input arguments.
%
%      CIRCUIT_BOARD_FATIGUE('Property','Value',...) creates a new CIRCUIT_BOARD_FATIGUE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before circuit_board_fatigue_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to circuit_board_fatigue_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help circuit_board_fatigue

% Last Modified by GUIDE v2.5 07-Apr-2018 12:43:21

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @circuit_board_fatigue_OpeningFcn, ...
                   'gui_OutputFcn',  @circuit_board_fatigue_OutputFcn, ...
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


% --- Executes just before circuit_board_fatigue is made visible.
function circuit_board_fatigue_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to circuit_board_fatigue (see VARARGIN)

% Choose default command line output for circuit_board_fatigue
handles.output = hObject;


set(handles.uipanel_results,'Visible','off');

listbox_unit_Callback(hObject, eventdata, handles);

set(handles.listbox_C,'Value',1);
set(handles.listbox_r,'Value',1);

set(handles.pushbutton_psd_fatigue,'Visible','off');

listbox_C_Callback(hObject, eventdata, handles);

%%%%%%%%%%%%

fstr='Steinberg_equation.png';

bg = imread(fstr);
info = imfinfo(fstr);
w = info.Width;  %An integer indicating the width of the image in pixels
h = info.Height; %An integer indicating the height of the image in pixels
 
axes(handles.axes2);
image(bg);
pos1 = getpixelposition(handles.axes2,true);
 
set(handles.axes2, ...
    'Visible', 'off', ...
    'Units', 'pixels', ...
    'Position', [pos1(1) pos1(2) w h]);
axis off;

%%%%%%%%%%%%



% Update handles structure
guidata(hObject, handles);

% UIWAIT makes circuit_board_fatigue wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = circuit_board_fatigue_OutputFcn(hObject, eventdata, handles) 
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
delete(circuit_board_fatigue);


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

B=str2num(get(handles.edit_B,'String'));
h=str2num(get(handles.edit_h,'String'));
L=str2num(get(handles.edit_L,'String'));

n=get(handles.listbox_unit,'Value');
iu=n;

if(n==2)
    B=B/25.4;
    h=h/25.4;
    L=L/25.4;    
end

nr=get(handles.listbox_r,'Value');

if(nr==1)
    r=1.0;
end
if(nr==2)
    r=0.707;
end
if(nr==3)
    r=0.50;
end

C=str2num(get(handles.edit_C,'String'));

den = C*h*r*sqrt(L);

Z=0.00022*B/den;

if(n==2)
    Z=Z*25.4;
end

zs=sprintf('%8.4g',Z);
set(handles.edit_Z,'String',zs);

zs_shock=sprintf('%8.4g',6*Z);
set(handles.edit_Z_shock,'String',zs_shock);

set(handles.pushbutton_psd_fatigue,'Visible','on');

set(handles.uipanel_results,'Visible','on');

setappdata(0,'iu',iu);
setappdata(0,'zs',zs);
setappdata(0,'z',Z);


function edit_B_Callback(hObject, eventdata, handles)
% hObject    handle to edit_B (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_B as text
%        str2double(get(hObject,'String')) returns contents of edit_B as a double


% --- Executes during object creation, after setting all properties.
function edit_B_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_B (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_h_Callback(hObject, eventdata, handles)
% hObject    handle to edit_h (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_h as text
%        str2double(get(hObject,'String')) returns contents of edit_h as a double


% --- Executes during object creation, after setting all properties.
function edit_h_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_h (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_L_Callback(hObject, eventdata, handles)
% hObject    handle to edit_L (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_L as text
%        str2double(get(hObject,'String')) returns contents of edit_L as a double


% --- Executes during object creation, after setting all properties.
function edit_L_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_L (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_C.
function listbox_C_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_C (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_C contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_C
clear_Z(hObject, eventdata, handles);

n=get(handles.listbox_C,'value');

if(n==1)
    set(handles.listbox_component,'Visible','off');    
else
    set(handles.listbox_component,'Visible','on');
    listbox_component_Callback(hObject, eventdata, handles);
end    



% --- Executes during object creation, after setting all properties.
function listbox_C_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_C (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_r.
function listbox_r_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_r (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_r contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_r
clear_Z(hObject, eventdata, handles);


% --- Executes during object creation, after setting all properties.
function listbox_r_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_r (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_C_Callback(hObject, eventdata, handles)
% hObject    handle to edit_C (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_C as text
%        str2double(get(hObject,'String')) returns contents of edit_C as a double


% --- Executes during object creation, after setting all properties.
function edit_C_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_C (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_component.
function listbox_component_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_component (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_component contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_component
clear_Z(hObject, eventdata, handles);

n=get(handles.listbox_component,'Value');

if(n==1)
    C=0.75;
end
if(n==2)
    C=0.75;
end
if(n==3)
    C=0.75;
end
if(n==4)
    C=1.0;
end
if(n==5)
    C=1.26;
end
if(n==6)
    C=1.0;
end
if(n==7)
    C=2.25;
end
if(n==8)
    C=1.26;
end
if(n==9)
    C=1.75;
end
if(n==10)
    C=0.75;
end
if(n==11)
    C=1.26;
end

Cs=sprintf('%8.4g',C);

set(handles.edit_C,'String',Cs);







% --- Executes during object creation, after setting all properties.
function listbox_component_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_component (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on key press with focus on edit_B and none of its controls.
function edit_B_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_B (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
clear_Z(hObject, eventdata, handles);

% --- Executes on key press with focus on edit_h and none of its controls.
function edit_h_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_h (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
clear_Z(hObject, eventdata, handles);


% --- Executes on key press with focus on edit_L and none of its controls.
function edit_L_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_L (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
clear_Z(hObject, eventdata, handles);



function edit_Z_Callback(hObject, eventdata, handles)
% hObject    handle to edit_Z (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_Z as text
%        str2double(get(hObject,'String')) returns contents of edit_Z as a double


% --- Executes during object creation, after setting all properties.
function edit_Z_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_Z (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function clear_Z(hObject, eventdata, handles)
%
set(handles.edit_Z,'String',' ');

set(handles.pushbutton_psd_fatigue,'Visible','off');


% --- Executes on key press with focus on edit_C and none of its controls.
function edit_C_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_C (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
clear_Z(hObject, eventdata, handles);


% --- Executes on button press in pushbutton_psd_fatigue.
function pushbutton_psd_fatigue_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_psd_fatigue (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.s=Steinberg_PSD_fatigue;

set(handles.s,'Visible','on')


% --- Executes on selection change in listbox_unit.
function listbox_unit_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_unit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_unit contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_unit

n=get(handles.listbox_unit,'Value');

   set(handles.text_uu,'String','inch (3-sigma)  for 20 million cycles'); 

if(n==1)
   set(handles.text_Bu,'String','inch'); 
   set(handles.text_hu,'String','inch'); 
   set(handles.text_Lu,'String','inch'); 
   set(handles.text_Zu,'String','inch (3-sigma)'); 
   set(handles.text_Z_shock_u,'String','inch');
else
   set(handles.text_Bu,'String','mm'); 
   set(handles.text_hu,'String','mm'); 
   set(handles.text_Lu,'String','mm'); 
   set(handles.text_Zu,'String','mm (3-sigma)'); 
   set(handles.text_Z_shock_u,'String','mm');   
end


% --- Executes during object creation, after setting all properties.
function listbox_unit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_unit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_Z_shock_Callback(hObject, eventdata, handles)
% hObject    handle to edit_Z_shock (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_Z_shock as text
%        str2double(get(hObject,'String')) returns contents of edit_Z_shock as a double


% --- Executes during object creation, after setting all properties.
function edit_Z_shock_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_Z_shock (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_eq.
function pushbutton_eq_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_eq (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


iu=getappdata(0,'iu');
z=getappdata(0,'z');

dlg_title=' ';
prompt = {'Enter Natural Frequency (Hz)'};

temp = inputdlg(prompt,dlg_title);

% whos temp

fn=temp{:};

% whos fn

ff=str2num(fn);

% whos ff

omegan=2*pi*ff;

iu=getappdata(0,'iu');
zs=getappdata(0,'zs');

pv=omegan*z;
ac=omegan^2*z;

if(iu==1)
    sdu='in';
    svu='in/sec';
    ac=ac/386;
else
    sdu='mm';
    svu='cm/sec';
    pv=pv/10;
    ac=ac/(1000*9.81);
end

sau='G';

disp(' ');
disp(' * * * * * * * * ');
disp(' ');

out1=sprintf(' Natural Frequency = %g Hz \n',ff);
disp(out1);

disp(' 3-sigma Limits for 20 million cycles ');
disp(' ');

out1=sprintf(' Relative Displacment %8.4g %s',z,sdu);
out2=sprintf(' Pseudo Velocity      %8.4g %s',pv,svu);
out3=sprintf(' Acceleration         %8.4g %s',ac,sau);

disp(out1);
disp(out2);
disp(out3);

disp(' ');
disp(' Peak Limits for 1 Shock ');
disp(' ');

out1=sprintf(' Relative Displacment %8.4g %s',6*z,sdu);
out2=sprintf(' Pseudo Velocity      %8.4g %s',6*pv,svu);
out3=sprintf(' Acceleration         %8.4g %s',6*ac,sau);

disp(out1);
disp(out2);
disp(out3);

disp(' ');



msgbox('Results written to Command Window');

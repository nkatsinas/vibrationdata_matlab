function varargout = response_velocities_two_subsystems(varargin)
% RESPONSE_VELOCITIES_TWO_SUBSYSTEMS MATLAB code for response_velocities_two_subsystems.fig
%      RESPONSE_VELOCITIES_TWO_SUBSYSTEMS, by itself, creates a new RESPONSE_VELOCITIES_TWO_SUBSYSTEMS or raises the existing
%      singleton*.
%
%      H = RESPONSE_VELOCITIES_TWO_SUBSYSTEMS returns the handle to a new RESPONSE_VELOCITIES_TWO_SUBSYSTEMS or the handle to
%      the existing singleton*.
%
%      RESPONSE_VELOCITIES_TWO_SUBSYSTEMS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in RESPONSE_VELOCITIES_TWO_SUBSYSTEMS.M with the given input arguments.
%
%      RESPONSE_VELOCITIES_TWO_SUBSYSTEMS('Property','Value',...) creates a new RESPONSE_VELOCITIES_TWO_SUBSYSTEMS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before response_velocities_two_subsystems_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to response_velocities_two_subsystems_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help response_velocities_two_subsystems

% Last Modified by GUIDE v2.5 21-Dec-2015 15:18:12

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @response_velocities_two_subsystems_OpeningFcn, ...
                   'gui_OutputFcn',  @response_velocities_two_subsystems_OutputFcn, ...
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


% --- Executes just before response_velocities_two_subsystems is made visible.
function response_velocities_two_subsystems_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to response_velocities_two_subsystems (see VARARGIN)

% Choose default command line output for response_velocities_two_subsystems
handles.output = hObject;


clc;

fstr='tcss_a.jpg';
bg = imread(fstr);
info = imfinfo(fstr);
w = info.Width;  %An integer indicating the width of the image in pixels
h = info.Height; %An integer indicating the height of the image in pixels
 
axes(handles.axes1);
image(bg);
pos1 = getpixelposition(handles.axes1,true);
 
set(handles.axes1, ...
    'Visible', 'off', ...
    'Units', 'pixels', ...
    'Position', [pos1(1) pos1(2) w h]);
axis off; 
 

listbox_units_Callback(hObject, eventdata, handles);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes response_velocities_two_subsystems wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = response_velocities_two_subsystems_OutputFcn(hObject, eventdata, handles) 
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

delete(coupling_loss_factors_two_subsystems);


% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

tpi=2*pi;

fc=str2num(get(handles.edit_fc,'String'));

omega=tpi*fc;


iu=get(handles.listbox_units,'value');

m1=str2num(get(handles.edit_m1,'String'));
m2=str2num(get(handles.edit_m2,'String'));
 
 
lf1=str2num(get(handles.edit_lf1,'String'));
lf2=str2num(get(handles.edit_lf2,'String'));

clf_12=str2num(get(handles.edit_clf_12,'String'));
clf_21=str2num(get(handles.edit_clf_21,'String'));

power_1=str2num(get(handles.edit_power_1,'String'));
power_2=str2num(get(handles.edit_power_2,'String'))



A=[ lf1+clf_12  -clf_21  ; -clf_12  lf2+clf_21  ];
B=[ power_1; power_2]/omega;

E=A\B;

E1=E(1);
E2=E(2);


if(iu==1)
    m1=m1/386;
    m2=m2/386;         
end


[v1]=energy_to_velox(E1,m1);
[v2]=energy_to_velox(E2,m2);


if(iu==2)
   v1=v1*1000;
   v2=v2*1000;
end


if(iu==1)
    seu='in-lbf';
    spu='in-lbf/sec';
    spv='in/sec';
else
    seu='J';
    spu='W';
    spv='mm/sec';    
end

disp(' ');
disp(' * * * * ');
disp(' ');

out1=sprintf(' Band Center Frequency = %g Hz \n',fc);
disp(out1);

out1=sprintf(' Input Power 1 = %8.4g %s ',power_1,spu);
out2=sprintf(' Input Power 2 = %8.4g %s \n',power_2,spu);
disp(out1);
disp(out2);

trans_power=omega*( clf_12*E1 - clf_21*E2 );

out1=sprintf(' Transmitted Power Flow 1 to 2 = %8.4g %s \n',trans_power,spu);
disp(out1);

out1=sprintf(' Dissipation Loss Factor 12 = %8.4g ',lf1);
out2=sprintf(' Dissipation Loss Factor 21 = %8.4g \n',lf2);

disp(out1);
disp(out2);

out1=sprintf(' Coupling Loss Factor 12 = %8.4g ',clf_12);
out2=sprintf(' Coupling Loss Factor 21 = %8.4g \n',clf_21);

disp(out1);
disp(out2);

out1=sprintf(' Energy 1 = %8.4g %s',E1,seu);
out2=sprintf(' Energy 2 = %8.4g %s \n',E2,seu);

disp(out1);
disp(out2);


out1=sprintf(' Velocity 1 = %8.4g %s rms',v1,spv);
out2=sprintf(' Velocity 2 = %8.4g %s rms\n',v2,spv);

disp(out1);
disp(out2);


a1=v1*omega;
a2=v2*omega;

if(iu==1)
    a1=a1/386;
    a2=a2/386;    
else
    a1=a1/(1000*9.81);   
    a2=a2/(1000*9.81);    
end

out1=sprintf(' Acceleration 1 = %8.4g G rms',a1);
out2=sprintf(' Acceleration 2 = %8.4g G rms\n',a2);

disp(out1);
disp(out2);

msgbox('Results written to Command Window');








% --- Executes on selection change in listbox_units.
function listbox_units_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_units (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_units contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_units

iu=get(handles.listbox_units,'value');


if(iu==1)
    set(handles.text_m1,'String','Mass 1 (lbm)');
    set(handles.text_m2,'String','Mass 2 (lbm)');
    set(handles.text_power_1,'String','Power 1 (in-lbf/sec)');
    set(handles.text_power_2,'String','Power 2 (in-lbf/sec)');    
else
    set(handles.text_m1,'String','Mass 1 (kg)');
    set(handles.text_m2,'String','Mass 2 (kg)'); 
    set(handles.text_power_1,'String','Power 1 (W)');
    set(handles.text_power_2,'String','Power 2 (W)');     
end




% --- Executes during object creation, after setting all properties.
function listbox_units_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_units (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_fc_Callback(hObject, eventdata, handles)
% hObject    handle to edit_fc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_fc as text
%        str2double(get(hObject,'String')) returns contents of edit_fc as a double


% --- Executes during object creation, after setting all properties.
function edit_fc_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_fc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_m1_Callback(hObject, eventdata, handles)
% hObject    handle to edit_m1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_m1 as text
%        str2double(get(hObject,'String')) returns contents of edit_m1 as a double


% --- Executes during object creation, after setting all properties.
function edit_m1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_m1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_m2_Callback(hObject, eventdata, handles)
% hObject    handle to edit_m2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_m2 as text
%        str2double(get(hObject,'String')) returns contents of edit_m2 as a double


% --- Executes during object creation, after setting all properties.
function edit_m2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_m2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_v1_Callback(hObject, eventdata, handles)
% hObject    handle to edit_v1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_v1 as text
%        str2double(get(hObject,'String')) returns contents of edit_v1 as a double


% --- Executes during object creation, after setting all properties.
function edit_v1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_v1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_v2_Callback(hObject, eventdata, handles)
% hObject    handle to edit_v2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_v2 as text
%        str2double(get(hObject,'String')) returns contents of edit_v2 as a double


% --- Executes during object creation, after setting all properties.
function edit_v2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_v2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_lf1_Callback(hObject, eventdata, handles)
% hObject    handle to edit_lf1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_lf1 as text
%        str2double(get(hObject,'String')) returns contents of edit_lf1 as a double


% --- Executes during object creation, after setting all properties.
function edit_lf1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_lf1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_lf2_Callback(hObject, eventdata, handles)
% hObject    handle to edit_lf2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_lf2 as text
%        str2double(get(hObject,'String')) returns contents of edit_lf2 as a double


% --- Executes during object creation, after setting all properties.
function edit_lf2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_lf2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit3_Callback(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double


% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_md2_Callback(hObject, eventdata, handles)
% hObject    handle to edit_md2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_md2 as text
%        str2double(get(hObject,'String')) returns contents of edit_md2 as a double


% --- Executes during object creation, after setting all properties.
function edit_md2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_md2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_md1_Callback(hObject, eventdata, handles)
% hObject    handle to edit_md1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_md1 as text
%        str2double(get(hObject,'String')) returns contents of edit_md1 as a double


% --- Executes during object creation, after setting all properties.
function edit_md1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_md1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_clf_12_Callback(hObject, eventdata, handles)
% hObject    handle to edit_clf_12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_clf_12 as text
%        str2double(get(hObject,'String')) returns contents of edit_clf_12 as a double


% --- Executes during object creation, after setting all properties.
function edit_clf_12_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_clf_12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_clf_21_Callback(hObject, eventdata, handles)
% hObject    handle to edit_clf_21 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_clf_21 as text
%        str2double(get(hObject,'String')) returns contents of edit_clf_21 as a double


% --- Executes during object creation, after setting all properties.
function edit_clf_21_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_clf_21 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_power_1_Callback(hObject, eventdata, handles)
% hObject    handle to edit_power_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_power_1 as text
%        str2double(get(hObject,'String')) returns contents of edit_power_1 as a double


% --- Executes during object creation, after setting all properties.
function edit_power_1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_power_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function axes1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes1



function edit_power_2_Callback(hObject, eventdata, handles)
% hObject    handle to edit_power_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_power_2 as text
%        str2double(get(hObject,'String')) returns contents of edit_power_2 as a double


% --- Executes during object creation, after setting all properties.
function edit_power_2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_power_2 (see GCBO)
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

     A = imread('velox_two_subsystems.jpg');
     figure(999) 
     imshow(A,'border','tight','InitialMagnification',100) 

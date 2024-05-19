function varargout = coupling_loss_factors_two_subsystems(varargin)
% COUPLING_LOSS_FACTORS_TWO_SUBSYSTEMS MATLAB code for coupling_loss_factors_two_subsystems.fig
%      COUPLING_LOSS_FACTORS_TWO_SUBSYSTEMS, by itself, creates a new COUPLING_LOSS_FACTORS_TWO_SUBSYSTEMS or raises the existing
%      singleton*.
%
%      H = COUPLING_LOSS_FACTORS_TWO_SUBSYSTEMS returns the handle to a new COUPLING_LOSS_FACTORS_TWO_SUBSYSTEMS or the handle to
%      the existing singleton*.
%
%      COUPLING_LOSS_FACTORS_TWO_SUBSYSTEMS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in COUPLING_LOSS_FACTORS_TWO_SUBSYSTEMS.M with the given input arguments.
%
%      COUPLING_LOSS_FACTORS_TWO_SUBSYSTEMS('Property','Value',...) creates a new COUPLING_LOSS_FACTORS_TWO_SUBSYSTEMS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before coupling_loss_factors_two_subsystems_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to coupling_loss_factors_two_subsystems_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help coupling_loss_factors_two_subsystems

% Last Modified by GUIDE v2.5 25-Nov-2015 17:52:06

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @coupling_loss_factors_two_subsystems_OpeningFcn, ...
                   'gui_OutputFcn',  @coupling_loss_factors_two_subsystems_OutputFcn, ...
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


% --- Executes just before coupling_loss_factors_two_subsystems is made visible.
function coupling_loss_factors_two_subsystems_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to coupling_loss_factors_two_subsystems (see VARARGIN)

% Choose default command line output for coupling_loss_factors_two_subsystems
handles.output = hObject;


clc;

fstr='tcss.jpg';

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

% UIWAIT makes coupling_loss_factors_two_subsystems wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = coupling_loss_factors_two_subsystems_OutputFcn(hObject, eventdata, handles) 
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
 
v1=str2num(get(handles.edit_v1,'String'));
v2=str2num(get(handles.edit_v2,'String')); 

n1=str2num(get(handles.edit_md1,'String'));
n2=str2num(get(handles.edit_md2,'String'));
 
lf1=str2num(get(handles.edit_lf1,'String'));
lf2=str2num(get(handles.edit_lf2,'String'));


if(iu==1)
    m1=m1/386;
    m2=m2/386;     
else
    v1=v1/1000;
    v2=v2/1000;    
end

E1=m1*v1^2;
E2=m2*v2^2;

power=(lf1*E1 + lf2*E2)*omega;

%  R. PANUSZKA, J. WICIAK, M. IWANIEC

nr=n2/n1;

clf_21= lf2*E2/(nr*E1-E2);
clf_12= clf_21*nr;

if(iu==1)
    seu='in-lbf';
    spu='in-lbf/sec';
else
    seu='J';
    spu='W';
end

disp(' ');
disp(' * * * * ');
disp(' ');

out1=sprintf(' Band Center Frequency = %g Hz \n',fc);
disp(out1);

out1=sprintf(' Total Input Power = %8.4g %s \n',power,spu);
disp(out1);

trans_power=omega*( clf_12*E1 - clf_21*E2 );

out1=sprintf(' Transmitted Power Flow 1 to 2 = %8.4g %s \n',trans_power,spu);
disp(out1);

out1=sprintf(' Energy 1 = %8.4g %s',E1,seu);
out2=sprintf(' Energy 2 = %8.4g %s \n',E2,seu);

disp(out1);
disp(out2);


out1=sprintf(' Energy 1 / Energy 2 = %8.4g %s',E1/E2);
out2=sprintf(' Energy 2 / Energy 1 = %8.4g %s',E2/E1);
disp(out1);
disp(out2);
disp(' ');

out1=sprintf(' Internal Loss Factor 12 = %8.4g ',lf1);
out2=sprintf(' Internal loss Factor 21 = %8.4g \n',lf2);

disp(out1);
disp(out2);

out1=sprintf(' Coupling Loss Factor 12 = %8.4g ',clf_12);
out2=sprintf(' Coupling Loss Factor 21 = %8.4g \n',clf_21);

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
    set(handles.text_v1,'String','Velocity 1 (in/sec) rms');
    set(handles.text_v2,'String','Velocity 2 (in/sec) rms');    
else
    set(handles.text_m1,'String','Mass 1 (kg)');
    set(handles.text_m2,'String','Mass 2 (kg)');
    set(handles.text_v1,'String','Velocity 1 (mm/sec) rms');
    set(handles.text_v2,'String','Velocity 2 (mm/sec) rms');         
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

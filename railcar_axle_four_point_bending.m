function varargout = railcar_axle_four_point_bending(varargin)
% RAILCAR_AXLE_FOUR_POINT_BENDING MATLAB code for railcar_axle_four_point_bending.fig
%      RAILCAR_AXLE_FOUR_POINT_BENDING, by itself, creates a new RAILCAR_AXLE_FOUR_POINT_BENDING or raises the existing
%      singleton*.
%
%      H = RAILCAR_AXLE_FOUR_POINT_BENDING returns the handle to a new RAILCAR_AXLE_FOUR_POINT_BENDING or the handle to
%      the existing singleton*.
%
%      RAILCAR_AXLE_FOUR_POINT_BENDING('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in RAILCAR_AXLE_FOUR_POINT_BENDING.M with the given input arguments.
%
%      RAILCAR_AXLE_FOUR_POINT_BENDING('Property','Value',...) creates a new RAILCAR_AXLE_FOUR_POINT_BENDING or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before railcar_axle_four_point_bending_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to railcar_axle_four_point_bending_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help railcar_axle_four_point_bending

% Last Modified by GUIDE v2.5 04-Apr-2017 13:30:14

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @railcar_axle_four_point_bending_OpeningFcn, ...
                   'gui_OutputFcn',  @railcar_axle_four_point_bending_OutputFcn, ...
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


% --- Executes just before railcar_axle_four_point_bending is made visible.
function railcar_axle_four_point_bending_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to railcar_axle_four_point_bending (see VARARGIN)

% Choose default command line output for railcar_axle_four_point_bending
handles.output = hObject;

clc;

fstr='railcar_axle.jpg';

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

listbox_units_Callback(hObject, eventdata, handles)

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes railcar_axle_four_point_bending wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = railcar_axle_four_point_bending_OutputFcn(hObject, eventdata, handles) 
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

delete(railcar_axle_four_point_bending);


% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

iu=get(handles.listbox_units,'value');


W=str2num(get(handles.edit_W,'String'));

L=str2num(get(handles.edit_L,'String'));

a=str2num(get(handles.edit_a,'String'));

D=str2num(get(handles.edit_D,'String'));

if(iu==1)
   mu='in-lbf'; 
   su='psi';
else
   mu='N-m'; 
   su='Pa'; 
   W=W*9.81;
   L=L/100;
   a=a/100;
   D=D/100;
end

W_half=W/2;

M=W_half*a;

[area,MOI,cna]=cylinder_geometry(D);

stress=M*cna/MOI;

disp(' ');
disp(' * * * * ');
disp(' ');

disp(' Maximum Bending Results ');

out1=sprintf('   Moment = %9.5g %s',M,mu);
out2=sprintf('   Stress = %9.5g %s',stress,su);

disp(out1);
disp(out2);
disp(' ');

bmd=[ 0  0 ;  a  M ;  (L+a) M ; (L+2*a) 0 ];

sd=[ 0 W_half; 
     a*0.999 W_half; 
     a*1.001 0; 
     (a+0.999*L) 0; 
     (a+1.001*L) -W_half; 
     (1.999*a+L) -W_half; 
     2*a+L 0 ];


fig_num=1;

t_string1='Axle Shear Diagram';
t_string2='Axle Bending Moment Diagram';


if(iu==1)
    ylabel2='Moment (in-lbf)';
    ylabel1='Shear (lbf)';    
    xlabel2='x (in)';
else 
    ylabel2='Moment (N-m)';    
    ylabel1='Shear (N)';
    xlabel2='x (cm)';    
end


[~]=subplots_two_linlin_two_titles_scale(fig_num,xlabel2,ylabel1,ylabel2,sd,bmd,t_string1,t_string2);

msgbox('Results written to Command Window');


% --- Executes on selection change in listbox_units.
function listbox_units_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_units (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_units contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_units

iu=get(handles.listbox_units,'Value');

if(iu==1)
    ws='lbm';
    ls='in';
    as='in';
    ds='in';
else
    ws='kg';    
    ls='cm';
    as='cm';
    ds='cm';    
end

set(handles.text_W_unit,'String',ws);
set(handles.text_L_unit,'String',ls);
set(handles.text_a_unit,'String',as);
set(handles.text_D_unit,'String',ds);



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



function edit_W_Callback(hObject, eventdata, handles)
% hObject    handle to edit_W (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_W as text
%        str2double(get(hObject,'String')) returns contents of edit_W as a double


% --- Executes during object creation, after setting all properties.
function edit_W_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_W (see GCBO)
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



function edit_a_Callback(hObject, eventdata, handles)
% hObject    handle to edit_a (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_a as text
%        str2double(get(hObject,'String')) returns contents of edit_a as a double


% --- Executes during object creation, after setting all properties.
function edit_a_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_a (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_D_Callback(hObject, eventdata, handles)
% hObject    handle to edit_D (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_D as text
%        str2double(get(hObject,'String')) returns contents of edit_D as a double


% --- Executes during object creation, after setting all properties.
function edit_D_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_D (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function varargout = isolated_RB_acceleration(varargin)
% ISOLATED_RB_ACCELERATION MATLAB code for isolated_RB_acceleration.fig
%      ISOLATED_RB_ACCELERATION, by itself, creates a new ISOLATED_RB_ACCELERATION or raises the existing
%      singleton*.
%
%      H = ISOLATED_RB_ACCELERATION returns the handle to a new ISOLATED_RB_ACCELERATION or the handle to
%      the existing singleton*.
%
%      ISOLATED_RB_ACCELERATION('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ISOLATED_RB_ACCELERATION.M with the given input arguments.
%
%      ISOLATED_RB_ACCELERATION('Property','Value',...) creates a new ISOLATED_RB_ACCELERATION or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before isolated_RB_acceleration_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to isolated_RB_acceleration_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help isolated_RB_acceleration

% Last Modified by GUIDE v2.5 03-Jan-2013 13:32:29

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @isolated_RB_acceleration_OpeningFcn, ...
                   'gui_OutputFcn',  @isolated_RB_acceleration_OutputFcn, ...
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


% --- Executes just before isolated_RB_acceleration is made visible.
function isolated_RB_acceleration_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to isolated_RB_acceleration (see VARARGIN)

% Choose default command line output for isolated_RB_acceleration
handles.output = hObject;



%% clc;

fstr='isolated_box_RB.jpg';

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



% Update handles structure
guidata(hObject, handles);

% UIWAIT makes isolated_RB_acceleration wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = isolated_RB_acceleration_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


unit=getappdata(0,'unit');
  m6=getappdata(0,'m6');
  k6=getappdata(0,'k6');


aaa=zeros(6,1);  
  
aaa(1)=str2num(get(handles.AX_edit,'String'));
aaa(2)=str2num(get(handles.AY_edit,'String'));
aaa(3)=str2num(get(handles.AZ_edit,'String'));

disp(' ');
disp(' Rigid-Body Acceleration (G) ');
disp('    x         y         z      ');
out2=sprintf(' %7.4g  %7.4g  %7.4g  \n',aaa(1),aaa(2),aaa(3));

disp(out2);

            
if(unit==1)
    aaa=aaa*386;
else
    aaa=aaa*9.8;
end
%
mm=m6*aaa;
%
x=k6\mm;
%
xmax=max(abs(x(1:3)));
%
for(i=1:3)
    if(abs(x(i))< (xmax/10000) || abs(x(i))< 1.0e-10)
        x(i)=0;
    end
end
%
xmax=max(abs(x(4:6)));
%
for(i=4:6)
    if(abs(x(i))< (xmax/10000)  || abs(x(i))< 1.0e-10)
        x(i)=0; 
    end
end
%
disp(' ');
disp('   C.G. Displacement  ');
disp('    x         y         z      ');


if(unit==1)
    disp('   (in)      (in)      (in)    ');
else
    disp('   (mm)      (mm)      (mm)    ');    
end

if(unit==2)
    x(1:3)=x(1:3)*1000;
end

out1=sprintf('   %6.3f   %6.3f  %6.3f   ',x(1),x(2),x(3));
disp(out1);
%
disp(' ');
disp('   C.G. Rotation  ');
disp('   theta-x     theta-y    theta-z ');
disp('   (rad)       (rad)       (rad) ');
out1=sprintf('   %6.3f     %6.3f     %6.3f ',x(4),x(5),x(6));
disp(out1);  
            
%
a1=getappdata(0,'a1');
a2=getappdata(0,'a2');
b=getappdata(0,'b');
c1=getappdata(0,'c1');
c2=getappdata(0,'c2');
%
alpha=x(4);
beta=x(5);
theta=x(6);
%
x1=x(1)-c1*beta+b*theta;
x2=x(1)-c1*beta+b*theta;
x3=x(1)+c2*beta+b*theta;
x4=x(1)+c2*beta+b*theta;
%
y1=x(2)+c1*alpha-a1*theta;
y2=x(2)+c1*alpha+a2*theta;
y3=x(2)-c2*alpha-a1*theta;
y4=x(2)-c2*alpha+a2*theta;
%
z1=x(3)+a1*beta-b*alpha;
z2=x(3)-a2*beta-b*alpha;
z3=x(3)+a1*beta-b*alpha;
z4=x(3)-a2*beta-b*alpha;
%
%
disp(' ');
disp('   Mounting Displacement  ');
disp(' n     x         y         z      ');


if(unit==1)
    disp('       (in)      (in)      (in)    ');
else
    disp('       (mm)      (mm)      (mm)    ');    
end

out1=sprintf('1    %6.3f    %6.3f    %6.3f  ',x1,y1,z1);
out2=sprintf('2    %6.3f    %6.3f    %6.3f  ',x2,y2,z2);
out3=sprintf('3    %6.3f    %6.3f    %6.3f  ',x3,y3,z3);
out4=sprintf('4    %6.3f    %6.3f    %6.3f  ',x4,y4,z4);

disp(out1);
disp(out2);
disp(out3);
disp(out4);


msgbox('Calculation Complete.  Output given in Matlab Command Window.')             
            

function AZ_edit_Callback(hObject, eventdata, handles)
% hObject    handle to AZ_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of AZ_edit as text
%        str2double(get(hObject,'String')) returns contents of AZ_edit as a double


% --- Executes during object creation, after setting all properties.
function AZ_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to AZ_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function AY_edit_Callback(hObject, eventdata, handles)
% hObject    handle to AY_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of AY_edit as text
%        str2double(get(hObject,'String')) returns contents of AY_edit as a double


% --- Executes during object creation, after setting all properties.
function AY_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to AY_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function AX_edit_Callback(hObject, eventdata, handles)
% hObject    handle to AX_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of AX_edit as text
%        str2double(get(hObject,'String')) returns contents of AX_edit as a double


% --- Executes during object creation, after setting all properties.
function AX_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to AX_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function uipanel1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to uipanel1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes during object creation, after setting all properties.
function text1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to text1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes during object creation, after setting all properties.
function text5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to text5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

function varargout = circular_plate_four_sine(varargin)
% CIRCULAR_PLATE_FOUR_SINE MATLAB code for circular_plate_four_sine.fig
%      CIRCULAR_PLATE_FOUR_SINE, by itself, creates a new CIRCULAR_PLATE_FOUR_SINE or raises the existing
%      singleton*.
%
%      H = CIRCULAR_PLATE_FOUR_SINE returns the handle to a new CIRCULAR_PLATE_FOUR_SINE or the handle to
%      the existing singleton*.
%
%      CIRCULAR_PLATE_FOUR_SINE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CIRCULAR_PLATE_FOUR_SINE.M with the given input arguments.
%
%      CIRCULAR_PLATE_FOUR_SINE('Property','Value',...) creates a new CIRCULAR_PLATE_FOUR_SINE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before circular_plate_four_sine_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to circular_plate_four_sine_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help circular_plate_four_sine

% Last Modified by GUIDE v2.5 19-Sep-2014 10:16:30

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @circular_plate_four_sine_OpeningFcn, ...
                   'gui_OutputFcn',  @circular_plate_four_sine_OutputFcn, ...
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


% --- Executes just before circular_plate_four_sine is made visible.
function circular_plate_four_sine_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to circular_plate_four_sine (see VARARGIN)

% Choose default command line output for circular_plate_four_sine
handles.output = hObject;

clc;

fstr='circular_plate_four.png';

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

% UIWAIT makes circular_plate_four_sine wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = circular_plate_four_sine_OutputFcn(hObject, eventdata, handles) 
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
handles.s=circular_plate_four_points_base;

set(handles.s,'Visible','on');

% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

tpi=2*pi;

freq=str2num(get(handles.edit_freq,'String'));
 Ain=str2num(get(handles.edit_accel,'String'));
   
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

damp=getappdata(0,'damp_ratio');

fn=getappdata(0,'fn');
part=getappdata(0,'part');  

Z=getappdata(0,'Z'); 
Z_theta=getappdata(0,'Z_theta'); 
Z_r=getappdata(0,'Z_r'); 

iu=getappdata(0,'iu');
E=getappdata(0,'E');
h=getappdata(0,'T');
radius=getappdata(0,'radius');   
mu=getappdata(0,'mu');
rho=getappdata(0,'rho');
total_mass=getappdata(0,'total_mass');
BC=getappdata(0,'BC');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

n_loc=get(handles.listbox_location,'Value');

if(n_loc==1)  
    r=0;    
    theta=0;
end
if(n_loc==2) 
    r=0.5;        
    theta=0;  
end
if(n_loc==3)
    r=1;        
    theta=0;
end
if(n_loc==4)
    r=0.5;        
    theta=pi/4;    
end
r=r*radius;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

tmax=1.0e+90;
rmax=1.0e+90;

i_theta=1;
i_r=1;

for i=1:length(Z_theta)

    terr=abs(Z_theta(i)-theta);
    
    if(terr<tmax)
        tmax=terr;
        i_theta=i;
    end
    
end
for i=1:length(Z_r)

    rerr=abs(Z_r(i)-r);
    
    if(rerr<rmax)
        rmax=rerr;
        i_r=i;
    end    
    
end

ZZ=Z(i_r,i_theta);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

f=freq;

nss=length(fn);
damp=damp(1:nss);

[Hrd,Hrv,Haa,accel_trans,rv_trans,rd_trans]=...
                       plate_circular_four_points_frf(f,fn,damp,part,ZZ,iu);

Hrd=abs(Hrd);
Hrv=abs(Hrv);
Haa=abs(Haa);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

   accel=Ain*abs(Haa);
 rel_vel=Ain*abs(Hrv);
rel_disp=Ain*abs(Hrd);
%
disp(' ');

out1=sprintf(' Base Input:  %g Hz, %g G  \n',freq,Ain);
out2=sprintf(' Response: \n');
out3=sprintf('     Accel = %8.4g G',accel);

if(iu==1)
    out4=sprintf('   Rel Vel = %8.4g in/sec  ',rel_vel);
    out5=sprintf('  Rel Disp = %8.4g in \n',rel_disp);
else
    out4=sprintf('   Rel Vel = %8.4g m/sec  ',rel_vel);
    out5=sprintf('  Rel Disp = %8.4g mm \n',rel_disp);
end    

disp(out1);
disp(out2);
disp(out3);
disp(out4);
disp(out5);
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

msgbox('Calculation complete.  Output written to Matlab Command Window.');
                  



% --- Executes on selection change in listbox_location.
function listbox_location_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_location (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_location contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_location


% --- Executes during object creation, after setting all properties.
function listbox_location_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_location (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_freq_Callback(hObject, eventdata, handles)
% hObject    handle to edit_freq (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_freq as text
%        str2double(get(hObject,'String')) returns contents of edit_freq as a double


% --- Executes during object creation, after setting all properties.
function edit_freq_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_freq (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_accel_Callback(hObject, eventdata, handles)
% hObject    handle to edit_accel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_accel as text
%        str2double(get(hObject,'String')) returns contents of edit_accel as a double


% --- Executes during object creation, after setting all properties.
function edit_accel_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_accel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

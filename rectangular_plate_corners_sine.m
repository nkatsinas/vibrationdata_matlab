function varargout = rectangular_plate_corners_sine(varargin)
% RECTANGULAR_PLATE_CORNERS_SINE MATLAB code for rectangular_plate_corners_sine.fig
%      RECTANGULAR_PLATE_CORNERS_SINE, by itself, creates a new RECTANGULAR_PLATE_CORNERS_SINE or raises the existing
%      singleton*.
%
%      H = RECTANGULAR_PLATE_CORNERS_SINE returns the handle to a new RECTANGULAR_PLATE_CORNERS_SINE or the handle to
%      the existing singleton*.
%
%      RECTANGULAR_PLATE_CORNERS_SINE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in RECTANGULAR_PLATE_CORNERS_SINE.M with the given input arguments.
%
%      RECTANGULAR_PLATE_CORNERS_SINE('Property','Value',...) creates a new RECTANGULAR_PLATE_CORNERS_SINE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before rectangular_plate_corners_sine_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to rectangular_plate_corners_sine_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help rectangular_plate_corners_sine

% Last Modified by GUIDE v2.5 05-Sep-2014 08:33:04

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @rectangular_plate_corners_sine_OpeningFcn, ...
                   'gui_OutputFcn',  @rectangular_plate_corners_sine_OutputFcn, ...
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


% --- Executes just before rectangular_plate_corners_sine is made visible.
function rectangular_plate_corners_sine_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to rectangular_plate_corners_sine (see VARARGIN)

% Choose default command line output for rectangular_plate_corners_sine
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes rectangular_plate_corners_sine wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = rectangular_plate_corners_sine_OutputFcn(hObject, eventdata, handles) 
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

setappdata(0,'rectangular_plate_bending_corners_key',1);

handles.s=rectangular_plate_corners_base;   
set(handles.s,'Visible','on'); 

delete(rectangular_plate_corners_sine);

% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

freq=str2num(get(handles.edit_freq,'String'));
 Ain=str2num(get(handles.edit_accel,'String'));
 
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 

T=getappdata(0,'T');
L=getappdata(0,'L');
W=getappdata(0,'W');  
iu=getappdata(0,'iu');

E=getappdata(0,'E');
rho=getappdata(0,'rho');
mu=getappdata(0,'mu');

ZAA=getappdata(0,'ZAA');

fn=getappdata(0,'fn');
alpha=getappdata(0,'alpha_r');
beta=getappdata(0,'beta_r');
gamma=getappdata(0,'gamma_r');

part=getappdata(0,'part');

damp=getappdata(0,'damp_ratio');


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

a=L;
b=W;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

n_loc=get(handles.listbox_location,'Value');

xc=0.5*L;
yc=0.5*W;

if(n_loc==1)
    x=xc-0.5*L;
    y=yc-0.5*W;
end
if(n_loc==2)
    x=xc-0.5*L;
    y=yc-0.25*W;
end
if(n_loc==3)
    x=xc-0.25*L;
    y=yc-0.5*W;
end
if(n_loc==4)
    x=xc-0.25*L;
    y=yc-0.25*W;
end


[Z,d2Zdx2,d2Zdy2,d2Zdxdy,SXX,SYY,TXY]=...
                               plate_corner_Z(x,y,a,b,alpha,beta,gamma,mu,ZAA);

%%%

nmodes=1;
%

f=freq;
nf=1;

[H,Hv,HA,Hsxx,Hsyy,Htxy]=plate_corner_frf(nf,nmodes,f,fn,damp,part,Z,SXX,SYY,TXY);

%

%                           
[accel_trans,rv_trans,rd_trans,vM_trans,HA,Hv,H,HM_stress_vM,Hsxx,Hsyy,Htxy]=...
         vibrationdata_plate_transfer_2(nf,iu,E,mu,T,H,Hv,HA,Hsxx,Hsyy,Htxy,f);   
%
%%%
 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
   accel=Ain*abs(HA);
 rel_vel=Ain*abs(Hv);
rel_disp=Ain*abs(H);
vMstress=Ain*abs(HM_stress_vM);   
%
disp(' ');

out1=sprintf(' Base Input:  %g Hz, %g G  \n',freq,Ain);
out2=sprintf(' Response: \n');
out3=sprintf('     Accel = %8.4g G',accel);

sv=rel_vel*rho*sqrt(E/rho);
svl=1.9*sv;
svh=2.5*sv;

if(iu==1)
    out4=sprintf('   Rel Vel = %8.4g in/sec  ',rel_vel);
    out5=sprintf('  Rel Disp = %8.4g in \n',rel_disp);
    out6=sprintf('  von Mises Stress = %8.4g psi \n',vMstress);
    out7=sprintf('  Stress-Velocity:   %8.4g to %8.4g  psi',svl,svh);    
else
    out4=sprintf('   Rel Vel = %8.4g m/sec  ',rel_vel);
    out5=sprintf('  Rel Disp = %8.4g mm \n',rel_disp*1000);
    out6=sprintf('  von Mises Stress = %8.4g Pa',vMstress);  
    out7=sprintf('  Stress-Velocity:   %8.4g to %8.4g  Pa',svl,svh);       
end    

disp(out1);
disp(out2);
disp(out3);
disp(out4);
disp(out5);
disp(out6);
%

if(n_loc==1)
    disp(out7);
end

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

function varargout = isolated_sine_acceleration(varargin)
% ISOLATED_SINE_ACCELERATION MATLAB code for isolated_sine_acceleration.fig
%      ISOLATED_SINE_ACCELERATION, by itself, creates a new ISOLATED_SINE_ACCELERATION or raises the existing
%      singleton*.
%
%      H = ISOLATED_SINE_ACCELERATION returns the handle to a new ISOLATED_SINE_ACCELERATION or the handle to
%      the existing singleton*.
%
%      ISOLATED_SINE_ACCELERATION('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ISOLATED_SINE_ACCELERATION.M with the given input arguments.
%
%      ISOLATED_SINE_ACCELERATION('Property','Value',...) creates a new ISOLATED_SINE_ACCELERATION or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before isolated_sine_acceleration_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to isolated_sine_acceleration_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help isolated_sine_acceleration

% Last Modified by GUIDE v2.5 04-Jan-2013 13:15:37

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @isolated_sine_acceleration_OpeningFcn, ...
                   'gui_OutputFcn',  @isolated_sine_acceleration_OutputFcn, ...
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


% --- Executes just before isolated_sine_acceleration is made visible.
function isolated_sine_acceleration_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to isolated_sine_acceleration (see VARARGIN)

% Choose default command line output for isolated_sine_acceleration
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

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes isolated_sine_acceleration wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = isolated_sine_acceleration_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in calculate_pushbutton.
function calculate_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to calculate_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
   fig_num=getappdata(0,'fig_num');
      damp=getappdata(0,'damping_visc');
ModeShapes=getappdata(0,'ModeShapes');
        fn=getappdata(0,'fn');
   
      unit=getappdata(0,'unit');
         m=getappdata(0,'m6');
              
      mass=getappdata(0,'mass');
%
amp=str2num(get(handles.A_edit,'String'));  % amplitude
freq=str2num(get(handles.F_edit,'String'));  % frequency

iaxis=get(handles.axis_listbox,'Value');


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(iaxis==1)
            out1=sprintf('\n X-axis input');
end  
if(iaxis==2)
            out1=sprintf('\n Y-axis input');
end  
if(iaxis==3)
            out1=sprintf('\n Z-axis input');
end  
%
disp(out1);

out1=sprintf('\n %8.4g G  %8.4g Hz \n',amp,freq);
disp(out1);

omegan=2*pi*fn;        
        
MST=ModeShapes';
%
sz=size(ModeShapes);
dof=(sz(1));
num=dof;
%
omega=2*pi*freq;
om2=omega.^2;
%
omn2=omegan.^2;
%
two_damp_omegan=zeros(6,1);
%
for i=1:dof 
    two_damp_omegan(i)=2*damp(i)*omegan(i);
end
%
out1=sprintf('\n number of dofs =%d \n',num);
disp(out1);
%
%
%  Being main loop ********************************************************
%
%  np=number of excitation frequencies
%
np=1;   
%
     rd=zeros(np,dof);
    acc=zeros(np,dof);
%
    for i=1:np 
%
         n=zeros(6,1);
%
        for j=1:dof
           A=-MST(j,iaxis)*mass;
           den= (omn2(j)-om2(i)) + (1i)*(two_damp_omegan(j)*omega(i));
           n(j)=A/den;
        end
        na=-om2(i)*n;
%
         rd(i,:)=ModeShapes*n;
        acc(i,:)=ModeShapes*na;
        acc(i,iaxis)=acc(i,iaxis)+1;  
%
    end 
%
     rd=abs(rd);
    acc=abs(acc);
%
    if(unit==1)
      rd_trans=[386*rd];
    else
      rd_trans=[9.81*rd];   
    end
    
    acc_trans=[acc];
    
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

ax=amp*acc_trans(1,1);
ay=amp*acc_trans(1,2);
az=amp*acc_trans(1,3);

rdx=amp*rd_trans(1,1);
rdy=amp*rd_trans(1,2);
rdz=amp*rd_trans(1,3);


aa=[ ax ay az ];
amax=max(abs(aa));
%
for(i=1:3)
    if(abs(aa(i))< (amax/10000) || abs(aa(i))< 1.0e-10)
        aa(i)=0;
    end
end
%
disp(' ');
disp(' C.G. Acceleration Response ');
out1=sprintf('  X-axis:  %8.4g G',aa(1));
out2=sprintf('  Y-axis:  %8.4g G',aa(2));
out3=sprintf('  Z-axis:  %8.4g G',aa(3));
disp(out1);
disp(out2);
disp(out3);
%
rr=[ rdx rdy rdz ];
rmax=max(abs(rr));
%
if(unit==1)
   dd='in'; 
else
   dd='mm'; 
   rr=rr*1000;
end
%
for(i=1:3)
    if(abs(rr(i))< (rmax/10000) || abs(rr(i))< 1.0e-10)
        rr(i)=0;
    end
end
%        
disp(' ');
disp(' C.G. Relative Displacement Response ');
out1=sprintf('  X-axis:  %8.4g %s',rr(1),dd);
out2=sprintf('  Y-axis:  %8.4g %s',rr(2),dd);
out3=sprintf('  Z-axis:  %8.4g %s',rr(3),dd);
disp(out1);
disp(out2);
disp(out3);
%
msgbox('Calculation complete.  Output written to Matlab Command Window.');


% --- Executes on selection change in axis_listbox.
function axis_listbox_Callback(hObject, eventdata, handles)
% hObject    handle to axis_listbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns axis_listbox contents as cell array
%        contents{get(hObject,'Value')} returns selected item from axis_listbox


% --- Executes during object creation, after setting all properties.
function axis_listbox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axis_listbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function A_edit_Callback(hObject, eventdata, handles)
% hObject    handle to A_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of A_edit as text
%        str2double(get(hObject,'String')) returns contents of A_edit as a double


% --- Executes during object creation, after setting all properties.
function A_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to A_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function F_edit_Callback(hObject, eventdata, handles)
% hObject    handle to F_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of F_edit as text
%        str2double(get(hObject,'String')) returns contents of F_edit as a double


% --- Executes during object creation, after setting all properties.
function F_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to F_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

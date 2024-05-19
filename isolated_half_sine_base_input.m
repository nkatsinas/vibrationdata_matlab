function varargout = isolated_half_sine_base_input(varargin)
% ISOLATED_HALF_SINE_BASE_INPUT MATLAB code for isolated_half_sine_base_input.fig
%      ISOLATED_HALF_SINE_BASE_INPUT, by itself, creates a new ISOLATED_HALF_SINE_BASE_INPUT or raises the existing
%      singleton*.
%
%      H = ISOLATED_HALF_SINE_BASE_INPUT returns the handle to a new ISOLATED_HALF_SINE_BASE_INPUT or the handle to
%      the existing singleton*.
%
%      ISOLATED_HALF_SINE_BASE_INPUT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ISOLATED_HALF_SINE_BASE_INPUT.M with the given input arguments.
%
%      ISOLATED_HALF_SINE_BASE_INPUT('Property','Value',...) creates a new ISOLATED_HALF_SINE_BASE_INPUT or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before isolated_half_sine_base_input_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to isolated_half_sine_base_input_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help isolated_half_sine_base_input

% Last Modified by GUIDE v2.5 04-Jan-2013 11:27:00

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @isolated_half_sine_base_input_OpeningFcn, ...
                   'gui_OutputFcn',  @isolated_half_sine_base_input_OutputFcn, ...
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


% --- Executes just before isolated_half_sine_base_input is made visible.
function isolated_half_sine_base_input_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to isolated_half_sine_base_input (see VARARGIN)

% Choose default command line output for isolated_half_sine_base_input
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

% UIWAIT makes isolated_half_sine_base_input wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = isolated_half_sine_base_input_OutputFcn(hObject, eventdata, handles) 
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
           
    Q=ModeShapes;
    MST=ModeShapes';    
%
A=str2num(get(handles.A_edit,'String'));  % pulse amplitude
T=str2num(get(handles.T_edit,'String'));  % pulse duration

iaxis=get(handles.axis_listbox,'Value');

amp=A;
%
if(unit==1)
        A=A*386;
else
        A=A*9.81;
end
%
dur1=2*T;
dur2=10/min(fn);
dur=max([dur1 dur2]);
%
sr1=20/T;
sr2=20*max(fn);
sr=max([sr1 sr2]);
%
dt=1/sr;
% 
nt=round(dur/dt);
%
omega=pi/T;
omegan=2*pi*fn;
%
den=zeros(6,1);
U1=zeros(6,1);
U2=zeros(6,1);
V1=zeros(6,1);
V2=zeros(6,1);
P=zeros(6,1);
omegad=zeros(6,1);
domegan=zeros(6,1);
%
rd=zeros(nt,6);
rv=zeros(nt,6);
ra=zeros(nt,6);
abase=zeros(nt,1);
%
An=zeros(6,1);
%
om2=omega^2;
for(i=1:6)
       omegad(i)=omegan(i)*sqrt(1-damp(i)^2);
       domegan(i)=damp(i)*omegan(i);
       omn2(i)=(omegan(i))^2;
       den(i)=( (om2-omn2(i))^2 + (2*damp(i)*omega*omegan(i))^2);
       U1(i)=2*damp(i)*omega*omegan(i);
       U2(i)=om2-omn2(i);
       V1(i)=2*damp(i)*omegan(i)*omegad(i);
       V2(i)=om2-omn2(i)*(1-2*(damp(i))^2);
       P(i)=omega/omegad(i);
end
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%   Transition points
%
t=T;
%
eee=exp(-domegan*t); 
%
arg=omega*t;
%
argd=omegad*t;
%
c1=cos(arg);
s1=sin(arg);
cd=cos(argd);
sd=sin(argd);
%
for j=1:6
%
        An(j)=MST(j,iaxis)*m(iaxis,iaxis)*A;
%               
        term1=U1(j)*c1 + U2(j)*s1;
        term2=V1(j)*cd(j)+V2(j)*sd(j);
        dterm1=    omega*( -U1(j)*s1 + U2(j)*c1 );
        dterm2=omegad(j)*( -V1(j)*sd(j) + V2(j)*cd(j) );
        deee(j)=-damp(j)*omegan(j)*eee(j);
%
        Tn(j)=An(j)*(term1-P(j)*eee(j)*term2)/den(j);
%
        Tnv(j)=An(j)*(dterm1 -P(j)*( deee(j)*term2 +eee(j)*dterm2))/den(j);          
%
        W(j)= ( Tnv(j) +   damp(j)*omegan(j)*Tn(j) )/omegad(j);
%
end
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
for i=1:nt
        t=dt*(i-1);
        tt(i)=t;
%        
        eee=exp(-domegan*t); 
%
        arg=omega*t;
%
        argd=omegad*t;
%
        c1=cos(arg);
        s1=sin(arg);
        cd=cos(argd);
        sd=sin(argd);
%
        for j=1:6
%
            if(t<=T)
                abase(i)=A*s1;
                An(j)=MST(j,iaxis)*m(iaxis,iaxis)*A;
 %               
                term1=U1(j)*c1 + U2(j)*s1;
                term2=V1(j)*cd(j)+V2(j)*sd(j);
                dterm1=    omega*( -U1(j)*s1 + U2(j)*c1 );
                dterm2=omegad(j)*( -V1(j)*sd(j) + V2(j)*cd(j) );
                deee(j)=-damp(j)*omegan(j)*eee(j);
%
                n(j)=An(j)*(term1-P(j)*eee(j)*term2)/den(j);
%
                nv(j)=An(j)*(dterm1 -P(j)*( deee(j)*term2 +eee(j)*dterm2))/den(j);          
%
            else
                abase(i)=0;
                ts=t-T;
%
                eee(j)=exp(-domegan(j)*ts); 
                deee(j)=-damp(j)*omegan(j)*eee(j);                
%
                arg=omega*ts;
%
                argd=omegad*ts;
%
                c1=cos(arg);
                s1=sin(arg);
                cd=cos(argd);
                sd=sin(argd);
%
                 n(j)=    eee(j)*( Tn(j)*cd(j)  +W(j)*sd(j) );
                nv(j)=   deee(j)*n(j)...
                      +omegad(j)*eee(j)*( -Tn(j)*sd(j)  +W(j)*cd(j) );           
            end
%
            An(j)=MST(j,iaxis)*m(iaxis,iaxis)*abase(i);
            na(j)= -2*damp(j)*omegan(j)*nv(j) -omn2(j)*n(j) -An(j);
%
        end
%
        rd(i,:)=Q(:,1:6)*n(1:6)';
        rv(i,:)=Q(:,1:6)*nv(1:6)';
        ra(i,:)=Q(:,1:6)*na(1:6)';  
%
        a(i,:)=ra(i,:);
%        
        a(i,iaxis)=a(i,iaxis)+abase(i);
%
end
%
if(unit==1)
   a=a/386;  
   abase=abase/386;
else
    a=a/9.81;
    abase=abase/9.81;
    rd=rd*1000;
end
%
figure(fig_num);
fig_num=fig_num+1;
setappdata(0,'fig_num',fig_num);
plot(tt,rd(:,1),tt,rd(:,2),tt,rd(:,3));
grid on;
legend ('X-axis','Y-axis','Z-axis'); 
xlabel('Time(sec)');
if(iaxis==1)
            out1=sprintf('Relative Displacement Response to Half-Sine Pulse X-axis Input');
end  
if(iaxis==2)
            out1=sprintf('Relative Displacement Response to Half-Sine Pulse Y-axis Input');
end
if(iaxis==3)
            out1=sprintf('Relative Displacement Response to Half-Sine Pulse Z-axis Input');
end         
title(out1);
if(unit==1)
    ylabel('Rel Disp(in)');
else
    ylabel('Rel Disp(mm)');    
end
%
figure(fig_num);
fig_num=fig_num+1;
setappdata(0,'fig_num',fig_num);
%        
plot(tt,abase,tt,a(:,1),tt,a(:,2),tt,a(:,3));
grid on;
xlabel('Time(sec)');
%
if(iaxis==1)
    out1=sprintf('Acceleration Response to Half-Sine Pulse X-axis Input');
end  
if(iaxis==2)
    out1=sprintf('Acceleration Response to Half-Sine Pulse Y-axis Input');
end
if(iaxis==3)
    out1=sprintf('Acceleration Response to Half-Sine Pulse Z-axis Input');
end         
title(out1);
%
ylabel('Accel(G)');
%
legend ('Base Input','X-axis','Y-axis','Z-axis');         
%
ax=a(:,1);
ay=a(:,2);
az=a(:,3);
rdx=rd(:,1);
rdy=rd(:,2);
rdz=rd(:,3);
%
if(max(abs(ax))<1.0e-09 )
            ax=0.;
end
if(max(abs(ay))<1.0e-09 )
            ay=0.;
end
if(max(abs(az))<1.0e-09 )
            az=0.;
end   
%
if(max(abs(rdx))<1.0e-09 )
            rdx=0.;
end
if(max(abs(rdy))<1.0e-09 )
            rdy=0.;
end
if(max(abs(rdz))<1.0e-09 )
            rdz=0.;
end         
%
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

out1=sprintf('\n %8.4g G  %8.4g sec Half-Sine Pulse \n',amp,T);
disp(out1);
%
disp(' ');
disp('  Acceleration Response (G)');
disp('              max       min  ');
out1=sprintf('  X-axis:  %7.4g   %7.4g ',max(ax),min(ax));
out2=sprintf('  Y-axis:  %7.4g   %7.4g ',max(ay),min(ay));
out3=sprintf('  Z-axis:  %7.4g   %7.4g ',max(az),min(az));
disp(out1);
disp(out2);
disp(out3);
%
disp(' ');
if(unit==1)
    disp('  Relative Displacement Response (inch) ');
else
    disp('  Relative Displacement Response (mm) ');    
end
disp('              max      min  ');
out1=sprintf('  X-axis:  %7.4g   %7.4g ',max(rdx),min(rdx));
out2=sprintf('  Y-axis:  %7.4g   %7.4g ',max(rdy),min(rdy));
out3=sprintf('  Z-axis:  %7.4g   %7.4g ',max(rdz),min(rdz));
disp(out1);
disp(out2);
disp(out3);
disp(' ');

msgbox('Calculation complete.  See external plots.');
    

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



function T_edit_Callback(hObject, eventdata, handles)
% hObject    handle to T_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of T_edit as text
%        str2double(get(hObject,'String')) returns contents of T_edit as a double


% --- Executes during object creation, after setting all properties.
function T_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to T_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

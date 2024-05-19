function varargout = two_dof_half_sine(varargin)
% TWO_DOF_HALF_SINE MATLAB code for two_dof_half_sine.fig
%      TWO_DOF_HALF_SINE, by itself, creates a new TWO_DOF_HALF_SINE or raises the existing
%      singleton*.
%
%      H = TWO_DOF_HALF_SINE returns the handle to a new TWO_DOF_HALF_SINE or the handle to
%      the existing singleton*.
%
%      TWO_DOF_HALF_SINE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TWO_DOF_HALF_SINE.M with the given input arguments.
%
%      TWO_DOF_HALF_SINE('Property','Value',...) creates a new TWO_DOF_HALF_SINE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before two_dof_half_sine_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to two_dof_half_sine_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help two_dof_half_sine

% Last Modified by GUIDE v2.5 17-Jan-2013 11:00:53

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @two_dof_half_sine_OpeningFcn, ...
                   'gui_OutputFcn',  @two_dof_half_sine_OutputFcn, ...
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


% --- Executes just before two_dof_half_sine is made visible.
function two_dof_half_sine_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to two_dof_half_sine (see VARARGIN)

% Choose default command line output for two_dof_half_sine
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes two_dof_half_sine wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = two_dof_half_sine_OutputFcn(hObject, eventdata, handles) 
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
      damp=getappdata(0,'damping');
ModeShapes=getappdata(0,'ModeShapes');
        fn=getappdata(0,'fn');
   
      unit=getappdata(0,'unit');
         m2=getappdata(0,'m2');
           
    Q=ModeShapes;
    MST=ModeShapes';    
%
A=str2num(get(handles.A_edit,'String'));  % pulse amplitude
T=str2num(get(handles.T_edit,'String'));  % pulse duration

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
den=zeros(2,1);
U1=zeros(2,1);
U2=zeros(2,1);
V1=zeros(2,1);
V2=zeros(2,1);
P=zeros(2,1);
omegad=zeros(2,1);
domegan=zeros(2,1);
%
rd=zeros(nt,2);
rv=zeros(nt,2);
ra=zeros(nt,2);
abase=zeros(nt,1);
%
An=zeros(2,1);
%
om2=omega^2;
for(i=1:2)
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
An=MST*[m2(1,1); m2(2,2)]*A;
%
for j=1:2
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
        for j=1:2
%
            if(t<=T)
                abase(i)=A*s1;
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
            na(j)= -2*damp(j)*omegan(j)*nv(j) -omn2(j)*n(j) -An(j)*abase(i)/A;
%
        end
%
        rd(i,:)=Q*n';
        rv(i,:)=Q*nv';
        ra(i,:)=Q*na';  
%
        a(i,:)=ra(i,:);        
        a(i,:)=a(i,:)+abase(i);
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
plot(tt,rd(:,1),tt,rd(:,2));
grid on;
legend ('Mass 1','Mass 2'); 
xlabel('Time(sec)');
%
out1=sprintf('Relative Displacement Response to Half-Sine Pulse Base Input');        
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
plot(tt,abase,tt,a(:,1),tt,a(:,2));
grid on;
xlabel('Time(sec)');
%
out1=sprintf('Acceleration Response to Half-Sine Pulse Base Input');   
title(out1);
%
ylabel('Accel(G)');
%
legend ('Base Input','Mass 1','Mass 2');         
%
a1=a(:,1);
a2=a(:,2);
rd1=rd(:,1);
rd2=rd(:,2);
%
if(max(abs(a1))<1.0e-09 )
            a1=0.;
end
if(max(abs(a2))<1.0e-09 )
            a2=0.;
end 
%
if(max(abs(rd1))<1.0e-09 )
            rd1=0.;
end  
if(max(abs(rd2))<1.0e-09 )
            rd2=0.;
end   
%
disp(out1);

out1=sprintf('\n %8.4g G  %8.4g sec Half-Sine Pulse \n',amp,T);
disp(out1);
%
disp(' ');
disp('  Acceleration Response (G)');
disp('              max       min  ');
out1=sprintf('  Mass 1:  %7.4g   %7.4g ',max(a1),min(a1));
out2=sprintf('  Mass 2:  %7.4g   %7.4g ',max(a2),min(a2));
disp(out1);
disp(out2);
%
disp(' ');
if(unit==1)
    disp('  Relative Displacement Response (inch) ');
else
    disp('  Relative Displacement Response (mm) ');    
end
disp('              max      min  ');
out1=sprintf('  Mass 1:  %7.4g   %7.4g ',max(rd1),min(rd1));
out2=sprintf('  Mass 2:  %7.4g   %7.4g ',max(rd2),min(rd2));
disp(out1);
disp(out2);
disp(' ');
rd21=rd2-rd1;
out3=sprintf(' Mass 2-Mass 1:  %7.4g   %7.4g ',max(rd21),min(rd21));
disp(out3);

msgbox('Calculation complete.  See external plots.');
    



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

function varargout = two_dof_sine(varargin)
% TWO_DOF_SINE MATLAB code for two_dof_sine.fig
%      TWO_DOF_SINE, by itself, creates a new TWO_DOF_SINE or raises the existing
%      singleton*.
%
%      H = TWO_DOF_SINE returns the handle to a new TWO_DOF_SINE or the handle to
%      the existing singleton*.
%
%      TWO_DOF_SINE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TWO_DOF_SINE.M with the given input arguments.
%
%      TWO_DOF_SINE('Property','Value',...) creates a new TWO_DOF_SINE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before two_dof_sine_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to two_dof_sine_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help two_dof_sine

% Last Modified by GUIDE v2.5 17-Jan-2013 10:21:47

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @two_dof_sine_OpeningFcn, ...
                   'gui_OutputFcn',  @two_dof_sine_OutputFcn, ...
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


% --- Executes just before two_dof_sine is made visible.
function two_dof_sine_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to two_dof_sine (see VARARGIN)

% Choose default command line output for two_dof_sine
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes two_dof_sine wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = two_dof_sine_OutputFcn(hObject, eventdata, handles) 
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
             
%
amp=str2num(get(handles.A_edit,'String'));  % amplitude
freq=str2num(get(handles.F_edit,'String'));  % frequency

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

disp(' ');
disp(' Base Input ');

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
two_damp_omegan=zeros(2,1);
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
    mass(1)=m2(1,1);
    mass(2)=m2(2,2);
%
    mm=[mass(1); mass(2)];
%
    Y=-MST*mm;
%
       rd=zeros(np,dof);
     rd21=zeros(np,1);
    acc=zeros(np,dof);
%
    for i=1:np 
%
         n=zeros(2,1);
%
        for j=1:dof
           A=Y(j);
           den= (omn2(j)-om2(i)) + (1i)*(two_damp_omegan(j)*omega(i));
           n(j)=A/den;
        end
        na=-om2(i)*n;
%
         rd(i,:)=ModeShapes*n;
        acc(i,:)=ModeShapes*na;
        acc(i,:)=acc(i,:)+1;  
%
    end 
%

    
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

a1=amp*acc_trans(1,1);
a2=amp*acc_trans(1,2);

rd1=amp*rd_trans(1,1);
rd2=amp*rd_trans(1,2);
rd21=rd(:,2)-rd(:,1);



aa=[ a1 a2 ];
aa=abs(aa);
amax=max(abs(aa));
%
for(i=1:2)
    if(abs(aa(i))< (amax/10000) || abs(aa(i))< 1.0e-10)
        aa(i)=0;
    end
end
%
if(unit==1)
%%%   aa=aa/386; 
else    
   aa=aa/9.81; 
end
%
disp(' ');
disp(' Acceleration Response ');
out1=sprintf('  Mass 1:  %8.4g G',aa(1));
out2=sprintf('  Mass 2:  %8.4g G',aa(2));
disp(out1);
disp(out2);
%
rr=[ rd1 rd2 ];
%
if(unit==1)
   dd='in'; 
else
   dd='mm'; 
   rr=rr*1000;
end
%
rd21=rr(:,2)-rr(:,1);
rr=abs(rr);
rmax=max(abs(rr));
%
for(i=1:2)
    if(abs(rr(i))< (rmax/10000) || abs(rr(i))< 1.0e-10)
        rr(i)=0;
    end
end
%        
disp(' ');
disp(' Relative Displacement Response ');
out1=sprintf('  Mass 1:  %8.4g %s',rr(1),dd);
out2=sprintf('  Mass 2:  %8.4g %s',rr(2),dd);
out3=sprintf('  Mass 2 - Mass 1:  %8.4g %s',abs(rd21),dd);
disp(out1);
disp(out2);
disp(out3);

%
msgbox('Calculation complete.  Output written to Matlab Command Window.');

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

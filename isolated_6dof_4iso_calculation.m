function varargout = isolated_6dof_4iso_calculation(varargin)
% ISOLATED_6DOF_4ISO_CALCULATION MATLAB code for isolated_6dof_4iso_calculation.fig
%      ISOLATED_6DOF_4ISO_CALCULATION, by itself, creates a new ISOLATED_6DOF_4ISO_CALCULATION or raises the existing
%      singleton*.
%
%      H = ISOLATED_6DOF_4ISO_CALCULATION returns the handle to a new ISOLATED_6DOF_4ISO_CALCULATION or the handle to
%      the existing singleton*.
%
%      ISOLATED_6DOF_4ISO_CALCULATION('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ISOLATED_6DOF_4ISO_CALCULATION.M with the given input arguments.
%
%      ISOLATED_6DOF_4ISO_CALCULATION('Property','Value',...) creates a new ISOLATED_6DOF_4ISO_CALCULATION or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before isolated_6dof_4iso_calculation_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to isolated_6dof_4iso_calculation_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help isolated_6dof_4iso_calculation

% Last Modified by GUIDE v2.5 09-Jun-2015 12:24:18

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @isolated_6dof_4iso_calculation_OpeningFcn, ...
                   'gui_OutputFcn',  @isolated_6dof_4iso_calculation_OutputFcn, ...
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


% --- Executes just before isolated_6dof_4iso_calculation is made visible.
function isolated_6dof_4iso_calculation_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to isolated_6dof_4iso_calculation (see VARARGIN)

% Choose default command line output for isolated_6dof_4iso_calculation
handles.output = hObject;

fstr='isolated_box_geo.jpg';

bg = imread(fstr);
info = imfinfo(fstr);
w = info.Width;  %An integer indicating the width of the image in pixels
h = info.Height; %An integer indicating the height of the image in pixels
 
axes(handles.axes1);
image(bg);

pos1 = getpixelposition(handles.uipanel_data,true);
pos2 = getpixelposition(handles.a1_text,true);
 
x=pos2(1)-pos1(1);
y=round(0.5*pos1(4)-0.5*h);

set(handles.axes1, ...
    'Visible', 'off', ...
    'Units', 'pixels', ...
    'Position', [x y w h]);
axis off;



handles.units=1;


clear_pushbuttons(hObject, eventdata, handles);

%% handles.s_IDa= isolated_damping;
%% set(handles.s_IDa,'Visible','off')

%% handles.s_ITFRFa= isolated_transmissibility_frf;
%% set(handles.s_ITFRFa,'Visible','off')

%% handles.s_HSa= isolated_half_sine_base_input;
%% set(handles.s_HSa,'Visible','off');

%% handles.s_ARBa= isolated_arbitrary_base_input;
%% set(handles.s_ARBa,'Visible','off');

%% handles.s_RBa= isolated_RB_acceleration;
%% set(handles.s_RBa,'Visible','off');

%% handles.s_PSDa= isolated_PSD;
%% set(handles.s_PSDa,'Visible','off');


damping_flag=999;
setappdata(0,'damping_flag',damping_flag);

frf_flag=999;
setappdata(0,'frf_flag',frf_flag);

damp=0;
setappdata(0,'damping',damp);

fig_num=1;
setappdata(0,'fig_num',fig_num);


% Update handles structure
guidata(hObject, handles);

units_change(hObject, eventdata, handles)

% UIWAIT makes isolated_6dof_4iso_calculation wait for user response (see UIRESUME)
% uiwait(handles.figure1);


function clear_pushbuttons(hObject, eventdata, handles)
set(handles.ED_pushbutton,'Enable','off')
set(handles.FRF_pushbutton,'Enable','off')
set(handles.sine_pushbutton,'Enable','off')
set(handles.HS_pushbutton,'Enable','off')
set(handles.ARB_pushbutton,'Enable','off')
set(handles.RB_pushbutton,'Enable','off')
set(handles.PSD_pushbutton,'Enable','off')


% --- Outputs from this function are returned to the command line.
function varargout = isolated_6dof_4iso_calculation_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in calculate_fn_pushbutton.
function calculate_fn_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to calculate_fn_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

a1=str2num(get(handles.a1_edit,'String'));
a2=str2num(get(handles.a2_edit,'String'));
 b=str2num(get(handles.b_edit,'String'));
c1=str2num(get(handles.c1_edit,'String'));
c2=str2num(get(handles.c2_edit,'String'));

mass=str2num(get(handles.mass_edit,'String'));
  jx=str2num(get(handles.Jx_edit,'String'));
  jy=str2num(get(handles.Jy_edit,'String'));
  jz=str2num(get(handles.Jz_edit,'String'));
  
  kx=str2num(get(handles.Kx_edit,'String'));
  ky=str2num(get(handles.Ky_edit,'String'));
  kz=str2num(get(handles.Kz_edit,'String'));  

unit=handles.units;

disp(' ');

if(unit==1)
    out1=' Geometry Dimensions (inch) ';
    out3=' Mass (lbm)';
    out5=' Polar MOI (lbm in^2)';
    out7=' Stiffness per Isolator (lbf/in)';    
else
    out1=' Geometry Dimensions (mm) ';
    out3=' Mass (kg)'; 
    out5=' Polar MOI (kg m^2)';    
    out7=' Stiffness per Isolator (N/mm)';        
end

out2=sprintf(' a1=%7.4g  a2=%7.4g  b=%7.4g  c1=%7.4g  c2=%7.4g \n',a1,a2,b,c1,c2);
out4=sprintf(' Mass=%7.4g \n',mass);
out6=sprintf(' Jx=%7.4g  Jy=%7.4g  Jz=%7.4g  \n',jx,jy,jz);
out8=sprintf(' Kx=%7.4g  Ky=%7.4g  Kz=%7.4g  \n',kx,ky,kz);

disp(out1);
disp(out2);
disp(out3);
disp(out4);
disp(out5);
disp(out6);
disp(out7);
disp(out8);


if(unit==1) % English
  mass=mass/386;
  jx=jx/386;
  jy=jy/386;
  jz=jz/386;
else % metric
  a1=a1/1000;
  a2=a2/1000;
  b=b/1000;
  c1=c1/1000;
  c2=c2/1000;
  kx=kx*1000;
  ky=ky*1000;
  kz=kz*1000;
end
%
clear k;
clear m;
clear Eigenvalues;
clear ModeShapes;
clear omega;
clear omegan;
clear fn;
clear lambda;
clear MST;
clear ModalMass;
clear part;
clear QTMQ;
clear r;
clear sum;
%
fig_num=1;
%
tpi=2.*pi;
%
n=6;
%
m=zeros(n,n);
k=zeros(n,n);
%
m(1,1)=mass;
%
m(2,2)=mass;
%	
m(3,3)=mass;
%	
m(4,4)=jx;
%
m(5,5)=jy;
%
m(6,6)=jz;
%
%
k(1,1)=4*kx;
%
k(1,2)=0;
%
k(1,3)=0;
%
k(1,4)=0;
%
k(1,5)=2*kx*(-c1+c2);
%
k(1,6)=4*kx*b;
%
k(2,2)=4*ky;
%
k(2,3)=0;
%
k(2,4)=2*ky*(c1-c2);
%
k(2,5)=0;
%
k(2,6)=2*ky*(-a1+a2);
%	
k(3,3)=4*kz;
%
k(3,4)=-4*kz*b;
%
k(3,5)=2*kz*(a1-a2);
%
k(3,6)=0;
%
k(4,4)= 4*kz*b^2 + 2*ky*(c1^2+c2^2);
%
k(4,5)=2*kz*(-a1+a2)*b;
%
k(4,6)=ky*(-a1+a2)*(c1-c2);
%
k(5,5)=2*kx*(c1^2+c2^2) + 2*kz*(a1^2+a2^2);
%
k(5,6)=2*kx*(-c1+c2)*b;
%
k(6,6)=4*kx*b^2 + 2*ky*(a1^2+a2^2);
%
% Symmetry
%
for(i=1:n)
    for(j=1:i-1)
        k(i,j)=k(j,i);    
    end
end
%
disp(' ');
disp(' The mass matrix is');
m
disp(' ');
disp(' The stiffness matrix is');
k
%
%  Calculate eigenvalues and eigenvectors
%
[ModeShapes,Eigenvalues]=eig(k,m);
k6=k;
m6=m;
%
for(i=1:n)
    lambda(i)=Eigenvalues(i,i);
    if(lambda(i)<0.)
        disp(' ');
        disp(' Warning: negative eigenvalue ');
        disp(' ');
    end
end
%
disp(' ');
disp(' Eigenvalues ');
lambda
%
omegan = sqrt(lambda);
fn=omegan/tpi;
%
disp(' ');
disp('  Natural Frequencies = ');
%
for(i=1:n)
    out1=sprintf(' %d.   %8.4g Hz',i,fn(i));
    disp(out1);
end
%
MST=ModeShapes';
temp=zeros(n,n);
temp=m*ModeShapes;
QTMQ=MST*temp;
%   
for(i=1:n)
    scale(i)=1./sqrt(QTMQ(i,i));
end
%
for(i=1:n)
    ModeShapes(:,i) = ModeShapes(:,i)*scale(i);  
end
%
MST=ModeShapes';
%
disp(' ');
disp('  Modes Shapes (rows represent modes) ');
disp(' ');
clear MSTT;
MSTT=MST;
maximum = max(max(abs(MST)));  
for(i=1:6)
   for(j=1:6)
       if(abs(MSTT(i,j))< (maximum/1.0e+05) )
           MSTT(i,j)=0.;
       end
   end
end
%
out_999 = sprintf('          x       y       z     alpha    beta    theta ');
disp(out_999);
for(i=1:6)
    out1 = sprintf(' %d.  %7.3f  %7.3f  %7.3f  %7.3f  %7.3f  %7.3f ',i,MSTT(i,1),MSTT(i,2),MSTT(i,3),MSTT(i,4),MSTT(i,5),MSTT(i,6));
    disp(out1);
end
%
disp(' ');
disp('  Participation Factors (rows represent modes) ');
disp(' ');
L=MST*m;
PF=L;
%
if(unit==1)
    PF=PF*386.;
end
%
maximum = max(max(abs(PF)));  
for(i=1:6)
   for(j=1:6)
       if(abs(PF(i,j))< (maximum/1.0e+04) )
           PF(i,j)=0.;
       end
   end
end
disp(out_999);
for(i=1:6)
    out1 = sprintf(' %d.  %7.3f  %7.3f  %7.3f  %7.3f  %7.3f  %7.3f ',i,PF(i,1),PF(i,2),PF(i,3),PF(i,4),PF(i,5),PF(i,6));
    disp(out1);
end
%
disp(' ');
disp('  Effective Modal Mass (rows represent modes) ');
disp(' ');
EMM=L.*L;
%
if(unit==1)
    EMM=EMM*386.;
end
%
maximum = max(max(abs(EMM)));  
for(i=1:6)
   for(j=1:6)
       if(abs(EMM(i,j))< (maximum/1.0e+04) )
           EMM(i,j)=0.;
       end
   end
end

disp(out_999);
for(i=1:6)
    out1 = sprintf(' %d.  %7.3f  %7.3f  %7.3f  %7.3f  %7.3f  %7.3f ',i,EMM(i,1),EMM(i,2),EMM(i,3),EMM(i,4),EMM(i,5),EMM(i,6));
    disp(out1);
end
disp(' ')
disp(' Total Modal Mass ')
disp(' ')
%
out1 = sprintf('   %7.3f  %7.3f  %7.3f  %7.3f  %7.3f  %7.3f ',sum(EMM(:,1)),sum(EMM(:,2)),sum(EMM(:,3)),sum(EMM(:,4)),sum(EMM(:,5)),sum(EMM(:,6)));
disp(out1);
%
msgbox('Calculation Complete.  Output given in Matlab Command Window.') 
%

set(handles.ED_pushbutton,'Enable','on')
set(handles.RB_pushbutton,'Enable','on')

setappdata(0,'unit',unit);
setappdata(0,'m6',m6);
setappdata(0,'k6',k6);
setappdata(0,'fn',fn);
setappdata(0,'ModeShapes',ModeShapes);
setappdata(0,'mass',mass);

setappdata(0,'a1',a1);
setappdata(0,'a2',a2);
setappdata(0,'b',b);
setappdata(0,'c1',c1);
setappdata(0,'c2',c2);

if(unit==1)
    PF=PF/386;
end

setappdata(0,'PF',PF);

guidata(hObject, handles);


function a1_edit_Callback(hObject, eventdata, handles)
% hObject    handle to a1_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of a1_edit as text
%        str2double(get(hObject,'String')) returns contents of a1_edit as a double


% --- Executes during object creation, after setting all properties.
function a1_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to a1_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function a2_edit_Callback(hObject, eventdata, handles)
% hObject    handle to a2_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of a2_edit as text
%        str2double(get(hObject,'String')) returns contents of a2_edit as a double


% --- Executes during object creation, after setting all properties.
function a2_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to a2_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function b_edit_Callback(hObject, eventdata, handles)
% hObject    handle to b_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of b_edit as text
%        str2double(get(hObject,'String')) returns contents of b_edit as a double


% --- Executes during object creation, after setting all properties.
function b_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to b_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function c1_edit_Callback(hObject, eventdata, handles)
% hObject    handle to c1_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of c1_edit as text
%        str2double(get(hObject,'String')) returns contents of c1_edit as a double


% --- Executes during object creation, after setting all properties.
function c1_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to c1_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function c2_edit_Callback(hObject, eventdata, handles)
% hObject    handle to c2_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of c2_edit as text
%        str2double(get(hObject,'String')) returns contents of c2_edit as a double


% --- Executes during object creation, after setting all properties.
function c2_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to c2_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function units_change(hObject, eventdata, handles)
%
if(handles.units==1) 
    set(handles.unit_text,'String','Unit: inches');
    set(handles.mass_text,'String','Unit: lbm');
    set(handles.MOI_text,'String','Unit: lbm in^2');    
    set(handles.stiffness_text,'String','Unit: lbf/in');      
else
    set(handles.unit_text,'String','Unit: mm');
    set(handles.mass_text,'String','Unit: kg');
    set(handles.MOI_text,'String','Unit: kg m^2');    
    set(handles.stiffness_text,'String','Unit: N/mm');      
end


% --- Executes on selection change in units_listbox.
function units_listbox_Callback(hObject, eventdata, handles)
% hObject    handle to units_listbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns units_listbox contents as cell array
%        contents{get(hObject,'Value')} returns selected item from units_listbox
%
handles.units=get(hObject,'Value');
%
guidata(hObject, handles);
%
units_change(hObject, eventdata, handles);
clear_pushbuttons(hObject, eventdata, handles);

% --- Executes during object creation, after setting all properties.
function units_listbox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to units_listbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function mass_edit_Callback(hObject, eventdata, handles)
% hObject    handle to mass_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of mass_edit as text
%        str2double(get(hObject,'String')) returns contents of mass_edit as a double


% --- Executes during object creation, after setting all properties.
function mass_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to mass_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Jx_edit_Callback(hObject, eventdata, handles)
% hObject    handle to Jx_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Jx_edit as text
%        str2double(get(hObject,'String')) returns contents of Jx_edit as a double


% --- Executes during object creation, after setting all properties.
function Jx_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Jx_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Jy_edit_Callback(hObject, eventdata, handles)
% hObject    handle to Jy_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Jy_edit as text
%        str2double(get(hObject,'String')) returns contents of Jy_edit as a double


% --- Executes during object creation, after setting all properties.
function Jy_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Jy_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Jz_edit_Callback(hObject, eventdata, handles)
% hObject    handle to Jz_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Jz_edit as text
%        str2double(get(hObject,'String')) returns contents of Jz_edit as a double


% --- Executes during object creation, after setting all properties.
function Jz_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Jz_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Kx_edit_Callback(hObject, eventdata, handles)
% hObject    handle to Kx_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Kx_edit as text
%        str2double(get(hObject,'String')) returns contents of Kx_edit as a double


% --- Executes during object creation, after setting all properties.
function Kx_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Kx_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Ky_edit_Callback(hObject, eventdata, handles)
% hObject    handle to Ky_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Ky_edit as text
%        str2double(get(hObject,'String')) returns contents of Ky_edit as a double


% --- Executes during object creation, after setting all properties.
function Ky_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Ky_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Kz_edit_Callback(hObject, eventdata, handles)
% hObject    handle to Kz_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Kz_edit as text
%        str2double(get(hObject,'String')) returns contents of Kz_edit as a double


% --- Executes during object creation, after setting all properties.
function Kz_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Kz_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit17_Callback(hObject, eventdata, handles)
% hObject    handle to Jx_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Jx_edit as text
%        str2double(get(hObject,'String')) returns contents of Jx_edit as a double


% --- Executes during object creation, after setting all properties.
function edit17_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Jx_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit18_Callback(hObject, eventdata, handles)
% hObject    handle to Jy_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Jy_edit as text
%        str2double(get(hObject,'String')) returns contents of Jy_edit as a double


% --- Executes during object creation, after setting all properties.
function edit18_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Jy_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit19_Callback(hObject, eventdata, handles)
% hObject    handle to Jz_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Jz_edit as text
%        str2double(get(hObject,'String')) returns contents of Jz_edit as a double


% --- Executes during object creation, after setting all properties.
function edit19_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Jz_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function mass_text_CreateFcn(hObject, eventdata, handles)
% hObject    handle to mass_text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on button press in FRF_pushbutton.
function FRF_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to FRF_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

damping_flag=getappdata(0,'damping_flag');

if(damping_flag~=1)
    Icon='warn';
    Title='Warning';
    Message='Enter damping values prior to this calculation.'; 
    msgbox(Message,Title,Icon);
else
    handles.s_ITFRF= isolated_transmissibility_frf;
    set(handles.s_ITFRF,'Visible','on')
end


% --- Executes on button press in HS_pushbutton.
function HS_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to HS_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

damping_flag=getappdata(0,'damping_flag');

if(damping_flag~=1)
    Icon='warn';
    Title='Warning';
    Message='Enter damping values prior to this calculation.'; 
    msgbox(Message,Title,Icon);
else
    handles.s_HS= isolated_half_sine_base_input;
    set(handles.s_HS,'Visible','on');
end

% --- Executes on button press in ARB_pushbutton.
function ARB_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to ARB_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

damping_flag=getappdata(0,'damping_flag');

if(damping_flag~=1)
    Icon='warn';
    Title='Warning';
    Message='Enter damping values prior to this calculation.'; 
    msgbox(Message,Title,Icon);
else
    handles.s_ARB= isolated_arbitrary_base_input;
    set(handles.s_ARB,'Visible','on');
end

% --- Executes on button press in RB_pushbutton.
function RB_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to RB_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% handles.s_RB= isolated_RB_acceleration;

handles.s_RB= isolated_RB_acceleration;
set(handles.s_RB,'Visible','on');




% --- Executes on button press in ED_pushbutton.
function ED_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to ED_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

damping_flag=getappdata(0,'damping_flag');
frf_flag=getappdata(0,'damping_flag');

handles.s_ID= isolated_damping;
set(handles.s_ID,'Visible','on');

set(handles.ED_pushbutton,'Enable','on')
set(handles.FRF_pushbutton,'Enable','on')
set(handles.PSD_pushbutton,'Enable','on')
set(handles.sine_pushbutton,'Enable','on')
set(handles.HS_pushbutton,'Enable','on')
set(handles.ARB_pushbutton,'Enable','on')
set(handles.RB_pushbutton,'Enable','on')


% --- Executes on button press in sine_pushbutton.
function sine_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to sine_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

damping_flag=getappdata(0,'damping_flag');
frf_flag=getappdata(0,'frf_flag');

if(damping_flag ~=1)
    Icon='warn';
    Title='Warning';
    Message='Enter Damping prior to this calculation.'; 
    msgbox(Message,Title,Icon);
else
    handles.s_sine= isolated_sine_acceleration;
    set(handles.s_sine,'Visible','on');
end


% --- Executes on button press in PSD_pushbutton.
function PSD_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to PSD_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

damping_flag=getappdata(0,'damping_flag');
frf_flag=getappdata(0,'frf_flag');

if(damping_flag ~=1)
    Icon='warn';
    Title='Warning';
    Message='Enter Damping prior to this calculation.';  
    msgbox(Message,Title,Icon);
else   
    handles.s_PSD= isolated_PSD;
    set(handles.s_PSD,'Visible','on');
end


% --- Executes on key press with focus on mass_edit and none of its controls.
function mass_edit_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to mass_edit (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
clear_pushbuttons(hObject, eventdata, handles);


% --- Executes on key press with focus on Jx_edit and none of its controls.
function Jx_edit_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to Jx_edit (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
clear_pushbuttons(hObject, eventdata, handles);


% --- Executes on key press with focus on Jy_edit and none of its controls.
function Jy_edit_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to Jy_edit (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
clear_pushbuttons(hObject, eventdata, handles);


% --- Executes on key press with focus on Jz_edit and none of its controls.
function Jz_edit_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to Jz_edit (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
clear_pushbuttons(hObject, eventdata, handles);


% --- Executes on key press with focus on Kx_edit and none of its controls.
function Kx_edit_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to Kx_edit (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
clear_pushbuttons(hObject, eventdata, handles);


% --- Executes on key press with focus on Ky_edit and none of its controls.
function Ky_edit_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to Ky_edit (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
clear_pushbuttons(hObject, eventdata, handles);


% --- Executes on key press with focus on Kz_edit and none of its controls.
function Kz_edit_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to Kz_edit (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
clear_pushbuttons(hObject, eventdata, handles);


% --- Executes on key press with focus on a1_edit and none of its controls.
function a1_edit_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to a1_edit (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
clear_pushbuttons(hObject, eventdata, handles);


% --- Executes on key press with focus on a2_edit and none of its controls.
function a2_edit_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to a2_edit (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
clear_pushbuttons(hObject, eventdata, handles);


% --- Executes on key press with focus on b_edit and none of its controls.
function b_edit_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to b_edit (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
clear_pushbuttons(hObject, eventdata, handles);


% --- Executes on key press with focus on c1_edit and none of its controls.
function c1_edit_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to c1_edit (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
clear_pushbuttons(hObject, eventdata, handles);


% --- Executes on key press with focus on c2_edit and none of its controls.
function c2_edit_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to c2_edit (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
clear_pushbuttons(hObject, eventdata, handles);


% --- Executes on button press in pushbutton_MOI.
function pushbutton_MOI_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_MOI (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


mass_s=get(handles.mass_edit,'String');

if (isempty(mass_s)~=1)
   m=str2num(mass_s);
else
    warndlg('Enter mass');
    return;
end    

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

a1_s=get(handles.a1_edit,'String');

if (isempty(a1_s)~=1)
    a1=str2num(a1_s);
else
    warndlg('Enter a1');
    return;
end    

a2_s=get(handles.a2_edit,'String');

if (isempty(a2_s)~=1)
    a2=str2num(a2_s);
else
    warndlg('Enter a2');
    return;
end   


b_s=get(handles.b_edit,'String');
 
if (isempty(b_s)~=1)
    b=str2num(b_s);
else
    warndlg('Enter b');
    return;
end  


c1_s=get(handles.c1_edit,'String');
 
if (isempty(c1_s)~=1)
    c1=str2num(c1_s);
else
    warndlg('Enter c1');
    return;
end    
 
c2_s=get(handles.c2_edit,'String');
 
if (isempty(c2_s)~=1)
    c2=str2num(c2_s);
else
    warndlg('Enter c2');
    return;
end   

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

dx=(c1-c2)/2;
dz=(a1-a2)/2;

dy=sqrt(dx^2+dz^2);

aL=a1+a2;
bL=2*b;
cL=c1+c2;


Jx= ((bL^2+cL^2)/12)  + m*dx^2;
Jy= ((aL^2+cL^2)/12)  + m*dy^2;
Jz= ((aL^2+bL^2)/12)  + m*dz^2;

iu=get(handles.units_listbox,'Value');

if(iu==2)
   Jx=Jx/1000^2; 
   Jy=Jy/1000^2; 
   Jz=Jz/1000^2;    
end


Jx_s=sprintf('%8.3g',Jx);
Jy_s=sprintf('%8.3g',Jy);
Jz_s=sprintf('%8.3g',Jz);

set(handles.Jx_edit,'String',Jx_s);
set(handles.Jy_edit,'String',Jy_s);
set(handles.Jz_edit,'String',Jz_s);

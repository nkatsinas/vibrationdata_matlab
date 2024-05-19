function varargout = two_dof_system_d(varargin)
% TWO_DOF_SYSTEM_D MATLAB code for two_dof_system_d.fig
%      TWO_DOF_SYSTEM_D, by itself, creates a new TWO_DOF_SYSTEM_D or raises the existing
%      singleton*.
%
%      H = TWO_DOF_SYSTEM_D returns the handle to a new TWO_DOF_SYSTEM_D or the handle to
%      the existing singleton*.
%
%      TWO_DOF_SYSTEM_D('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TWO_DOF_SYSTEM_D.M with the given input arguments.
%
%      TWO_DOF_SYSTEM_D('Property','Value',...) creates a new TWO_DOF_SYSTEM_D or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before two_dof_system_d_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to two_dof_system_d_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help two_dof_system_d

% Last Modified by GUIDE v2.5 25-Nov-2020 12:50:07

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @two_dof_system_d_OpeningFcn, ...
                   'gui_OutputFcn',  @two_dof_system_d_OutputFcn, ...
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


% --- Executes just before two_dof_system_d is made visible.
function two_dof_system_d_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to two_dof_system_d (see VARARGIN)

% Choose default command line output for two_dof_system_d
handles.output = hObject;

clc;

cmap(1,:)=[0 0.1 0.4];        % dark blue
cmap(2,:)=[0.8 0 0];        % red
cmap(3,:)=[0 0 0];          % black
cmap(4,:)=[0.6 0.3 0];      % brown
cmap(5,:)=[0 0.5 0.5];      % teal
cmap(6,:)=[1 0.5 0];        % orange
cmap(7,:)=[0.5 0.5 0];      % olive
cmap(8,:)=[0.13 0.55 0.13]; % forest green  
cmap(9,:)=[0.5 0 0];        % maroon
cmap(10,:)=[0.5 0.5 0.5 ];  % grey
cmap(11,:)=[1. 0.4 0.4];    % pink-orange
cmap(12,:)=[0.5 0.5 1];     % lavender
cmap(13,:)=[0.05 0.7 1.];   % light blue
cmap(14,:)=[0  0.8 0.4 ];   % green
cmap(15,:)=[1 0.84 0];      % gold
cmap(16,:)=[0 0.8 0.8];     % turquoise   

 
%%%%%%% axes 4 %%%%%%%%%%%
 
%%%%%% masses %%%%%%%%%%%%
 
axes(handles.axes1);
x=[-10 -10 10 10 -10];
y=[7 12 12 7 7];
 
plot(x,y,'Color',cmap(1,:),'linewidth',0.75);
hold on;
 
%%%%%% text %%%%%%%%%%%%

text(0.5,10.5,'\theta','fontsize',12); 

text(12.5,11.5,'x','fontsize',11);
 
text(-8.5,9.5,'m, J','fontsize',11);
text(-10.5,4.5,'k_{1}','fontsize',11);
text(9.5,4.5,'k_{2}','fontsize',11);

text(-5.5,14.5,'L_{1}','fontsize',11);
text( 3,14.5,'L_{2}','fontsize',11);
 
%%%%%% side lines %%%%%%%%%%%%
 
x=[10 11.5];
y=[9.5 9.5];
plot(x,y,'Color','k');
 
 
%%%%%% arrows %%%%%%%%%%%%
 
headWidth = 4;
headLength = 4;
  
ah = annotation('arrow',...
            'headStyle','cback1','HeadLength',headLength,'HeadWidth',headWidth);
        set(ah,'parent',gca);
        set(ah,'position',[11.5 9.5 0 3]);        
        

ah = annotation('arrow',...
            'headStyle','cback1','HeadLength',headLength,'HeadWidth',headWidth);
        set(ah,'parent',gca);
        set(ah,'position',[-6.5 14.5 -1.5 0]);        
 
ah = annotation('arrow',...
            'headStyle','cback1','HeadLength',headLength,'HeadWidth',headWidth);
        set(ah,'parent',gca);
        set(ah,'position',[-3.5 14.5 1.5 0]); 
        
ah = annotation('arrow',...
            'headStyle','cback1','HeadLength',headLength,'HeadWidth',headWidth);
        set(ah,'parent',gca);
        set(ah,'position',[2.0 14.5 -4 0]);         

ah = annotation('arrow',...
            'headStyle','cback1','HeadLength',headLength,'HeadWidth',headWidth);
        set(ah,'parent',gca);
        set(ah,'position',[5 14.5 3 0]);   
        
ah = annotation('arrow',...
            'headStyle','cback1','HeadLength',headLength,'HeadWidth',headWidth);
        set(ah,'parent',gca);
        set(ah,'position',[-0.93 10.6 -0.13 0.2]);         
        
%%%%%% spring %%%%%%%%%%%%        
 
nn=2000;
 
dt=4/(nn-1);
 
t=zeros(nn,1);
for i=1:nn
    t(i)=(i-1)*dt;
end
t=t-0.75;
y=0.6*sawtooth(2*pi*t,0.5);
 
t=3*t/4+3.5;
 
plot(y-8,t,'Color',cmap(5,:),'linewidth',0.75);
plot(y+8,t,'Color',cmap(5,:),'linewidth',0.75);
 
 
 
x=[-8 -8];
y=[2 3];
plot(x,y,'Color',cmap(5,:),'linewidth',0.75);
 
x=[8 8];
y=[2 3];
plot(x,y,'Color',cmap(5,:),'linewidth',0.75);
 

x=[-8 -8];
y=[6 7];
plot(x,y,'Color',cmap(5,:),'linewidth',0.75);
 
x=[8 8];
y=[6 7];
plot(x,y,'Color',cmap(5,:),'linewidth',0.75);


x=[-8 -8];
y=[12.5 16];
plot(x,y,'Color','k','linewidth',0.75);

x=[8 8];
plot(x,y,'Color','k','linewidth',0.75);

x=[-2 -2];
y=[13.5 16];
plot(x,y,'Color','k','linewidth',0.75); 


%%%%%% base %%%%%%%%%%%
 
x=[-11 11];
y=[ 2 2];
plot(x,y,'Color','k','linewidth',0.75);

y=[1 2];

q=10.6;

for i=1:16
    x=[-0.7 0]+q;
    plot(x,y,'Color','k','linewidth',0.75); 
    q=q-1.4;
end
 
%%%%%% circle %%%%%%%%%
r=1;
x=-2;
y=9.5;

th = 0:pi/50:(2*pi+pi/50);
for i=1:length(th)
    thh=th(i);
    xunit(i) = r * cos(thh) + x;
    yunit(i) = r * sin(thh) + y;
    if(thh>=0 && thh <=pi)
        yunit(i)=yunit(i)*(1+0.02*sin(thh));
    else
        yunit(i)=yunit(i)*(1+0.02*sin(thh));
    end
end
plot(xunit, yunit,'Color','k','linewidth',0.75);

clear xunit;
clear yunit;
clear th;

r=1.6;
x=-2;
y=9.5;

th = [-pi/4 0 pi/4];

for i=1:16
    th(i)=(-pi/4)+(i-1)*pi/32;
end    

for i=1:length(th)
    thh=th(i);
    xunit(i) = r * cos(thh) + x;
    yunit(i) = r * sin(thh) + y;
    if(thh>=0 && thh <=pi)
        yunit(i)=yunit(i)*(1+0.01*sin(thh));
    else
        yunit(i)=yunit(i)*(1+0.01*sin(thh));
    end
end
plot(xunit, yunit,'Color','k','linewidth',0.75);



 
x=[-2 -2];
y=[6 13];
plot(x,y,'Color','k','linewidth',0.75);

x=[-4 0];
y=[9.5 9.5];
plot(x,y,'Color','k','linewidth',0.75);

x=[1.4 9.7];
y=[9.5 9.5];
plot(x,y,'--k','linewidth',0.75);

%%%%%% end %%%%%%%%%%%%
 
 
hold off;
grid on;
set(gca,'XTick',[], 'YTick', [])
xlim([-15 15]);
ylim([-1 17]);
 


set(handles.listbox_psave,'Value',2);


units_listbox_Callback(hObject, eventdata, handles)
listbox_inertia_Callback(hObject, eventdata, handles)

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes two_dof_system_d wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = two_dof_system_d_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_K2_Callback(hObject, eventdata, handles)
% hObject    handle to edit_K2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_K2 as text
%        str2double(get(hObject,'String')) returns contents of edit_K2 as a double


% --- Executes during object creation, after setting all properties.
function edit_K2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_K2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_J_Callback(hObject, eventdata, handles)
% hObject    handle to edit_J (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_J as text
%        str2double(get(hObject,'String')) returns contents of edit_J as a double


% --- Executes during object creation, after setting all properties.
function edit_J_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_J (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_K1_Callback(hObject, eventdata, handles)
% hObject    handle to edit_K1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_K1 as text
%        str2double(get(hObject,'String')) returns contents of edit_K1 as a double


% --- Executes during object creation, after setting all properties.
function edit_K1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_K1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_M_Callback(hObject, eventdata, handles)
% hObject    handle to edit_M (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_M as text
%        str2double(get(hObject,'String')) returns contents of edit_M as a double


% --- Executes during object creation, after setting all properties.
function edit_M_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_M (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in units_listbox.
function units_listbox_Callback(hObject, eventdata, handles)
% hObject    handle to units_listbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns units_listbox contents as cell array
%        contents{get(hObject,'Value')} returns selected item from units_listbox

n=get(handles.units_listbox,'Value');

if(n==1)
    set(handles.mass_unit_text,'String','Mass: lbm');
    set(handles.inertia_unit_text,'String','Inertia: lbm in^2')    
    set(handles.stiffness_unit_text,'String','Stiffness: lbf/in');   
    set(handles.length_unit_text,'String','Length: in');     
else
    set(handles.mass_unit_text,'String','Mass: kg'); 
    set(handles.inertia_unit_text,'String','Inertia: kg m^2')     
    set(handles.stiffness_unit_text,'String','Stiffness: N/m');
    set(handles.length_unit_text,'String','Length: m');    
end



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



function edit_L1_Callback(hObject, eventdata, handles)
% hObject    handle to edit_L1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_L1 as text
%        str2double(get(hObject,'String')) returns contents of edit_L1 as a double


% --- Executes during object creation, after setting all properties.
function edit_L1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_L1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_L2_Callback(hObject, eventdata, handles)
% hObject    handle to edit_L2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_L2 as text
%        str2double(get(hObject,'String')) returns contents of edit_L2 as a double


% --- Executes during object creation, after setting all properties.
function edit_L2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_L2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

disp(' ');
disp(' * * * * ');
disp(' ');

iu=get(handles.units_listbox,'Value');
nJ=get(handles.listbox_inertia,'Value');

M=str2num(get(handles.edit_M,'string'));

K1=str2num(get(handles.edit_K1,'string'));
K2=str2num(get(handles.edit_K2,'string'));
L1=str2num(get(handles.edit_L1,'string'));
L2=str2num(get(handles.edit_L2,'string'));


if(nJ==1)
    J=str2num(get(handles.edit_J,'string'));
else
    R=str2num(get(handles.edit_R,'string'));
    J=M*R^2;
end

[mass,stiffness]=two_dof_system_d_mk(M,J,K1,K2,L1,L2,iu);

[fn,omega,ModeShapes,MST]=Generalized_Eigen(stiffness,mass,1);
%

if(iu==1)
    xlab='Length (in)';
else
    xlab='Length (m)';    
end

x(1)=-L1;
x(2)=0;
x(3)=L2;

alpha=ModeShapes(2,1);
beta=ModeShapes(2,2);


d1(1)=-L1*tan(alpha);
d1(2)=0;
d1(3)=L2*tan(alpha);

d2(1)=-L1*tan(beta);
d2(2)=0;
d2(3)=L2*tan(beta);

d1=d1+ModeShapes(1,1);
d2=d2+ModeShapes(1,2);

dn=zeros(3,1);

xz=0;
dz=0;

%%%%%%%%%%%%%%%%%%%%

disp(' ');
disp(' Transformed mode shapes for spring-to-mass attachment points '); 
disp('  (column format) ');
disp('  ');

out1=sprintf(' %8.4g  %8.4g ',d1(1),d2(1));
out2=sprintf(' %8.4g  %8.4g ',d1(3),d2(3));

disp(out1);
disp(out2);

%%%%%%%%%%%%%%%%%%%%

psave=get(handles.listbox_psave,'Value');

h1=figure(1);
plot(xz,dz,'bo',x,dn,'b',x,d1,'r',x,-d1,'r');
out1=sprintf('First Mode Shape  %6.3g Hz  ',fn(1));
title(out1);
ylabel('Unscaled Displacement');
xlabel(xlab);
grid on;

if(psave==1)
    set(gca,'Fontsize',12);
    print(h1,'two_dof_mode1','-dpng','-r300');
end
    
h2=figure(2);
plot(xz,dz,'bo',x,dn,'b',x,d2,'r',x,-d2,'r');
out1=sprintf('Second Mode Shape  %6.3g Hz  ',fn(2));
title(out1);
ylabel('Unscaled Displacement');
xlabel(xlab);
grid on;

if(psave==1)
    set(gca,'Fontsize',12);
    print(h2,'two_dof_mode2','-dpng','-r300');
end


disp(' Output arrays:  tdof_mass & tdof_stiffness ');

assignin('base', 'tdof_mass', mass);
assignin('base', 'tdof_stiffness', stiffness);

msgbox('Calculation complete.  Output written to Matlab Command Window.');

if(psave==1)
   disp(' ');
   disp(' Plot files saved as: ')
   disp(' ');
   disp(' two_dof_mode1.png  &  two_dof_mode2.png ');
end


% --- Executes on button press in pushbutton_return.
function pushbutton_return_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_return (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

delete(two_dof_system_d);


% --- Executes on selection change in listbox_inertia.
function listbox_inertia_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_inertia (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_inertia contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_inertia

n=get(handles.listbox_inertia,'Value');

set(handles.text_inertia,'Visible','off');
set(handles.edit_J,'Visible','off');

set(handles.text_gyration,'Visible','off');
set(handles.edit_R,'Visible','off');


if(n==1)
    set(handles.text_inertia,'Visible','on');
    set(handles.edit_J,'Visible','on');    
else
    set(handles.text_gyration,'Visible','on');
    set(handles.edit_R,'Visible','on');    
end



% --- Executes during object creation, after setting all properties.
function listbox_inertia_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_inertia (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_R_Callback(hObject, eventdata, handles)
% hObject    handle to edit_R (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_R as text
%        str2double(get(hObject,'String')) returns contents of edit_R as a double


% --- Executes during object creation, after setting all properties.
function edit_R_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_R (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_psave.
function listbox_psave_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_psave (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_psave contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_psave


% --- Executes during object creation, after setting all properties.
function listbox_psave_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_psave (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function pushbutton_calculate_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

function varargout = two_dof_base_d(varargin)
% TWO_DOF_BASE_D MATLAB code for two_dof_base_d.fig
%      TWO_DOF_BASE_D, by itself, creates a new TWO_DOF_BASE_D or raises the existing
%      singleton*.
%
%      H = TWO_DOF_BASE_D returns the handle to a new TWO_DOF_BASE_D or the handle to
%      the existing singleton*.
%
%      TWO_DOF_BASE_D('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TWO_DOF_BASE_D.M with the given input arguments.
%
%      TWO_DOF_BASE_D('Property','Value',...) creates a new TWO_DOF_BASE_D or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before two_dof_base_d_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to two_dof_base_d_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help two_dof_base_d

% Last Modified by GUIDE v2.5 25-Nov-2020 17:42:29

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @two_dof_base_d_OpeningFcn, ...
                   'gui_OutputFcn',  @two_dof_base_d_OutputFcn, ...
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


% --- Executes just before two_dof_base_d is made visible.
function two_dof_base_d_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to two_dof_base_d (see VARARGIN)

% Choose default command line output for two_dof_base_d
handles.output = hObject;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
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



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
axes(handles.axes1);
x=[-10 -10 10 10 -10];
y=[7 12 12 7 7];
 
plot(x,y,'Color',cmap(1,:),'linewidth',0.75);
hold on;
 
x=x*1.1;
y=[-11 -12 -12 -11 -11]+13;
 
plot(x,y,'Color',cmap(1,:),'linewidth',0.75);
hold on;
 
%%%%%% text %%%%%%%%%%%%
 
text(0.5,10.5,'\theta','fontsize',12); 
 
text(12.5,11.5,'x','fontsize',11);
 
text(13.5,3,'y','fontsize',11);
 
text(13.4,4.1,'..','fontsize',13);
 
text(-8.5,9.5,'m, J','fontsize',11);
text(-11,4.5,'k_{1}','fontsize',11);
text(5,4.5,'k_{2}','fontsize',11);
 
text(-5.5,14.5,'L_{1}','fontsize',11);
text( 3,14.5,'L_{2}','fontsize',11);
 
%%%%%% side lines %%%%%%%%%%%%
 
x=[10 11.5];
y=[9.5 9.5];
plot(x,y,'Color','k');
 
 
x=[11 12.5];
y=[1.5 1.5];
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
 
ah = annotation('arrow',...
            'headStyle','cback1','HeadLength',headLength,'HeadWidth',headWidth);
        set(ah,'parent',gca);
        set(ah,'position',[12.5 1.5 0 2.5]);            
        
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
xlim([-14.25 17.75]-1);
ylim([-1 18]);
 




units_listbox_Callback(hObject, eventdata, handles)
listbox_inertia_Callback(hObject, eventdata, handles)

set(handles.pushbutton_damping,'Visible','off');
set(handles.transmissibility_pushbutton,'Visible','off');
set(handles.pushbutton_sine,'Visible','off');
set(handles.pushbutton_PSD,'Visible','off');
set(handles.pushbutton_arbitrary,'Visible','off');

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes two_dof_base_d wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = two_dof_base_d_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

delete(two_dof_base_d);


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


% --- Executes on button press in pushbutton_fn.
function pushbutton_fn_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_fn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

disp(' ');
disp(' * * * * ');
disp(' ');


fig_num=1;

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

%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
[fn,omega,ModeShapes,MST]=Generalized_Eigen(stiffness,mass,1);

%
v=eye(2);
LM=MST*mass*v;
PF=LM;

%%%%%%%%%%%%%%%%%%%%

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

mode_spring=[ d1(1) d2(1) ; d1(2) d2(2) ];

setappdata(0,'mode_spring',mode_spring);

%%%%%%%%%%%%%%%%%%%%
 
disp(' ');
disp(' Transformed mode shapes for spring-to-mass attachment points '); 
disp('  (column format) ');
disp('  ');
 
out1=sprintf(' %8.4g  %8.4g ',d1(1),d2(1));
out2=sprintf(' %8.4g  %8.4g ',d1(3),d2(3));
 
disp(out1);
disp(out2);

figure(fig_num);
fig_num=fig_num+1;
plot(xz,dz,'bo',x,dn,'b',x,d1,'r',x,-d1,'r');
out1=sprintf('First Mode Shape  %6.3g Hz  ',fn(1));
title(out1);
ylabel('Unscaled Displacement');
xlabel(xlab);
grid on;

    
figure(fig_num);
fig_num=fig_num+1;
plot(xz,dz,'bo',x,dn,'b',x,d2,'r',x,-d2,'r');
out1=sprintf('Second Mode Shape  %6.3g Hz  ',fn(2));
title(out1);
ylabel('Unscaled Displacement');
xlabel(xlab);
grid on;

%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

disp(' ');
disp('  Participation Factors (rows represent modes) ');
disp(' ');

maximum = max(max(abs(PF)));  
for i=1:2
   for j=1:2
       if(abs(PF(i,j))< (maximum/1.0e+04) )
           PF(i,j)=0.;
       end
   end
end

out1 = sprintf('            x      theta   ');
disp(out1);

for i=1:2
    out1 = sprintf(' %d.\t%9.3g\t%9.3g\t%9.3g\t%9.3g\t%9.3g\t%9.3g ',i,PF(i,1),PF(i,2));
    disp(out1);
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

disp(' ');
disp('  Effective Modal Mass (rows represent modes) ');
disp(' ');
EMM=LM.*LM;
maximum = max(max(abs(EMM)));  
for i=1:2
   for j=1:2
       if(abs(EMM(i,j))< (maximum/1.0e+04) )
           EMM(i,j)=0.;
       end
   end
end
out1 = sprintf('            x      theta   ');
disp(out1);
for i=1:2
    out1 = sprintf(' %d.\t%9.3g\t%9.3g ',i,EMM(i,1),EMM(i,2));
    disp(out1);
end
disp(' ')
disp(' Total Modal Mass ')
disp(' ')
%
out1 = sprintf(' \t%9.3g\t%9.3g ',sum(EMM(:,1)),sum(EMM(:,2)));
disp(out1);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

setappdata(0,'unit',iu);
setappdata(0,'m2',mass);
setappdata(0,'k2',stiffness);
setappdata(0,'fn',fn);
setappdata(0,'ModeShapes',ModeShapes);

setappdata(0,'L1',L1);
setappdata(0,'L2',L2);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

m2=getappdata(0,'m2');
k2=getappdata(0,'k2');

clear mass;
clear stiff;

mass=zeros(3,3);
stiff=zeros(3,3);
 
mass(1,1)=1;
mass(2,2)=m2(1,1);
mass(3,3)=m2(2,2);
 
stiff(2:3,2:3)=k2;
 
stiff(1,1)=stiff(2,2);
stiff(1,2)=-stiff(1,1);
stiff(1,3)=-stiff(2,3);
 
stiff(2,1)=stiff(1,2);
stiff(3,1)=stiff(1,3);


setappdata(0,'mass',mass);
setappdata(0,'stiff',stiff);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


setappdata(0,'fig_num',fig_num);

set(handles.pushbutton_damping,'Visible','on');

msgbox('Calculation complete.  Output written to Matlab Command Window.');


% --- Executes on button press in pushbutton_damping.
function pushbutton_damping_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_damping (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.s= two_dof_damping;
set(handles.s,'Visible','on');

set(handles.transmissibility_pushbutton,'Visible','on');
set(handles.pushbutton_sine,'Visible','on');
set(handles.pushbutton_PSD,'Visible','on');
set(handles.pushbutton_arbitrary,'Visible','on');


% --- Executes on button press in transmissibility_pushbutton.
function transmissibility_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to transmissibility_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%%% handles.s= two_dof_transmissibility_trot;

handles.s= two_dof_transmissibility_trot;

set(handles.s,'Visible','on');


% --- Executes on button press in pushbutton_sine.
function pushbutton_sine_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_sine (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.s= two_dof_sine_trot;
set(handles.s,'Visible','on');


% --- Executes on button press in pushbutton_PSD.
function pushbutton_PSD_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_PSD (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.s= two_dof_psd_trot;
set(handles.s,'Visible','on');


% --- Executes on button press in pushbutton_arbitrary.
function pushbutton_arbitrary_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_arbitrary (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


handles.s= two_dof_arbitrary_trot;
set(handles.s,'Visible','on');


% --- Executes during object creation, after setting all properties.
function axes1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes1

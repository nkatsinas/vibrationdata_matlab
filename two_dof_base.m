function varargout = two_dof_base(varargin)
% TWO_DOF_BASE MATLAB code for two_dof_base.fig
%      TWO_DOF_BASE, by itself, creates a new TWO_DOF_BASE or raises the existing
%      singleton*.
%
%      H = TWO_DOF_BASE returns the handle to a new TWO_DOF_BASE or the handle to
%      the existing singleton*.
%
%      TWO_DOF_BASE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TWO_DOF_BASE.M with the given input arguments.
%
%      TWO_DOF_BASE('Property','Value',...) creates a new TWO_DOF_BASE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before two_dof_base_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to two_dof_base_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help two_dof_base

% Last Modified by GUIDE v2.5 11-Oct-2016 16:12:47

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @two_dof_base_OpeningFcn, ...
                   'gui_OutputFcn',  @two_dof_base_OutputFcn, ...
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


% --- Executes just before two_dof_base is made visible.
function two_dof_base_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to two_dof_base (see VARARGIN)

% Choose default command line output for two_dof_base
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
 
%%%%%%% axes 1 %%%%%%%%%%%
 
clc;  
axes(handles.axes1);

%%%%%% base %%%%%%%%%%%%

x=[-5.5 -5.5 5.5 5.5 -5.5];
y=[0 0.5 0.5 0 0]-4.5;
 
plot(x,y,'Color',cmap(1,:),'linewidth',0.75);
hold on;

headWidth = 4;
headLength = 4;
 
 
ah = annotation('arrow',...
            'headStyle','cback1','HeadLength',headLength,'HeadWidth',headWidth);
        set(ah,'parent',gca);
        set(ah,'position',[7 -4.25 0 1.5]); 
        
x=[4.5 6]+1;
y=[-4.25 -4.25];
plot(x,y,'Color','k');        

%%%%%% masses %%%%%%%%%%%%

x=[-4 -4 4 4 -4];
y=[3 6 6 3 3]-3;
 
plot(x,y,'Color',cmap(1,:),'linewidth',0.75);

x=[-4 -4 4 4 -4];
y=[3 6 6 3 3]+4;
 
plot(x,y,'Color',cmap(1,:),'linewidth',0.75);
 
%%%%%% side lines %%%%%%%%%%%%
 
x=[4 6];
y=[1.5 1.5];
plot(x,y,'Color','k');
 
 
x=[4 6];
y=[8.5 8.5];
plot(x,y,'Color','k');
 
%%%%%% text %%%%%%%%%%%%
 
text(7,3,'x_{1}','fontsize',11);
text(7,10,'x_{2}','fontsize',11);
 
  
text(-0.9,8.5,'m_{2}','fontsize',11);
text(-0.9,1.5,'m_{1}','fontsize',11);
text(-4,5,'k_{2}','fontsize',11);
text(-4,-2,'k_{1}','fontsize',11);

text(8,-2,'y','fontsize',11);
text(7.825,-1.25,'..','fontsize',13);

%%%%%% arrows %%%%%%%%%%%%
 
headWidth = 4;
headLength = 4;
 
 
        
  
ah = annotation('arrow',...
            'headStyle','cback1','HeadLength',headLength,'HeadWidth',headWidth);
        set(ah,'parent',gca);
        set(ah,'position',[6 1.5 0 1.5]);        
        
ah = annotation('arrow',...
            'headStyle','cback1','HeadLength',headLength,'HeadWidth',headWidth);
        set(ah,'parent',gca);
        set(ah,'position',[6 8.5 0 1.5]);        
        
 
        
%%%%%% spring %%%%%%%%%%%%        
 
nn=2000;
 
dt=4/(nn-1);
 
t=zeros(nn,1);
for i=1:nn
    t(i)=(i-1)*dt;
end
t=t-0.75;
y=sawtooth(2*pi*t,0.5);
 
t=3*t/(max(t)-min(t))+2;
 
plot(y,t+2,'Color',cmap(5,:),'linewidth',0.75);
plot(y,t+2-7,'Color',cmap(5,:),'linewidth',0.75);
 
 
 
x=[0 0];
y=[3 min(t+2)];
plot(x,y,'Color',cmap(5,:),'linewidth',0.75);
 
x=[0 0];
y=[max(t)+2 max(t)+2.5];
plot(x,y,'Color',cmap(5,:),'linewidth',0.75);
 
x=[0 0];
y=[3 min(t+2)]-7;
plot(x,y,'Color',cmap(5,:),'linewidth',0.75);
 
x=[0 0];
y=[max(t)+2 max(t)+2.5]-7;
plot(x,y,'Color',cmap(5,:),'linewidth',0.75);
 
 
 
%%%%%% end %%%%%%%%%%%%
 
 
hold off;
grid on;
set(gca,'XTick',[], 'YTick', [])
xlim([-12 12]);
ylim([-6 12]);
 
 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

axes(handles.axes2);

%%%%%% base %%%%%%%%%%%%

x=[-11.5 -11.5 5.5 5.5 -11.5];
y=[0 0.5 0.5 0 0]-4.5;
 
plot(x,y,'Color',cmap(1,:),'linewidth',0.75);
hold on;

headWidth = 4;
headLength = 4;
 
 
ah = annotation('arrow',...
            'headStyle','cback1','HeadLength',headLength,'HeadWidth',headWidth);
        set(ah,'parent',gca);
        set(ah,'position',[7 -4.25 0 1.5]); 
        
x=[4.5 6]+1;
y=[-4.25 -4.25];
plot(x,y,'Color','k');        

%%%%%% masses %%%%%%%%%%%%

x=[-3.5 -3.5 4 4 -3.5];
y=[3 6 6 3 3]-3;

plot(x,y,'Color',cmap(1,:),'linewidth',0.75);

x=[-10 -10 4 4 -10];
y=[3 6 6 3 3]+4;
 
plot(x,y,'Color',cmap(1,:),'linewidth',0.75);
 
%%%%%% side lines %%%%%%%%%%%%
 
x=[4 6];
y=[1.5 1.5];
plot(x,y,'Color','k');
 
 
x=[4 6];
y=[8.5 8.5];
plot(x,y,'Color','k');
 
%%%%%% text %%%%%%%%%%%%
 
text(7,3,'x_{1}','fontsize',11);
text(7,10,'x_{2}','fontsize',11);
 
  
text(-3.9,8.5,'m_{2}','fontsize',11);
text(-0.9,1.5,'m_{1}','fontsize',11);
text(2,5,'k_{2}','fontsize',11);
text(2,-2,'k_{1}','fontsize',11);
text(-12,2,'k_{3}','fontsize',11);

text(8,-2,'y','fontsize',11);
text(7.825,-1.25,'..','fontsize',13);

%%%%%% arrows %%%%%%%%%%%%
 
headWidth = 4;
headLength = 4;
 
 
        
  
ah = annotation('arrow',...
            'headStyle','cback1','HeadLength',headLength,'HeadWidth',headWidth);
        set(ah,'parent',gca);
        set(ah,'position',[6 1.5 0 1.5]);        
        
ah = annotation('arrow',...
            'headStyle','cback1','HeadLength',headLength,'HeadWidth',headWidth);
        set(ah,'parent',gca);
        set(ah,'position',[6 8.5 0 1.5]);        
        
       
  
        
%%%%%% spring %%%%%%%%%%%%        
 
nn=2000;
 
dt=4/(nn-1);
 
t=zeros(nn,1);
for i=1:nn
    t(i)=(i-1)*dt;
end
t=t-0.75;
y=sawtooth(2*pi*t,0.5);
 
t=3*t/(max(t)-min(t))+2;
 
plot(y,t+2,'Color',cmap(5,:),'linewidth',0.75);
plot(y,t+2-7,'Color',cmap(5,:),'linewidth',0.75);
 
 
 
x=[0 0];
y=[3 min(t+2)];
plot(x,y,'Color',cmap(5,:),'linewidth',0.75);
 
x=[0 0];
y=[max(t)+2 max(t)+2.5];
plot(x,y,'Color',cmap(5,:),'linewidth',0.75);
 
x=[0 0];
y=[3 min(t+2)]-7;
plot(x,y,'Color',cmap(5,:),'linewidth',0.75);
 
x=[0 0];
y=[max(t)+2 max(t)+2.5]-7;
plot(x,y,'Color',cmap(5,:),'linewidth',0.75);
 
%%%%%%

nn=4000;
dt=13/(nn-1); 

t=zeros(nn,1);
for i=1:nn
    t(i)=(i-1)*dt;
end
t=t-0.75;
y=sawtooth(2*pi*t,0.5);
 
t=10*t/(max(t)-min(t))+2;
 
plot(y-7,t+2-7,'Color',cmap(5,:),'linewidth',0.75);


x=[0 0]-7;
y=[-4 -3.5];
plot(x,y,'Color',cmap(5,:),'linewidth',0.75);
 
x=[0 0]-7;
y=[6.45 7];
plot(x,y,'Color',cmap(5,:),'linewidth',0.75);
 

%%%%%% end %%%%%%%%%%%%
 
 
hold off;
grid on;
set(gca,'XTick',[], 'YTick', [])
xlim([-20 14]);
ylim([-7 13]);
 
 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

axes(handles.axes3);
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
xlim([-13.25 16.75]-1);
ylim([-1 18]);
 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

fig_num=1;

setappdata(0,'fig_num',fig_num);   

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes two_dof_base wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = two_dof_base_OutputFcn(hObject, eventdata, handles) 
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

two_dof_base_aa;


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.two_dof_b= two_dof_base_b;
set(handles.two_dof_b,'Visible','on');


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.two_dof_d= two_dof_base_d;
set(handles.two_dof_d,'Visible','on');


% --- Executes during object creation, after setting all properties.
function axes2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes2

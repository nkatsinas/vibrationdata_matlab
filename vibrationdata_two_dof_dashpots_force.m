function varargout = vibrationdata_two_dof_dashpots_force(varargin)
% VIBRATIONDATA_TWO_DOF_DASHPOTS_FORCE MATLAB code for vibrationdata_two_dof_dashpots_force.fig
%      VIBRATIONDATA_TWO_DOF_DASHPOTS_FORCE, by itself, creates a new VIBRATIONDATA_TWO_DOF_DASHPOTS_FORCE or raises the existing
%      singleton*.
%
%      H = VIBRATIONDATA_TWO_DOF_DASHPOTS_FORCE returns the handle to a new VIBRATIONDATA_TWO_DOF_DASHPOTS_FORCE or the handle to
%      the existing singleton*.
%
%      VIBRATIONDATA_TWO_DOF_DASHPOTS_FORCE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in VIBRATIONDATA_TWO_DOF_DASHPOTS_FORCE.M with the given input arguments.
%
%      VIBRATIONDATA_TWO_DOF_DASHPOTS_FORCE('Property','Value',...) creates a new VIBRATIONDATA_TWO_DOF_DASHPOTS_FORCE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before vibrationdata_two_dof_dashpots_force_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to vibrationdata_two_dof_dashpots_force_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help vibrationdata_two_dof_dashpots_force

% Last Modified by GUIDE v2.5 24-Aug-2018 14:20:56

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @vibrationdata_two_dof_dashpots_force_OpeningFcn, ...
                   'gui_OutputFcn',  @vibrationdata_two_dof_dashpots_force_OutputFcn, ...
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


% --- Executes just before vibrationdata_two_dof_dashpots_force is made visible.
function vibrationdata_two_dof_dashpots_force_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to vibrationdata_two_dof_dashpots_force (see VARARGIN)

% Choose default command line output for vibrationdata_two_dof_dashpots_force
handles.output = hObject;

%%%%%%%%%%%

%%%%%%%%%%%

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


axes(handles.axes1);
x=[-6 -6 6 6 -6];
y=[3 6 6 3 3]-3;

plot(x,y,'Color',cmap(1,:),'linewidth',0.75);
hold on;

x=[-6 -6 6 6 -6];
y=[3 6 6 3 3]+4;

plot(x,y,'Color',cmap(1,:),'linewidth',0.75);

%%%%%% side lines %%%%%%%%%%%%

x=[4 6]+2;
y=[1.5 1.5];
plot(x,y,'Color','k');


x=[4 6]+2;
y=[8.5 8.5];
plot(x,y,'Color','k');

%%%%%% text %%%%%%%%%%%%

text(9,3,'x_{1}','fontsize',11);
text(9,10,'x_{2}','fontsize',11);


text(-1,12.5,'F_{2}','fontsize',10.5);
text(-1,5.5,'F_{1}','fontsize',10.5);

text(-0.9,8.5,'m_{2}','fontsize',11);
text(-0.9,1.5,'m_{1}','fontsize',11);

text(-8,5,'k_{2}','fontsize',11);
text(-8,-2,'k_{1}','fontsize',11);

text(6,5,'c_{2}','fontsize',11);
text(6,-2,'c_{1}','fontsize',11);


%%%%%% arrows %%%%%%%%%%%%

headWidth = 4;
headLength = 4;

ah = annotation('arrow',...
            'headStyle','cback1','HeadLength',headLength,'HeadWidth',headWidth);
        set(ah,'parent',gca);
        set(ah,'position',[0 3 0 1.5]);

ah = annotation('arrow',...
            'headStyle','cback1','HeadLength',headLength,'HeadWidth',headWidth);
        set(ah,'parent',gca);
        set(ah,'position',[0 10 0 1.5]);
        
  
ah = annotation('arrow',...
            'headStyle','cback1','HeadLength',headLength,'HeadWidth',headWidth);
        set(ah,'parent',gca);
        set(ah,'position',[8 1.5 0 1.5]);        
        
ah = annotation('arrow',...
            'headStyle','cback1','HeadLength',headLength,'HeadWidth',headWidth);
        set(ah,'parent',gca);
        set(ah,'position',[8 8.5 0 1.5]);        
        

        
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

plot(y-3.5,t+2,'Color',cmap(5,:),'linewidth',0.75);
plot(y-3.5,t+2-7,'Color',cmap(5,:),'linewidth',0.75);



x=[0 0];
y=[3 min(t+2)];
plot(x-3.5,y,'Color',cmap(5,:),'linewidth',0.75);

x=[0 0];
y=[max(t)+2 max(t)+2.5];
plot(x-3.5,y,'Color',cmap(5,:),'linewidth',0.75);

x=[0 0];
y=[3 min(t+2)]-7;
plot(x-3.5,y,'Color',cmap(5,:),'linewidth',0.75);

x=[0 0];
y=[max(t)+2 max(t)+2.5]-7;
plot(x-3.5,y,'Color',cmap(5,:),'linewidth',0.75);

%%%%%% base %%%%%%%%%%%

x=[-6.5 6.5];
y=[ 1 1]-5;
plot(x,y,'Color','k','linewidth',0.75);
y=[0.5 1]-5;
x=[-0.7 0];
plot(x,y,'Color','k','linewidth',0.75);
x=[-0.7 0]-1.4;
plot(x,y,'Color','k','linewidth',0.75);
x=[-0.7 0]-2.8;
plot(x,y,'Color','k','linewidth',0.75);
x=[-0.7 0]-4.2;
plot(x,y,'Color','k','linewidth',0.75);
x=[-0.7 0]-4.2-1.4;
plot(x,y,'Color','k','linewidth',0.75);

x=[-0.7 0]+1.4;
plot(x,y,'Color','k','linewidth',0.75);
x=[-0.7 0]+2.8;
plot(x,y,'Color','k','linewidth',0.75);
x=[-0.7 0]+4.2;
plot(x,y,'Color','k','linewidth',0.75);
x=[-0.7 0]+4.2+1.4;
plot(x,y,'Color','k','linewidth',0.75);

%%%%%% dashpot %%%%%%%%%%

x=[2.25 2.25]+1.25;
y=[2.5 4.625]-6.5;
plot(x,y,'Color',cmap(5,:),'linewidth',0.75);

x=[1.75 2.75]+1.25;
y=[4.625 4.625]-6.5;
plot(x,y,'Color',cmap(5,:),'linewidth',0.75);



x=[2.25 2.25]+1.25;
y=[5 6.5]-6.5;
plot(x,y,'Color',cmap(5,:),'linewidth',0.75);

x=[1.25 3.25]+1.25;
y=[5 5]-6.5;
plot(x,y,'Color',cmap(5,:),'linewidth',0.75);



x=[1.25 1.25]+1.25;
y=[4.6 5]-6.5;
plot(x,y,'Color',cmap(5,:),'linewidth',0.75);

x=[3.25 3.25]+1.25;
y=[4.6 5]-6.5;
plot(x,y,'Color',cmap(5,:),'linewidth',0.75);

%%%%%%

x=[2.25 2.25]+1.25;
y=[2.5 4.625]-6.5+7;
plot(x,y,'Color',cmap(5,:),'linewidth',0.75);

x=[1.75 2.75]+1.25;
y=[4.625 4.625]-6.5+7;
plot(x,y,'Color',cmap(5,:),'linewidth',0.75);



x=[2.25 2.25]+1.25;
y=[5 6.5]-6.5+7;
plot(x,y,'Color',cmap(5,:),'linewidth',0.75);

x=[1.25 3.25]+1.25;
y=[5 5]-6.5+7;
plot(x,y,'Color',cmap(5,:),'linewidth',0.75);



x=[1.25 1.25]+1.25;
y=[4.6 5]-6.5+7;
plot(x,y,'Color',cmap(5,:),'linewidth',0.75);

x=[3.25 3.25]+1.25;
y=[4.6 5]-6.5+7;
plot(x,y,'Color',cmap(5,:),'linewidth',0.75);

%%%%%% end %%%%%%%%%%%%


hold off;
grid on;
set(gca,'XTick',[], 'YTick', [])
xlim([-10 13]);
ylim([-5.5 14]);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

fstr ='two_dof_system_dashpots_c_sm.jpg';
 
bg = imread(fstr);
info = imfinfo(fstr);
w = info.Width;  %An integer indicating the width of the image in pixels
h = info.Height; %An integer indicating the height of the image in pixels
 
axes(handles.axes2);
image(bg);
 
pos1 = getpixelposition(handles.pushbutton_select_b,true);

xc=0.5*pos1(3)+pos1(1);
x=round(xc-0.5*w);
y=pos1(2)+1.4*pos1(4);

set(handles.axes2, ...
    'Visible', 'off', ...
    'Units', 'pixels', ...
    'Position', [x y w h]);
axis off;


%%%%%%%%%%%

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes vibrationdata_two_dof_dashpots_force wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = vibrationdata_two_dof_dashpots_force_OutputFcn(hObject, eventdata, handles) 
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

delete(vibrationdata_two_dof_dashpots_force);


% --- Executes on button press in pushbutton_select_a.
function pushbutton_select_a_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_select_a (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.s= two_dof_system_dashpots_b;
set(handles.s,'Visible','on');


% --- Executes on button press in pushbutton_select_b.
function pushbutton_select_b_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_select_b (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.s= two_dof_system_dashpots_c;
set(handles.s,'Visible','on');

% --- Executes on button press in pushbutton_select_c.
function pushbutton_select_c_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_select_c (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.s= two_dof_system_c_force;
set(handles.s,'Visible','on');

function varargout = automobile_road(varargin)
% AUTOMOBILE_ROAD MATLAB code for automobile_road.fig
%      AUTOMOBILE_ROAD, by itself, creates a new AUTOMOBILE_ROAD or raises the existing
%      singleton*.
%
%      H = AUTOMOBILE_ROAD returns the handle to a new AUTOMOBILE_ROAD or the handle to
%      the existing singleton*.
%
%      AUTOMOBILE_ROAD('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in AUTOMOBILE_ROAD.M with the given input arguments.
%
%      AUTOMOBILE_ROAD('Property','Value',...) creates a new AUTOMOBILE_ROAD or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before automobile_road_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to automobile_road_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help automobile_road

% Last Modified by GUIDE v2.5 20-Feb-2015 10:29:20

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @automobile_road_OpeningFcn, ...
                   'gui_OutputFcn',  @automobile_road_OutputFcn, ...
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


% --- Executes just before automobile_road is made visible.
function automobile_road_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to automobile_road (see VARARGIN)

% Choose default command line output for automobile_road
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


x=[5 5 11 11 5 ];
y=[-11 -12 -12 -11 -11]+13;
 
plot(x,y,'Color',cmap(1,:),'linewidth',0.75);
hold on;

x=[5 5 11 11 5 ]-16;
y=[-11 -12 -12 -11 -11]+13;
 
plot(x,y,'Color',cmap(1,:),'linewidth',0.75);
hold on;

%%%%%% text %%%%%%%%%%%%

text(0.5,10.5,'\theta','fontsize',12); 

text(12.5,11.5,'x','fontsize',11);

text(13.5,3,'y_{2}','fontsize',11);
text(-2.5,3,'y_{1}','fontsize',11);

 
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
 

x=[11 12.5]-16;
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
        set(ah,'position',[-3.5 1.5 0 2.5]);    
        
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

units_listbox_Callback(hObject, eventdata, handles)
listbox_inertia_Callback(hObject, eventdata, handles)
listbox_analysis_Callback(hObject, eventdata, handles)

set(handles.listbox_psave,'Value',2);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes automobile_road wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = automobile_road_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes during object creation, after setting all properties.
function axes1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes1


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
    set(handles.text_mph,'String','mph');
    set(handles.text_h,'String','in');
    set(handles.text_w,'String','in');    
else
    set(handles.mass_unit_text,'String','Mass: kg'); 
    set(handles.inertia_unit_text,'String','Inertia: kg m^2')     
    set(handles.stiffness_unit_text,'String','Stiffness: N/m');
    set(handles.length_unit_text,'String','Length: m');  
    set(handles.text_mph,'String','km/hr');    
    set(handles.text_h,'String','cm');
    set(handles.text_w,'String','cm');     
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



function edit_Q1_Callback(hObject, eventdata, handles)
% hObject    handle to edit_Q1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_Q1 as text
%        str2double(get(hObject,'String')) returns contents of edit_Q1 as a double


% --- Executes during object creation, after setting all properties.
function edit_Q1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_Q1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_Q2_Callback(hObject, eventdata, handles)
% hObject    handle to edit_Q2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_Q2 as text
%        str2double(get(hObject,'String')) returns contents of edit_Q2 as a double


% --- Executes during object creation, after setting all properties.
function edit_Q2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_Q2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_v_Callback(hObject, eventdata, handles)
% hObject    handle to edit_v (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_v as text
%        str2double(get(hObject,'String')) returns contents of edit_v as a double


% --- Executes during object creation, after setting all properties.
function edit_v_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_v (see GCBO)
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

tpi=2*pi;

fig_num=1;

iu=get(handles.units_listbox,'Value');
nJ=get(handles.listbox_inertia,'Value');

M=str2num(get(handles.edit_M,'string'));

k1=str2num(get(handles.edit_K1,'string'));
k2=str2num(get(handles.edit_K2,'string'));
L1=str2num(get(handles.edit_L1,'string'));
L2=str2num(get(handles.edit_L2,'string'));

Q1=str2num(get(handles.edit_Q1,'string'));
Q2=str2num(get(handles.edit_Q2,'string'));

damp(1)=1/(2*Q1);
damp(2)=1/(2*Q2);

if(nJ==1)
    J=str2num(get(handles.edit_J,'string'));
else
    R=str2num(get(handles.edit_R,'string'));
    J=M*R^2;
end


if(iu==1)
    M=M/386;
    J=J/386;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

na=get(handles.listbox_analysis,'Value');

h=str2num(get(handles.edit_h,'String'));
w=str2num(get(handles.edit_w,'String'));
v=str2num(get(handles.edit_v,'String'));

if(iu==1)
    v=v*17.6;
else  
    v=v*0.28;    
    h=h/10;
    w=w/10;
end

L=L1+L2;



if(na==1) % speed bump
    
    T=w/v;
   
    roadL=50*w;
    
    delta=w/200;
    
    num=roadL/delta;
    
    Y1=zeros(num,1);
    Y2=zeros(num,1);
    
    V1=zeros(num,1);
    V2=zeros(num,1);  
    
    A1=zeros(num,1);
    A2=zeros(num,1);
    
    x=zeros(num,1);
    
    for i=1:num
        x(i)=(i-1)*delta;
    end  
  
    t=x/v;
    
    for i=1:num
        

        
        if( x(i)<=w)        
            
            arg=pi*t(i)/T;
            
            Y2(i)=sin(pi*x(i)/w);           % mass 2 is at front
            
            V2(i)=(pi/T)*cos(arg);   
            A2(i)=-(pi/T)^2*sin(arg); 
        end
        
        if( x(i)>=L && x(i)<(L+w))
            
            arg=pi*(t(i)-L/v)/T;
            
            Y1(i)=sin(pi*(x(i)-L)/w);        % mass 1 is at rear
            V1(i)=(pi/T)*cos(arg);     
            A1(i)=-(pi/T)^2*sin(arg);   
        end        
        
    end
    

end
if(na==2) % washboard

    roadL=40*w;
    
    delta=w/100;
    
    num=round(roadL/delta);
    
    Y1=zeros(num,1);
    V1=zeros(num,1);
    A1=zeros(num,1);
    
    Y2=zeros(num,1);
    V2=zeros(num,1);    
    A2=zeros(num,1);
    
    x=zeros(num,1);
    
    cc=0;
    nn=0;
    ie=0;
    
    
    for i=1:num
        x(i)=(i-1)*delta;
    end  
  
    t=x/v;    
    
    T=w/v;
    
    for i=1:num
        x(i)=(i-1)*delta;
                            
        arg=tpi*t(i)/T;
            
        Y2(i)=sin(tpi*x(i)/w);           % mass 2 is at front
        V2(i)=(tpi/T)*cos(arg);   
        A2(i)=-(tpi/T)^2*sin(arg); 
        
        if( x(i)>=L)

            arg=tpi*(t(i)-L/v)/T;
            
            Y1(i)=sin(tpi*(x(i)-L)/w);        % mass 1 is at rear
            V1(i)=(tpi/T)*cos(arg);     
            A1(i)=-(tpi/T)^2*sin(arg);               
            
            cc=cc+Y1(i)*Y2(i);
            nn=nn+1;
            
            if(ie==0)
                ie=i;
            end
            
        end        
        
    end   
    
    cc=cc/(nn*std(Y1(ie:num))*std(Y2(ie:num)));
    
    out1=sprintf('\n correlation coefficient = %8.4g \n',cc);
    disp(out1);
    
end



Y1=Y1*h;
Y2=Y2*h;

V1=V1*h;
V2=V2*h;

A1=A1*h;
A2=A2*h;


clear x;

dt=(t(num)-t(1))/(num-1);

nt=num;

if(na==2) % washboard
    out1=sprintf('\n Input Frequency = %8.4g Hz \n',1/T);
    disp(out1);
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

mass=zeros(4,4);
mass(1,1)=1;
mass(2,2)=1;
mass(3,3)=M;
mass(4,4)=J;

stiff=zeros(4,4);
stiff(1,1)=k1;
stiff(1,3)=-k1;
stiff(1,4)=k1*L1;

stiff(2,2)=k2;
stiff(2,3)=-k2;
stiff(2,4)=-k2*L2;

stiff(3,3)=k1+k2;
stiff(3,4)=-k1*L1+k2*L2;

stiff(4,4)=k1*L1^2+k2*L2^2;

for irow=2:4
    for jcol=1:(irow-1)
        stiff(irow,jcol)=stiff(jcol,irow);
    end
end

mass
stiff

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%
%  etype =1  enforced acceleration
%         2  enforced displacement
%

etype=2;

num=4; % total dof
nem=2; % number of dof with enforced displacements

nff=num-nem;

ea=[1 2]; % dof with enforced

[ngw]=track_changes(nem,num,ea);

dtype=1; % display partitioned matrices


[TT,T1,T2,Mwd,Mww,Kwd,Kww]=...
                enforced_partition_matrices(num,ea,mass,stiff,etype,dtype);
            
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
%
[fn,omegan,ModeShapes,MST]=Generalized_Eigen(Kww,Mww,1);
%
if(iu==1) 
    xlab='Length (in)';
else
    xlab='Length (m)';    
end

xx(1)=-L1;
xx(2)=0;
xx(3)=L2;

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

disp(' ');

%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%  Modal Transient
%
clear omegad;
omegad=zeros(nff,1);
for i=1:nff
    omegad(i)=omegan(i)*sqrt(1-damp(i)^2);
end
%
clear Q;
Q=ModeShapes;
QT=Q';

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

f=[Y1 Y2];
forig=f;

ddisp=f;
dvelox=[V1 V2];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[num_modes,FP]=transform_force(f,Q,QT,Kwd,nt);  % Kwd for enforced displacement    
%
%
[a1,a2,df1,df2,df3,vf1,vf2,vf3,af1,af2,af3]=...
              ramp_invariant_filter_coefficients(num_modes,omegan,damp,dt);
%

[a,v,d]=enforced_motion_modal_transient_engine(FP,a1,a2,df1,df2,df3,...
                                     vf1,vf2,vf3,af1,af2,af3,nt,num_modes,Q);
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[d,v,acc,d_save,v_save,a_save]=...
        transform_and_original_order(d,v,a,ddisp,dvelox,forig,T1,T2,nt,num,ngw);



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

acc_cg=acc(:,3);
acc_rot=acc(:,4);

d_cg=d(:,3);

rd_s1=zeros(nt,1);
rd_s2=zeros(nt,1);



for i=1:nt
    theta=d(i,4);
    
    rd_s1(i)= d_cg(i)-L1*tan(theta) - d(i,1);
    rd_s2(i)= d_cg(i)+L2*tan(theta) - d(i,2);
    
end


if(iu==1)
   acc_cg=acc_cg/386;
else
   acc_cg=acc_cg/9.81;   
end
%
[jerk_cg]=differentiate_function(acc_cg,dt);
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

disp(' ');
disp('  Maximum & Minimum Amplitudes');
disp(' ');

disp(' C.G. Acceleration (G)');
out1=sprintf(' %8.4g  %8.4g ',max(acc_cg),min(acc_cg));
disp(out1);

disp(' ');
disp(' C.G. Jerk (G/sec)');
out1=sprintf(' %8.4g  %8.4g ',max(jerk_cg),min(jerk_cg));
disp(out1);

disp(' ');
disp(' Rotational Acceleration (rad/sec^2)');
out1=sprintf(' %8.4g  %8.4g ',max(acc_rot),min(acc_rot));
disp(out1);


disp(' ');
if(iu==1)
    disp('Displacement (in)');
else
    disp('Displacement (cm)');    
    d_cg=d_cg*100;
    d_cg=d_cg*100;    
end
out1=sprintf(' %8.4g  %8.4g ',max(d_cg),min(d_cg));
disp(out1);


disp(' ');
if(iu==1)
    disp(' Relative Displacement (in)');
else
    disp(' Relative Displacement (cm)');    
    rd_s1=rd_s1*100;
    rd_s2=rd_s2*100;    
end
out1=sprintf(' Spring 1:  %8.4g  %8.4g ',max(rd_s1),min(rd_s1));
disp(out1);
out1=sprintf(' Spring 2:  %8.4g  %8.4g ',max(rd_s2),min(rd_s2));
disp(out1);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


psave=get(handles.listbox_psave,'Value');

if(psave==1)
    disp(' ');
    disp(' Plot files ');
    disp(' ');    
end    

h1=figure(fig_num);
fig_num=fig_num+1;
plot(xz,dz,'bo',xx,dn,'b',xx,d1,'r',xx,-d1,'r');
out1=sprintf('First Mode Shape  %6.3g Hz  ',fn(1));
title(out1);
ylabel('Unscaled Displacement');
xlabel(xlab);
grid on;

if(psave==1)
    set(gca,'Fontsize',12);
    pn='two_dof_mode1';
    print(h1,pn,'-dpng','-r300');
    out1=sprintf(' %s.png',pn);
    disp(out1);
end
    
h1=figure(fig_num);
fig_num=fig_num+1;
plot(xz,dz,'bo',xx,dn,'b',xx,d2,'r',xx,-d2,'r');
out1=sprintf('Second Mode Shape  %6.3g Hz  ',fn(2));
title(out1);
ylabel('Unscaled Displacement');
xlabel(xlab);
grid on;

if(psave==1)
    set(gca,'Fontsize',12);
    pn='two_dof_mode2';
    print(h1,pn,'-dpng','-r300');
    out1=sprintf(' %s.png',pn);
    disp(out1);
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

h1=figure(fig_num);
fig_num=fig_num+1;

if(iu==2)
    Y1=Y1/100;
    Y2=Y2/100;
end
plot(t,Y1,t,Y2);


legend('Rear','Front');
title('Input Displacement');
xlabel('Time (sec)');
if(iu==1)
    ylabel('Displacement (in)');
else
    ylabel('Displacement (cm)');    
end
grid on;

if(psave==1)
    set(gca,'Fontsize',12);
    pn='input_displacements';
    print(h1,pn,'-dpng','-r300');
    out1=sprintf(' %s.png',pn);
    disp(out1);
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


if(iu==1)
   A1=A1/386;
   A2=A2/386;   
else
   A1=A1/9.81;
   A2=A2/9.81;   
end



h1=figure(fig_num);
fig_num=fig_num+1;

plot(t,A1,t,A2);

legend('Rear','Front');
title('Input Acceleration');
xlabel('Time (sec)');
ylabel('Accel (G)');

grid on;

if(psave==1)
    set(gca,'Fontsize',12);
    pn='input_accelerations';
    print(h1,pn,'-dpng','-r300');
    out1=sprintf(' %s.png',pn);
    disp(out1);
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

h1=figure(fig_num);
fig_num=fig_num+1;
plot(t,jerk_cg);
xlabel('Time (sec)');
ylabel('Jerk (G/sec)');
grid on;
title('C.G. Jerk');


if(psave==1)   
    pname='jerk_cg';
    set(gca,'Fontsize',12);
    print(h1,pname,'-dpng','-r300');    
    out1=sprintf(' %s.png',pname);
    disp(out1);    
end 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

h1=figure(fig_num);
fig_num=fig_num+1;
plot(t,acc_cg);
xlabel('Time (sec)');
ylabel('Accel (G)');
grid on;
title('C.G. Acceleration');


if(psave==1)   
    pname='accel_cg';
    set(gca,'Fontsize',12);
    print(h1,pname,'-dpng','-r300');    
    out1=sprintf(' %s.png',pname);
    disp(out1);    
end 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

h1=figure(fig_num);
fig_num=fig_num+1;
plot(t,acc_rot);
title('Rotational Acceleration');
xlabel('Time (sec)');
ylabel('Accel (rad/sec^2)');
grid on;


if(psave==1)
    set(gca,'Fontsize',12);
    pn='accel_rotation';
    print(h1,pn,'-dpng','-r300');
    out1=sprintf(' %s.png',pn);
    disp(out1);
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

h1=figure(fig_num);
fig_num=fig_num+1;
plot(t,d_cg);
title('C.G. Displacement');
xlabel('Time (sec)');
if(iu==1)
    ylabel('Disp (in)');
else
    ylabel('Disp (cm)');    
end
grid on;


if(psave==1)   
    pname='disp_cg';
    set(gca,'Fontsize',12);
    print(h1,pname,'-dpng','-r300');    
    out1=sprintf(' %s.png',pname);
    disp(out1);    
end 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

h1=figure(fig_num);
fig_num=fig_num+1;
plot(t,rd_s1,t,rd_s2);
legend('Spring 1','Spring 2');
title('Relative Displacement');
xlabel('Time (sec)');
if(iu==1)
    ylabel('Disp (in)');
else
    ylabel('Disp (cm)');    
end    
grid on;


if(psave==1)   
    pname='spring_rel_disp';
    set(gca,'Fontsize',12);
    print(h1,pname,'-dpng','-r300');    
    out1=sprintf(' %s.png',pname);
    disp(out1);    
end 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

disp(' ');
disp(' Arrays saved to Workspace ');
disp('  ');
disp(' Y1 = rear input displacement ');
disp(' Y2 = front input displacement ');
disp(' A1 = rear input acceleration ');
disp(' A2 = front input acceleration ');
disp(' acc_cg = C.G. acceleration ');
disp(' disp_cg = C.G. displacement ');
disp(' rd_s1 = spring 1 relative displacement ');
disp(' rd_s2 = spring 2 relative displacement ');
disp(' acc_rot = rotational acceleration ');


%%%%

assignin('base', 'Y1', [t Y1]);
assignin('base', 'Y2', [t Y2]);
assignin('base', 'A1', [t A1]);
assignin('base', 'A2', [t A2]);
assignin('base', 'acc_cg', [t acc_cg]);
assignin('base', 'disp_cg', [t d_cg]);
assignin('base', 'rd_s1', [t rd_s1]);
assignin('base', 'rd_s2', [t rd_s2]);
assignin('base', 'acc_rot', [t acc_rot]);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% --- Executes on button press in pushbutton_washboard.
function pushbutton_washboard_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_washboard (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on selection change in listbox_analysis.
function listbox_analysis_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_analysis (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_analysis contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_analysis

n=get(handles.listbox_analysis,'Value');

iu=get(handles.units_listbox,'Value');

if(n==1) % speed bump
    set(handles.text_width,'String','Width');
    
    if(iu==1)
         set(handles.edit_h,'String','5')
         set(handles.edit_w,'String','24')         
    else
         set(handles.edit_h,'String','13')
         set(handles.edit_w,'String','61')         
    end
    
else  % washboard road
    set(handles.text_width,'String','Wavelength');
    
    if(iu==1)
         set(handles.edit_h,'String','2')
         set(handles.edit_w,'String','8')         
    else
         set(handles.edit_h,'String','5')
         set(handles.edit_w,'String','20')         
    end    
    
end


% --- Executes during object creation, after setting all properties.
function listbox_analysis_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_analysis (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_h_Callback(hObject, eventdata, handles)
% hObject    handle to edit_h (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_h as text
%        str2double(get(hObject,'String')) returns contents of edit_h as a double


% --- Executes during object creation, after setting all properties.
function edit_h_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_h (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_w_Callback(hObject, eventdata, handles)
% hObject    handle to edit_w (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_w as text
%        str2double(get(hObject,'String')) returns contents of edit_w as a double


% --- Executes during object creation, after setting all properties.
function edit_w_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_w (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_return.
function pushbutton_return_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_return (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


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

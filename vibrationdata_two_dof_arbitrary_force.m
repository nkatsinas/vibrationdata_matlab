function varargout = vibrationdata_two_dof_arbitrary_force(varargin)
% VIBRATIONDATA_TWO_DOF_ARBITRARY_FORCE MATLAB code for vibrationdata_two_dof_arbitrary_force.fig
%      VIBRATIONDATA_TWO_DOF_ARBITRARY_FORCE, by itself, creates a new VIBRATIONDATA_TWO_DOF_ARBITRARY_FORCE or raises the existing
%      singleton*.
%
%      H = VIBRATIONDATA_TWO_DOF_ARBITRARY_FORCE returns the handle to a new VIBRATIONDATA_TWO_DOF_ARBITRARY_FORCE or the handle to
%      the existing singleton*.
%
%      VIBRATIONDATA_TWO_DOF_ARBITRARY_FORCE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in VIBRATIONDATA_TWO_DOF_ARBITRARY_FORCE.M with the given input arguments.
%
%      VIBRATIONDATA_TWO_DOF_ARBITRARY_FORCE('Property','Value',...) creates a new VIBRATIONDATA_TWO_DOF_ARBITRARY_FORCE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before vibrationdata_two_dof_arbitrary_force_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to vibrationdata_two_dof_arbitrary_force_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help vibrationdata_two_dof_arbitrary_force

% Last Modified by GUIDE v2.5 27-Sep-2020 08:14:24

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @vibrationdata_two_dof_arbitrary_force_OpeningFcn, ...
                   'gui_OutputFcn',  @vibrationdata_two_dof_arbitrary_force_OutputFcn, ...
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


% --- Executes just before vibrationdata_two_dof_arbitrary_force is made visible.
function vibrationdata_two_dof_arbitrary_force_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to vibrationdata_two_dof_arbitrary_force (see VARARGIN)

% Choose default command line output for vibrationdata_two_dof_arbitrary_force
handles.output = hObject;

set(handles.pushbutton_modal,'Enable','off');

listbox_dof_Callback(hObject, eventdata, handles);

set(handles.listbox_dof,'Value',1);

set(handles.uipanel_save,'Visible','off');

clc;

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

%%%%%% masses %%%%%%%%%%%%

axes(handles.axes1);
x=[-4 -4 4 4 -4];
y=[3 6 6 3 3]-3;

plot(x,y,'Color',cmap(1,:),'linewidth',0.75);
hold on;

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


text(-3.5,11,'F_{2}','fontsize',11);
text(3.5,5,'F_{1}','fontsize',11);

text(-0.9,8.5,'m_{2}','fontsize',11);
text(-0.9,1.5,'m_{1}','fontsize',11);
text(-3.5,5,'k_{2}','fontsize',11);
text(-3.5,-2,'k_{1}','fontsize',11);

%%%%%% arrows %%%%%%%%%%%%

headWidth = 4;
headLength = 4;

ah = annotation('arrow',...
            'headStyle','cback1','HeadLength',headLength,'HeadWidth',headWidth);
        set(ah,'parent',gca);
        set(ah,'position',[2.5 3 0 1.5]);

ah = annotation('arrow',...
            'headStyle','cback1','HeadLength',headLength,'HeadWidth',headWidth);
        set(ah,'parent',gca);
        set(ah,'position',[0 10 0 1.5]);
        
  
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

%%%%%% base %%%%%%%%%%%

x=[-5 5];
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
plot(x,y,'Color','k','linewidth',0.75);
x=[-0.7 0]+1.4;
plot(x,y,'Color','k','linewidth',0.75);
x=[-0.7 0]+2.8;
plot(x,y,'Color','k','linewidth',0.75);
x=[-0.7 0]+4.2;
plot(x,y,'Color','k','linewidth',0.75);


%%%%%% end %%%%%%%%%%%%


hold off;
grid on;
set(gca,'XTick',[], 'YTick', [])
xlim([-11 11]);
ylim([-6 12]);



% Update handles structure
guidata(hObject, handles);

% UIWAIT makes vibrationdata_two_dof_arbitrary_force wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = vibrationdata_two_dof_arbitrary_force_OutputFcn(hObject, eventdata, handles) 
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

delete(vibrationdata_two_dof_arbitrary_force);


% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

try

    Figures = findobj( 'Type', 'Figure' , '-not' , 'Tag' , get( handles.output , 'Tag' ) );
    NFigures = length( Figures );
    for nFigures = 1 : NFigures
        close( Figures( nFigures ) );
    end
catch
end


tpi=2*pi;

       mass=getappdata(0,'m2');
      dampv=getappdata(0,'damping');
ModeShapes=getappdata(0,'ModeShapes');
        fn=getappdata(0,'fn');
        iu=getappdata(0,'unit');

        
 try
     FS=get(handles.edit_input_array,'String');
     THM=evalin('base',FS);   
 catch
     warndlg('Input array does not exist.');
     return;
 end

 sz=size(THM);
 if(sz(2)>3)
     warndlg('Error: Time History has more than three columns');
     return;
 end
 
 
fig_num=getappdata(0,'fig_num');

if(isempty(fig_num))
    fig_num=1;
end
 
 
n=get(handles.listbox_dof,'Value');    


%%
%%

t=THM(:,1);

nt=length(t);
f1=zeros(nt,1);
f2=zeros(nt,1);

if(n==1)
    f1=THM(:,2);
end
if(n==2)
    f2=THM(:,2);
end
if(n==3)
    f1=THM(:,2);
    f2=THM(:,3);
end

F=[f1 f2];

%
tmx=max(t);
tmi=min(t);

dur=tmx-tmi;

dt=dur/(nt-1);
sr=1./dt;
%
if(sr<10*max(fn))
    disp(' ');
    warndlg(' Warning: insufficient sample rate. ');
end
%
omegan=tpi*fn;

ndof=2;
sys_dof=ndof;

[x,v,a,nx,nv,na]=ramp_invariant_force(ModeShapes,F,ndof,sys_dof,omegan,dampv,dt);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

t_string1='dof 1';
t_string2='dof 2';

%
figure(fig_num);
fig_num=fig_num+1;

dd=x;
if(iu==2)
    dd=dd*1000;
end


plot(t,dd(:,1),t,dd(:,2));

    
legend ('dof 1','dof 2');   
xlabel('Time(sec)');
title('Displacement');
grid on;
disp(' ');
if(iu==1)
    ylabel(' Displacement(in) ');
    disp(' Peak Displacement (in) ')
    ylabel1='Disp(in)';    
else
    ylabel(' Displacement(mm) ');
    disp(' Peak Displacement (mm)')
    ylabel1='Disp(mm)';      
end

out1=sprintf('dof 1  %8.4g  %8.4g  ',max(dd(:,1)),min(dd(:,1)));
out2=sprintf('dof 2  %8.4g  %8.4g  ',max(dd(:,2)),min(dd(:,2)));

disp(out1);
disp(out2);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


data1=[ t dd(:,1)];
data2=[ t dd(:,2)];

xlabel2='Time(sec)';
ylabel2=ylabel1;

[fig_num]=subplots_two_linlin_scale(fig_num,xlabel2,ylabel1,ylabel2,data1,data2,t_string1,t_string2);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

rd=zeros(nt,1);

for i=1:nt
    rd(i)=dd(i,1)-dd(i,2);
end
    
figure(fig_num);
fig_num=fig_num+1;
plot(t,rd);
xlabel('Time(sec)');
title('Relative Displacement (dof 2 - dof 1)');
grid on;
disp(' ');
if(iu==1)
    ylabel(' Disp(in) ');
    disp(' Peak Relative Displacement (in) ')
else
    ylabel(' Disp(mm) ');
    disp(' Peak Relative Displacement (mm)')
end

out1=sprintf('dof 2 - dof 1  %8.4g  %8.4g  ',max(rd),min(rd));
disp(out1);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
figure(fig_num);
fig_num=fig_num+1;
plot(t,v(:,1),t,v(:,2));
legend ('dof 1','dof 2');   
xlabel('Time(sec)');
title('Velocity');

grid on;
%

disp(' ');
if(iu==1)
    ylabel(' Velocity(in/sec) ');
    disp(' Peak Velocity (in/sec) ')
    t_string='Velocity (in/sec)';
    ylabel1='Vel(in/sec)';  
else
    ylabel(' Velocity(mm/sec) ');
    disp(' Peak Velocity (mm/sec)')
    t_string='Velocity (mm/sec)'; 
    ylabel1='Vel(mm/sec)';  
end
 
out1=sprintf('dof 1  %8.4g  %8.4g  ',max(v(:,1)),min(v(:,1)));
out2=sprintf('dof 2  %8.4g  %8.4g  ',max(v(:,2)),min(v(:,2)));
 
disp(out1);
disp(out2);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

data1=[ t v(:,1)];
data2=[ t v(:,2)];

xlabel2='Time(sec)';
ylabel2=ylabel1;

[fig_num]=subplots_two_linlin_scale(fig_num,xlabel2,ylabel1,ylabel2,data1,data2,t_string1,t_string2);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%

acc=a;

%
figure(fig_num);
fig_num=fig_num+1;
if(iu==1)
    acc=acc/386;
else
    acc=acc/9.81;
end
plot(t,acc(:,1),t,acc(:,2));
legend ('dof 1','dof 2');   
xlabel('Time(sec)');
title('Acceleration');
ylabel(' Accel(G) ');
grid on;
disp(' ');
disp(' Peak Acceleration (G) ');
        
out1=sprintf('dof 1  %8.4g  %8.4g  ',max(acc(:,1)),min(acc(:,1)));
out2=sprintf('dof 2  %8.4g  %8.4g  ',max(acc(:,2)),min(acc(:,2)));
 
disp(out1);
disp(out2);
        
disp(' ');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

ylabel1='dof 1';
ylabel2='dof 2';

data1=[ t acc(:,1)];
data2=[ t acc(:,2)];

xlabel2='Time(sec)';
ylabel1='Accel(G)';
ylabel2=ylabel1;

[fig_num]=subplots_two_linlin_scale(fig_num,xlabel2,ylabel1,ylabel2,data1,data2,t_string1,t_string2);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


setappdata(0,'rd',[t rd]);
setappdata(0,'acc',[t acc]);
setappdata(0,'v',[t v]);
setappdata(0,'dd',[t dd]);
setappdata(0,'force_accel',[THM acc]);

set(handles.pushbutton_modal,'Enable','on');

set(handles.uipanel_save,'Visible','on');



% --- Executes on selection change in listbox_dof.
function listbox_dof_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_dof (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_dof contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_dof

set(handles.uipanel_save,'Visible','off');

iu=getappdata(0,'unit');

n=get(handles.listbox_dof,'Value');

if(n<=2)
   if(iu==1)
        ss='The input array must have two columns:  time (sec) & force (lbf)';
   else
        ss='The input array must have two columns:  time (sec) & force (N)';
   end
end
if(n==3)
   if(iu==1)
        ss='The input array must have threes columns:  time (sec) & force 1 & force 2 (lbf)';  
   else
        ss='The input array must have threes columns:  time (sec) & force 1 & force 2 (N)';        
   end
end

set(handles.text_instruction,'String',ss);

set(handles.listbox_output,'String',' ');

string_th{1}='Relative Displacement';
string_th{2}='Displacement';
string_th{3}='Velocity';
string_th{4}='Acceleration';


if(n==1)
    string_th{5}='Force 1   Accel 1   Accel 2';
end
if(n==2)
    string_th{5}='Force 2   Accel 1   Accel 2';
end
if(n==3)
    string_th{5}='Force 1   Force 2   Accel 1   Accel 2';
end


set(handles.listbox_output,'String',string_th);


% --- Executes during object creation, after setting all properties.
function listbox_dof_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_dof (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_input_array_Callback(hObject, eventdata, handles)
% hObject    handle to edit_input_array (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_input_array as text
%        str2double(get(hObject,'String')) returns contents of edit_input_array as a double


% --- Executes during object creation, after setting all properties.
function edit_input_array_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_input_array (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_save.
function pushbutton_save_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

n=get(handles.listbox_output,'Value');

if(n==1)
    data=getappdata(0,'rd');
end
if(n==2)
    data=getappdata(0,'dd');
end
if(n==3)
    data=getappdata(0,'v');
end
if(n==4)
    data=getappdata(0,'acc');
end
if(n==5)
    data=getappdata(0,'force_accel');    
end

output_array=get(handles.edit_output_array,'String');
assignin('base', output_array, data);

disp(' ');
fprintf('\n output array:  %s \n',output_array);


%

if(n<=4)

    output_array_1=sprintf('%s_1',output_array);
    output_array_2=sprintf('%s_2',output_array);

    assignin('base', output_array_1, [data(:,1) data(:,2)] );
    assignin('base', output_array_2, [data(:,1) data(:,3)] );

    disp(output_array_1);
    disp(output_array_2);

end

%

m=get(handles.listbox_dof,'Value');

if(n==1)
    msgbox('Output Array:  time, rel disp'); 
end
if(n==2)
    msgbox('Output Array:  time, disp 1, disp 2 '); 
end
if(n==3)
    msgbox('Output Array:  time, vel 1, vel 2 '); 
end
if(n==4)
    msgbox('Output Array:  time, accel 1, accel 2 ');
end
if(n==5)
    if(m==1)
        msgbox('Output Array:  time, force 1, accel 1, accel 2 ');
    end
    if(m==2)
        msgbox('Output Array:  time, force 2, accel 1, accel 2 ');    
    end
    if(m==3)
        msgbox('Output Array:  time, force 1, force 2, accel 1, accel 2 ');    
    end    
end




function edit_output_array_Callback(hObject, eventdata, handles)
% hObject    handle to edit_output_array (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_output_array as text
%        str2double(get(hObject,'String')) returns contents of edit_output_array as a double


% --- Executes during object creation, after setting all properties.
function edit_output_array_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_output_array (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_output.
function listbox_output_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_output (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_output contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_output


% --- Executes during object creation, after setting all properties.
function listbox_output_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_output (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function uipanel_save_CreateFcn(hObject, eventdata, handles)
% hObject    handle to uipanel_save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on button press in pushbutton_modal.
function pushbutton_modal_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_modal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.s=modal_toolbox;
set(handles.s,'Visible','on');

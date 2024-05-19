function varargout = steady(varargin)
% STEADY MATLAB code for steady.fig
%      STEADY, by itself, creates a new STEADY or raises the existing
%      singleton*.
%
%      H = STEADY returns the handle to a new STEADY or the handle to
%      the existing singleton*.
%
%      STEADY('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in STEADY.M with the given input arguments.
%
%      STEADY('Property','Value',...) creates a new STEADY or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before steady_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to steady_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help steady

% Last Modified by GUIDE v2.5 27-May-2022 11:44:47

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @steady_OpeningFcn, ...
                   'gui_OutputFcn',  @steady_OutputFcn, ...
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


% --- Executes just before steady is made visible.
function steady_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to steady (see VARARGIN)

% Choose default command line output for steady
handles.output = hObject;

set(handles.text_enter_mass,'Visible','on');
set(handles.edit_mass,'Visible','on'); 
 

clear_results(hObject, eventdata, handles);

change_frames(hObject, eventdata, handles);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes steady wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = steady_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

function clear_results(hObject, eventdata, handles)
%

set(handles.edit_phase,'Visible','off');
set(handles.text_phase,'Visible','off'); 
    
set(handles.text_acceleration,'String',' ');
set(handles.text_velocity,'String',' ');
set(handles.text_displacement,'String',' '); 
set(handles.text_tf_or_rd,'String',' ');

set(handles.edit_acceleration,'Visible','off');
set(handles.edit_velocity,'Visible','off');
set(handles.edit_displacement,'Visible','off');
set(handles.edit_tf_or_rd,'Visible','off');



% --- Executes on selection change in listbox_units.
function listbox_units_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_units (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_units contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_units

change_frames(hObject, eventdata, handles);


function change_frames(hObject, eventdata, handles)
%
nu=get(handles.listbox_units,'Value');
ne=get(handles.listbox_excitation,'Value');

clear_results(hObject, eventdata, handles);


if(ne==1)     
    set(handles.text_enter_mass,'Visible','on'); 
    set(handles.edit_mass,'Visible','on');        
else    
    set(handles.text_enter_mass,'Visible','off');   
    set(handles.edit_mass,'Visible','off');       
end

if(nu==1) % English
    if(ne==1)
       string=sprintf('Applied Force (lbf)');
       set(handles.text_enter_mass,'String','Enter Mass (lbm)');
    else
       string=sprintf('Base Acceleration (G)');
    end
%
else % metric
%
    if(ne==1)
       string=sprintf('Applied Force (N)');
       set(handles.text_enter_mass,'String','Mass (kg)');
    else
       string=sprintf('Base Acceleration (G)');
    end
end
%
set(handles.text_force_base,'String',string);


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

cla;
 
axes(handles.axes1);

if(ne==1)  % Force
    
axes(handles.axes1);
x=[-4 -4 4 4 -4];
y=[3 6 6 3 3]-3;
 
plot(x,y,'Color',cmap(1,:),'linewidth',0.75);
hold on;

 
%%%%%% side lines %%%%%%%%%%%%
 
x=[4 6];
y=[1.5 1.5];
plot(x,y,'Color','k');
 
 
 
%%%%%% text %%%%%%%%%%%%
 
text(7,3,'x','fontsize',11);
text(0.5,6,'F','fontsize',11);
text(-0.9,1.5,'m','fontsize',11);
text(-5,-1.5,'k','fontsize',11);
text(4.5,-1.5,'c','fontsize',11);
 
%%%%%% arrows %%%%%%%%%%%%
 
headWidth = 4;
headLength = 4;
 
ah = annotation('arrow',...
            'headStyle','cback1','HeadLength',headLength,'HeadWidth',headWidth);
        set(ah,'parent',gca);
        set(ah,'position',[0 3 0 2]);
 
        
  
ah = annotation('arrow',...
            'headStyle','cback1','HeadLength',headLength,'HeadWidth',headWidth);
        set(ah,'parent',gca);
        set(ah,'position',[6 1.5 0 1.5]);        
        
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

plot(y-2,t+2-7,'Color',cmap(5,:),'linewidth',0.75);
 

x=[0 0];
y=[3 min(t+2)]-7;
plot(x-2,y,'Color',cmap(5,:),'linewidth',0.75);
 
x=[0 0];
y=[max(t)+2 max(t)+2.5]-7;
plot(x-2,y,'Color',cmap(5,:),'linewidth',0.75);
 
%%%%%% dashpot %%%%%%%%%%

x=[2.25 2.25];
y=[2.5 4.625]-6.5;
plot(x,y,'Color',cmap(5,:),'linewidth',0.75);

x=[1.75 2.75];
y=[4.625 4.625]-6.5;
plot(x,y,'Color',cmap(5,:),'linewidth',0.75);



x=[2.25 2.25];
y=[5 6.5]-6.5;
plot(x,y,'Color',cmap(5,:),'linewidth',0.75);

x=[1.25 3.25];
y=[5 5]-6.5;
plot(x,y,'Color',cmap(5,:),'linewidth',0.75);



x=[1.25 1.25];
y=[4.6 5]-6.5;
plot(x,y,'Color',cmap(5,:),'linewidth',0.75);

x=[3.25 3.25];
y=[4.6 5]-6.5;
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
xlim([-11.5 11.5]);
ylim([-6 7.5]);

            
else  % Base Excitation
    


x=[-5.5 -5.5 5.5 5.5 -5.5];
y=[5.5 6 6 5.5 5.5]-3;
 
plot(x,y,'Color',cmap(1,:),'linewidth',0.75);
hold on;

x=[-4 -4 4 4 -4]; 
y=[3 6 6 3 3]+3.5;
 
plot(x,y,'Color',cmap(1,:),'linewidth',0.75);
 
%%%%%% side lines %%%%%%%%%%%%
 
x=[5.5 7.5];
y=[1.5 1.5]+1.25;
plot(x,y,'Color','k');
 
 
x=[4 7.5];
y=[8 8];
plot(x,y,'Color','k');
 
%%%%%% text %%%%%%%%%%%%
 
% text(7,10,'${\ddot{X}}$','Interpreter','latex');

text(8.32,5.15,'..','fontsize',13);
text(8.5,4.5,'y','fontsize',11);

text(8.32,10.65,'..','fontsize',13);
text(8.5,10,'x','fontsize',11);

 
text(-0.9,8,'m','fontsize',11);

text(-5,5.2,'k','fontsize',11);

text(4.5,5.3,'c','fontsize',11);
 
%%%%%% arrows %%%%%%%%%%%%
 
headWidth = 4;
headLength = 4;
 
       
  
ah = annotation('arrow',...
            'headStyle','cback1','HeadLength',headLength,'HeadWidth',headWidth);
        set(ah,'parent',gca);
        set(ah,'position',[7.5 2.75 0 1.5]);        
        
ah = annotation('arrow',...
            'headStyle','cback1','HeadLength',headLength,'HeadWidth',headWidth);
        set(ah,'parent',gca);
        set(ah,'position',[7.5 8 0 1.5]);        
        
 
        
%%%%%% spring %%%%%%%%%%%%        
 
nn=2000;
 
dt=4/(nn-1);
 
t=zeros(nn,1);
for i=1:nn
    t(i)=(i-1)*dt;
end
t=t-0.75;
y=sawtooth(2*pi*t,0.5);
 
t=2.5*t/(max(t)-min(t))+2;
 
plot(y-2,t+2,'Color',cmap(5,:),'linewidth',0.75);

x=[-2 -2];
y=[3 min(t+2)];
plot(x,y,'Color',cmap(5,:),'linewidth',0.75);
 
 
x=[-2 -2];
y=[max(t)+2 max(t)+2.5];
plot(x,y,'Color',cmap(5,:),'linewidth',0.75);
 

%%%%%% dashpot %%%%%%%%%%

x=[2.25 2.25];
y=[3 4.625];
plot(x,y,'Color',cmap(5,:),'linewidth',0.75);

x=[1.75 2.75];
y=[4.625 4.625];
plot(x,y,'Color',cmap(5,:),'linewidth',0.75);



x=[2.25 2.25];
y=[5 6.5];
plot(x,y,'Color',cmap(5,:),'linewidth',0.75);

x=[1.25 3.25];
y=[5 5];
plot(x,y,'Color',cmap(5,:),'linewidth',0.75);



x=[1.25 1.25];
y=[4.6 5];
plot(x,y,'Color',cmap(5,:),'linewidth',0.75);

x=[3.25 3.25];
y=[4.6 5];
plot(x,y,'Color',cmap(5,:),'linewidth',0.75);
 

%%%%%% end %%%%%%%%%%%%
 
hold off;
grid on;
set(gca,'XTick',[], 'YTick', [])
xlim([-10 12]);
ylim([0 13]);
     
    
end



% --- Executes during object creation, after setting all properties.
function listbox_units_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_units (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_excitation.
function listbox_excitation_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_excitation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_excitation contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_excitation
change_frames(hObject, eventdata, handles);



% --- Executes during object creation, after setting all properties.
function listbox_excitation_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_excitation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_mass_Callback(hObject, eventdata, handles)
% hObject    handle to edit_mass (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_mass as text
%        str2double(get(hObject,'String')) returns contents of edit_mass as a double


% --- Executes during object creation, after setting all properties.
function edit_mass_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_mass (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_accel_force_Callback(hObject, eventdata, handles)
% hObject    handle to edit_accel_force (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_accel_force as text
%        str2double(get(hObject,'String')) returns contents of edit_accel_force as a double


% --- Executes during object creation, after setting all properties.
function edit_accel_force_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_accel_force (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_fext_Callback(hObject, eventdata, handles)
% hObject    handle to edit_fext (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_fext as text
%        str2double(get(hObject,'String')) returns contents of edit_fext as a double


% --- Executes during object creation, after setting all properties.
function edit_fext_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_fext (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_fn_Callback(hObject, eventdata, handles)
% hObject    handle to edit_fn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_fn as text
%        str2double(get(hObject,'String')) returns contents of edit_fn as a double


% --- Executes during object creation, after setting all properties.
function edit_fn_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_fn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_Q_Callback(hObject, eventdata, handles)
% hObject    handle to edit_Q (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_Q as text
%        str2double(get(hObject,'String')) returns contents of edit_Q as a double


% --- Executes during object creation, after setting all properties.
function edit_Q_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_Q (see GCBO)
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

nu=get(handles.listbox_units,'Value');
ne=get(handles.listbox_excitation,'Value');


set(handles.edit_acceleration,'Visible','on');
set(handles.edit_velocity,'Visible','on');
set(handles.edit_displacement,'Visible','on');
set(handles.edit_tf_or_rd,'Visible','on');

set(handles.text_acceleration,'String','Acceleration (G)');

if(nu==1)
    set(handles.text_velocity,'String','Velocity (in/sec)');
    set(handles.text_displacement,'String','Displacement (in)'); 
    
    if(ne==1)
        set(handles.text_tf_or_rd,'String','Transmitted Force (lbf)');        
    else
        set(handles.text_tf_or_rd,'String','Relative Displacement (in)');
    end
else
    set(handles.text_velocity,'String','Velocity (m/sec)');
    set(handles.text_displacement,'String','Displacement (mm)'); 
    
    if(ne==1)
        set(handles.text_tf_or_rd,'String','Transmitted Force (N)');        
    else
        set(handles.text_tf_or_rd,'String','Relative Displacement (mm)');        
    end    

    set(handles.edit_phase,'Visible','on');
    set(handles.text_phase,'Visible','on'); 
    
end

fn=str2num(get(handles.edit_fn,'String'));
Q=str2num(get(handles.edit_Q,'String'));

fext=str2num(get(handles.edit_fext,'String'));

omegan=tpi*fn;
omega=tpi*fext;

rho=omega/omegan;


damp=1/(2*Q);

den=omegan^2-omega^2+(1i)*(2*damp*omegan*omega);


if(ne==1)  % applied force  
    
    force=str2num(get(handles.edit_accel_force,'String'));
    mass=str2num(get(handles.edit_mass,'String'));
    
    if(nu==1)
        mass=mass/386;
    end
    
    stiff=mass*omegan^2;
  
    
    displacement=force*(1/stiff)*omegan^2/den;
    velocity=(1i)*omega*displacement;
    acceleration=-omega^2*displacement;
    
    term=2*damp*rho;

    num=sqrt(1+term^2);
    den=sqrt((1-rho^2)^2+term^2);
    
    transmitted_force=force*num/den;
    
else       % base excitation
    
    base_accel=str2num(get(handles.edit_accel_force,'String'));
    
    if(nu==1)
        base_accel=base_accel*386;
    else
        base_accel=base_accel*9.81;
    end
    
    
    num=omegan^2+(1i)*2*damp*omega*omegan;
    
    acceleration=base_accel*num/den;
    velocity=acceleration/((1i)*omega);    
    displacement=acceleration/(-omega^2);
    relative_displacement=-base_accel/den;
    
    ph=phase(num/den);
    
    sss=sprintf('%8.4g',180*ph/pi);
    set(handles.edit_phase,'String',sss);
    
    set(handles.edit_phase,'Visible','on');
    set(handles.text_phase,'Visible','on');
    
end

if(nu==1)
    acceleration=acceleration/386;
else
    acceleration=acceleration/9.81;
    displacement=displacement*1000;
    if(ne==2)
       relative_displacement=relative_displacement*1000;
    end   
end

as=sprintf('%8.4g',abs(acceleration));
set(handles.edit_acceleration,'String',as);

vs=sprintf('%8.4g',abs(velocity));
set(handles.edit_velocity,'String',vs);

ds=sprintf('%8.4g',abs(displacement));
set(handles.edit_displacement,'String',ds);

if(ne==1)
    tf=sprintf('%8.4g',transmitted_force);
    set(handles.edit_tf_or_rd,'String',tf);
else
    rd=sprintf('%8.4g',abs(relative_displacement));
    set(handles.edit_tf_or_rd,'String',rd);    
end

% --- Executes on button press in pushbutton_exit.
function pushbutton_exit_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_exit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function edit_acceleration_Callback(hObject, eventdata, handles)
% hObject    handle to edit_acceleration (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_acceleration as text
%        str2double(get(hObject,'String')) returns contents of edit_acceleration as a double


% --- Executes during object creation, after setting all properties.
function edit_acceleration_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_acceleration (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_velocity_Callback(hObject, eventdata, handles)
% hObject    handle to edit_velocity (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_velocity as text
%        str2double(get(hObject,'String')) returns contents of edit_velocity as a double


% --- Executes during object creation, after setting all properties.
function edit_velocity_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_velocity (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_displacement_Callback(hObject, eventdata, handles)
% hObject    handle to edit_displacement (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_displacement as text
%        str2double(get(hObject,'String')) returns contents of edit_displacement as a double


% --- Executes during object creation, after setting all properties.
function edit_displacement_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_displacement (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_tf_or_rd_Callback(hObject, eventdata, handles)
% hObject    handle to edit_tf_or_rd (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_tf_or_rd as text
%        str2double(get(hObject,'String')) returns contents of edit_tf_or_rd as a double


% --- Executes during object creation, after setting all properties.
function edit_tf_or_rd_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_tf_or_rd (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on key press with focus on edit_fn and none of its controls.
function edit_fn_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_fn (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
clear_results(hObject, eventdata, handles);


% --- Executes on key press with focus on edit_Q and none of its controls.
function edit_Q_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_Q (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
clear_results(hObject, eventdata, handles);


% --- Executes on key press with focus on edit_mass and none of its controls.
function edit_mass_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_mass (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
clear_results(hObject, eventdata, handles);


% --- Executes on key press with focus on edit_fext and none of its controls.
function edit_fext_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_fext (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
clear_results(hObject, eventdata, handles);


% --- Executes on key press with focus on edit_accel_force and none of its controls.
function edit_accel_force_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_accel_force (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
clear_results(hObject, eventdata, handles);


% --- Executes on button press in pushbutton_return.
function pushbutton_return_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_return (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
delete(steady);



function edit_phase_Callback(hObject, eventdata, handles)
% hObject    handle to edit_phase (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_phase as text
%        str2double(get(hObject,'String')) returns contents of edit_phase as a double


% --- Executes during object creation, after setting all properties.
function edit_phase_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_phase (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

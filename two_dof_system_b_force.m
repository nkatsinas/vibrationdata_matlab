function varargout = two_dof_system_b_force(varargin)
% TWO_DOF_SYSTEM_B_FORCE MATLAB code for two_dof_system_b_force.fig
%      TWO_DOF_SYSTEM_B_FORCE, by itself, creates a new TWO_DOF_SYSTEM_B_FORCE or raises the existing
%      singleton*.
%
%      H = TWO_DOF_SYSTEM_B_FORCE returns the handle to a new TWO_DOF_SYSTEM_B_FORCE or the handle to
%      the existing singleton*.
%
%      TWO_DOF_SYSTEM_B_FORCE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TWO_DOF_SYSTEM_B_FORCE.M with the given input arguments.
%
%      TWO_DOF_SYSTEM_B_FORCE('Property','Value',...) creates a new TWO_DOF_SYSTEM_B_FORCE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before two_dof_system_b_force_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to two_dof_system_b_force_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help two_dof_system_b_force

% Last Modified by GUIDE v2.5 26-Sep-2020 14:04:00

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @two_dof_system_b_force_OpeningFcn, ...
                   'gui_OutputFcn',  @two_dof_system_b_force_OutputFcn, ...
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


% --- Executes just before two_dof_system_b_force is made visible.
function two_dof_system_b_force_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to two_dof_system_b_force (see VARARGIN)

% Choose default command line output for two_dof_system_b_force
handles.output = hObject;

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




clear_buttons(hObject, eventdata, handles);


% Update handles structure
guidata(hObject, handles);

% UIWAIT makes two_dof_system_b_force wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = two_dof_system_b_force_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

%
function clear_buttons(hObject, eventdata, handles)
set(handles.pushbutton_enter_damping,'Visible','off');
set(handles.pushbutton_FRF,'Visible','off');
set(handles.pushbutton_sine,'Visible','off');
set(handles.pushbutton_arbitrary_pulse,'Visible','off');
set(handles.pushbutton_PSD,'Visible','off');
set(handles.pushbutton_Dirac,'Visible','off');
%


% --- Executes on button press in pushbutton_return.
function pushbutton_return_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_return (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

delete(two_dof_system_b_force);


% --- Executes on button press in pushbutton_fn.
function pushbutton_fn_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_fn (see GCBO)
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

iu=get(handles.units_listbox,'value');

m1=str2num( get(handles.mass1_edit,'String' ));
m2=str2num( get(handles.mass2_edit,'String' ));
k1=str2num( get(handles.stiffness1_edit,'String' ));
k2=str2num( get(handles.stiffness2_edit,'String' ));

mass=zeros(2,2);

mass(1,1)=m1;
mass(2,2)=m2;

stiffness=[(k1+k2) -k2; -k2 k2];

%
if(iu==1)
   mass=mass/386.;
end
%
disp(' ');

[fn,ModeShapes,~,~]=tdof_fn_etr_results(mass,stiffness,iu);

%
setappdata(0,'unit',iu);
setappdata(0,'m2',mass);
setappdata(0,'k2',stiffness);
setappdata(0,'fn',fn);
setappdata(0,'ModeShapes',ModeShapes);

set(handles.pushbutton_enter_damping,'Visible','on');

set(handles.uipanel_save,'Visible','on');

msgbox('Calculation complete.  Output written to Matlab Command Window.');



% --- Executes on button press in pushbutton_enter_damping.
function pushbutton_enter_damping_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_enter_damping (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

set(handles.pushbutton_FRF,'Visible','on');
set(handles.pushbutton_sine,'Visible','on');
set(handles.pushbutton_arbitrary_pulse,'Visible','on');
set(handles.pushbutton_PSD,'Visible','on');
set(handles.pushbutton_Dirac,'Visible','on');

handles.s= two_dof_damping;
set(handles.s,'Visible','on');


%% complex_mode_shape(hObject, eventdata, handles);


function complex_mode_shape(hObject, eventdata, handles)

M=getappdata(0,'m2');
K=getappdata(0,'k2');

fn=getappdata(0,'fn');
omega=2*pi*fn;

ModeShapes=getappdata(0,'ModeShapes');
MST=ModeShapes';

dampv=getappdata(0,'damping');

dof=2;
C=zeros(dof,dof);

for i=1:dof
    C(i,i)=2*dampv(i)*omega(i);
end
%
C=M*ModeShapes*C*MST*M;
[X,e,s] = polyeig(K,C,M);



% --- Executes on button press in pushbutton_arbitrary_pulse.
function pushbutton_arbitrary_pulse_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_arbitrary_pulse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.s= vibrationdata_two_dof_arbitrary_force;
set(handles.s,'Visible','on');


% --- Executes on button press in pushbutton_FRF.
function pushbutton_FRF_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_FRF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.s= vibrationdata_force_frf;
set(handles.s,'Visible','on');

% --- Executes on button press in pushbutton_sine.
function pushbutton_sine_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_sine (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.s=vibrationdata_two_dof_sine_force;
set(handles.s,'Visible','on');

% --- Executes on button press in pushbutton_PSD.
function pushbutton_PSD_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_PSD (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.s=vibrationdata_two_dof_psd_force;
set(handles.s,'Visible','on');

function mass2_edit_Callback(hObject, eventdata, handles)
% hObject    handle to mass2_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of mass2_edit as text
%        str2double(get(hObject,'String')) returns contents of mass2_edit as a double


% --- Executes during object creation, after setting all properties.
function mass2_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to mass2_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function mass1_edit_Callback(hObject, eventdata, handles)
% hObject    handle to mass1_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of mass1_edit as text
%        str2double(get(hObject,'String')) returns contents of mass1_edit as a double


% --- Executes during object creation, after setting all properties.
function mass1_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to mass1_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function stiffness2_edit_Callback(hObject, eventdata, handles)
% hObject    handle to stiffness2_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of stiffness2_edit as text
%        str2double(get(hObject,'String')) returns contents of stiffness2_edit as a double


% --- Executes during object creation, after setting all properties.
function stiffness2_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to stiffness2_edit (see GCBO)
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

set(handles.uipanel_save,'Visible','off');

n=get(handles.units_listbox,'Value');

if(n==1)
    set(handles.mass_unit_text,'String','Mass Unit: lbm');
    set(handles.stiffness_unit_text,'String','Stiffness Unit: lbf/in');    
else
    set(handles.mass_unit_text,'String','Mass Unit: kg'); 
    set(handles.stiffness_unit_text,'String','Stiffness Unit: N/m');     
end

clear_buttons(hObject, eventdata, handles)

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



function stiffness1_edit_Callback(hObject, eventdata, handles)
% hObject    handle to stiffness1_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of stiffness1_edit as text
%        str2double(get(hObject,'String')) returns contents of stiffness1_edit as a double


% --- Executes during object creation, after setting all properties.
function stiffness1_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to stiffness1_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_Dirac.
function pushbutton_Dirac_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_Dirac (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.s=vibrationdata_two_dof_Dirac_force;
set(handles.s,'Visible','on');


% --- Executes on button press in pushbutton_save.
function pushbutton_save_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

n=get(handles.listbox_save,'Value');

if(n==1)
    data=setappdata(0,'m2');
end
if(n==2)
    data=getappdata(0,'k2');
end
if(n==3)
    data=getappdata(0,'fn');
end
if(n==4)
    data=getappdata(0,'ModeShapes');
end

output_name=get(handles.edit_output_array_name,'String');
assignin('base', output_name, data);

h = msgbox('Save Complete');



% --- Executes on key press with focus on mass2_edit and none of its controls.
function mass2_edit_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to mass2_edit (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.uipanel_save,'Visible','off');


% --- Executes on key press with focus on stiffness2_edit and none of its controls.
function stiffness2_edit_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to stiffness2_edit (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.uipanel_save,'Visible','off');


% --- Executes on key press with focus on mass1_edit and none of its controls.
function mass1_edit_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to mass1_edit (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.uipanel_save,'Visible','off');


% --- Executes on key press with focus on stiffness1_edit and none of its controls.
function stiffness1_edit_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to stiffness1_edit (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(handles.uipanel_save,'Visible','off');



function edit_output_array_name_Callback(hObject, eventdata, handles)
% hObject    handle to edit_output_array_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_output_array_name as text
%        str2double(get(hObject,'String')) returns contents of edit_output_array_name as a double


% --- Executes during object creation, after setting all properties.
function edit_output_array_name_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_output_array_name (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_save.
function listbox_save_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_save contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_save


% --- Executes during object creation, after setting all properties.
function listbox_save_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

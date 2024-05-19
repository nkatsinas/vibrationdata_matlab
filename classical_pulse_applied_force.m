function varargout = classical_pulse_applied_force(varargin)
% CLASSICAL_PULSE_APPLIED_FORCE MATLAB code for classical_pulse_applied_force.fig
%      CLASSICAL_PULSE_APPLIED_FORCE, by itself, creates a new CLASSICAL_PULSE_APPLIED_FORCE or raises the existing
%      singleton*.
%
%      H = CLASSICAL_PULSE_APPLIED_FORCE returns the handle to a new CLASSICAL_PULSE_APPLIED_FORCE or the handle to
%      the existing singleton*.
%
%      CLASSICAL_PULSE_APPLIED_FORCE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CLASSICAL_PULSE_APPLIED_FORCE.M with the given input arguments.
%
%      CLASSICAL_PULSE_APPLIED_FORCE('Property','Value',...) creates a new CLASSICAL_PULSE_APPLIED_FORCE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before classical_pulse_applied_force_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to classical_pulse_applied_force_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help classical_pulse_applied_force

% Last Modified by GUIDE v2.5 30-Oct-2016 10:26:47

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @classical_pulse_applied_force_OpeningFcn, ...
                   'gui_OutputFcn',  @classical_pulse_applied_force_OutputFcn, ...
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


% --- Executes just before classical_pulse_applied_force is made visible.
function classical_pulse_applied_force_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to classical_pulse_applied_force (see VARARGIN)

% Choose default command line output for classical_pulse_applied_force
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

cla;
     
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


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

set(handles.listbox_pulse_type,'Value',1);
set(handles.listbox_analysis_type,'Value',2);
set(handles.listbox_resp_unit,'Value',1);
set(handles.listbox_output_type,'Value',1);
set(handles.listbox_time_unit,'Value',1);
set(handles.listbox_psave,'Value',2);


set(handles.edit_fn,'Visible','off');
set(handles.text_fn,'Visible','off');
set(handles.edit_Q,'String','10');
set(handles.pushbutton_save,'Enable','off');

listbox_analysis_type_Callback(hObject, eventdata, handles);
listbox_pulse_type_Callback(hObject, eventdata, handles);
listbox_resp_unit_Callback(hObject, eventdata, handles);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes classical_pulse_applied_force wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = classical_pulse_applied_force_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton_calculation.
function pushbutton_calculation_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

set(handles.pushbutton_save,'Enable','on');

fn=0;
f1=0;
f2=0;
resp_dur=0;

npt=get(handles.listbox_pulse_type,'Value');
nat=get(handles.listbox_analysis_type,'Value');
ntu=get(handles.listbox_time_unit,'Value');
iunit=get(handles.listbox_resp_unit,'Value');
Q=str2num(get(handles.edit_Q,'String'));

if(nat==1)
    warndlg('SRS function to be added in next revision');
    return;
end

mass=str2num(get(handles.edit_mass,'String'));

if(iunit==1)
    mass=mass/386;
end

fn=str2num(get(handles.edit_fn,'String'));
resp_dur=str2num(get(handles.edit_aux1,'String'));

amp=str2num(get(handles.edit_amp,'String'));
dur=str2num(get(handles.edit_T,'String'));

if(ntu==2)
    dur=dur/1000;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

damp=1/(2*Q);
omegan=2.*pi*fn;
stiff=mass*omegan^2;

%
if(iunit==1)
    out1=sprintf('         stiffness =%8.4g lbf/in \n',stiff);
else
    out1=sprintf('         stiffness =%8.4g  N/m \n',stiff);  
end

disp(out1);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(npt==1)
    [t,accel,velox,dispx,applied_force]=...
             vibrationdata_half_sine_pulse_force(amp,dur,fn,mass,stiff,damp,resp_dur);
end
if(npt==2)
    [t,accel,velox,dispx,applied_force]=...
           vibrationdata_rectangular_pulse_force(amp,dur,fn,mass,stiff,damp,resp_dur);
end

trans_force=mass*accel;

if(iunit==1)
    accel=accel/386;
end


acceleration=[t accel];
velocity=[t velox];
displacement=[t dispx];



fig_num=1;

figure(fig_num)
plot(t,applied_force);
grid on;
title('Applied Force');
xlabel('Time (sec)');
if(iunit==1)
    ylabel('Force (lbf)');    
else
    ylabel('Force (N)');    
end

fig_num=fig_num+1;

[fig_num,ha,hv,hd]=...
  plot_avd_time_histories_h_alt(acceleration,velocity,displacement,iunit,fig_num);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

psave=get(handles.listbox_psave,'Value');

if(psave==1)
 
    disp(' ');
    disp(' Plot files:');
    disp(' ');

    pname='acceleration';
    out1=sprintf('   %s.png',pname);
    disp(out1);
    set(gca,'Fontsize',12);
    print(ha,pname,'-dpng','-r300');
    
    pname='velocity';
    out1=sprintf('   %s.png',pname);
    disp(out1);
    set(gca,'Fontsize',12);
    print(hv,pname,'-dpng','-r300');
    
    pname='displacement';
    out1=sprintf('   %s.png',pname);
    disp(out1);
    set(gca,'Fontsize',12);
    print(hd,pname,'-dpng','-r300');  
   
end

AF=[t applied_force];

setappdata(0,'applied_force',AF);
setappdata(0,'acceleration',acceleration);
setappdata(0,'velocity',velocity);
setappdata(0,'displacement',displacement);



% --- Executes on button press in pushbutton_return.
function pushbutton_return_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_return (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
delete(classical_pulse_base_input);


% --- Executes on selection change in listbox_pulse_type.
function listbox_pulse_type_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_pulse_type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_pulse_type contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_pulse_type

n=get(handles.listbox_pulse_type,'Value');

set(handles.text_ramp_durations,'Visible','off');
set(handles.text_initial,'Visible','off');
set(handles.text_final,'Visible','off');
set(handles.edit_initial,'Visible','off');
set(handles.edit_final,'Visible','off');


if(n~=5)
    set(handles.text_duration,'String','Duration');    
else
    set(handles.text_duration,'String','Total Duration');
    
    set(handles.text_ramp_durations,'Visible','on');
    set(handles.text_initial,'Visible','on');
    set(handles.text_final,'Visible','on');
    set(handles.edit_initial,'Visible','on');
    set(handles.edit_final,'Visible','on');     
end


% --- Executes during object creation, after setting all properties.
function listbox_pulse_type_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_pulse_type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit5_Callback(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit5 as text
%        str2double(get(hObject,'String')) returns contents of edit5 as a double


% --- Executes during object creation, after setting all properties.
function edit5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit6_Callback(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit6 as text
%        str2double(get(hObject,'String')) returns contents of edit6 as a double


% --- Executes during object creation, after setting all properties.
function edit6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_analysis_type.
function listbox_analysis_type_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_analysis_type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_analysis_type contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_analysis_type

n=get(handles.listbox_analysis_type,'Value');

if(n==1)
    
    warndlg('SRS function to be added in next revision');
    return;
    
    set(handles.edit_fn,'Visible','off');
    set(handles.text_fn,'Visible','off');
    set(handles.edit_aux2,'Visible','on');
    set(handles.text_aux2,'Visible','on');
    set(handles.text_aux1,'String','Start Freq (Hz)');
    

else
    set(handles.edit_fn,'Visible','on');
    set(handles.text_fn,'Visible','on');
    set(handles.text_aux1,'String','Response Duration (sec)');
    set(handles.edit_aux2,'Visible','off');
    set(handles.text_aux2,'Visible','off');
    

end





% --- Executes during object creation, after setting all properties.
function listbox_analysis_type_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_analysis_type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
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



function edit_amp_Callback(hObject, eventdata, handles)
% hObject    handle to edit_amp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_amp as text
%        str2double(get(hObject,'String')) returns contents of edit_amp as a double


% --- Executes during object creation, after setting all properties.
function edit_amp_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_amp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_T_Callback(hObject, eventdata, handles)
% hObject    handle to edit_T (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_T as text
%        str2double(get(hObject,'String')) returns contents of edit_T as a double


% --- Executes during object creation, after setting all properties.
function edit_T_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_T (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_time_unit.
function listbox_time_unit_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_time_unit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_time_unit contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_time_unit


% --- Executes during object creation, after setting all properties.
function listbox_time_unit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_time_unit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_aux1_Callback(hObject, eventdata, handles)
% hObject    handle to edit_aux1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_aux1 as text
%        str2double(get(hObject,'String')) returns contents of edit_aux1 as a double


% --- Executes during object creation, after setting all properties.
function edit_aux1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_aux1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_aux2_Callback(hObject, eventdata, handles)
% hObject    handle to edit_aux2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_aux2 as text
%        str2double(get(hObject,'String')) returns contents of edit_aux2 as a double


% --- Executes during object creation, after setting all properties.
function edit_aux2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_aux2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_resp_unit.
function listbox_resp_unit_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_resp_unit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_resp_unit contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_resp_unit

iu=get(handles.listbox_resp_unit,'Value');

if(iu==1)
    set(handles.text_force,'String','Force (lbf)');
    set(handles.text_mass,'String','Mass (lbm)');
else
    set(handles.text_force,'String','Force (N)');
    set(handles.text_mass,'String','Mass (kg)');
end


% --- Executes during object creation, after setting all properties.
function listbox_resp_unit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_resp_unit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_save.
function pushbutton_save_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

ntype=get(handles.listbox_output_type,'Value');

if(ntype==1)
   data=getappdata(0,'applied_force');  
end
if(ntype==2)
   data=getappdata(0,'acceleration');    
end
if(ntype==3)
   data=getappdata(0,'velocity');         
end
if(ntype==4)
   data=getappdata(0,'displacement');         
end

output_name=get(handles.edit_output_filename,'String');
assignin('base', output_name,data);

h = msgbox('Save Complete'); 


function edit_output_filename_Callback(hObject, eventdata, handles)
% hObject    handle to edit_output_filename (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_output_filename as text
%        str2double(get(hObject,'String')) returns contents of edit_output_filename as a double


% --- Executes during object creation, after setting all properties.
function edit_output_filename_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_output_filename (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in listbox_output_type.
function listbox_output_type_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_output_type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_output_type contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_output_type


% --- Executes during object creation, after setting all properties.
function listbox_output_type_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_output_type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_initial_Callback(hObject, eventdata, handles)
% hObject    handle to edit_initial (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_initial as text
%        str2double(get(hObject,'String')) returns contents of edit_initial as a double


% --- Executes during object creation, after setting all properties.
function edit_initial_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_initial (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_final_Callback(hObject, eventdata, handles)
% hObject    handle to edit_final (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_final as text
%        str2double(get(hObject,'String')) returns contents of edit_final as a double


% --- Executes during object creation, after setting all properties.
function edit_final_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_final (see GCBO)
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

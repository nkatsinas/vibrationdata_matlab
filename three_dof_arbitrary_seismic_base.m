function varargout = three_dof_arbitrary_seismic_base(varargin)
% THREE_DOF_ARBITRARY_SEISMIC_BASE MATLAB code for three_dof_arbitrary_seismic_base.fig
%      THREE_DOF_ARBITRARY_SEISMIC_BASE, by itself, creates a new THREE_DOF_ARBITRARY_SEISMIC_BASE or raises the existing
%      singleton*.
%
%      H = THREE_DOF_ARBITRARY_SEISMIC_BASE returns the handle to a new THREE_DOF_ARBITRARY_SEISMIC_BASE or the handle to
%      the existing singleton*.
%
%      THREE_DOF_ARBITRARY_SEISMIC_BASE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in THREE_DOF_ARBITRARY_SEISMIC_BASE.M with the given input arguments.
%
%      THREE_DOF_ARBITRARY_SEISMIC_BASE('Property','Value',...) creates a new THREE_DOF_ARBITRARY_SEISMIC_BASE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before three_dof_arbitrary_seismic_base_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to three_dof_arbitrary_seismic_base_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help three_dof_arbitrary_seismic_base

% Last Modified by GUIDE v2.5 03-Jan-2017 16:30:25

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @three_dof_arbitrary_seismic_base_OpeningFcn, ...
                   'gui_OutputFcn',  @three_dof_arbitrary_seismic_base_OutputFcn, ...
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


% --- Executes just before three_dof_arbitrary_seismic_base is made visible.
function three_dof_arbitrary_seismic_base_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to three_dof_arbitrary_seismic_base (see VARARGIN)

% Choose default command line output for three_dof_arbitrary_seismic_base
handles.output = hObject;


set(handles.uipanel_save,'Visible','off');

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes three_dof_arbitrary_seismic_base wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = three_dof_arbitrary_seismic_base_OutputFcn(hObject, eventdata, handles) 
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

delete(three_dof_arbitrary_seismic_base);


% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

tpi=2*pi;

      dampv=getappdata(0,'damp_ratio');
ModeShapes=getappdata(0,'ModeShapes');
        fn=getappdata(0,'fn');
        iu=getappdata(0,'unit');
        base_mass=getappdata(0,'base_mass');
        
 try
     FS=get(handles.edit_input_array,'String');
     THM=evalin('base',FS);   
 catch
     warndlg('Input array does not exist.');
     return;
 end
 
fig_num=getappdata(0,'fig_num');

if(isempty(fig_num))
    fig_num=1;
end
 
 
%  n=1;  % apply the force at base mass

%%
%%

t=THM(:,1);

nt=length(t);

amp=THM(:,2);

if(iu==1)
   amp=amp*386; 
else
   amp=amp*9.81; 
end

f1=amp*base_mass;

f2=zeros(nt,1);
f3=zeros(nt,1);

F=[f1 f2 f3];

%
tmx=max(t);
tmi=min(t);

dur=tmx-tmi;

dt=dur/(nt-1);
sr=1/dt;
%
if(sr<(10*max(fn)))
    disp(' ');
    warndlg(' Warning: insufficient sample rate. ');
end
%
omegan=tpi*fn;

ndof=length(fn);
sys_dof=ndof;

[x,v,a,~,~,~]=ramp_invariant_force(ModeShapes,F,ndof,sys_dof,omegan,dampv,dt);

            size(F)
            F(1:10,:)
            ModeShapes
            sys_dof
            omegan
            dampv
            dt
            

x=real(x');
a=real(a');

a(1:10,:)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

t_string1='Base Mass';
t_string2='Mass 1';
t_string3='Mass 2';

%

dd=x;
if(iu==2)
    dd=dd*1000;
end



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

rd=zeros(nt,(ndof-1));

for i=1:nt
    rd(i,1)=dd(i,2)-dd(i,1);
    rd(i,2)=dd(i,3)-dd(i,2);    
end


xlabel2='Time (sec)';

if(iu==1)
    ylabel1=' Disp(in) ';
    disp(' Peak Relative Displacement (in) ')
else
    ylabel1=' Disp(mm) ';
    disp(' Peak Relative Displacement (mm)')
end

ylabel2=ylabel1;

rddata1=[ t rd(:,1) ];
rddata2=[ t rd(:,2) ];

t_string1='Relative Displacement (Base Mass - Mass 1)';
t_string2='Relative Displacement (   Mass 2 - Mass 1)';

[fig_num]=subplots_two_linlin_two_titles(fig_num,xlabel2,ylabel1,ylabel2,rddata1,rddata2,t_string1,t_string2);

disp('                        Max      Min ');

out1=sprintf('Mass 1 - Base Mass  %8.4g  %8.4g  ',max(rd),min(rd));
disp(out1);
out1=sprintf('Mass 2 -    Mass 1  %8.4g  %8.4g  ',max(rd),min(rd));
disp(out1);


         
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
plot(t,acc(:,1),t,acc(:,2),t,acc(:,3));
legend ('Base Mass','Mass 1','Mass 2');   
xlabel('Time(sec)');
title('Acceleration');
ylabel(' Accel(G) ');
grid on;
disp(' ');
disp(' Acceleration ');

disp('               Max(G)   Min(G)  Overall(GRMS)');

out1=sprintf('Base Mass  %8.4g  %8.4g  %8.4g  ',max(acc(:,1)),min(acc(:,1)),std(acc(:,1)));
out2=sprintf('   Mass 1  %8.4g  %8.4g  %8.4g  ',max(acc(:,2)),min(acc(:,2)),std(acc(:,2)));
out3=sprintf('   Mass 2  %8.4g  %8.4g  %8.4g  ',max(acc(:,3)),min(acc(:,3)),std(acc(:,3)));
 
disp(out1);
disp(out2);
disp(out3)
        
disp(' ');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

adata1=[ t acc(:,1)];
adata2=[ t acc(:,2)];
adata3=[ t acc(:,3)];

xlabel3='Time(sec)';
ylabel1='Accel(G)';
ylabel2=ylabel1;
ylabel3=ylabel1;

t_string1='Base Mass';
t_string2='Mass 1';
t_string3='Mass 2';

[fig_num]=subplots_three_linlin_three_titles(fig_num,xlabel3,...
             ylabel1,ylabel2,ylabel3,adata1,adata2,adata3,t_string1,t_string2,t_string3);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


setappdata(0,'rd',[t rd]);
setappdata(0,'acc',[t acc]);
%% setappdata(0,'v',[t v]);
%% setappdata(0,'dd',[t dd]);

set(handles.uipanel_save,'Visible','on');



% --- Executes on selection change in listbox_dof.
function listbox_dof_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_dof (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_dof contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_dof

iu=getappdata(0,'unit');

n=1;


ss='The input array must have two columns:  time (sec) & accel (G)';

%% set(handles.text_instruction,'String',ss);


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
    data=getappdata(0,'acc');
end

output_array=get(handles.edit_output_array,'String');
assignin('base', output_array, data);

%
output_array_b=sprintf('%s_b',output_array);
output_array_1=sprintf('%s_1',output_array);
output_array_2=sprintf('%s_2',output_array);

assignin('base', output_array_b, [data(:,1) data(:,2)] );
assignin('base', output_array_1, [data(:,1) data(:,3)] );
assignin('base', output_array_2, [data(:,1) data(:,4)] );
%

h = msgbox('Save Complete'); 

disp(' ');
disp(output_array);
disp(output_array_1);
disp(output_array_2);


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

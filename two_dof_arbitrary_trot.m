function varargout = two_dof_arbitrary_trot(varargin)
% TWO_DOF_ARBITRARY_TROT MATLAB code for two_dof_arbitrary_trot.fig
%      TWO_DOF_ARBITRARY_TROT, by itself, creates a new TWO_DOF_ARBITRARY_TROT or raises the existing
%      singleton*.
%
%      H = TWO_DOF_ARBITRARY_TROT returns the handle to a new TWO_DOF_ARBITRARY_TROT or the handle to
%      the existing singleton*.
%
%      TWO_DOF_ARBITRARY_TROT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TWO_DOF_ARBITRARY_TROT.M with the given input arguments.
%
%      TWO_DOF_ARBITRARY_TROT('Property','Value',...) creates a new TWO_DOF_ARBITRARY_TROT or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before two_dof_arbitrary_trot_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to two_dof_arbitrary_trot_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help two_dof_arbitrary_trot

% Last Modified by GUIDE v2.5 13-Feb-2015 10:09:22

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @two_dof_arbitrary_trot_OpeningFcn, ...
                   'gui_OutputFcn',  @two_dof_arbitrary_trot_OutputFcn, ...
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


% --- Executes just before two_dof_arbitrary_trot is made visible.
function two_dof_arbitrary_trot_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to two_dof_arbitrary_trot (see VARARGIN)

% Choose default command line output for two_dof_arbitrary_trot
handles.output = hObject;

set(handles.listbox_export_plots,'Value',2);

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes two_dof_arbitrary_trot wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = two_dof_arbitrary_trot_OutputFcn(hObject, eventdata, handles) 
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

delete(two_dof_arbitrary_trot);



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


% --- Executes on button press in pushbutton_calculate.
function pushbutton_calculate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_calculate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

try
  FS=get(handles.edit_input_array,'String');
  THM=evalin('base',FS);
catch
  warndlg('Input array does not exist.');
  return
end

THM=fix_size(THM);
t=THM(:,1);

sz=size(THM);

nt=sz(1);

dt=(THM(nt,1)-THM(1,1))/(nt-1);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

   fig_num=getappdata(0,'fig_num');
      damp=getappdata(0,'damping');
ModeShapes=getappdata(0,'ModeShapes');
        fn=getappdata(0,'fn');
      unit=getappdata(0,'unit');
        m2=getappdata(0,'m2');     
        k2=getappdata(0,'k2'); 
        mass=getappdata(0,'mass');     
        stiff=getappdata(0,'stiff');        
        L1=getappdata(0,'L1');     
        L2=getappdata(0,'L2');  
        

iu=unit;

FI=THM;
        
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

num=3; % total dof
nem=1; % number of dof with enforce acceleration

nff=num-nem;

ea(1)=1; % dof with enforced

dtype=1; % display partitioned matrices

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if(iu==1)
    FI(:,2)=FI(:,2)*386;        
else
    FI(:,2)=FI(:,2)*9.81;        
end

f=FI(:,2);

forig=f;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

dvelox=zeros(nt,1);
 ddisp=zeros(nt,1);

[dvelox]=integrate_function(f,dt);
 [ddisp]=integrate_function(dvelox,dt);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[ngw]=track_changes(nem,num,ea);
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
 
etype=1;  % enforced acceleration
[TT,T1,T2,Mwd,Mww,Kwd,Kww]=enforced_partition_matrices(num,ea,mass,stiff,etype,dtype);
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
%
[fn,omegan,ModeShapes,MST]=Generalized_Eigen(Kww,Mww,1);
%
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

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%%


[num_modes,FP]=transform_force(f,Q,QT,Mwd,nt);  
%
%
[a1,a2,df1,df2,df3,vf1,vf2,vf3,af1,af2,af3]=...
              ramp_invariant_filter_coefficients(num_modes,omegan,damp,dt);
%

[a,v,d]=enforced_motion_modal_transient_engine(FP,a1,a2,df1,df2,df3,...
                                     vf1,vf2,vf3,af1,af2,af3,nt,num_modes,Q);
%

[d,v,acc,d_save,v_save,a_save]=...
        transform_and_original_order(d,v,a,ddisp,dvelox,forig,T1,T2,nt,num,ngw);

%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

acc_cg=acc(:,2);
acc_rot=acc(:,3);

rd_cg=d(:,2)-ddisp;


rd_s1=zeros(nt,1);
rd_s2=zeros(nt,1);


size(d);


for i=1:nt

    theta=d(i,3);

    rd_s1(i)= rd_cg(i)-L1*tan(theta);
    rd_s2(i)= rd_cg(i)+L2*tan(theta);

end


if(iu==1)
   acc_cg=acc_cg/386;
else
   acc_cg=acc_cg/9.81;
   rd_cg=rd_cg/1000;
   rd_s1=rd_s1/1000;
   rd_s2=rd_s2/1000;   
end
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

disp(' ');
disp('  Maximum & Minimum Amplitudes');
disp(' ');
disp(' C.G. Acceleration (G)');
out1=sprintf(' %8.4g  %8.4g ',max(acc_cg),min(acc_cg));
disp(out1);

disp(' ');
disp(' Rotational Acceleration (rad/sec^2)');
out1=sprintf(' %8.4g  %8.4g ',max(acc_rot),min(acc_rot));
disp(out1);

disp(' ');

if(unit==1)
    disp(' Relative Displacement (in)');
else  
    disp(' Relative Displacement (mm)');
end  

out1=sprintf(' Spring1:  %8.4g  %8.4g ',max(rd_s1),min(rd_s1));
out2=sprintf('     C.G:  %8.4g  %8.4g ',max(rd_cg),min(rd_cg));
out3=sprintf(' Spring2:  %8.4g  %8.4g ',max(rd_s2),min(rd_s2));

disp(out1);
disp(out2);
disp(out3);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%

psave=get(handles.listbox_export_plots,'Value');


h2=figure(fig_num);
fig_num=fig_num+1;
plot(THM(:,1),THM(:,2));
xlabel('Time (sec)');
ylabel('Accel (G)');
grid on;
title('Base Input Acceleration');
clear THM;


if(psave==1)
    disp(' ');
    disp(' Plot files exported to hard drive as: ');    
    disp(' ');    
    pname='accel_base_input';
    set(gca,'Fontsize',12);
    print(h2,pname,'-dpng','-r300');    
    out1=sprintf(' %s.png',pname);
    disp(out1);    
end 




h2=figure(fig_num);
fig_num=fig_num+1;
plot(t,acc_cg);
xlabel('Time (sec)');
ylabel('Accel (G)');
grid on;
title('C.G. Acceleration');




if(psave==1)   
    pname='accel_cg';
    set(gca,'Fontsize',12);
    print(h2,pname,'-dpng','-r300');    
    out1=sprintf(' %s.png',pname);
    disp(out1);    
end 


h2=figure(fig_num);
fig_num=fig_num+1;
plot(t,acc_rot);
title('Rotational Acceleration');
xlabel('Time (sec)');
ylabel('Accel (rad/sec^2)');
grid on;



if(psave==1)   
    pname='accel_rotation';
    set(gca,'Fontsize',12);
    print(h2,pname,'-dpng','-r300');    
    out1=sprintf(' %s.png',pname);
    disp(out1);    
end 


h2=figure(fig_num);
fig_num=fig_num+1;
plot(t,rd_cg);
xlabel('Time (sec)');


if(unit==1)
    ylabel('Rel Disp (in)');
else
    ylabel('Rel Disp (mm)');    
end    
    
grid on;
title('C.G. Relative Displacement');


if(psave==1)   
    pname='relative_displacement';
    set(gca,'Fontsize',12);
    print(h2,pname,'-dpng','-r300');    
    out1=sprintf(' %s.png',pname);
    disp(out1);    
end 




setappdata(0,'acc_cg',acc_cg);
setappdata(0,'acc_rot',acc_rot);
setappdata(0,'rd_s1',rd_s1);
setappdata(0,'rd_cg',rd_cg);
setappdata(0,'rd_s2',rd_s2);


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



n=get(handles.listbox_save,'Value');

if(n==1)
    data=getappdata(0,'acc_cg');
end
if(n==2)
    data=getappdata(0,'acc_cg');
end
if(n==3)
    data=getappdata(0,'rd_cg');
end
if(n==4)
    data=getappdata(0,'rd_s1');
end
if(n==5)
    data=getappdata(0,'rd_s2');
end


output_name=get(handles.edit_output_array,'String');
assignin('base', output_name, data);

h = msgbox('Save Complete'); 



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


% --- Executes on selection change in listbox_export_plots.
function listbox_export_plots_Callback(hObject, eventdata, handles)
% hObject    handle to listbox_export_plots (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox_export_plots contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox_export_plots


% --- Executes during object creation, after setting all properties.
function listbox_export_plots_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox_export_plots (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
